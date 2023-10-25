Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312DC2D626
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80702D53
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 00:40:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qvYV6-00030B-AQ; Wed, 25 Oct 2023 09:40:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qvYV5-0047vy-MW; Wed, 25 Oct 2023 09:40:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qvYV5-005pg5-DN; Wed, 25 Oct 2023 09:40:23 +0200
Date: Wed, 25 Oct 2023 09:40:23 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jeff King <peff@peff.net>
Cc: Luben Tuikov <luben.tuikov@amd.com>,
	Michael Strawbridge <michael.strawbridge@amd.com>,
	git@vger.kernel.org, entwicklung@pengutronix.de
Subject: Re: Regression: git send-email fails with "Use of uninitialized
 value $address" + "unable to extract a valid address"
Message-ID: <20231025074023.dowdv67urpjtzzka@pengutronix.de>
References: <20231013141437.ywrhw65xdapmev7d@pengutronix.de>
 <20231020100442.an47wwsti2d4zeyx@pengutronix.de>
 <68d7e5c3-6b4a-4d0d-9885-f3d4e2199f26@amd.com>
 <20231024130037.sbevzk2x7oclj7d7@pengutronix.de>
 <89712aea-04fc-4775-afd4-afd3ca24ad01@amd.com>
 <20231024204318.gi6b4ygqbilm2yke@pengutronix.de>
 <20231025072104.GA2145145@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="swx3a54tljgiqlgj"
Content-Disposition: inline
In-Reply-To: <20231025072104.GA2145145@coredump.intra.peff.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org


--swx3a54tljgiqlgj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Oct 25, 2023 at 03:21:04AM -0400, Jeff King wrote:
> On Tue, Oct 24, 2023 at 10:43:18PM +0200, Uwe Kleine-K=F6nig wrote:
>=20
> > I debugged a bit and if I do
> >=20
> > 	mv .git/hooks/sendemail-validate .git/hooks/sendemail-validate.bak
> >=20
> > git send-email --to 'Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de=
>'
> > starts to work for me, too.
> >=20
> > I'd guess the content of my sendemail-validate script doesn't matter
> > much, but for the record, it's:
> >=20
> > 	#!/bin/sh
> > 	# installed by patatt install-hook
> > 	patatt sign --hook "${1}"
> >=20
> > Does the problem reproduce on your end with a sendemail-validate script?
>=20
> I can reproduce with:
>=20
>   git init
>   echo foo >file && git add file && git commit -m foo
>   echo 'exit 0' >.git/hooks/sendemail-validate
>   chmod +x .git/hooks/sendemail-validate
>   git send-email --dry-run --to=3D'p=EBff <peff@peff.net>' -1
>=20
> Note that the bug will only trigger if Email::Valid is installed.

I can confirm I have this package installed (via Debian's
libemail-valid-perl).

> I think this is the same issue being discussed elsewhere. The call to
> process_address_list() sanitizes it to use rfc2047 encoding, which is
> necessary for it to be syntactically valid.
>=20
> So the patch to move the validation later in the process here:
>=20
>   https://lore.kernel.org/git/ee56c4df-e030-45f9-86a9-94fb3540db60@amd.co=
m/
>=20
> fixes it.

Tested and indeed that fixes my usecase. With that patch also the
original regression is fixed and I can do

	git send-email -1 --to 'Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de=
>, p=EBff <peff@peff.net>'

again. \o/

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--swx3a54tljgiqlgj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmU4xmYACgkQj4D7WH0S
/k5ssQf/cOi0PkECE7KjGsWjVT5UROXh/IvWvUwpkyq1FFWQ6ZaXtNlJJ/5bGeI7
eAIbbuH2NLFhAXsLWjBOBfgqclbzR71n+8hb87E4ygeqVie+U46LhVDjMEMEQ/5s
JCKu6/+ebGgVoSzMsx2ws3rO0KurpKpMl77mkKUb9XVF6M9R884mnHq/foUwXLGH
NJORHoJa4Ssf9Z6Exdwf4k0z2f92J1A+y18p06H2T3HVz5InjDb6UHd80Pz/EMwp
U9HI9BKotMN4U6mVyzZoMFQfTSWoNM/LBJGIiYr8zAV/+7DFL7spa4t0axxOGKvT
60OsoklT2EjY5l1msOz7vqOPeE5+2Q==
=l3Mh
-----END PGP SIGNATURE-----

--swx3a54tljgiqlgj--
