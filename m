From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v7] Add new git-related helper to contrib
Date: Thu, 30 May 2013 14:31:11 +0530
Message-ID: <CALkWK0=ZbOy6sXOvnTNAqz_UBsUymY1CR_WczT-O3Q+18HJjzQ@mail.gmail.com>
References: <1369884777-7227-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 11:02:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhykC-0005gf-5P
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 11:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967959Ab3E3JB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 05:01:56 -0400
Received: from mail-bk0-f53.google.com ([209.85.214.53]:49283 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967942Ab3E3JBx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 05:01:53 -0400
Received: by mail-bk0-f53.google.com with SMTP id mx10so886143bkb.26
        for <git@vger.kernel.org>; Thu, 30 May 2013 02:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QQya4TasBfLSbswxpBJXYBtTHoQevoG3MniegB5VqQg=;
        b=eX26dTcOWuHyrzSSCoAYxVsXawjtmHkVAoUxhlv1cHGBRPnJ3siRLxOdU+mGRqGMLb
         46fUmcFQMwHtSfLI5eF0e1UFFTFlMiiYam3tk6G5SkicOsv6enGtH8WPqcSsApgNd6D8
         17QXP2gmroCrXanVrGjDQ64rxdXAv3LtEmRS419W6R71CNxf2j3l+oe/sHf0nw/5f0R2
         5+P2m0fC+3g/17YijyfxI4DxyfoPS6tQHALTuFjWK0lBOfMWNGbNrgNW8Qp2cMres2v5
         CxjDiD4x0lgsLePyq8fkpwgeTjYXSsS22H0QTbjcVldxIHhJaZbY6LSWA6Z3dNocxPmo
         CH7Q==
X-Received: by 10.204.240.79 with SMTP id kz15mr466969bkb.112.1369904511645;
 Thu, 30 May 2013 02:01:51 -0700 (PDT)
Received: by 10.204.172.209 with HTTP; Thu, 30 May 2013 02:01:11 -0700 (PDT)
In-Reply-To: <1369884777-7227-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225947>

Let's do one more review.

Felipe Contreras wrote:
> diff --git a/contrib/related/git-related b/contrib/related/git-related
> new file mode 100755
> index 0000000..1b9b1e7
> --- /dev/null
> +++ b/contrib/related/git-related
> @@ -0,0 +1,120 @@
> +#!/usr/bin/env ruby
> +
> +# This script finds people that might be interested in a patch
> +# usage: git related <file>
> +
> +$since = '5-years-ago'
> +$min_percent = 10
> +
> +class Commit
> +
> +  attr_reader :persons

Unless you plan to introduce many more fields (I haven't looked at the
later patches), you might as well implement an #each, like in Commits.

> +  def initialize(id)
> +    @id = id
> +    @persons = []
> +  end
> +
> +  def parse(data)
> +    msg = nil

msg = false, to indicate that it is a boolean.

> +    data.each_line do |line|
> +      if not msg
> +        case line
> +        when /^author ([^<>]+) <(\S+)> (.+)$/
> +          @persons << '%s <%s>' % [$1, $2]

Why capture the third group when $3 is unused?

> +        when /^$/
> +          msg = true
> +        end
> +      else
> +        if line =~ /^(Signed-off|Reviewed|Acked)-by: ([^<>]+) <(\S+?)>$/
> +          @persons << '%s <%s>' % [$2, $3]

Why capture the first group when $1 is unused?

> +        end
> +      end
> +    end
> +    @persons.uniq!
> +  end
> +
> +end
> +
> +class Commits
> +
> +  def initialize
> +    @items = {}
> +  end
> +
> +  def size
> +    @items.size
> +  end
> +
> +  def each(&block)
> +    @items.each(&block)
> +  end
> +
> +  def import
> +    return if @items.empty?
> +    File.popen(%w[git cat-file --batch], 'r+') do |p|

Don't you need rb+ to suppress the CRLF nonsense on Windows?

> +      p.write(@items.keys.join("\n"))

As you might have realized, the parentheses are optional everywhere
(except when it is required for disambiguation).  I'm merely pointing
it out here, because this line looks especially ugly.

> +      p.close_write
> +      p.each do |line|
> +        if line =~ /^(\h{40}) commit (\d+)/
> +          id, len = $1, $2

id, len = $1, Integer $2.  And drop the .to_i on the next line.

> +          data = p.read($2.to_i)
> +          @items[id].parse(data)
> +        end
> +      end
> +    end
> +  end
> +
> +  def get_blame(source, start, len, from)
> +    return if len == 0
> +    len ||= 1

I asked you to use 'len =1 if not len' for clarity, but you didn't like it.

> +    File.popen(['git', 'blame', '--incremental', '-C', '-C',
> +               '-L', '%u,+%u' % [start, len],
> +               '--since', $since, from + '^',
> +               '--', source]) do |p|
> +      p.each do |line|
> +        if line =~ /^\h{40}/
> +          id = $&
> +          @items[id] = Commit.new(id)
> +        end
> +      end
> +    end
> +  end
> +
> +  def from_patch(file)
> +    from = source = nil
> +    File.open(file) do |f|
> +      f.each do |line|

File.readlines(file).each do |line|.

> +        case line
> +        when /^From (\h+) (.+)$/
> +          from = $1

Useless capture.

> +        when /^---\s+(\S+)/
> +          source = $1 != '/dev/null' ? $1[2..-1] : nil
> +        when /^@@ -(\d+)(?:,(\d+))?/
> +          get_blame(source, $1, $2, from) if source and from

Useless capture.  When is len ($2) going to be nil?

> +        end
> +      end
> +    end
> +  end
> +
> +end
> +
> +exit 1 if ARGV.size != 1
> +
> +commits = Commits.new
> +commits.from_patch(ARGV[0])
> +commits.import
> +
> +count_per_person = Hash.new(0)
> +
> +commits.each do |id, commit|

commits.each do |_, commit|, since you're not using id.

> +  commit.persons.each do |person|
> +    count_per_person[person] += 1
> +  end
> +end
> +
> +count_per_person.each do |person, count|
> +  percent = count.to_f * 100 / commits.size

I prefer 'Float count' over count.to_f, but that's just a matter of taste.

> +  next if percent < $min_percent
> +  puts person
> +end
> --
> 1.8.3.rc3.312.g47657de
