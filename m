From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 2/3] bisect: add tests for bisection on bare repositories
Date: Mon, 8 Aug 2011 00:39:55 +1000
Message-ID: <CAH3AnrohGgvu+B-p2-4kNcx68UV4tAbirz7gf6Qi9=WpGqE+3Q@mail.gmail.com>
References: <1312714240-23647-1-git-send-email-jon.seymour@gmail.com>
	<1312714240-23647-3-git-send-email-jon.seymour@gmail.com>
	<20110807133939.GA10748@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, chriscool@tuxfamily.org,
	j6t@kdbg.org, jnareb@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 07 16:40:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq4WI-0006ZD-Vf
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 16:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272Ab1HGOj5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Aug 2011 10:39:57 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39118 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946Ab1HGOj4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Aug 2011 10:39:56 -0400
Received: by vxi9 with SMTP id 9so1939219vxi.19
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 07:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=RRcovpMAmUkNzjWRHlF3nDPO/ZDTsb86DjmtObZ4srQ=;
        b=Df2XLF7fMJ66M5aQneq6I/+2acyki3Ai0xQRWeLQLZHvvW6KUn8gj3a2fp/sVecm81
         I6szqp0Ijgx8rLHfsnJuwVfQnsMUF8Ma8r9h/GjeTfXpMvWk8EGHmClraTSPJ+5DsR/A
         Nb3oQDkXOn7VU3LXQm1tiynW7YxTm7hJIWAmg=
Received: by 10.52.27.171 with SMTP id u11mr4701267vdg.131.1312727995681; Sun,
 07 Aug 2011 07:39:55 -0700 (PDT)
Received: by 10.52.183.134 with HTTP; Sun, 7 Aug 2011 07:39:55 -0700 (PDT)
In-Reply-To: <20110807133939.GA10748@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178920>

On Sun, Aug 7, 2011 at 11:39 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Jon Seymour wrote:
>
>> We add a test to check that bisection works on bare repositories
>> both when --no-checkout is specified explicitly and when it
>> is defaulted.
>
> Yay!
>
>> --- a/t/t6030-bisect-porcelain.sh
>> +++ b/t/t6030-bisect-porcelain.sh
>> @@ -592,6 +592,34 @@ test_expect_success 'erroring out when using ba=
d path parameters' '
>> =C2=A0 =C2=A0 =C2=A0 grep "bad path parameters" error.txt
>> =C2=A0'
>>
>> +test_expect_success 'create bare repo' '
>> + =C2=A0 =C2=A0 git clone --bare . bare
>> +'
>
> I'd prefer to see separate clones for the two tests, so if one
> catastrophically fails it does not affect the other.
>
>> +
>> +test_expect_success 'test bisection on bare repo - --no-checkout sp=
ecified' '
>> + =C2=A0 =C2=A0 test_when_finished "cd .." &&
>> + =C2=A0 =C2=A0 cd bare &&
>> + =C2=A0 =C2=A0 git bisect start --no-checkout &&
>> + =C2=A0 =C2=A0 git bisect good $HASH1 &&
>> + =C2=A0 =C2=A0 git bisect bad $HASH4 &&
>> + =C2=A0 =C2=A0 git bisect run sh -c \
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "test \$(git rev-list BI=
SECT_HEAD ^$HASH2 --max-count=3D1 | wc -l) =3D 0" \
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 >../my_bisect_log.txt &&
>> + =C2=A0 =C2=A0 grep "$HASH3 is the first bad commit" ../my_bisect_l=
og.txt &&
>> + =C2=A0 =C2=A0 git bisect reset'
>
> I worry that "sh" might not actually be a POSIX shell on some systems=
=2E
> Maybe a subshell could also simplify this. =C2=A0Like so:

Thanks. Am assuming Junio is ok with use of eval, given these reasons.

The subshell is a good idea. So...

+test_expect_success 'test bisection on bare repo - --no-checkout speci=
fied' '
+	git clone --bare . bare.nocheckout &&
+	(
+		cd bare.nocheckout &&
+		git bisect start --no-checkout &&
+		git bisect good $HASH1 &&
+		git bisect bad $HASH4 &&
+		git bisect run eval \
+			"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=3D1 | wc -l) =
=3D 0" \
+			>../nocheckout.log &&
+		git bisect reset
+	) &&
+	grep "$HASH3 is the first bad commit" nocheckout.log
+'
+
+
+test_expect_success 'test bisection on bare repo - --no-checkout defau=
lted' '
+	git clone --bare . bare.defaulted &&
+	(
+		cd bare.defaulted &&
+		git bisect start &&
+		git bisect good $HASH1 &&
+		git bisect bad $HASH4 &&
+		git bisect run eval \
+			"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=3D1 | wc -l) =
=3D 0" \
+			>../defaulted.log &&
+		git bisect reset
+	) &&
+	grep "$HASH3 is the first bad commit" defaulted.log
+'
+

jon.
