Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5C811F453
	for <e@80x24.org>; Sat,  3 Nov 2018 15:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeKDAoC (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 20:44:02 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:59442 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbeKDAoC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 20:44:02 -0400
Received: from pomiot (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 23E6D335C6F;
        Sat,  3 Nov 2018 15:32:21 +0000 (UTC)
Message-ID: <1541259137.1028.12.camel@gentoo.org>
Subject: Re: [PATCH v4] gpg-interface.c: detect and reject multiple
 signatures on commits
From:   =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Date:   Sat, 03 Nov 2018 16:32:17 +0100
In-Reply-To: <CACsJy8DKD3F3o74gTHW-WEL_hpB8x+oaWX8_SwN01Nmz3W9Z_w@mail.gmail.com>
References: <20181020193020.28517-1-mgorny@gentoo.org>
         <CACsJy8DKD3F3o74gTHW-WEL_hpB8x+oaWX8_SwN01Nmz3W9Z_w@mail.gmail.com>
Organization: Gentoo
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-2X3ZOUeWYRl5P4aRkvip"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-2X3ZOUeWYRl5P4aRkvip
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2018-11-03 at 16:17 +0100, Duy Nguyen wrote:
> On Sat, Oct 20, 2018 at 9:31 PM Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org=
> wrote:
> > +test_expect_success GPG 'detect fudged commit with double signature' '
> > +       sed -e "/gpgsig/,/END PGP/d" forged1 >double-base &&
> > +       sed -n -e "/gpgsig/,/END PGP/p" forged1 | \
> > +               sed -e "s/^gpgsig//;s/^ //" | gpg --dearmor >double-sig=
1.sig &&
> > +       gpg -o double-sig2.sig -u 29472784 --detach-sign double-base &&
> > +       cat double-sig1.sig double-sig2.sig | gpg --enarmor >double-com=
bined.asc &&
> > +       sed -e "s/^\(-.*\)ARMORED FILE/\1SIGNATURE/;1s/^/gpgsig /;2,\$s=
/^/ /" \
> > +               double-combined.asc > double-gpgsig &&
> > +       sed -e "/committer/r double-gpgsig" double-base >double-commit =
&&
> > +       git hash-object -w -t commit double-commit >double-commit.commi=
t &&
> > +       test_must_fail git verify-commit $(cat double-commit.commit) &&
> > +       git show --pretty=3Dshort --show-signature $(cat double-commit.=
commit) >double-actual &&
> > +       grep "BAD signature from" double-actual &&
> > +       grep "Good signature from" double-actual
> > +'
>=20
> This test fails on 'master' today for me
>=20
> gpg: WARNING: multiple signatures detected.  Only the first will be check=
ed.
> gpg: Signature made Sat Nov  3 15:13:28 2018 UTC
> gpg:                using DSA key 13B6F51ECDDE430D
> gpg:                issuer "committer@example.com"
> gpg: BAD signature from "C O Mitter <committer@example.com>" [ultimate]
> gpg: BAD signature from "C O Mitter <committer@example.com>" [ultimate]
> not ok 16 - detect fudged commit with double signature
>=20
> Perhaps my gpg is too old?
>=20
> $ gpg --version
> gpg (GnuPG) 2.1.15
> libgcrypt 1.7.3
> Copyright (C) 2016 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.=
html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
>=20
> Home: /home/pclouds/.gnupg
> Supported algorithms:
> Pubkey: RSA, ELG, DSA, ECDH, ECDSA, EDDSA
> Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
>         CAMELLIA128, CAMELLIA192, CAMELLIA256
> Hash: SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
> Compression: Uncompressed, ZIP, ZLIB, BZIP2

Perhaps this is indeed specific to this version of GnuPG.  The tests
pass for me with both 1.4.21 and 2.2.10.  We don't have 2.1* in Gentoo
anymore.

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--=-2X3ZOUeWYRl5P4aRkvip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEXr8g+Zb7PCLMb8pAur8dX/jIEQoFAlvdv4JfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDVF
QkYyMEY5OTZGQjNDMjJDQzZGQ0E0MEJBQkYxRDVGRjhDODExMEEACgkQur8dX/jI
EQqchg//QaAZwfVX7h/dLvkZx2Rv5SBofDEsMYlQkMLuNeIslyyf6f1EN3sfF+ph
JWIZTAtRydHn5joWZMCak6tY+ZibzAkDckKMC3gjcZQ+iU9KLxhhbxAopQiX+V4J
I712H4jMlZLbX5GVdSjdfIOcu9vMnNLHMqFEWJLEEKFhvz+R6wYNAByanZbQ5vZf
GumRMEjBBrg84c1NPi3mPD+/UNyaGRc/KrVgDg2CJCSw+APz1K4BT3M1P6Nc2dBY
r1SdP77B3bLsw2BsFnUxzRjvCnDwsba24VjgB342E1ZDW1lfxH1MsAcaPbhwXlSO
vRUXVTRqr5+Ld1d3taEwze7YPkWITaPUUATjKX8RWVueCqwSZWtwjCcg8ci507Il
vtWjtqO/IQ8+Bj7zGIdcES1ssTBOJV5XbHLg81LT4xQZvMaFQfl8hK6Ajr9CWR5D
DNh+DS6PxWFzOFv6f5CdGzg4VzzfBnwTU8A+jv59ykxNT5zeTuXra3DXQLrk4zGe
ygKukednxB5FjosOshW8UIsJmhip/IGQ/3upfWLFZMlH4ohgynjQXHtWkpA7G9Ya
LMpkgJorvaSJuqAkciYVdrmBi7HY68YrAQb+0XHq1UlAsejIUYJyNGcQ7ollpURV
SDgtW+YjQvb21ZdpSHt2JtD9fi70U/cposu+uy03Esn9XLZnwa4=
=6kkG
-----END PGP SIGNATURE-----

--=-2X3ZOUeWYRl5P4aRkvip--

