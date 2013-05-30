From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v7] Add new git-related helper to contrib
Date: Thu, 30 May 2013 06:31:20 -0500
Message-ID: <CAMP44s25vX1p1Np7yqc9_AqVBme+MCTY88hjhfWdL6KZkxgs7Q@mail.gmail.com>
References: <1369884777-7227-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=ZbOy6sXOvnTNAqz_UBsUymY1CR_WczT-O3Q+18HJjzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 13:31:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui14q-0004JH-2q
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 13:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247Ab3E3LbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 07:31:24 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:53992 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab3E3LbX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 07:31:23 -0400
Received: by mail-la0-f48.google.com with SMTP id fs12so119540lab.7
        for <git@vger.kernel.org>; Thu, 30 May 2013 04:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NeSomND8EVWsr7BC0oVmctIhWVsdYik62Jn291UQS5Y=;
        b=i4lCrlwUOvlfVTljS1lNxIC1IgB4WyG2U0uCRvtL+DBopv7A8KRrRjROg7l1Ifxg2Z
         0LmvsosdQW67mAPIg/iimpzprwVOWkgsBx3WmorVm0+IqvSNjZpWtcJgS6FGkbnua8q8
         YOw9kB4fA11NqBJiQcZEiczoU28nBAJWyEqC/f09BgAGESWkPDC54ke/tv3BTH49v5VY
         ERVwgKEOUMGMHuVGgfReGyc1Pe203zOUQmocKXaCD/DNn8KxcogPdgkmYW1N++UVOOJR
         VzzWw24Qc6vzMRg3YvXF03kAoKNHtoCqAfnMUW25PapkZssPkZLl8Y9I1mi3AA8qS6p/
         MQNA==
X-Received: by 10.112.33.17 with SMTP id n17mr3512114lbi.72.1369913481094;
 Thu, 30 May 2013 04:31:21 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Thu, 30 May 2013 04:31:20 -0700 (PDT)
In-Reply-To: <CALkWK0=ZbOy6sXOvnTNAqz_UBsUymY1CR_WczT-O3Q+18HJjzQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225956>

On Thu, May 30, 2013 at 4:01 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Let's do one more review.
>
> Felipe Contreras wrote:
>> diff --git a/contrib/related/git-related b/contrib/related/git-related
>> new file mode 100755
>> index 0000000..1b9b1e7
>> --- /dev/null
>> +++ b/contrib/related/git-related
>> @@ -0,0 +1,120 @@
>> +#!/usr/bin/env ruby
>> +
>> +# This script finds people that might be interested in a patch
>> +# usage: git related <file>
>> +
>> +$since = '5-years-ago'
>> +$min_percent = 10
>> +
>> +class Commit
>> +
>> +  attr_reader :persons
>
> Unless you plan to introduce many more fields (I haven't looked at the
> later patches), you might as well implement an #each, like in Commits.

commit.each doesn't make sense; each what?

We could do 'commit.each_person', but why is that so better than
commit.persons.each? It's not.

>> +    data.each_line do |line|
>> +      if not msg
>> +        case line
>> +        when /^author ([^<>]+) <(\S+)> (.+)$/
>> +          @persons << '%s <%s>' % [$1, $2]
>
> Why capture the third group when $3 is unused?

Completeness.

>> +        when /^$/
>> +          msg = true
>> +        end
>> +      else
>> +        if line =~ /^(Signed-off|Reviewed|Acked)-by: ([^<>]+) <(\S+?)>$/
>> +          @persons << '%s <%s>' % [$2, $3]
>
> Why capture the first group when $1 is unused?

You want to complicate the regex even more with:

/^(?:Signed-off|Reviewed|Acked)-by: ([^<>]+) <(\S+?)>$/

For what purpose?

>> +        end
>> +      end
>> +    end
>> +    @persons.uniq!
>> +  end
>> +
>> +end
>> +
>> +class Commits
>> +
>> +  def initialize
>> +    @items = {}
>> +  end
>> +
>> +  def size
>> +    @items.size
>> +  end
>> +
>> +  def each(&block)
>> +    @items.each(&block)
>> +  end
>> +
>> +  def import
>> +    return if @items.empty?
>> +    File.popen(%w[git cat-file --batch], 'r+') do |p|
>
> Don't you need rb+ to suppress the CRLF nonsense on Windows?

Who knows.

>> +      p.write(@items.keys.join("\n"))
>
> As you might have realized, the parentheses are optional everywhere
> (except when it is required for disambiguation).  I'm merely pointing
> it out here, because this line looks especially ugly.

I suspect most Git developers would prefer the traditional function call style.

>> +      p.close_write
>> +      p.each do |line|
>> +        if line =~ /^(\h{40}) commit (\d+)/
>> +          id, len = $1, $2
>
> id, len = $1, Integer $2.  And drop the .to_i on the next line.

This is way is better.

>> +          data = p.read($2.to_i)
>> +          @items[id].parse(data)
>> +        end
>> +      end
>> +    end
>> +  end
>> +
>> +  def get_blame(source, start, len, from)
>> +    return if len == 0
>> +    len ||= 1
>
> I asked you to use 'len =1 if not len' for clarity, but you didn't like it.

git grep "||=" disagrees.

>> +    File.popen(['git', 'blame', '--incremental', '-C', '-C',
>> +               '-L', '%u,+%u' % [start, len],
>> +               '--since', $since, from + '^',
>> +               '--', source]) do |p|
>> +      p.each do |line|
>> +        if line =~ /^\h{40}/
>> +          id = $&
>> +          @items[id] = Commit.new(id)
>> +        end
>> +      end
>> +    end
>> +  end
>> +
>> +  def from_patch(file)
>> +    from = source = nil
>> +    File.open(file) do |f|
>> +      f.each do |line|
>
> File.readlines(file).each do |line|.

That's less efficient.

>> +        when /^---\s+(\S+)/
>> +          source = $1 != '/dev/null' ? $1[2..-1] : nil
>> +        when /^@@ -(\d+)(?:,(\d+))?/
>> +          get_blame(source, $1, $2, from) if source and from
>
> Useless capture.  When is len ($2) going to be nil?

Junio already went over it, see the diff format.

What's your objective? Block this patch from ever going in?

Not a single one of these comments makes a difference at all, all of
them can wait until after the patch is merged, many of them are a
matter of preferences, and some of them have already been addressed as
precisely that: disagreements in style.

-- 
Felipe Contreras
