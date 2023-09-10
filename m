Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFEBEE14D8
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 14:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242454AbjIJOYy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Sep 2023 10:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIJOYy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2023 10:24:54 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A39CCC
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 07:24:49 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 23D7A5A2FC;
        Sun, 10 Sep 2023 14:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1694355889;
        bh=N57GKmjQt9vPT6q5Keix2yckM3YcBpndenDUoneOI7s=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=KUR6u1VlzeGEf3hSAWG+Y3sP2OEioazKI20CxjeTJ0ltHEjiTbyTOz2p/kkuSpaA5
         GTidOfcoOEJPqrDsFiFsetbOJTmHInG/eWubakw7YxQoattszsD1qX4x76I/OXV89x
         uiLz8YHoobAbzZFIHCQH/7ucd/qs+cT9Y7ynrjvvey8q5L36otV5hLm4Dldw9TX/GK
         iBf0TZBJA8SYdv7TuWZN97txswXjF0KkkF1CCyOp7O33dIttgNa1PD/UlIYPJTvaY1
         xbkyANFBBdXum+22GvFs8+Ua2iHnNWAkrMVHkCY6d8WMgD9jX19vbXXzmqYVQxAX1U
         ZPGS65RkK+k0FFI1N41cRiJDqcqGLMXO5AkQW0zB0ZyCDG3bBl0m4DCimez32sTwCo
         mRpxwXEyh1EWu34DBrN2U/M632C1drR4rX2KoGxYw8zjvc3mEvZ5TWTsjz4/nL3kN8
         OrRUn+aSU1VlxBM6TxnNl5nFcy+958DeZr9JHu8nB1lKXVFiR/h
Date:   Sun, 10 Sep 2023 14:24:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/32] doc hash-file-transition: A map file for mapping
 between sha1 and sha256
Message-ID: <ZP3Rr8Ei0sG0lg0R@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
 <20230908231049.2035003-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EctuRMjSePlgh8yL"
Content-Disposition: inline
In-Reply-To: <20230908231049.2035003-1-ebiederm@xmission.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EctuRMjSePlgh8yL
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

I think this is a fine approach, and as I'm sure you noticed from my
series, it's a lot more robust than trying to implement pack v3.  I'd be
fine with going with this approach instead of pack v3.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--EctuRMjSePlgh8yL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZP3RrwAKCRB8DEliiIei
gUKcAP9N6ssVz61qKMwIF3bTbXEvkJm8NSJtk660oiiKw1PB9QD+MM0JV7KZDxb5
sBXp/RSa+DXuDzMvdTOvVWCxBgp/Zw8=
=6Hp6
-----END PGP SIGNATURE-----

--EctuRMjSePlgh8yL--
