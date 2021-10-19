Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC110C433EF
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F5461004
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhJTABb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 20:01:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36942 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229842AbhJTABa (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Oct 2021 20:01:30 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 023A760734;
        Tue, 19 Oct 2021 23:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634687926;
        bh=p6RNDVYhBo7li/Fia+AAenRf1y0bppth1kV7cnlfHQg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ctsmWyfQD2FGTrNHOeGpwZ/m26PY7mPz1BLpc0LybwcMrhjAjAqBRMqv6WEjXDZY4
         PLiLTrWpH1ZOQiOib91SHnA6F4uqUOBkRGk38iod2EsybPuFAnM9iu60FnUeXI5X/B
         D2QUd+z8cqtB+VDfO45T79fo1lpvdFlOx3vyEpcyCLSlgjOvy77jERVVn4MDDvimU0
         KXnleiUKJxryxXOt6EY/y1VeBqTOktVNEysYQlhtaI08rOS7Ui2DOxCuWJTju34JJm
         SN3IEP5JGNSQ1uNfRsQZc8E49hW3lmCdFMWt91wMmqveS3w08LBFpgorTyn1lmFHQ3
         vRBkizicUlBuLKuLJW86PCnn/k/7Uluxluw8f5MXdf963Xo6nNLa/eTV80F1gERv5u
         eLMoK2FrGVDCka6fdLJDacAasy5bjvtziSvpQHJxnocD3uD6ZxA6S1CatRpO28SwI6
         z5ljR05aS3vrsJa4DG+ZV8cWLnoY0OOe3MydzGUwkbre443hrgL
Date:   Tue, 19 Oct 2021 23:58:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] handling REF_STATUS_EXPECTING_REPORT over http
Message-ID: <YW9bsUdgpm3/C4+R@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <YW3MY6lAI5l+BOnP@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0TRpFdgH/IyPAqOs"
Content-Disposition: inline
In-Reply-To: <YW3MY6lAI5l+BOnP@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0TRpFdgH/IyPAqOs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-18 at 19:34:59, Jeff King wrote:
> I recently saw a case where GitHub's server implementation failed to
> correctly report ref statuses. In this case it was because it hit an
> internal timeout, but the root cause doesn't really matter; the server
> is doing the wrong thing.
>=20
> But what's interesting on the Git client side is that we produce quite a
> confusing message for http. For ssh, we correctly say something like (in
> this example, I'm pushing an absurd number of tags that causes the
> timeout):
>=20
>    To ssh://github.com/some/repo
>     ! [remote failure]  tag-1 -> tag-1 (remote failed to report status)
>    [...etc...]
>     ! [remote failure]  tag-999 -> tag-999 (remote failed to report statu=
s)
>    error: failed to push some refs to 'ssh://github.com/some/repo'
>=20
> but for http, I get just:
>=20
>   Everything up-to-date
>=20
> Which is misleading to say the least. The issue is communication between
> send-pack and remote-curl on the client side.
>=20
> The first patch does the minimal fix. The second one has some cosmetic
> improvements. They arguably could be squashed together, but I think
> keeping them split shows exactly what the second patch is actually
> accomplishing (especially with the minor change to the expected output
> in the test).
>=20
> This bug has been around since smart http was added in 2009. I just
> prepared it on master, but I expect it could also go to maint.

This seems sane to me, and I'm delighted you managed to add a test for
this case (which I was not expecting to be possible).
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--0TRpFdgH/IyPAqOs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYW9brwAKCRB8DEliiIei
gdWUAQDcvulhQ4Mx++fsTkvvkMI4YGAdBUpFOqR15LUawomzOQD+PYo4IJLKcJ5a
8ihkBYwvJm0Ul/pO9oubgB9JEF1YBQY=
=OfAs
-----END PGP SIGNATURE-----

--0TRpFdgH/IyPAqOs--
