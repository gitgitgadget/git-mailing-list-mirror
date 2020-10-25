Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86CFC4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 23:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E72F20790
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 23:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419329AbgJYXCn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 19:02:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56812 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1418851AbgJYXCm (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Oct 2020 19:02:42 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C87176074C
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 23:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1603666930;
        bh=xAzWw84ETZVwzQh0t9GiRhQNsgM8VxIVHl9veRQpZi4=;
        h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
         In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=1c8xVctYaktU0QLNAc5Loy50hop6GH2BLSLUJTxpG/q2bEhn5Ev5bHsm30bGO3Ojx
         C8+fWADkPL6yik8t1Kevzku0tAcYkQsOZjiBCKFQzS9dq7iR5FsbYmRIM1r9EcJO3i
         qPV5c4gbAwsNFCRHiGaYy8QX5HDX5DPWCe9QkQOt7/9m94FuID3j58tQV9hZjvrZHS
         DM7IQxmeJ8QJk607Wg1sr+KXYSIN3gEPx3/msw6U7XH0vYX8McvDiMdpwEGY8TN7U/
         L02sOyaUbjt1Y10JiS6PEGqlY/q+8/RTKk36ko4M9MNKUUZmlLXxttH5w+4+J8Iut8
         6Dk3G8hgHKug1OZ2vMOrEsm+1xqi70P3ryrJnHTeL4TUtZbJiFCgCGrtitYaXoD2c+
         kNV/9PQoNM4K/5SgJG2PDcItVX1QokakAO7T9ytsU0Vu3R4UA6dtMlE2+Az9o0R/Ze
         LLeKiW06Dp4WEKMobvkW7YRkkp91cLLm7w8bqlmHz5LlVfqTAsb
Date:   Sun, 25 Oct 2020 23:02:03 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: Re: Do porcelain command require lock management?
Message-ID: <20201025230203.GH860779@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20201024144637.cvwa22f2y4tvfn4z@chatter.i7.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4C6bbPZ6c/S1npyF"
Content-Disposition: inline
In-Reply-To: <20201024144637.cvwa22f2y4tvfn4z@chatter.i7.local>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4C6bbPZ6c/S1npyF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-10-24 at 14:46:37, Konstantin Ryabitsev wrote:
> Hello:
>=20
> A script I'm writing performs a succession of porcelain commands to
> create a commit in a bare git repository:
>=20
> git hash-object
> git mktree
> git commit-tree
> git update-ref
>=20
> Do I need to manage external locking around these commands to avoid any
> concurrency problems, or will git take care of that?

I'm almost certain that Git will do the same locking and object creation
semantics that it does in porcelain commands as in the plumbing commands
you're using.  For example, I happen to know that all loose object
creation goes through one function, which should gracefully handle
concurrent accesses.  Git is in general safe against concurrent accesses
and is designed not to lose or corrupt data in this case.

However, I will point out that ref updates may conflict and if so, Git
will fail instead of waiting.  So while your repository will remain
consistent and won't experience corruption, that doesn't mean that all
operations will complete successfully.  Some sort of retry mechanism or
other error handling will probably be warranted.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--4C6bbPZ6c/S1npyF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX5YD6gAKCRB8DEliiIei
gR76AP9LONGN2B3gAYV+LGm4RRVJQYohIYPfUZybFPhsjAWUtAD+PyEbA3CrLMZX
dUnkmWEs0RSbASL1NTtcw4fkw3VZCQo=
=Y94n
-----END PGP SIGNATURE-----

--4C6bbPZ6c/S1npyF--
