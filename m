Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA37C433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 01:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F1164F93
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 01:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhCLBlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 20:41:49 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38764 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230516AbhCLBli (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 Mar 2021 20:41:38 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EB7D1607A2;
        Fri, 12 Mar 2021 01:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1615513297;
        bh=ds8mCujPV0mLEm8bMtfz5y5prHY7lI0QPB8FhPbdeoY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tIWXGAFJbrLi/ZawdG39MOlmmtzu9/dAjuB6FNU+OJAR381db7Ut6cYHVjrz5sD8e
         1v7sSS61KI0qxMyWFTsibGgKuN3R4mDC1hG3xhdps4I0UBoB24cW7nlTBC802YQKjZ
         /ZNQKyZusFMtRdhcKjCk6PxaAFLivoKlVh6mgD8iiXaIFxg9ttA6BmtrYV87esKJg8
         8UtVuYvSDSzZ9niaFlJFvIJDScW6JsRNm7YCcAJqFooYT+yrUP4Okd/ufZVf6Z7RFi
         koUdGic403+t8q9B7BjlhfCbntiO+FtyUpTcTZ2xe6ePwHiUNHwbU1UFHjMNW/Iag2
         M6BSlWp6Mpo90y+mKURBQCA+CTPgsBlCpO+Cy1REUGfkmCi0lD7ZkXoYbgCVIEXLoy
         EUPSAM17QkbNHK4SyOEjqygAXQx4IRqWcLluZkjRg4SSkDKmFKeKhr4ZGXfreckvED
         u+9odNb34M6L2fWW9tPbT+Khm6uJ5B6ZmaNkHFATrLru+yGTOt/
Date:   Fri, 12 Mar 2021 01:41:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     John Szakmeister <john@szakmeister.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] http: store credential when PKI auth is used
Message-ID: <YErGymyECXjPXWcP@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
References: <20210312004842.30697-1-john@szakmeister.net>
 <20210312004842.30697-2-john@szakmeister.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LHjX0+M66C6nQ97b"
Content-Disposition: inline
In-Reply-To: <20210312004842.30697-2-john@szakmeister.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--LHjX0+M66C6nQ97b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-12 at 00:48:41, John Szakmeister wrote:
> We already looked for the PKI credentials in the credential store, but
> failed to approve it on success.  Meaning, the PKI certificate password
> was never stored and git would request it on every connection to the
> remote.  Let's complete the chain by storing the certificate password on
> success.
>=20
> Likewise, we also need to reject the credential when there is a failure.
> Curl appears to report client-related certificate issues are reported
> with the CURLE_SSL_CERTPROBLEM error.  This includes not only a bad
> password, but potentially other client certificate related problems.
> Since we cannot get more information from curl, we'll go ahead and
> reject the credential upon receiving that error, just to be safe and
> avoid caching or saving a bad password.
>=20
> Signed-off-by: John Szakmeister <john@szakmeister.net>
> ---
>  http.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/http.c b/http.c
> index f8ea28bb2e..12a8aaba48 100644
> --- a/http.c
> +++ b/http.c
> @@ -1637,7 +1637,17 @@ static int handle_curl_result(struct slot_results =
*results)
>  		credential_approve(&http_auth);
>  		if (proxy_auth.password)
>  			credential_approve(&proxy_auth);
> +		credential_approve(&cert_auth);
>  		return HTTP_OK;
> +	} else if (results->curl_result =3D=3D CURLE_SSL_CERTPROBLEM) {
> +		/*
> +		 * We can't tell from here whether it's a bad path, bad
> +		 * certificate, bad password, or something else wrong
> +		 * with the certificate.  So we reject the credential to
> +		 * avoid caching or saving a bad password.
> +		 */
> +		credential_reject(&http_auth);

Is this supposed to be &cert_auth here?  I'm not sure how a bad HTTP
password would even have been tested in this case.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--LHjX0+M66C6nQ97b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYErGyQAKCRB8DEliiIei
gYIeAP0T994cW2aWWnilkoR3QvkDMFFinMEkYd5zgtK1n8rJjwD/al9ZxCYmmVwy
1w4ZpSJ7QYYS3N2qk6jqBKKJMLMsGQs=
=Oo4c
-----END PGP SIGNATURE-----

--LHjX0+M66C6nQ97b--
