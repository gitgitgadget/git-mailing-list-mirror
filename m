From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [PATCH v4 2/6] t9001: check email address is in Cc: field
Date: Wed, 8 Jun 2016 21:23:44 +0200
Message-ID: <6b2b9023-b50e-9bbd-840a-ec7142ec5a75@grenoble-inp.org>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
 <20160608130142.29879-3-samuel.groot@grenoble-inp.org>
 <xmqqinxjmvop.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, aaron@schrab.com, e@80x24.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 21:23:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAj4v-0005k3-Te
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 21:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161968AbcFHTXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 15:23:46 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:58524 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249AbcFHTXp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 15:23:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id BCC082584;
	Wed,  8 Jun 2016 21:23:43 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LciGCswAf4m0; Wed,  8 Jun 2016 21:23:43 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id AD14E222F;
	Wed,  8 Jun 2016 21:23:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id A74D02066;
	Wed,  8 Jun 2016 21:23:43 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wsjksW_zvT4c; Wed,  8 Jun 2016 21:23:43 +0200 (CEST)
Received: from wificampus-030012.grenet.fr (wificampus-030012.grenet.fr [130.190.30.12])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 88BAD2064;
	Wed,  8 Jun 2016 21:23:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <xmqqinxjmvop.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296838>

On 06/08/2016 07:34 PM, Junio C Hamano wrote:
> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
>> index 56ad8ce..943e6b7 100755
>> --- a/t/t9001-send-email.sh
>> +++ b/t/t9001-send-email.sh
>> @@ -888,8 +888,8 @@ test_expect_success $PREREQ 'utf8 Cc is rfc2047 encoded' '
>>  	--to=nobody@example.com \
>>  	--smtp-server="$(pwd)/fake.sendmail" \
>>  	outdir/*.patch &&
>> -	grep "^	" msgtxt1 |
>> -	grep "=?UTF-8?q?=C3=A0=C3=A9=C3=AC=C3=B6=C3=BA?= <utf8@example.com>"
>> +	cc_adr=$(awk "/^Cc: /{flag=1}/^Subject: /{flag=0} flag {print}" msgtxt1) &&
>> +	echo "$cc_adr" | fgrep "=?UTF-8?q?=C3=A0=C3=A9=C3=AC=C3=B6=C3=BA?= <utf8@example.com>"
>>  '
>
> This still depends on that the output has Cc: before Subject: and
> there is no other header that can have an address on it.  E.g.
>
> 	To: a@example.com
>         Cc: b@example.com
>         X-foo: <<whatever address you are looking for>>
>         Subject: [PATCH] A sample patch
>
> would still say that the address is _on_ the CC: list.

We thought of that but did not find the proper way to do it.

> I do not usually do awk, but I think you should be able to avoid
> capturing output from it, echoing and then grepping, which is way
> too ugly.  Perhaps you can start from something like below?
>
> #!/bin/sh
> awk '
> 	BEGIN { in_cc = 0 }
> 	/^[Cc][Cc]: / {
> 		sub("^[Cc][Cc]: *", "")
> 		in_cc = 1
> 	}
> 	/^[^ 	]*:/ {
> 		in_cc = 0
> 	}
> 	/^$/ { exit }
> 	in_cc {
> 		sub("^ *", "")
> 		sub(", *$", "")
> 		print
> 	}
> ' <<\EOF
> To: a@example.com
> Cc: b@example.com,
>     c@example.com,
>     d@example.com
> X-foo: e@example.com
> Subject: [PATCH] A sample patch
>
> Cc: foo@example.com
> EOF

Thanks, I will work on that :-)
