Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Greylist: delayed 522 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Nov 2023 00:47:05 PST
Received: from outbound.soverin.net (outbound.soverin.net [IPv6:2a10:de80:1:4092:b9e9:2292:0:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FB210A
	for <git@vger.kernel.org>; Mon, 27 Nov 2023 00:47:05 -0800 (PST)
Received: from smtp.freedom.nl (c04cst-smtp-frd02.int.sover.in [10.10.4.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4SdzWH3LvHzJ5;
	Mon, 27 Nov 2023 08:38:19 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [10.10.4.108]) by freedom.nl (Postfix) with ESMTPSA id 4SdzWG6Pxzz2xqm;
	Mon, 27 Nov 2023 08:38:18 +0000 (UTC)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freedom.nl;
	s=default; t=1701074299;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2DheC75w1zyblh0K+Mh/QkDV0bfgeqceny8KByIcYdk=;
	b=ZLDLJdfqBwxwpfv1P3E/teZ7Z+ZYBwRcD8xfUcnkr35SwqVqvdgzJEi5uh5cqKDiddkBBr
	H4iI4jCayX8FOddYanHMpZu9/0AoTNTyTIEuBrM61knA0+NeNTJpccqPQktdH3d6/vSB1R
	Qx+jDipmWfdwUGtwyq+/kh/NRLZYDjU=
ARC-Authentication-Results: i=1;
	smtp.freedom.nl;
	auth=pass smtp.mailfrom=linux@tux.freedom.nl
ARC-Seal: i=1; s=default; d=freedom.nl; t=1701074299; a=rsa-sha256;
	cv=none;
	b=eshLajqt5AYCAAwdl61TgRkZaU346Jat4s5PWZlfccssFB32JncNFjJH5TMFVUsg6hmoXY
	xKFDFS22xCNJTgogLIbyE+LUC6RHbxFiNkbyeXZnDw9S/L9rN5djDynwN6a/iK2kmpitWj
	ab1VJIDFfb+WpvvLLPdy8S16bg2Cm3s=
Date: Mon, 27 Nov 2023 09:38:10 +0100
X-Soverin-Authenticated: true
From: "H.Merijn Brand" <linux@tux.freedom.nl>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Fix git-send-email.perl w.r.t. recent Getopt::Long update
Message-ID: <20231127093810.2092fe1d@pc09>
In-Reply-To: <xmqqzfz03tbn.fsf@gitster.g>
References: <20231124103932.31ca7688@pc09>
	<xmqqzfz03tbn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2V6K0LtRBTPit_/bRPk=TaO";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/2V6K0LtRBTPit_/bRPk=TaO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Nov 2023 09:58:52 +0900, Junio C Hamano <gitster@pobox.com> wrot=
e:

> "H.Merijn Brand" <linux@tux.freedom.nl> writes:
>=20
> > From the Getopt::Long changes:
> > ```
> > Changes in version 2.55
> > -----------------------
> > * Fix long standing bug that duplicate options were not detected when
> >   the options differ in case while ignore_case is in effect.
> >   This will now yield a warning and become a fatal error in a future
> >   release.
> > ```
> >
> > Current version is 2.57 =20
>=20
> This patch looks like duplicate of
>=20
>   https://lore.kernel.org/git/20231116193014.470420-1-tmz@pobox.com/
>=20
> perhaps independently discovered and worked on.  Thanks for caring.
>=20
> One downside of unconditional upgrade of the call is, of course,
> that it would no longer work for those with older Getopt::Long that
> did not support the "!" suffix.  Fortunately, Getopt::Long 2.33
> started shipping with Perl 5.8.1 that is more than 20 years old, so
> with the series we accepted, we also have a change to bump the
> required version of Perl from 5.8.0 to 5.8.1 to make it clear that
> it is deliberate that we drop the support for anything older at the
> same time.

The is a no-issue ...

Just the 'use Getopt::Long' is enough to guarantee a working version:

The '!' was already implemented in version 2.10 (April 1997):
--8<---
=3Ditem !

Option does not take an argument and may be negated, i.e. prefixed by
"no". E.g. "foo!" will allow B<--foo> (with value 1) and B<-nofoo>
(with value 0).
The option variable will be set to 1, or 0 if negated.
-->8---

Looking at the ChangeLog,  a reliable behavior of '!' was available
since version 2.22 (march 2000):
--8<---
Changes in version 2.22
-----------------------

* Fixes a bug in the combination of aliases and negation.

  Old:  "foo|bar!" allowed negation on foo, but not on bar.
  New:  "foo|bar!" allows negation on foo and bar.

  Caveat: "foo|f!", with bundling, issues the warning that negation on
  a short option is ignored. To obtain the desired behaviour, use

        "foo!" =3D> \$opt_foo, "f" =3D> \$opt_foo
  or
        "foo|f" =3D> \$opt_foo, "nofoo" =3D> sub { $opt_foo =3D 0 }

  Remember that this is _only_ required when bundling is in effect.
-->8---

--=20
H.Merijn Brand  https://tux.nl   Perl Monger   http://amsterdam.pm.org/
using perl5.00307 .. 5.37        porting perl5 on HP-UX, AIX, and Linux
https://tux.nl/email.html http://qa.perl.org https://www.test-smoke.org
                          =20

--Sig_/2V6K0LtRBTPit_/bRPk=TaO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEGolmczWuFi3lJEbAA6FHoT5dwJgFAmVkVXIACgkQA6FHoT5d
wJjTVgf+LuiDAP6nWo8ZlkxBZmUIdxclKfeBwrOlb24o0SezU1lAjx6giT7o0RTA
KZdrF0f5A9CH5o8GltGbty/BJrjMoMsvNV7HbiUBewtDy3Z6mpu09bMGshKrBXyo
GDPpKZ3PE2um1kP3/CvBqjswyycXE+sQaEvXhkSgLFuYIIRiv/S0lYoD9P32Aiqq
EgRK23lbCEPGNO25AjwsCzUBvQJgmAb87iumujeEW0d4yBIl/h1kEIDMnsaZO0ue
oqozgWQSnUWzvALfhFeJKV+nIFN8djQnMhSWIv9j0PUHYd8EKUSFHvUi+tHFQjVn
Ig8JJvUMPd96HIKTb8Uf4tUAAG2Tpg==
=28ac
-----END PGP SIGNATURE-----

--Sig_/2V6K0LtRBTPit_/bRPk=TaO--
