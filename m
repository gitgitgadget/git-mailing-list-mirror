From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Wed, 22 May 2013 17:23:28 -0500
Message-ID: <CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 00:23:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfHRY-0008PE-A8
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 00:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757312Ab3EVWXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 18:23:32 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36140 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756616Ab3EVWXb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 18:23:31 -0400
Received: by mail-lb0-f174.google.com with SMTP id u10so2632296lbi.5
        for <git@vger.kernel.org>; Wed, 22 May 2013 15:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1H4Q8l1aPu/R3yPRqV75pqwHljwZA3tL1NTFkPKiBr0=;
        b=USXY0G3J0g7Pmgk1KyMUASMymsilFRjmSZFRsUA7zilM623XpTJSIbnyUPRNw9jy7S
         HTPdO0Wwj3dygLyGydwzGTljKq3rg8LZnxAuPHzQCmscZrLyE+N037b9lvJsTXedgT5p
         Gw1pxE8HVY7kFDSRHaortZchwB9kcv1BelkRvXl+bUEehksTTL/5PDTKvtCObFn4FeyP
         hq0/0vIREjVSY40wD+bUvM+Vp7Ob9TXbxJDT1NlJzhO62HzJwAwP9pliEEpSKdi1hnHK
         akDvMyu0OxZ6wrB/PsEQnbonY+caMXoFvoNrHuVWaLqWN+sG7h5Wn0NZmRBrsnv1Cntd
         Z8OQ==
X-Received: by 10.112.218.102 with SMTP id pf6mr5025088lbc.77.1369261408535;
 Wed, 22 May 2013 15:23:28 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Wed, 22 May 2013 15:23:28 -0700 (PDT)
In-Reply-To: <7vr4gyizti.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225198>

On Wed, May 22, 2013 at 2:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> diff --git a/contrib/related/git-related b/contrib/related/git-related
>> new file mode 100755
>> index 0000000..b96dcdd
>> --- /dev/null
>> +++ b/contrib/related/git-related
>> @@ -0,0 +1,124 @@
>> +#!/usr/bin/env ruby
>> +
>> +# This script finds people that might be interested in a patch
>> +# usage: git related <file>
>> +
>> +$since = '5-years-ago'
>> +$min_percent = 10
>> +
>> +def fmt_person(name, email)
>> +  '%s <%s>' % [name, email]
>> +end
>
> Micronit.  I suspect you do not need this helper, unless later
> patches start using it.

It's not *needed*, but it makes if fulfills the role of a function: to
avoid typing that code in multiple places.

>> +  def import
>> +    return if @items.empty?
>> +    File.popen(%w[git cat-file --batch], 'r+') do |p|
>> +      p.write(@items.keys.join("\n"))
>> +      p.close_write
>> +      p.each do |line|
>> +        if line =~ /^(\h{40}) commit (\d+)/
>> +          id, len = $1, $2
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
>> +    File.popen(['git', 'blame', '--incremental', '-CCC',
>
> I am torn on the hardcoded use of "-CCC" here.
>
> Depending on the nature of the change in question, it may match well
> or worse to what you are trying to find out.  When you are trying to
> say "What were you smoking when you implemented this broken logic?",
> using -C may be good, but when your question is "Even though all the
> callers of this function live in that other file, somebody moved
> this function that used to be file static in that file to here and
> made it public. Why?", you do not want to use -C.
>
> I am reasonably sure that in the finished code later in the series
> it will become configurable, but a fallback default is better to be
> not so expensive one.

The script's purpose is to find related commits, -CCC does that, does it not?

>> +               '-L', '%u,+%u' % [start, len],
>> +               '--since', $since, from + '^',
>
> Is "from" unconditionally set?
>
> Perhaps that nil + '^' magically disappear and this code is relying
> on that, but it smells like a too much magic to me.

I personally don't care. You decide what's the behavior when no 'From
' line is available in the patch. I don't see the point in worrying
about non-git patches.

>> +               '--', source]) do |p|
>> +      p.each do |line|
>> +        if line =~ /^(\h{40})/
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
>> +        case line
>> +        when /^From (\h+) (.+)$/
>> +          from = $1
>> +        when /^---\s+(\S+)/
>> +          source = $1 != '/dev/null' ? $1[2..-1] : nil
>> +        when /^@@ -(\d+)(?:,(\d+))?/
>> +          get_blame(source, $1, $2, from)
>> +        end
>
> Makes sense to start from the preimage so that you can find out who
> wrote the original block of lines your patch is removing.
>
> But then if source is /dev/null, wouldn't you be able to stop
> without running blame at all?  You know the patch is creating a new
> file at that point and there is nobody to point a finger at.

A patch can touch multiple files.

-- 
Felipe Contreras
