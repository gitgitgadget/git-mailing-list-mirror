From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] gettext.c: detect the vsnprintf bug at runtime
Date: Mon, 2 Dec 2013 16:00:14 +0700
Message-ID: <CACsJy8BqzH7G4yyXMnhgA6kH25eipt9ubqL1S2OdM-ke8GnvJA@mail.gmail.com>
References: <1385812884-23776-1-git-send-email-pclouds@gmail.com>
 <1385865938-16392-1-git-send-email-pclouds@gmail.com> <529BD4E1.8040408@gmail.com>
 <CACsJy8B5aBGnm=04y60W1XVovHVryP1Co0_mmgV0f7Ox13aGjw@mail.gmail.com> <529C3987.7070708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 10:01:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnPNK-0004pi-UQ
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 10:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051Ab3LBJAy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Dec 2013 04:00:54 -0500
Received: from mail-qe0-f49.google.com ([209.85.128.49]:41271 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759Ab3LBJAp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Dec 2013 04:00:45 -0500
Received: by mail-qe0-f49.google.com with SMTP id w7so12655772qeb.8
        for <git@vger.kernel.org>; Mon, 02 Dec 2013 01:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=E/E3iUpARTmgBKexgUG3wH15fqCjX2E2bhcPKN0yU8c=;
        b=qXPJLdTBLz3qvkiVnTqdE1B0tLceOjgzy56IQSnSOJ8bnvFkfcGsgbcvzGgfdh1quz
         ARSQ0C0I1zuOQQj91mkCzcPVfiDZC8jns0eG6+Gn0oMlNmiISGa0c6cuFjLuW2tOZ/sk
         94KtZ28RrirqI2bn42VqVclCBiVsyOgvf8T+0T2t34IcgSMPwZOIgQvsMF3eXe46s3qm
         hIFAwV+1tMPeBzqVehyufJPqOe9e8d1e18PU0IqtBATqUJYBXW/BSb0IYeR5e343FmMc
         GEEs5i+VlwXOBrhjnQfdjHadHjwr+HZY215jiV84QdK60vbwlMmcw/ADEgCP+0/ej7hz
         BD3w==
X-Received: by 10.224.50.84 with SMTP id y20mr11062890qaf.74.1385974844793;
 Mon, 02 Dec 2013 01:00:44 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Mon, 2 Dec 2013 01:00:14 -0800 (PST)
In-Reply-To: <529C3987.7070708@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238619>

On Mon, Dec 2, 2013 at 2:40 PM, Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vn=
wildman@gmail.com> wrote:
> On 02/12/2013 12:57, Duy Nguyen wrote:
>>> I suggest use C preprocessor instead. The person who complete git (=
make debian, rpm etc. package) decide  enable it or not (disable by def=
ault). Most of people use git from distribution instead of complete it =
from source.
>>>
>>> #ifndef VSNPRINTF_OK
>>>         setlocale(LC_CTYPE, "C");
>>> #endif
>>>
>> A single vsnprintf is cheap enough that I would not worry about
>> performance impact. Given a choice between this and distro
>> maintainers, some of them do check release notes, some not so much,
>> I'd rather go with this.
> We can set this macro automatically  by using autoconf.
> Add following code in configure.ac

Except that most git devs do not use autoconf. I don't know about
other but Gentoo also packages git without autoconf. And this test
only means that at build time we detect this. glibc version at runtime
could be different, as long as they are binary compatible with the
build-time one.

>
>
> AC_LANG_CONFTEST(
> [AC_LANG_PROGRAM([[
> #include <stdio.h>
> #include <locale.h>
> #include <gnu/libc-version.h>
>
> #define STR "David_K\345gedal"
> ]],[[
>     char buf[20];
>     setlocale(LC_ALL, "en_US.UTF-8");
>     if (snprintf(buf, 13, "%.13s", STR) < 0){
>         printf("0");
>     }else{
>         printf("1");
>     }
> ]])])
> gcc -o conftest conftest.c
> AC_DEFINE([VSNPRINTF_OK], [m4_esyscmd([./conftest])], [Enable l10n li=
bc
> if vnsprintf OK])
>
> You can change c code here!
>
> --
> Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n.
>



--=20
Duy
