Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EBEC433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 07:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0EF520727
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 07:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbhAYHgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 02:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbhAYHg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 02:36:28 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499D6C061573
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 23:35:15 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l3wP0-0001IJ-QF; Mon, 25 Jan 2021 08:35:10 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l3wOy-00050X-Qa; Mon, 25 Jan 2021 08:35:08 +0100
Date:   Mon, 25 Jan 2021 08:35:08 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] range-diff/format-patch: refactor check for
 commit range
Message-ID: <20210125073508.l7ksohyfhcogch4x@pengutronix.de>
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
 <pull.841.v2.git.1611339373.gitgitgadget@gmail.com>
 <3f21e10f919eead049dc2440a29bb2bed6c99d0d.1611339373.git.gitgitgadget@gmail.com>
 <xmqqzh107m5d.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aftbhbozzha65n2k"
Content-Disposition: inline
In-Reply-To: <xmqqzh107m5d.fsf@gitster.c.googlers.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aftbhbozzha65n2k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 22, 2021 at 12:27:10PM -0800, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Currently, when called with exactly two arguments, `git range-diff`
> > tests for a literal `..` in each of the two. Likewise, the argument
> > provided via `--range-diff` to `git format-patch` is checked in the same
> > manner.
> >
> > However, `<commit>^!` is a perfectly valid commit range, equivalent to
> > `<commit>^..<commit>` according to the `SPECIFYING RANGES` section of
> > gitrevisions[7].
> >
> > In preparation for allowing more sophisticated ways to specify commit
> > ranges, let's refactor the check into its own function.
>=20
> I think the sharing between the two makes sense, but the helper
> function should make it clear in its name that this is "the kind of
> commit range range-diff wants to take".  Among the commit range "git
> log" and friends can take, range-diff can take only a subset of it,
> and only a subset of it is meaningful to range-diff (e.g. HEAD^@ is
> still a commit range you can give to "git log", but it would not
> make much sense to give it to range-diff).

Does it make so little sense to forbid passing HEAD^@ as a range to
range-diff? I can imagine situations where is would make sense, e.g. I
often create customer patch stacks from a set of topic branches using
octopus merge. To compare two of these ^@ might be handy.

My POV is that if it's easy to use the same function (and so the same
set of range descriptors) for git log and git range-diff then do so.
This yields a consistent behaviour which is IMHO better than preventing
people to do things that are considered strange today.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--aftbhbozzha65n2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAOdKkACgkQwfwUeK3K
7AlxZwf/SLEM299R6ngrm/9LBrEqqypGPZp9sysvqH2WJBLYnn4TtJW2eyVHqoAY
22T8N3cVzRgWgx+cuQO0stTtlqKKu31Ruw5anR2KGJwF88t2bZoYSw9ePoKmgXLc
HR8XJKPhGCl17InySausPGBJiXqFLjMzH7wW3bF0jlwaOeBtxBCp0tsFbe0xKccU
VVHnLQkaxNd6R81rEMBxgDRzt+SSI4vgkd/6BZKbIPM9X58BdsuMr2MgC0OWmCA8
QZqmKGT5GviAbw96jT2rrO/IBJwJyoCXc/VFPIkhG2ODXcQMAF3uTmrFZjpuocFQ
o7OJW7rZb1MD2uu0nsTo0o3WGEYa9w==
=zI9f
-----END PGP SIGNATURE-----

--aftbhbozzha65n2k--
