Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691A2CA0EC7
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 00:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjILApT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 20:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjILApA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 20:45:00 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BED18832D
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 17:40:27 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 649625A2FC;
        Tue, 12 Sep 2023 00:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1694477646;
        bh=HKhsEakvP4q1aDN0xvLi6Xkj4b6tYcJ0FTLndwb2ajw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tb5hrILb1XM0utPlih2d8H+8G/meQUJrf70N2pZAHtOlADFrzR8OeZiWIStsyzAw1
         GMBb7icregOqNonoO397wU9uIZ9OGrueMDyx5UgtXCnpzOHXV9m4X/KEKJQSO24L25
         njmtmGiQWpbnGjcDIrBjkSfQ76YTA0e9FBzzCNCKtU3zSjrpKhYcsd2zAdSBcP3FBp
         SPykk3r5Sn0v9g0HvcCLj8dTbZ85jvDzlwvKYycAsEqVss+W8EKIYYXPMiiAMRNoZD
         Y8j5NyNb06LMi+3feeQDl9NffKyES49t7X2O7aRbpjvRxCsaJ/Xs6qwW8BAdjuiPGW
         w8NuScb0Q7gP6bCxwX8giFxrH4xmgfPOUcR/p40voZwVKuDIpZBAXiqAZLKVvIlEim
         6Sxa43pjyLLwGtSkb6HNWFHVOvL2iL9Jq9DC/li1pp6LhrQQwG2/I7hSnbltTYfCBO
         fRVw6xQZmBiYXiXNR0kpzg66kkmihVQazLCKqf82pntwgSXsoQm
Date:   Tue, 12 Sep 2023 00:14:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/32] doc hash-file-transition: A map file for mapping
 between sha1 and sha256
Message-ID: <ZP+tTFK3Ly4sqlsq@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
 <20230908231049.2035003-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rjcfCrq67vkdNjGZ"
Content-Disposition: inline
In-Reply-To: <20230908231049.2035003-1-ebiederm@xmission.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rjcfCrq67vkdNjGZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-09-08 at 23:10:18, Eric W. Biederman wrote:
> The v3 pack index file as documented has a lot of complexity making it
> difficult to implement correctly.  I worked with bryan's preliminary
> implementation and it took several passes to get the bugs out.
>=20
> The complexity also requires multiple table look-ups to find all of
> the information that is needed to translate from one kind of oid to
> another.  Which can't be good for cache locality.
>=20
> Even worse coming up with a new index file version requires making
> changes that have the potentialy to break anything that uses the index
> of a pack file.
>=20
> Instead of continuing to deal with the chance of braking things
> besides the oid mapping functionality, the additional complexity in
> the file format, and worry if the performance would be reasonable I
> stripped down the problem to it's fundamental complexity and came up
> with a file format that is exactly about mapping one kind of oid to
> another, and only supports two kinds of oids.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  .../technical/hash-function-transition.txt    | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>=20
> diff --git a/Documentation/technical/hash-function-transition.txt b/Docum=
entation/technical/hash-function-transition.txt
> index ed574810891c..4b937480848a 100644
> --- a/Documentation/technical/hash-function-transition.txt
> +++ b/Documentation/technical/hash-function-transition.txt
> @@ -209,6 +209,46 @@ format described in linkgit:gitformat-pack[5], just =
like
>  today. The content that is compressed and stored uses SHA-256 content
>  instead of SHA-1 content.
> =20
> +Per Pack Mapping Table
> +~~~~~~~~~~~~~~~~~~~~~~
> +A pack compat map file (.compat) files have the following format:
> +
> +HEADER:
> +	4-byte signature:
> +	    The signature is: {'C', 'M', 'A', 'P'}
> +	1-byte version number:
> +	    Git only writes or recognizes version 1.
> +	1-byte First Object Id Version
> +	    We infer the length of object IDs (OIDs) from this value:
> +		1 =3D> SHA-1
> +		2 =3D> SHA-256

One thing I forgot to mention here, is that we have 32-bit format IDs
for these in the structure, so we should use them here and below.  These
are GIT_SHA1_FORMAT_ID and GIT_SHA256_FORMAT_ID.

Not that I would encourage distributing such software, but it makes it
much easier for people to experiment with additional hash algorithms (in
terms of performance, etc.) if we make the space a little sparser.

> +	1-byte Second Object Id Version
> +	    We infer the length of object IDs (OIDs) from this value:
> +		1 =3D> SHA-1
> +		2 =3D> SHA-256

In your new patch for the next part, you consider that there might be
multiple compatibility hash algorithms.  I had anticipated only one at
a time in my series, but I'm not opposed to multiple if you want to
support that.

However, here you're making the assumption that there are only two.  If
you want to support multiple values, we need to explicitly consider that
both here (where we need a count of object ID version and multiple
tables, one for each algorithm), and in the follow-up series.

I had not considered more than two algorithms because it substantially
complicates the code and requires us to develop n*(n-1) tables, but I'm
not the one volunteering to do most of the work here, so I'll defer to
your preference.  (I do intend to send a patch or two, though.)

It's also possible we could be somewhat provident and define the on-disk
formats for multiple algorithms and then punt on the code until later if
you prefer that.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--rjcfCrq67vkdNjGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZP+tTAAKCRB8DEliiIei
gQ+UAQDFg6LVbhsSARz9h48C3Prrcj9YTh79htVv5r/C6A3F5wD/cWlMZO0KCKAZ
AFV0z+nIaMEMMEoqoCB2sk21FQ+YlAI=
=l9QZ
-----END PGP SIGNATURE-----

--rjcfCrq67vkdNjGZ--
