From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 07/11] Documentation/replace: tell that -f option
 bypasses the type check
Date: Tue, 3 Sep 2013 11:29:39 +0200
Message-ID: <CAP8UFD31dawrGEiukHYvfUFtDtqrK-OLMLdqFfdOBU=rDYuAcQ@mail.gmail.com>
References: <70F5C527E29F43A9BE85694F560E01A9@PhilipOakley>
	<20130901.134900.829124962244710553.chriscool@tuxfamily.org>
	<29D8721CD44F4C3180D6F1BA5CDCF38E@PhilipOakley>
	<20130902.081157.986549849748779440.chriscool@tuxfamily.org>
	<66A16BF0137D40568A34C316DDA6D32E@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>,
	Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Sep 03 11:29:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGmvh-0001IR-4R
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 11:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680Ab3ICJ3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 05:29:41 -0400
Received: from mail-vc0-f181.google.com ([209.85.220.181]:52776 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932610Ab3ICJ3k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 05:29:40 -0400
Received: by mail-vc0-f181.google.com with SMTP id hz10so3820371vcb.12
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 02:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=i25gYENFLgUS4AoiD2mGUvAm75jIURyM9/39MCU1iyI=;
        b=c6k0/mGFZojEf5QUWB6R2il+3AWpFsVilQo3zT3Fhahk7ssBxj35Zj3W2ytWyD6LsH
         fgRIhUn43ISwZox+eMpQKdknHznHmi752OYZ8GR+sFmWcYqUrc93hDWd85ZHAWARDQmV
         VvDjfFrnb5OWa+wkyNAUp4RbIaNOkbO6vQlmfND6P0wuPWdVCziEGUXWQahd6F24XBD8
         8yIx5UjrV8+j/CIY7ektZptoDz5bcDqmxQNt0eGTlvP9xZQWho9uNJMJYLeS6N8ffUAA
         dmOJSuNX36IzgKPTMGuAL0SYfX28iLLUk7UIZMWgfJhU5xsdWfZxbTyRlPuIiTTcOagx
         pd9w==
X-Received: by 10.52.230.233 with SMTP id tb9mr4474923vdc.17.1378200579675;
 Tue, 03 Sep 2013 02:29:39 -0700 (PDT)
Received: by 10.58.240.102 with HTTP; Tue, 3 Sep 2013 02:29:39 -0700 (PDT)
In-Reply-To: <66A16BF0137D40568A34C316DDA6D32E@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233711>

On Mon, Sep 2, 2013 at 11:50 PM, Philip Oakley <philipoakley@iee.org> wrote:
>
> From: "Christian Couder" <chriscool@tuxfamily.org>
>
>> You mean something like the following:
>>
>> $ cat  ./graft2replace.sh
>> #!/bin/bash
>>
>> while read orig parents
>> do
>>        printf "%s" "git cat-file commit $orig"
>>        printf "%s" " | perl -n -e 'print unless /^parent /'"
>>        insn=''
>>        for commit in $parents; do insn="$insn print \"parent
>> $commit\\n\";"; done
>>        printf "%s" " | perl -n -e 'print; if (/^tree /) { $insn }'"
>>        printf "%s\n" " > new_commit.txt"
>>        printf "%s\n" 'REPL=$(git hash-object -t commit -w new_commit.txt)'
>
>
> Does `hash-object` do the inverese of `cat-file commit`?
>
> I didn't find the hash-object(1) man page very informative on that matter
> and a (very) quick look at its code made me think it was just hashing the
> raw contents which wouldn't be what what was wanted.

I agree with Jonathan's suggest to add an EXAMPLE section in
hash-object(1) manpage and maybe a new gitobject(5) manpage too.

You can also find a few examples of how git hash-object can be used in
t/t6050-replace.sh:

For example:

     R=$(git cat-file commit $HASH2 | sed -e "s/A U/O/" | git
hash-object -t commit --stdin -w) &&
     git cat-file commit $R | grep "author O Thor" &&
     git update-ref refs/replace/$HASH2 $R

>>        printf "%s\n" "git replace $orig \$REPL"
>> done
>>
>> This generates shell instructions from a graft file. Then you only need to
>> execute the generated shell instructions.
>> For example:
>>
>> $ cat graft_file.txt
>> 5bf34fff3186254d7254583675d10ddf98df989b
>> 79fe155489351e8af829a3106e7150397c57d863
>> dcfbab6bea3df3166503f3084cec2679f10f9e80
>> fb5657082148297b61fbca7e64d51c1e7870309a
>>
>> $ cat graft_file.txt | ./graft2replace.sh
>> git cat-file commit 5bf34fff3186254d7254583675d10ddf98df989b | perl -n -e
>> 'print unless /^parent /' | perl -n -e 'print; if (/^tree /) {  print
>> "parent 79fe155489351e8af829a3106e7150397c57d863\n"; print "parent
>> dcfbab6bea3df3166503f3084cec2679f10f9e80\n"; }' > new_commit.txt
>> REPL=$(git hash-object -t commit -w new_commit.txt)
>> git replace 5bf34fff3186254d7254583675d10ddf98df989b $REPL
>> git cat-file commit fb5657082148297b61fbca7e64d51c1e7870309a | perl -n -e
>> 'print unless /^parent /' | perl -n -e 'print; if (/^tree /) {  }' >
>> new_commit.txt
>> REPL=$(git hash-object -t commit -w new_commit.txt)
>> git replace fb5657082148297b61fbca7e64d51c1e7870309a $REPL
>>
>> Note that I haven't really tested it.

Also note that it is obviously broken if you have commits with a
commit message that has lines starting with 'parent ' or 'tree '.

> I think we could call it 'git-graft', being the help function/script that
> converts raw grafts to proper object replacements ;-)

I will have a look at improving it, testing it and sending a patch to
put it in contrib/.

Thanks,
Christian.
