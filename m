Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E469C2BA2B
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 00:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44C3C2072D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 00:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="iz7PGBPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390347AbgDNADa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 20:03:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37052 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390344AbgDNADa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Apr 2020 20:03:30 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F21326042C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 00:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1586822609;
        bh=N6ecF+dVT9P0L6Q3cn0aeSlgAtslEj58XKk7GfJwgCA=;
        h=Date:From:To:Subject:Content-Type:Content-Disposition:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=iz7PGBPlLTD+NTgDu5EKV9AOjnEPm1aJkeEIGS0Lne9TqngUL2vXz+5GYYSZBXMmj
         sKMwVaPe70+FgRgEH++mzGeJ9OOBuJSSWVS/scEB/Tvu+dvjxtZXGN2Pj9sD1IGyZc
         pnO9wqMixw2B8I3o4Kop2M9ABXJCd0G6wjfuOTrqx+bAEZHIepu8cGVNQfvEDyDsu0
         NSEoSbdppbwqOsfxC0loHo8SgiyAoJRSNH0BhvOQaqf8F21n7WcKt4nMYGvNXdrjUq
         dE5/DsOBd62VKJIx3aQS4BaiHzkHo8u1r/GczAXUfx2/c8FsgJnrYi9S4ZgkqZARIH
         sCi7REas9rudLsCcDntvwNkOyeaZ1nv1EEvLiGAlbmu8NAKkgzrbVCLa8pMJse0uFO
         xZABUMGkXJuWpfvT+irtYwkTIhMKZJQNPxWTlZcAIqxca3FMDXnCnSq0/EiJAdrYda
         Ia5TfoPa0YY8Zf2LHe9Dyniz8UuOwNRqWHJDvxZplcEVUNpjTXb
Date:   Tue, 14 Apr 2020 00:03:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: Mishandling of fractional seconds in ISO 8601 format
Message-ID: <20200414000324.GA2751707@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.5.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

git-commit(1) claims we support ISO 8601 format.  However, our
approxidate code misparses some dates with fractional seconds.

Reproduction:

  git init foo
  cd foo
  echo abc > abc.txt
  git add .
  git commit --date=3D"2020-04-03T12:43:55.019-04:00=E2=80=9D

This should produce Fri Apr 3 12:43:55 2020 -0400, but actually produces
Sun Apr 19 12:43:55 2020 +0000 (at least on my system, which uses UTC).
Note the different date, which is 16 days away from what is expected.

Since we claim to support ISO 8601, we need to either reject fractional
seconds with an error, or accept and ignore them.  If what we really
support is RFC 3339 (which I suspect it is), we need to do the latter,
since that profile explicitly permits them in the syntax, as well as
update the documentation accordingly.

This was originally reported at
https://stackoverflow.com/questions/61193896/how-does-git-parse-date-string=
/61197722.
I don't plan to send a patch for this right now, but I wanted to make
sure it was reported to the list.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXpT9ywAKCRB8DEliiIei
gZzxAP9OsFaSw6sqv8RlX5OpB1jrgNxcpKyupRpIGA7xyYKxQQD/Xq3MFjTI/ruh
T4Sg3PmtxOKhiEsx5Vn4lq3MsAyjJw0=
=L8IM
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
