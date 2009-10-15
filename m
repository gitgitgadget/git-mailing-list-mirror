From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: My custom cccmd
Date: Thu, 15 Oct 2009 16:20:02 +0300
Message-ID: <94a0d4530910150620g733bdf0aq88660053f869b0a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 15 15:29:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyQOs-0007rl-OL
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 15:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762751AbZJONVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 09:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762749AbZJONVv
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 09:21:51 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:41412 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762748AbZJONVu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 09:21:50 -0400
Received: by fg-out-1718.google.com with SMTP id 16so482424fgg.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2009 06:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=EgCPkKJZMhnKjrNNdwyZvWe3P1ciifnPrEpD9bdZHhk=;
        b=PIeOLaO04VMJ0Se67dgPyNdKyTa6rfY07Tr7Cdci0J+PhsUND8ken6GxV93DhAhHFU
         9VLwmWe7SPbhZi4+kOx52YmpawV5hnDooIROqtGs/uq6jSL5g013oUK16ORYrLSYN7xa
         IS+CCXGoRHFTwBdrk4NRHdPRfPFmGXzrITN3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=i/j5Sq3evgkw+gPsTJMj9wiuj5OeFHMbhFLJBprWQODU95KvnVdO/IzKmYwOhEhWIA
         JB/r7dZo2IBXNvc4gFUHi4TnmYmBWIC6Ggi8IoKcYTOsfdFLX0xRArdYIjmS3pQuTxDa
         2Zf27ce5wbaSvy2e2o1wfKr5bD0u0zkBkM8Tw=
Received: by 10.86.208.2 with SMTP id f2mr193996fgg.16.1255612802530; Thu, 15 
	Oct 2009 06:20:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130391>

Hi,

I love the new option to run a cccmd and how good it works on the
linux kernel, but I couldn't find a generic script. So I decided to
write my own.

It's very simple, it just looks into the authors of the commits that
modified the lines being overridden (git blame). It's not checking for
s-o-b, or anything fancy.

Comments?

#!/usr/bin/env ruby

@commits = {} # keeps a count of commits per author

ARGV.each do |filename|
  File.open(filename) do |patch_file|
    patch_file.each_line do |patch_line|
      case patch_line
      when /^---\s+(\S+)/
        @source = $1[2..-1]
      when /^@@\s-(\d+),(\d+)/
        blame = `git blame -p -L #{$1},+#{$2} #{@source} | grep author`
        blame.each_line do |al|
          key, value = al.chomp.split(" ", 2)
          case key
          when "author"
            @name = value
          when "author-mail"
            @mail = value
            author = "\"#{@name}\" #{@mail}"
            @commits[author] ||= 0
            @commits[author] += 1
          end
        end
      end
    end
  end
end

@commits.each_key do |a|
  puts a
end

-- 
Felipe Contreras
