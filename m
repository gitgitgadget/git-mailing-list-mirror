From: =?UTF-8?B?IkphbiBILiBTY2jDtm5oZXJyIg==?= <schnhrr@cs.tu-berlin.de>
Subject: Re: [PATCH] wildmatch: correct isprint and isspace
Date: Thu, 15 Nov 2012 18:13:25 +0100
Message-ID: <50A522B5.7080206@cs.tu-berlin.de>
References: <1352803572-14547-1-git-send-email-pclouds@gmail.com> <1352981983-22005-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	rene.scharfe@lsrfire.ath.cx, Johannes Sixt <j6t@kdbg.org>,
	torvalds@linux-foundation.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 18:14:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ30j-0004Gx-HJ
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 18:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768444Ab2KORNk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2012 12:13:40 -0500
Received: from mail.eecsit.tu-berlin.de ([130.149.17.13]:46589 "EHLO
	mail.cs.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768123Ab2KORNj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 12:13:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost-12225.cs.tu-berlin.de (Postfix) with ESMTP id 2967A7533
	for <git@vger.kernel.org>; Thu, 15 Nov 2012 18:13:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at cs.tu-berlin.de (including SpamAssassin)
Received: from mailhost.cs.tu-berlin.de ([127.0.0.1])
	by localhost (mail.cs.tu-berlin.de [127.0.0.1]) (amavisd-new, port 12224)
	with ESMTP id aaFfxxnprj6N 17364-03;
	Thu, 15 Nov 2012 18:13:25 +0100 (CET) 13793
Received: from [130.149.91.59] (asahi.kbs.tu-berlin.de [130.149.91.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: schnhrr)
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTPSA;
	Thu, 15 Nov 2012 18:13:25 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120919 Thunderbird/10.0.7
In-Reply-To: <1352981983-22005-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209833>

Am 15.11.2012 13:19, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
>  On Thu, Nov 15, 2012 at 2:30 AM, Ren=C3=A9 Scharfe <rene.scharfe@lsr=
fire.ath.cx> wrote:
>  > Nevertheless, it's unfortunate that we have an isspace() that *alm=
ost* does
>  > what the widely known thing of the same name does.  I'd shy away f=
rom
>  > changing git's version directly, because it's used more than a hun=
dred times
>  > in the code, and estimating the impact of adding \v and \f to it.
>  > Perhaps renaming it to isgitspace() is a good first step, followed=
 by
>  > adding a "standard" version of isspace() for wildmatch?
>=20
>  There are just too many call sites of isspace() and there is a risk
>  of new call sites coming in independently. So I think keeping isspac=
e()
>  as-is and using a different name for the standard version is probabl=
y
>  a better choice.

After having a closer look, where wildmatch is actually used -- matchin=
g
filenames -- and I've not yet seen \v or \f in a filename, it's possibl=
y
unnecessary to do anything about isspace() right now.

(It's probably more an issue that filenames can be localized, and we on=
ly
support unlocalized character classes.)

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 02f48f6..d4c3fda 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -486,6 +486,7 @@ extern const unsigned char sane_ctype[256];
>  #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask=
)) !=3D 0)
>  #define isascii(x) (((x) & ~0x7f) =3D=3D 0)
>  #define isspace(x) sane_istest(x,GIT_SPACE)
> +#define isspace_posix(x) (((x) >=3D 9 && (x) <=3D 13) || (x) =3D=3D =
32)
>  #define isdigit(x) sane_istest(x,GIT_DIGIT)
>  #define isalpha(x) sane_istest(x,GIT_ALPHA)
>  #define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
> @@ -499,7 +500,8 @@ extern const unsigned char sane_ctype[256];
>  #define isxdigit(x) (hexval_table[x] !=3D -1)

This was from a previous patch, but maybe: "hexval_table[(unsigned char=
)x]"

>  #define isprint(x) (sane_istest(x, GIT_ALPHA | GIT_DIGIT | GIT_SPACE=
 | \
>  		GIT_PUNCT | GIT_REGEX_SPECIAL | GIT_GLOB_SPECIAL | \
> -		GIT_PATHSPEC_MAGIC))
> +		GIT_PATHSPEC_MAGIC) && \
> +		(x) >=3D 32)

May I suggest the current is_print() implementation in master:

#define isprint(x) ((x) >=3D 0x20 && (x) <=3D 0x7e)


To summarize my opinion:

I no longer see a reason to correct isspace() (unless somebody with an =
actual
use case complains), and a more POSIXly isprint() is already in master.

=3D> Nothing to do. :)

Regards
Jan
