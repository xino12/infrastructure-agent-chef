class Chef
  class Recipe
    # Helper methods for the `newrelic-infra` cookbook recipes
    #
    # @since 0.1.0
    module NewRelicInfra
      class << self
        # Method to generate a String of configuration flags from a given hash
        #
        # @param flags [Hash] hash of configuration flags and associated values
        # @return [String] string of configuration flags and associated values
        def generate_flags(flags)
          flag_arr = flags.each_with_object([]) do |(flag_key, flag_value), obj|
            obj << "-#{flag_key}=#{flag_value}" unless flag_value.nil?
          end
          flag_arr.join(' ')
        end
      end
    end
  end
end

# Adds a method to Hash class types to recursively string-ify all keys
# rubocop:disable Metrics/MethodLength
class Hash
  def deep_stringify
    each_with_object({}) do |(key, value), options|
      deep_val =
        if value.is_a? Hash
          value.deep_stringify
        elsif value.is_a? Array
          value.map do |arr|
            arr.is_a?(Hash) ? arr.deep_stringify : arr
          end
        else
          value
        end

      options[key.to_s] = deep_val
      options
    end
  end
end
# rubocop:enable Metrics/MethodLength
