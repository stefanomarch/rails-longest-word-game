require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @letters = params[:letters].split(' ')
    @user_input = params[:user_input].upcase
    @result = ''
    url = "https://wagon-dictionary.herokuapp.com/#{@user_input}"
    dictionary = open(url).read
    @word_check = JSON.parse(dictionary)

    if @word_check['found'] == true
      if @user_input.chars.all? { |letter| @letters.include?(letter) }
        if (@letters - @user_input.chars).length != (@letters.length - @user_input.chars.length)
          @result = 'you use the same letter more times'
        end
        @result = "Amazing, #{@user_input} is included in the letters array"
      else
        @result = "I'm sorry but #{@user_input} is not included in #{@letters.join(', ')}"
      end
    else
      @result = "#{@user_input}is not an english word"
    end
  end


end
