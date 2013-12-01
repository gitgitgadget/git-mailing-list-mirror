From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] gettext.c: only work around the vsnprintf bug on glibc
 < 2.17
Date: Sun, 1 Dec 2013 08:33:21 +0700
Message-ID: <CACsJy8BdFst0ZRpvMwUxby88YMJdiY4h386kTVP57h6XfgLLgg@mail.gmail.com>
References: <1385776291-21006-1-git-send-email-pclouds@gmail.com>
 <1385812884-23776-1-git-send-email-pclouds@gmail.com> <529A6E48.4050001@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Dec 01 02:34:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmvvD-0004Sc-Pi
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 02:34:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425Ab3LABdx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Nov 2013 20:33:53 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:63286 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab3LABdw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Nov 2013 20:33:52 -0500
Received: by mail-qa0-f46.google.com with SMTP id f11so3103792qae.19
        for <git@vger.kernel.org>; Sat, 30 Nov 2013 17:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=JX97AQZCo4uVFvPMoppGO6rQZu6tkPoSvbq0kLr/SQA=;
        b=AVVaQGTNnlcXZbB5EI5iCF/2BC1BJqep1XWkr+u4ZuTaheh4QOOz0iC9OurMmZ51hZ
         VE90XMoqPwJU8u1mXlQ2nDAFmLCFrBG9a+6pOH7bENqRkxri73Iv26gitR1D861tJ4jG
         qn46Xgor+k0YDypwr4o4n2U6Nonm3QztnYD033xS8f6bHD4ZIwHs1maG26CDKWc5vOJO
         xvoesnI1pkOrrEw+zC3zaaYthTFcsCLJGKx7gYHBCuLdF8dSU80ysKaGVzy6L6VA3xNf
         XCDalpPJ5CoPsD8iPh0MKW/JRTr9ZApECAQTs/uFHdNwPrDOIy/QqXIVEGakwLAzRN4x
         y7WA==
X-Received: by 10.49.106.1 with SMTP id gq1mr46381129qeb.12.1385861631512;
 Sat, 30 Nov 2013 17:33:51 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Sat, 30 Nov 2013 17:33:21 -0800 (PST)
In-Reply-To: <529A6E48.4050001@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238576>

On Sun, Dec 1, 2013 at 6:01 AM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> On 2013-11-30 13.01, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> Bug 6530 [1] causes "git show v0.99.6~1" to fail with error "your
> causes or caused (as we have a work around?)
>> vsnprintf is broken". The workaround avoids that, but it corrupts
>> system error messages in non-C locales.
> [snip]
>> The bug in glibc has been fixed since 2.17. If git is built with gli=
bc, it can
>                 ^^^^^^ (Should we name glibc ?)

No, probably leftover from editing.

> [snip]
>> -     setlocale(LC_MESSAGES, "");
>> -     init_gettext_charset("git");
>> +     setlocale(vsnprintf_broken ? LC_MESSAGES : LC_ALL, "");
> 1) One thing I don't understand: Why do we need to set LC_ALL ?
> The old patch didn't do it, or what do I miss ?
> See https://wiki.debian.org/Locale :
> Using LC_ALL is strongly discouraged as it overrides everything. Plea=
se use it only when testing and never set it in a startup file.

I'm fine with changing it back to LC_MESSAGES+LC_TYPE. For the record,
all gtk+ apps do setlocale(LC_ALL, "");

> 2) I stole the code partly from here:
>    http://sourceware.org/bugzilla/show_bug.cgi?id=3D6530
> ----------------------
> #include <stdio.h>
> #include <locale.h>
> #include <gnu/libc-version.h>
>
> #define STR "=C2=B2=C3=A9=C3=84=C2=BE=C3=82=C3=AD=C3=89=C2=B1=C2=B2=C2=
=A1=C2=B6=C2=BE=C2=A3=C2=AC=C3=96=C3=9C=C2=BA=C3=A8=C2=B5t=C3=84=C3=BA=C2=
=B5=C3=84360=C2=B2=C2=BB=C3=97=C2=A8=C3=92=C2=B5=C2=A3=C2=A1"
>
> int main(void) {
>         char buf[200];
>         setlocale(LC_ALL, "");
>                                 printf("gnu_glibc_version()=3D%s\n", =
 gnu_get_libc_version());
>         printf("ret(snprintf)=3D%d\n", snprintf(buf, 150, "%.50s", ST=
R));
>         return 0;
> }
>
> ----------------------
> Then I run it on different machines:
>
> gnu_glibc_version()=3D2.11.3 /* Ubuntu 10.4, no updates */
> gnu_glibc_version()=3D2.11.3 /* Debian Squeze  ?*/
> gnu_glibc_version()=3D2.13 /* Debian Wheezy */
> ret(snprintf)=3D50 /* All the 3 above */
> -------------
> So could it be that libc is patched in Debian/Ubuntu, and we
> can do a runtime check (rather than looking at the version number),
> similar to the code above ?

Good idea. Now I need to install 2.16 for reproducing it :(

> ------------
>
> 3) The patch didn't break anything here (Debian, Mac OS).
>
> 4) Could it be good to have a test case ? Is t0204 good for inspirati=
on ?
>
> 5) I can do more testing if needed.
>
> /Torsten
>
>
>



--=20
Duy
