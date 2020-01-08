Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA67C00523
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 03:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC292070E
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 03:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kj5Cdp4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgAHDe6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 22:34:58 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33328 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726142AbgAHDe5 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Jan 2020 22:34:57 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3E0E3607F5;
        Wed,  8 Jan 2020 03:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578454496;
        bh=HVSkTH2uACelZpM+DSErVc3licZ7ej6XztalSSFrlmM=;
        h=Date:From:To:Cc:Subject:Content-Type:Content-Disposition:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=kj5Cdp4WIP9A52s3uZtXvtkKzJgXyH2t3gXgiWq+hKsuA2TduEpKcs6iAwOueLkMj
         wx3Cw30U1ubwC8evZdqxYeIrTPBwTQxo8ulYsby/vgOKcrSBzFvZ7yntpIGwi4sOVJ
         HFiWdjjBbPEfKp3BEaaJPYUDpOiWIwnmGN/NqSAT+/oP6Eaqk0o0ug7DeX9AeoYkOx
         4kOCRTsfR6zUNONCVymz+NHK9JJ9aimUBFuDHlJQdVxVQSPkyQBeAMf+VOrgO9y6KF
         x0mKrRl/W3lT33WKddnFb0jF1FEL/IqYASjGBWK9wea/0yZ9TlZ6FGWONB5KbnlmMn
         zoOPDtSYCZoToV7vb3kRoGUzJI+Wqq0g/8jNdlCSTo9qdrllsiFH0eXPtNL90B+Vjw
         cLSKG55OU9mnyu0gpcf8nzVaJlO4NBNESp8wxQUkrwYPsV1TggZVtaoNza1G1pXlFT
         kVIzVSqPFGo3LUZbOMcBY1SHmGfC02o3TEFK6yrEywytv86l0rA
Date:   Wed, 8 Jan 2020 03:34:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: Extra request with protocol v2 and git ls-remote
Message-ID: <20200108033451.GN6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MmQIYbZiCoQ2kDro"
Content-Disposition: inline
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MmQIYbZiCoQ2kDro
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A colleague (Jon Simons) today pointed out an interesting behavior of
git ls-remote with protocol v2: it makes a second POST request and sends
only a flush packet.  This can be demonstrated with the following:

  GIT_CURL_VERBOSE=3D1 git -c protocol.version=3D2 ls-remote origin

The Content-Length header on the second request will be exactly 4 bytes.

I'm not sure exactly how to fix this by looking at remote-curl.c, but I
suspect that we can avoid sending a request if all we're going to do is
send a flush packet.  If I were a bit more familiar with the code, I'd
send a patch, but I'm not.

I just thought I'd point this out since it was surprising to me.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--MmQIYbZiCoQ2kDro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4VTdoACgkQv1NdgR9S
9ovh0RAAzp6o2IbhAGzKmCSpT8rkpw/RLkz/FG2Yt14eyeoLX55E6kEN4v7SprLn
vrvrnAy04147xOfvwNh0XNgJfGdt6xn7Y8pJO2UkcTaSYcu6pYMF2nRiwyjLKHMe
5dd/pE5++ed7flBbv7MQ2/Friy5ZClcZB9pMpQvZNg5V0dPmj3IsJ/9VVrMYWk3r
awMr0101cdJscTSiNsFEZpjVtpEGiMhmCmfpZv3Cg57kmmNS8n9lLiK2ZZytsyJW
WhjsH46r8fJ230QlSw+J0XoXObqTvvWjUVDF2fSJNLKrKj7U+FmWrAa0fssU+MqG
XqFksLAs85cmzN3288mqIdCSqfkgrGalyLn5YGj7m4RV4VpgGB3niy5q2PB5ldm8
LV04PAtro3fGRDstqDeVqrdBOMQntNm4ACXYl6FQSaw9WyC/weRZMcBhQVAQRDZu
FK71B3QC9xTkn4v7NKj8Y7fLtOKQZKMtazUIO4Jm+yVDvKah8/w+a4B9med1SeMW
hHAyBP4MgCbnMZuo8wT6fNffGsjokMQEAM6/ZTYFaPDEMPTrOR1z3OeVC5QuDov8
2aF/7Rk1OESgrMXn+OUqxS/V/zY9azw0V+oYC6GWk8oEvPNDcH9Y2Amf2I2IKwRq
flvHTLcRg3FApQQHFuy+HN5LE8gsuoHfZHQ/cDzlXhfnwq+InZA=
=vUnn
-----END PGP SIGNATURE-----

--MmQIYbZiCoQ2kDro--
