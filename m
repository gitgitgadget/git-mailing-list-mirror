From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/5] config.mak.uname: supporting 64-bit MSys2
Date: Thu, 21 Jan 2016 11:36:14 +0100
Message-ID: <1453372574-20431-1-git-send-email-szeder@ira.uka.de>
References: <a54e0357d8f274c7ffa49daa2c91ba371fa501ab.1452691805.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 21 11:36:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMCbk-0003qe-Rk
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 11:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759240AbcAUKgo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Jan 2016 05:36:44 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:55712 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759233AbcAUKgm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2016 05:36:42 -0500
Received: from x4db25724.dyn.telefonica.de ([77.178.87.36] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aMCbX-0006NP-Mu; Thu, 21 Jan 2016 11:36:41 +0100
X-Mailer: git-send-email 2.7.0.rc2.34.g28a1f98
In-Reply-To: <a54e0357d8f274c7ffa49daa2c91ba371fa501ab.1452691805.git.johannes.schindelin@gmx.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1453372601.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284512>

> This just makes things compile, the test suite needs extra tender lov=
ing
> care in addition to this change. We will address these issues in late=
r
> commits.
>=20
> While at it, also allow building MSys2 Git (i.e. a Git that uses MSys=
2's
> POSIX emulation layer).
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  config.mak.uname | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/config.mak.uname b/config.mak.uname
> index b0592c1..4b2e1b8 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -518,13 +518,12 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>  	NO_INET_NTOP =3D YesPlease
>  	NO_POSIX_GOODIES =3D UnfortunatelyYes
>  	DEFAULT_HELP_FORMAT =3D html
> -	COMPAT_CFLAGS +=3D -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/wi=
n32
> +	COMPAT_CFLAGS +=3D -DNOGDI -Icompat -Icompat/win32
>  	COMPAT_CFLAGS +=3D -DSTRIP_EXTENSION=3D\".exe\"
>  	COMPAT_OBJS +=3D compat/mingw.o compat/winansi.o \
>  		compat/win32/pthread.o compat/win32/syslog.o \
>  		compat/win32/dirent.o
>  	BASIC_CFLAGS +=3D -DPROTECT_NTFS_DEFAULT=3D1
> -	BASIC_LDFLAGS +=3D -Wl,--large-address-aware
>  	EXTLIBS +=3D -lws2_32
>  	GITLIBS +=3D git.res
>  	PTHREAD_LIBS =3D

(On Windows I only used git, and only briefly, and it was back in the
v1.9.x era, so please pardon my ignorance...)

I'm puzzled by the if statements in the hunk below:

> @@ -545,8 +544,17 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
>  else
>  	ifeq ($(shell expr "$(uname_R)" : '2\.'),2)
>  		# MSys2
> +		prefix =3D /usr/
> +		ifeq (MINGW32,$(MSYSTEM))
> +			prefix =3D /mingw32

Here prefix is set for 32 bit MSys2.  OK.

> +		endif
> +		ifeq (MINGW64,$(MSYSTEM))
> +			prefix =3D /mingw64

Here prefix is set for 64 bit MSys2.  Still OK.

> +		else
> +			COMPAT_CFLAGS +=3D -D_USE_32BIT_TIME_T
> +			BASIC_LDFLAGS +=3D -Wl,--large-address-aware

But then these flags are set for any MSys2 that is not 64 bit, which
also includes MINGW32, which we've already dealt with above
explicitly.  Hmm.

Is this intentional?  It would be easier to follow if the settings
specific to MINGW32 weren't scattered in two discontinuous blocks.
What values can MSYSTEM have here besides MINGW32 and MINGW64?

Thanks,
G=C3=A1bor

> +		endif
>  		CC =3D gcc
> -		prefix =3D /mingw32
>  		COMPAT_CFLAGS +=3D -D__USE_MINGW_ANSI_STDIO=3D0
>  		INSTALL =3D /bin/install
>  		NO_R_TO_GCC_LINKER =3D YesPlease
> --=20
> 2.6.3.windows.1.300.g1c25e49
