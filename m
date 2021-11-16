Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753E2C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 22:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46C8D61881
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 22:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhKPWUv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 17:20:51 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:43480 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhKPWUu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 17:20:50 -0500
Received: from camp.crustytoothpaste.net (unknown [72.12.180.34])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id CA0015B466;
        Tue, 16 Nov 2021 22:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1637101072;
        bh=Sy/+LiycYo0Aq33RPIhVTCHHyc4/oYUoJwcVwjHLz9Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=G/1mflS1sdG4MokgZ8gGU7X1okwNGKjFwuTuklEbsZ3o65B5uvDsWv5GOs6xzuuUp
         4cAun+g6Kl8eBwBtcNkzetBCDN4t3SLw72xwmzpNQ4SwvF8e3nRmzd7RUATw019Job
         0DEKZxUmWtuoWzi475HFU6gY4BNaByQZsxe3oGvxhmzqh+StKR8dYPBsKIxwcsNYPx
         K8WN2eSd/t1GaO0aBivp/bileAjTBcVDCfNy+t8tuGpt3Ujyjl78IG2inv0biR1dTe
         /vvHwo6vMnxmZPI3qwAVw6qO/KyHdfpKCFrkEgfLFfKLjqV/qzA/LJWtVGDrQFPW2E
         BaAzY1eELCBzKzsbdDOCYEYkb5MaXTWeBuds0jZbu0Jt2XcclWkfIYbEdswuhDPDgG
         j+j/yk9RBKqY8r1tmEqluPvoUfKQHWzov1UId+D+tJCI+BUYIJB5X1tBK6C0EQqshu
         cRa8ZVl7i8JPgtoBn+X4LzojdnX6OH3qSEHxD8kCDDjkAKI3RWo
Date:   Tue, 16 Nov 2021 22:17:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] Generate temporary files using a CSPRNG
Message-ID: <YZQuDVMRx6hGEbpe@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
 <YZPR4Ya1ocWvKbAf@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PMHWJz3b1JEZRw8V"
Content-Disposition: inline
In-Reply-To: <YZPR4Ya1ocWvKbAf@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PMHWJz3b1JEZRw8V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-11-16 at 15:44:33, Jeff King wrote:
> On Tue, Nov 16, 2021 at 03:35:40AM +0000, brian m. carlson wrote:
>=20
> > For those who are interested, I computed the probability of spurious
> > failure for the self-test mode like so:
> >=20
> >   256 * (255/256)^65536
> >=20
> > This Ruby one-liner estimates the probability at approximately 10^-108:
> >=20
> >   ruby -e 'a =3D 255 ** 65536; b =3D 256 ** 65536; puts b.to_s.length -=
 a.to_s.length - 3'
> >=20
> > If I have made an error in the calculation, please do feel free to point
> > it out.
>=20
> Yes, I think your math is correct there.
>=20
> A more interesting question is whether generating 64k of PRNG bytes per
> test run is going to a problem for system entropy pools. For that
> matter, I guess the use of it for tempfiles will produce a similar
> burden, since we run so many commands. My understanding is that modern
> systems will just produce infinite output for /dev/urandom, etc, but I
> wonder if there are any systems left where that is not true (because
> they have a misguided notion that they need to stir in more "real"
> entropy bits).

I have specifically avoided invoking any sort of potentially blocking
CSPRNG for that reason.  /dev/urandom is specifically not supposed to
block, and on the systems that I mentioned, the way Go uses it would
indicate that it should not.  There is a system, which is Plan 9, where
Go uses /dev/random to seed an X.917 generator, and there I assume there
is no /dev/urandom, but I also know full well that we are likely
completely broken on Plan 9 already, so this will be the least of the
required fixes.

RtlGenRandom is non-blocking, and as the commit message mentioned,
arc4random uses ChaCha20 in a non-blocking way on all systems I could
find, except MirBSD which uses RC4, also without blocking.  Linux's
CSPRNG is also non-blocking.

I've also looked at Rust's getrandom crate, which provides support for
various other systems, and I have no indication that any of the
interfaces I've provided are blocking in any way, since that crate would
not desire that behavior.  Looking at it just now, I did notice that
macOS supports getentropy, so if I need to do a reroll, I'll add an
option for that.

So I don't think we're likely to run into a problem here.  If we do run
into systems with that problem, we can add an option to use libbsd,
which provides arc4random and company (using ChaCha20).  The tricky part
is that when using libbsd, arc4random is not in <stdlib.h> (since that's
a system header file) and is instead in <bsd/stdlib.h>.  However, it's
an easy change if we run into some uncommon system where that's the
case.

If we don't like the test, we can avoid running it by default on the
risk of seeing breakage go uncaught.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--PMHWJz3b1JEZRw8V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYZQuCwAKCRB8DEliiIei
gRZUAP9Mzm4wVeB5yDcCEziQQvq9HZOcz8y22hh1QYLiiUaoMgEA6AcYeWr9v8SQ
K59xul3MwZ8a1g3Xyzl7quH22xZaxwU=
=PAKV
-----END PGP SIGNATURE-----

--PMHWJz3b1JEZRw8V--
