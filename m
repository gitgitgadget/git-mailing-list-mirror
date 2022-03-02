Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA85C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 22:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbiCBWWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 17:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbiCBWWF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 17:22:05 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC13BD836E
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 14:21:20 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 1CA5E5A0D2;
        Wed,  2 Mar 2022 22:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1646259679;
        bh=0fdreOVtQpfaq/YrzW7oBbyzOsxJk6t6/Jt0sV36At4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=mDRaKHx+cgER6E7N9XpmQhXWRlvZdrV+u24xMD7OTe3WTNij8K2ybgRg15Sb8IhYg
         j5klaYC8PvY6GXZ4243yUhbrxtNf+HUTFIJpmt/Q/iI1Q902SGKK1kJKR8UzShLINU
         NQzw95Y5qBSQn48prnMdj1e0RP7dLx5Y/vQABcbcmOCGj9WIRltKL3EJraoZp+pqip
         1aLomf72QjojwrOI+jTnT6qtdYop3Fk+32bSPuljB9wf9AaujvCsdR0CKt6sfwYSH1
         NaP/hFX6FfQlndgO0K9IN1TrZlmhLYSY7wAnH3UbldMW+gChZL5avLtbokw2ZwBLz0
         2smoqxa7JmsCM8IJ1SWVPfUkn3QsDajGKz2QWawu+hWqyPlq3tzDP7VvS7Ad69svwI
         QRubsX8JEQj1o1QYixzArqJ+GrzHWmfuPUFegLxykWPe63z21CI409NTL+63J1Oosl
         Zr6SjxydADNY3jY1yiBYgKcAW1nysJAOJ8nZUj2kiuQGeoz/r57
Date:   Wed, 2 Mar 2022 22:21:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] builtin/remote.c: show progress when renaming remote
 references
Message-ID: <Yh/t3HfKiEMx957i@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
References: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xJP0MbUoQfd8jlO2"
Content-Disposition: inline
In-Reply-To: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xJP0MbUoQfd8jlO2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-03-01 at 22:20:33, Taylor Blau wrote:
> When renaming a remote, Git needs to rename all remote tracking
> references to the remote's new name (e.g., renaming
> "refs/remotes/old/foo" to "refs/remotes/new/foo" when renaming a remote
> from "old" to "new").
>=20
> This can be somewhat slow when there are many references to rename,
> since each rename is done in a separate call to rename_ref() as opposed
> to grouping all renames together into the same transaction. It would be
> nice to execute all renames as a single transaction, but there is a
> snag: the reference transaction backend doesn't support renames during a
> transaction (only individually, via rename_ref()).
>=20
> The reasons there are described in more detail in [1], but the main
> problem is that in order to preserve the existing reflog, it must be
> moved while holding both locks (i.e., on "oldname" and "newname"), and
> the ref transaction code doesn't support inserting arbitrary actions
> into the middle of a transaction like that.
>=20
> As an aside, adding support for this to the ref transaction code is
> less straightforward than inserting both a ref_update() and ref_delete()
> call into the same transaction. rename_ref()'s special handling to
> detect D/F conflicts would need to be rewritten for the transaction code
> if we wanted to proactively catch D/F conflicts when renaming a
> reference during a transaction. The reftable backend could support this
> much more readily because of its lack of D/F conflicts.
>=20
> Instead of a more complex modification to the ref transaction code,
> display a progress meter when running verbosely in order to convince the
> user that Git is doing work while renaming a remote.
>=20
> This is mostly done as-expected, with the minor caveat that we
> intentionally count symrefs renames twice, since renaming a symref takes
> place over two separate calls (one to delete the old one, and another to
> create the new one).
>=20
> [1]: https://lore.kernel.org/git/572367B4.4050207@alum.mit.edu/
>=20
> Suggested-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>

As I mentioned to you personally, I think this looks good.

For context, I discovered this when I tried to rename a remote with tens
of thousands of branches and it just ran silently for an extended period
of time without any output.  I actually interrupted it with Ctrl-C
because I thought it had hung, so I'm hoping this will provide a better
experience for users in that situation.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--xJP0MbUoQfd8jlO2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYh/t3AAKCRB8DEliiIei
gSFKAQCgBNKKI+AKLjkf1CagfIRvrstYeBwC+uls55nitV9TwwD+MuK0s6iDbIEp
vXpWdM7MEPFrYn0dXxGaXDDPT2LS3gA=
=kdIJ
-----END PGP SIGNATURE-----

--xJP0MbUoQfd8jlO2--
