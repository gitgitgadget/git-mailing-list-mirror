Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D752C4707F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 22:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DE5A61222
	for <git@archiver.kernel.org>; Thu, 27 May 2021 22:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbhE0WRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 18:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbhE0WRq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 18:17:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB02BC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 15:16:12 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lmOIV-0002po-62; Fri, 28 May 2021 00:16:11 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lmOIT-0001IY-Pq; Fri, 28 May 2021 00:16:09 +0200
Date:   Fri, 28 May 2021 00:16:09 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, entwicklung@pengutronix.de
Subject: Re: time needed to rebase shortend by using --onto?
Message-ID: <20210527221609.khkcmohmtfliykla@pengutronix.de>
References: <20210526100932.2hw4rbazgvd6mzff@pengutronix.de>
 <xmqqim35b0kz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nibxyw2h3isidh7y"
Content-Disposition: inline
In-Reply-To: <xmqqim35b0kz.fsf@gitster.g>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nibxyw2h3isidh7y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Junio,

On Thu, May 27, 2021 at 07:18:52AM +0900, Junio C Hamano wrote:
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> writes:
>=20
> > It rebases clean on v5.10:
> >
> > 	$ time git rebase v5.10
> > 	Performing inexact rename detection: 100% (36806539/36806539), done.
> > 	Performing inexact rename detection: 100% (36806539/36806539), done.
> > 	Performing inexact rename detection: 100% (36806539/36806539), done.
> > 	Performing inexact rename detection: 100% (36806539/36806539), done.
> > 	Successfully rebased and updated detached HEAD.
> >
> > 	real	3m47.841s
> > 	user	1m25.706s
> > 	sys	0m11.181s
> >
> > If I start with the same rev checked out and explicitly specify the
> > merge base, the rebase process is considerably faster:
> >
> > 	$ time git rebase --onto v5.10 v5.4
> > 	Performing inexact rename detection: 100% (36806539/36806539), done.
> > 	Performing inexact rename detection: 100% (36806539/36806539), done.
> > 	Performing inexact rename detection: 100% (36806539/36806539), done.
> > 	Performing inexact rename detection: 100% (36806539/36806539), done.
> > 	Successfully rebased and updated detached HEAD.
> >
> > 	real	1m20.588s
> > 	user	1m12.645s
> > 	sys	0m6.733s
> >
> > Is there some relevant complexity in the first invocation I'm not seeing
> > that explains it takes more than the double time? I would have expected
> > that
> >
> > 	git rebase v5.10
> >
> > does the same as:
> >
> > 	git rebase --onto v5.10 $(git merge-base HEAD v5.10)
>=20
> There is a voodoo called fork-point detection that walks back the
> reflogs and repeatedly computes merge bases, and giving --onto to
> explicitly give a commit on which the history is transplanted should
> remove the need to do the computation, so that is a possibility.
>=20
> But according to the manpage, it should not kick in for invocations
> in the above example that specify the <upstream> (the
> rebase.forkpoint configuration variable can clobber this default).

FTR: I don't have this variable set in the two repositories that show
the different timings.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nibxyw2h3isidh7y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCwGiUACgkQwfwUeK3K
7Alkewf+MeaaWFSRSZGWRRyO8Nzhy66sLBenTuWsmakWvdQcSt+rZ6LXexlp0KVJ
YP8yIKPlKWNeP4Lz3hTcT6kMEB21xOgGUh+p6iF+rABkYemkWNwAx3ETMg4E+3fE
elCRIv4v3cBhafTSrJUhB/LW9cdIznUgKhFL5EbjaTCNTdazEQWJ5ApsyqC0dG8/
0vbpcW7sYmO1M9AzWGzPkwbHj+X4463YD4xgDps8h34X2DJn9vhSShH/rZFppqsb
5zxrH7vavpv2eEfg53euV7SZt7dVqa1U0rurB/28chyzVNuT2Nrb3V9bxoTSO1Ag
21bB2MMzvUjbCycq5dlYNAWUwKRDAA==
=JswX
-----END PGP SIGNATURE-----

--nibxyw2h3isidh7y--
