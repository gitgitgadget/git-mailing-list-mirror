From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] git-compat-util.h: Don't define NORETURN under __clang__
Date: Tue, 03 Aug 2010 15:35:47 +0200
Message-ID: <vpq62zr24zw.fsf@bauges.imag.fr>
References: <1280840883-24540-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 15:40:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgHj4-0006CX-4H
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 15:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756379Ab0HCNfy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 09:35:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44068 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752952Ab0HCNfx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 09:35:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o73DXiNj001132
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 3 Aug 2010 15:33:44 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OgHem-000292-2O; Tue, 03 Aug 2010 15:35:48 +0200
In-Reply-To: <1280840883-24540-1-git-send-email-avarab@gmail.com>
 (=?iso-8859-1?Q?=22=C6var_Arnfj=F6r=F0?= Bjarmason"'s message of "Tue\,  3
 Aug 2010 13\:08\:03 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 03 Aug 2010 15:33:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o73DXiNj001132
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281447227.53458@2x4AmAkgqkKpRdkptuGHaA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152520>

=C6var Arnfj=F6r=F0 Bjarmason venit, vidit, dixit 03.08.2010 15:08:

> clang version 1.0 on Debian testing x86_64 defines __GNUC__, but barf=
s
> on `void __attribute__((__noreturn__))'. E.g.:
>=20
>     usage.c:56:1: error: function declared 'noreturn' should not retu=
rn [-Winvalid-noreturn]
>     }
>     ^
>     1 diagnostic generated.
>     make: *** [usage.o] Error 1

It doesn't mean that it's not accepting __noreturn__, it means it was
not smart enough to check that the function do not return.

In my git, usage.c:56: leads me to this function:

void usagef(const char *err, ...)
{
	va_list params;

	va_start(params, err);
	usage_routine(err, params);
	va_end(params);
}

The absence of return comes from usage_routine, which is a pointer to
function, and it seems your version of clang doesn't handle
__noreturn__ pointers to functions properly.

On my box:

git$ make -B CC=3Dclang V=3Dyes usage.o                                =
                                                                       =
=20
clang -o usage.o -c   -g -Wall -Werror -I.  -DHAVE_PATHS_H -DSHA1_HEADE=
R=3D'<openssl/sha.h>'  -DNO_STRLCPY -DNO_MKSTEMPS  usage.c
git$ clang --version
clang version 1.1 (branches/release_27)
Target: i386-pc-linux-gnu
Thread model: posix

so, more recent clang do not seem to have this issue.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 02a73ee..c651cb7 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -183,7 +183,10 @@ extern char *gitbasename(char *);
>  #define is_dir_sep(c) ((c) =3D=3D '/')
>  #endif
> =20
> -#ifdef __GNUC__
> +#ifdef __clang__
> +#define NORETURN
> +#define NORETURN_PTR __attribute__((__noreturn__))
> +#elif __GNUC__

If you go for something like this, you should check the version of
clang, and special-case only version < 1.1.

But I'm not sure special-casing old version of a young compiler really
makes sense. We're only talking about warnings here, so I'd say you
should either upgrade clang or remove -Werror from your CFLAGS.

(other than that, it's cool to see someone testing another
compiler ;-) )

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
