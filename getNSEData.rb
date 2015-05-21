#!/usr/bin/env ruby

# Autho - Raghvendra Sharma
# Copyright - 2015
# Desc - to fetch bhavcopy files from NSE server for local analysis

require 'net/http'

Y=[]
M=["JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEV"]

(2001..2013).each do|y|
  
  M.each do |mth| 
    Net::HTTP.start("nseindia.com") do |http|
      (01..31).each do |d|
        if d < 10
          
          filename="cm0#{d}#{mth}#{y}bhav.csv.zip"
        else 
          filename="cm#{d}#{mth}#{y}bhav.csv.zip"
        end 
        url="/content/historical/EQUITIES/#{y}/#{mth}/#{filename}"
        puts "looking for file #{filename} on #{url}"
        resp = http.get("#{url}")
        if ! resp.nil? 
          puts "found"
          open("#{filename}", "wb") do |file|
          file.write(resp.body)
          `unzip -o #{filename} 2>>./erros.unzip`
        end # loop
      end # if
      end
    end
  end
end
