From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 1/2] cache.h: eliminate SHA-1 deprecation warnings on
 Mac OS X
Date: Fri, 17 May 2013 02:18:37 -0400
Message-ID: <CAPig+cTHh7iEY0+rReQ2LC94CsX-_aKdMLiVnL0ZF-FtKL6DaQ@mail.gmail.com>
References: <1368601868-42410-1-git-send-email-davvid@gmail.com>
	<5193CC6B.50909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri May 17 08:18:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdE03-0004B7-Ua
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 08:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505Ab3EQGSk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 May 2013 02:18:40 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:53434 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039Ab3EQGSj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 May 2013 02:18:39 -0400
Received: by mail-la0-f47.google.com with SMTP id fq12so3787625lab.6
        for <git@vger.kernel.org>; Thu, 16 May 2013 23:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1hsNI/TT7D6c4L7HOKvq/8vPH5qErZ6TzNFWG7m+v78=;
        b=jv205JfrJ4eAQ24OtYhvCPF2BIhsln7SkjD2othx2/3wa3kLAr3mjBn77Aaymb/N/a
         mElcsd23qj7RxYC5HscP/WKO3bJ82+XFSt/hvP/r5x8OKpsQBO0SoWnUpDpFl7A/bO7F
         xWmL2JlXSESVq10GgQwWn/jA3yVbisQi8U8ohnv2C/Hn9uTyTIwze3H1HTpJxIPNuukq
         7+tKcZr35iqGD77mHv8/9Iw7o3HNfIpJa6OXF6fAjmpbjJpGgCznQvzUcABwb0f4z8SB
         RfcRAqQYtXVqD8AVC3QEDgtEa8gelUBFxAMP9dCCbtmpd/ZjdCn6k6cwPFFXbFnPrSp5
         1Gwg==
X-Received: by 10.112.125.232 with SMTP id mt8mr18541133lbb.55.1368771517590;
 Thu, 16 May 2013 23:18:37 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Thu, 16 May 2013 23:18:37 -0700 (PDT)
In-Reply-To: <5193CC6B.50909@web.de>
X-Google-Sender-Auth: XzqbNLV7fVfy5PMhvzA9viY4pOU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224654>

On Wed, May 15, 2013 at 1:56 PM, Torsten B=F6gershausen <tboegi@web.de>=
 wrote:
> On 2013-05-15 09.11, David Aguilar wrote:
>> +     ifndef NO_APPLE_COMMON_CRYPTO
>> +             APPLE_COMMON_CRYPTO =3D YesPlease
>> +     endif
>>       NO_REGEX =3D YesPlease
>>       PTHREAD_LIBS =3D
>>  endif
>> @@ -1389,10 +1396,16 @@ ifdef PPC_SHA1
>>       LIB_OBJS +=3D ppc/sha1.o ppc/sha1ppc.o
>>       LIB_H +=3D ppc/sha1.h
>>  else
>> +ifdef APPLE_COMMON_CRYPTO
>> +     BASIC_CFLAGS +=3D -DCOMMON_DIGEST_FOR_OPENSSL
>> +     SHA1_HEADER =3D <CommonCrypto/CommonDigest.h>
>
> Would it make sense to replace APPLE_COMMON_CRYPTO
> with COMMON_DIGEST_FOR_OPENSSL ?
>
> In the spirit of other Makefile-defines becoming Compiler defines,
> a random picked example:
> ifdef NO_STRTOULL
>         COMPAT_CFLAGS +=3D -DNO_STRTOULL
> endif

Not necessarily. Unlike NO_STRTOULL and cousins,
COMMON_DIGEST_FOR_OPENSSL is not a Git build tweak; it is merely a
(public) implementation detail of the Apple header [1] to magically
associate OpenSSL digest functions with CommonCrypto counterparts.
It's not the only such macro recognized by the Apple headers. For
instance, COMMON_DIGEST_FOR_RFC_1321 magically associates legacy MD5
digest functions with CommonCrypto counterparts.

=46urther, as Junio noted elsewhere, David is using CommonCrypto for
HMAC replacements, not just for digest replacements, so a Makefile
knob with DIGEST in its name is not really appropriate. More
generally, David would like to find CommonCrypto replacements for all
the OpenSSL functionality, so a Makefile knob named after DIGEST is
too specific.

These considerations motivated the original suggestion for a single
Git Makefile knob to enable/disable, as a unit, all CommonCrypto
replacements. Such a knob would naturally have COMMON_CRYPTO as part
of its name.

[1]: /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platfo=
rm/Developer/SDKs/MacOSX10.8.sdk/usr/include/CommonCrypto/CommonDigest.=
h

-- ES
