From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [RFC][PATCH 00/10] Sparse: Git's "make check" target
Date: Sat, 09 Jun 2007 00:08:52 -0700
Message-ID: <466A5204.6060200@freedesktop.org>
References: <4669D2F2.90801@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC513410B810FC6C99AF7ACE5"
Cc: Junio C Hamano <junkio@cox.net>,
	GIT Mailing-list <git@vger.kernel.org>,
	linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Jun 09 09:09:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwv4W-0001as-I4
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 09:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbXFIHJP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 03:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752652AbXFIHJO
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 03:09:14 -0400
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:43102 "EHLO
	mail5.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbXFIHJN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 03:09:13 -0400
Received: (qmail 1607 invoked from network); 9 Jun 2007 07:09:12 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail5.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <ramsay@ramsay1.demon.co.uk>; 9 Jun 2007 07:09:11 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <4669D2F2.90801@ramsay1.demon.co.uk>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49559>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC513410B810FC6C99AF7ACE5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ramsay Jones wrote:
> Since the Git Makefile has a "check" target that uses sparse, I decided=
 to
> take a look at the sparse project to see what it was about, and what it=

> has to say about the git source code.

Glad to hear it!

> Initially, I had many problems because I am using cygwin, but I was abl=
e to
> fix most of those problems. (the output from "make check" was about 16k=

> lines at one point!). Git also tickled a bug in sparse 0.2, which resul=
ted
> in some 120+ lines of bogus warnings; that was fixed in version 0.3 (co=
mmit
> 0.2-15-gef25961).  As a result, sparse version 0.3 + my patches, elicit=
s 106
> lines of output from "make check".

One note about using Sparse with Git: you almost certainly don't want to =
pass
-Wall to sparse, and current Git passes CFLAGS to Sparse which will do ex=
actly
that.  -Wall turns on all possible Sparse warnings, including nitpicky
warnings and warnings with a high false positive rate.  You should start =
from
the default set of Sparse warnings, and add additional warnings as desire=
d, or
turn off those you absolutely can't live with.  Current Sparse from Git (=
post
0.3, after commit e18c1014449adf42520daa9d3e53f78a3d98da34) has a change =
to
cgcc to filter out -Wall, so you can pass -Wall to GCC but not Sparse.  S=
ee
below for other reasons why you should use cgcc.

That said, this suggests that perhaps Sparse should treat -Wall different=
ly
for compatibility with GCC; specifically, perhaps Sparse should just igno=
re
-Wall, as its meaning with GCC (enable a reasonable default set of warnin=
gs)
already occurs by default in Sparse.  The current -Wall could become some=
thing
like -Weverything.  This would make Sparse somewhat less intuitive, but
somewhat more GCC compatible.

> Naturally, I decided to "fix" the warnings produced by sparse, which re=
sulted
> in the following patch series:
>=20
> [PATCH 01/10] Sparse: fix "non-ANSI function declaration" warnings
> [PATCH 02/10] Sparse: fix some "using integer as NULL pointer" warnings=

> [PATCH 03/10] Sparse: fix some "symbol not declared" warnings (Part 1)
> [PATCH 04/10] Sparse: fix some "symbol not declared" warnings (Part 2)
> [PATCH 05/10] Sparse: fix some "symbol not declared" warnings (Part 3)
> [PATCH 06/10] Sparse: fix "'add_head' not declared" warning
> [PATCH 07/10] Sparse: fix "'merge_file' not declared" warning
> [PATCH 08/10] Sparse: fix an "incorrect type in argument n" warning
> [PATCH 09/10] Sparse: fix some "symbol 's' shadows an earlier one" warn=
ings
> [PATCH 10/10] Sparse: fix a "symbol 'weak_match' shadows an earlier one=
" warning

Awesome.  I'll take a look at that patch series.

> However, this patch series does not completely remove all warnings; the=
 output
> is reduced to:
>=20
> builtin-pack-objects.c:312:31: warning: Using plain integer as NULL poi=
nter
> csum-file.c:152:22: warning: Using plain integer as NULL pointer
> exec_cmd.c:7:40: error: undefined identifier 'GIT_EXEC_PATH'
> git.c:209:35: error: undefined identifier 'GIT_VERSION'
> http.c:203:46: error: undefined identifier 'GIT_USER_AGENT'
> index-pack.c:201:25: warning: Using plain integer as NULL pointer
> index-pack.c:538:26: warning: Using plain integer as NULL pointer
>=20
> The three "undefined identifier 'GIT_...'" are easy to remove, I just d=
idn't
> get around to doing it (The GIT_... symbols are macros, defined in indi=
vidual
> make rules rather than CFLAGS, an thus not passed to sparse).

You can easily fix that problem if you use cgcc as CC.

> The four "Using plain integer...", whilst equally easy to remove, argua=
bly should
> not be ;-)  If you look at the code you will find they are all of the f=
orm
>     x =3D crc32(0, Z_NULL, 0);
> where the second parameter type is basically (unsigned char *) and the =
Z_NULL
> macro is defined in the zlib header file as 0.  It could be said that t=
his is
> "idiomatic zlib usage" and should remain as written.  If you don't subs=
cribe
> to that view, then the required patch is obvious :P)
[...]
> [Note: As far as the NULL pointer warnings are concerned, I don't much =
care either
> way. I just used that as an example (also note patch 02). Having said t=
hat, I
> do think that the "NULL is the only one true null pointer" brigade need=
 to
> chill out a little; in fact I remember when 0 was the *only* null point=
er.]

And at one point prototypes didn't exist either. :)

Other valid null pointers exist, such as (void *)0.  You could also use (=
char
*)0 in this particular case.  Sparse complains because you just use the
integer 0.  I suggest just using NULL.

If you want to keep using Z_NULL rather than NULL, you could always undef=
 it
and define it as NULL after including the zlib header files.

If you really want to turn that particular Sparse warning off, you can us=
e
-Wno-non-pointer-null.  However, I don't think you should do that.

> If you are on Linux and want to play along, then the official version 0=
=2E3
> release of sparse should work for you, along with a minor change to the=

> Makefile thus:
>=20
> --->8---
> diff --git a/Makefile b/Makefile
> index 19b6da1..ac3e2af 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -184,7 +184,7 @@ export TCL_PATH TCLTK_PATH
> =20
>  # sparse is architecture-neutral, which means that we need to tell it
>  # explicitly what architecture to check for. Fix this up for yours..
> -SPARSE_FLAGS =3D -D__BIG_ENDIAN__ -D__powerpc__
> +SPARSE_FLAGS =3D -D__STDC__=3D1 $(shell cat .sparse_flags)
> =20
> --->8---
>=20
> where the .sparse_flags file is created with a script (gen-sparse-flags=
=2Esh)
> as follows:
>=20
> --->8---
> #/bin/sh
>=20
> rm -f /tmp/foo.h .macros; touch /tmp/foo.h
>=20
> gcc -E -dM /tmp/foo.h >.macros
> sed -e "s/^#define /-D'/" -e "s/ /=3D/" -e "s/$/'/" <.macros >.sparse_f=
lags=20
>=20
> rm -f /tmp/foo.h
>=20
> --->8---

Note that you could do that much more simply by using:
gcc -E -dM -x c /dev/null | sed ...

However, see below about using cgcc instead.

> Note: setting __STDC__ in the SPARSE_FLAGS should not be necessary (I t=
hought
> I needed it at one point...) but I didn't get around to removing it.

Sparse has defined __STDC__ since 2003, well before even version 0.1.

> As an alternative, you could clear the SPARSE_FLAGS and change the "che=
ck" target
> to call "cgcc -no-compile" in place of sparse.

Please go with that option.  In addition to providing an easy way to use
sparse and GCC together (make CC=3Dcgcc), cgcc defines arch-specific flag=
s that
sparse currently does not.  Ideally sparse should define these flags, but=
 that
would add some architecture-specific logic to sparse, which would then re=
quire
sparse to know the desired machine target.  That may need to happen in th=
e
future, but I don't have a good plan for how to do it yet.  In the meanti=
me,
please run sparse through cgcc.

Also, you might consider just using cgcc to run both GCC and Sparse.  Tha=
t
would handle the issue of target-specific CFLAGS, by ensuring that Sparse=
 and
GCC always see the same CFLAGS.

- Josh Triplett



--------------enigC513410B810FC6C99AF7ACE5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGalISGJuZRtD+evsRAuUfAKCcUMbaXz8FgYeRAOz8xaPJ3E8d7ACeJo1n
VVfXdfRviupmi7IbqfNJIS0=
=8y33
-----END PGP SIGNATURE-----

--------------enigC513410B810FC6C99AF7ACE5--
