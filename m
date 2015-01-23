From: Per Cederqvist <cederp@opera.com>
Subject: Re: [GUILT 1/5] Fix generation of Documentation/usage-%.txt.
Date: Fri, 23 Jan 2015 15:33:03 +0100
Message-ID: <CAP=KgsSMT7Wniek1FgRGkrxa9+45hxcDtE-C1B4sQMvUviKJ1g@mail.gmail.com>
References: <1422019499-2012-1-git-send-email-cederp@opera.com>
	<1422019499-2012-2-git-send-email-cederp@opera.com>
	<20150123142103.GA101465@meili.jeffnet.31bits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 15:33:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEfIN-0000Vk-2W
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 15:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbbAWOdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 09:33:06 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:64213 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbbAWOdF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 09:33:05 -0500
Received: by mail-ie0-f182.google.com with SMTP id ar1so7360692iec.13
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 06:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jHICJgX3zwn39OZYnPmMRHjN0Cu6JzrF+Od/5C/JqLI=;
        b=iAiMuSKlPOVVSeY5soSl9mXQ6YUKCzTjuTVjI1NY1NbIANxD0OMhPhi6lqj3aZtEBr
         uTJnywcw9Hs1FyVQq+kwhsOhJuMMBzGFgvW/RJ7QCTjCLkjFvF36i6vvPmq+khWeRkgz
         YF+xLuvkFtgGHaZszjzV/x31Ux5Xf0fbK5SXlHlfL7HinxbL6SWIGoladopA+Y5o3SvE
         aU14N3QDfDjsjZ0p6AZgFV+t8+tWf88ItPNkoqrko2wKWM8NQb94Gr5n4pfVsZxxkho/
         v4KtmAmMO7cOM300CxB+FHv7Rnw6/E1TAMMjYXAw5Gh+1mJW3dcMdcos8oG6Ydan9iCA
         hB7A==
X-Gm-Message-State: ALoCoQkXQLEIUmdADNfs8gwPsFNkSl+ZkQu2Q9goTQg3WgBYxoCpmt1RYoHcNI/LAMMODz+fZKt0
X-Received: by 10.107.164.36 with SMTP id n36mr3970111ioe.82.1422023583579;
 Fri, 23 Jan 2015 06:33:03 -0800 (PST)
Received: by 10.42.235.141 with HTTP; Fri, 23 Jan 2015 06:33:03 -0800 (PST)
In-Reply-To: <20150123142103.GA101465@meili.jeffnet.31bits.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262936>

On Fri, Jan 23, 2015 at 3:21 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
> On Fri, Jan 23, 2015 at 02:24:55PM +0100, Per Cederqvist wrote:
>> The old rule worked, most of the time, but had several issues:
>>
>>  - It depended on the corresponding guilt-*.txt file, but the usage.sh
>>    script actually reads ../guilt-foo.
>>
>>  - Actually, each usage-%.txt depended on all guilt-*.txt files, so
>>    make had to do more work than necessary if a single file was
>>    altered.
>>
>>  - The construct broke parallel make, which would spawn several
>>    usage.sh at once.  This leads to unnecessary work, and could
>>    potentially result in broken usage files if the "echo some_string >
>>    some_file" construct used by usage.sh isn't atomic.
>>
>> Fixed by letting the usage.sh script update a single file, and writing
>> a proper implicit make rule.  This makes parallel make work a lot
>> better.
>
> Nice!
>
>> There is a small downside, though, as usage.sh will now be run once
>> for each command (if everything is regenerated).  I think it is worth
>> to pay that price to get the correctness.  This command is still very
>> fast compared to the docbook processing.
>
> Given how much simple usage.sh got, I'm thinking it might be worth it to
> just remove it, and just shove the rule into the makefile itself.
>
> Ok, I tried to write it.  I came up with the following.  (Note: I have *not*
> tested it.)  It's not *that* ugly.
>
> usage-guilt-%.txt: ../guilt-% usage.sh
>         echo "'$(basename $<)' `sed -n -e '/^USAGE=/{s/USAGE="//; s/"$//; p; q}' $<`" > $@
>
> What do you think?  Too opaque?  Your change looks good.

Too opaque, and not tested enough. It doesn't work, since make will
handle all $.  You need to write $$ instead of $ in at least one of the
places.  I would stick with usage.sh, as getting the quoting right when
you have make, shell, subshells, and sed all at the same time is just
too painful.

But it is of course up to you. You are the maintainer. :-)

    /ceder

> Jeff.
>
>> Signed-off-by: Per Cederqvist <cederp@opera.com>
>> ---
>>  Documentation/Makefile | 4 ++--
>>  Documentation/usage.sh | 8 +++-----
>>  2 files changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index b6c3285..ec3c9e8 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -66,8 +66,8 @@ clean:
>>       rm -f usage-*.txt
>>       rm -f version.txt
>>
>> -usage-%.txt: $(MAN1_TXT) usage.sh
>> -     sh ./usage.sh
>> +usage-guilt-%.txt: ../guilt-% usage.sh
>> +     sh ./usage.sh $<
>>
>>  %.html : %.txt footer.txt version.txt
>>       $(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf $(ASCIIDOC_EXTRA) $<
>> diff --git a/Documentation/usage.sh b/Documentation/usage.sh
>> index 20fdca4..629f546 100644
>> --- a/Documentation/usage.sh
>> +++ b/Documentation/usage.sh
>> @@ -1,7 +1,5 @@
>>  #!/bin/sh
>>
>> -for i in `ls ../guilt-*`; do
>> -     name=$(basename $i)
>> -     u=$(grep USAGE $i |  sed 's/USAGE="//' | sed 's/"$//')
>> -     echo "'$name' $u"  > usage-$name.txt
>> -done
>> +name=$(basename $1)
>> +u=$(grep USAGE $1 |  sed 's/USAGE="//' | sed 's/"$//')
>> +echo "'$name' $u"  > usage-$name.txt
>> --
>> 2.1.0
>>
>
> --
> The reasonable man adapts himself to the world; the unreasonable one
> persists in trying to adapt the world to himself. Therefore all progress
> depends on the unreasonable man.
>                 - George Bernard Shaw
