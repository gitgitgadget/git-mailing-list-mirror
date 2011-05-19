From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] compat: add a getpass() compatibility function
Date: Thu, 19 May 2011 14:17:33 +0200
Message-ID: <BANLkTinPHeSfZXRb7pqt7-XWkR5fH=wAjg@mail.gmail.com>
References: <563395AE-A3E5-45FF-9063-F807C2CE3AD0@gieschke.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Rafael Gieschke <rafael@gieschke.de>
X-From: git-owner@vger.kernel.org Thu May 19 14:18:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN2Az-0001st-GT
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 14:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756749Ab1ESMR5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2011 08:17:57 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:43736 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755929Ab1ESMRz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 08:17:55 -0400
Received: by pxi16 with SMTP id 16so1739336pxi.4
        for <git@vger.kernel.org>; Thu, 19 May 2011 05:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=E6qSQbbnJf6S1zxuim4BVWYRLl2x3EO79Agax5hAFM4=;
        b=ALU+7454RCUi8UqhO2vQ0ZiItGtO+XxP64K6bLQP5NN1DeMEP0ZRWye36swgFP1SEa
         2LnPBdmRhg3Ty8IGZV4Hu9Exg8Suz6rYn7z0moR9w/H8Lt1XdmOBX3RjuGm6VE0T/iAx
         bJFw3+zQxaliOAUxhDlrLTsB/rV+pyPDz7/7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=rQKKYMTAbbJ4cmIrO4SFw/tsHIDgFUFvTRHyvWDaPapymlR3ACHUtLg76g7a1m3knD
         xtCTAK5CLGO4GbWNpBo0ljubLeTE7VkQgR1c7AGMEJQMn1P142MSS6TkMEw07RG+9Ltd
         AYsYKhc1Jyq6FD+d6QIdibHRSjUiSodxljOQQ=
Received: by 10.68.71.135 with SMTP id v7mr4780117pbu.232.1305807474099; Thu,
 19 May 2011 05:17:54 -0700 (PDT)
Received: by 10.68.64.229 with HTTP; Thu, 19 May 2011 05:17:33 -0700 (PDT)
In-Reply-To: <563395AE-A3E5-45FF-9063-F807C2CE3AD0@gieschke.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173954>

On Thu, May 19, 2011 at 1:37 PM, Rafael Gieschke <rafael@gieschke.de> w=
rote:
>
> If NO_GETPASS is set, getpass is provided in compat/getpass.c from
> https://github.com/CyanogenMod/android_external_dropbear/raw/master/n=
etbsd_getpass.c
> (getpass was renamed to gitgetpass).

Nice.

But I can't help to think that this implementation of getpass looks a
bit heavy, especially since we already have our own getpass
implementation in compat/mingw.c.

Do we really need two implementations? Wouldn't it be better to factor
out the mingw-version to a separate source file, and then improve it?

Windows doesn't have /dev/tty, but the logic in this version handles
that by using stdin/stderr instead. The signal-stuff has a comment
that indicates it might not even be correct. tcgetattr/tcsetattr isn't
supported on Windows, but it's not needed if we use getch (as the
version in compat/mingw.c does). POSIX/curses getch respects the
echo-setting, while Windows getch never echo.

Given the information above, it sounds to me like we can enhance the
version we already have to behave as it should also on non-Windows
platforms, without having to maintain two versions. But it might not
be worth it, given the simplicity of the Windows version and the
increased dependency of curses, I dunno.

As a Windows-guy, I'm not entirely comfortable with putting something
in compat/[function-name].c that is only portable to POSIX-platforms.
This is not the current trend, but that might not be a conscious
choice.

> diff --git a/compat/getpass.c b/compat/getpass.c
> new file mode 100644
> index 0000000..e13f29f
> --- /dev/null
> +++ b/compat/getpass.c
> @@ -0,0 +1,114 @@
> +/* =A0 =A0 $NetBSD: getpass.c,v 1.15 2003/08/07 16:42:50 agc Exp $ *=
/
> +
> +/*
> + * Copyright (c) 1988, 1993
> + * =A0 =A0 The Regents of the University of California. =A0All right=
s reserved.
> + *
> + * Redistribution and use in source and binary forms, with or withou=
t
> + * modification, are permitted provided that the following condition=
s
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + * =A0 =A0notice, this list of conditions and the following disclaim=
er.
> + * 2. Redistributions in binary form must reproduce the above copyri=
ght
> + * =A0 =A0notice, this list of conditions and the following disclaim=
er in the
> + * =A0 =A0documentation and/or other materials provided with the dis=
tribution.
> + * 3. Neither the name of the University nor the names of its contri=
butors
> + * =A0 =A0may be used to endorse or promote products derived from th=
is software
> + * =A0 =A0without specific prior written permission.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS=
'' AND
> + * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,=
 THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULA=
R PURPOSE
> + * ARE DISCLAIMED. =A0IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS =
BE LIABLE
> + * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONS=
EQUENTIAL
> + * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE=
 GOODS
> + * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPT=
ION)
> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRAC=
T, STRICT
> + * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN=
 ANY WAY
> + * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILI=
TY OF
> + * SUCH DAMAGE.
> + */
> +
> +#if 0
> +#include <sys/cdefs.h>
> +#if defined(LIBC_SCCS) && !defined(lint)
> +#if 0
> +static char sccsid[] =3D "@(#)getpass.c =A08.1 (Berkeley) 6/4/93";
> +#else
> +__RCSID("$NetBSD: getpass.c,v 1.15 2003/08/07 16:42:50 agc Exp $");
> +#endif
> +#endif /* LIBC_SCCS and not lint */

We usually don't keep dead code around. Since you've already edited
the file, perhaps you should just delete those lines?

> +
> +#if 0
> +#ifdef __weak_alias
> +__weak_alias(getpass,_getpass)
> +#endif
> +#endif


Same here.

> +
> +char *
> +gitgetpass(prompt)
> + =A0 =A0 =A0 const char *prompt;
> +{
> + =A0 =A0 =A0 struct termios term;
> + =A0 =A0 =A0 int ch;
> + =A0 =A0 =A0 char *p;
> + =A0 =A0 =A0 FILE *fp, *outfp;
> + =A0 =A0 =A0 int echo;
> + =A0 =A0 =A0 static char buf[_PASSWORD_LEN + 1];

Is _PASSWORD_LEN portable? A google search of "site:opengroup.org
_PASSWORD_LEN " returns nothing...

The getpass implementation in compat/mingw.c uses a strbuf, so it
doesn't have a limit on the password-length. Perhaps that would be an
improvement here?

> + =A0 =A0 =A0 sigset_t oset, nset;
> +
> +#if 0
> + =A0 =A0 =A0 _DIAGASSERT(prompt !=3D NULL);
> +#endif

Again, dead code.

> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* read and write to /dev/tty if possible; else read =
from
> + =A0 =A0 =A0 =A0* stdin and write to stderr.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if ((outfp =3D fp =3D fopen(_PATH_TTY, "w+")) =3D=3D NU=
LL) {

Is _PATH_TTY portable? A google search of "site:opengroup.org
_PATH_TTY" returns nothing...
