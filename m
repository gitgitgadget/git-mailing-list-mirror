Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DA5C3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 23:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjANX72 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 18:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjANX70 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 18:59:26 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCFB59DB
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 15:59:25 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D2F0B5A463;
        Sat, 14 Jan 2023 23:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1673740764;
        bh=E3gcxlLzMEqG1nRBy+4bfTUR5PNMaVQfm0HmWrqTSgY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=hZvX30bML2p+Yh+lIcTRlw7kp3cnbFDX9Cu/MJ7lw1qASxSPjzHloJrvT1o1T738O
         3aPUNO0RnRXk9N25ckN3w/TC5EJABSA+sl4yHyB2w+P34OeLErbMRhabl74ltwG76J
         2qFD14msSSB0e9RTvioKA/jXZ1PyRrhFBAHr5q8qsTb3uNyZXHhMIvGR06MHR0uBWz
         ZxJ5kVQ9InAdrqDPboUPa3yqhinFD3Pr/hDGKMhhYxiv6RJj5WpMu2y4er7QQGb9AJ
         90lX7HpmOl1mcBdjvqwFpdRF4ILEeKcHVWHXT4BqNkxHO0RocrDS6s7tEdT7WGApxi
         NpsZWdRkAFOEkUcSEO9P2KT/rp2Xf1lTo7l5egEcKP/kIIiAeegNSjlATA8JOllntr
         6QCoij8KzX0AyZenAT+mPH5N9Qzmi2bVUv9zDM9Chu359vVUkw/866R1fsMVnLqPsA
         TbkU9ijMB39iX9C+aP8WgA6oVc0JoHY/DX9Ysd4YIHGJh/vek3M
Date:   Sat, 14 Jan 2023 23:59:23 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Hans Petter Selasky <hps@selasky.org>
Cc:     git@vger.kernel.org
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Message-ID: <Y8NB21PExmifhyeQ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Hans Petter Selasky <hps@selasky.org>, git@vger.kernel.org
References: <9c0fda42-67ab-f406-489b-38a2d9bbcfc2@selasky.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="idKHPl6vSBLQL2Vg"
Content-Disposition: inline
In-Reply-To: <9c0fda42-67ab-f406-489b-38a2d9bbcfc2@selasky.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--idKHPl6vSBLQL2Vg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-01-13 at 13:23:59, Hans Petter Selasky wrote:
> Hi,
>=20
> Currently GIT only supports cryptographic hashes for its commit tags.
>=20
> That means:
>=20
> 1) It's very difficult to edit the history without also recomputing the h=
ash
> tags for all commits after the needed change-point, which then means
> references to a repository is broken.

This is intentional.  Commit and tag signing requires an unbroken Merkle
tree-like construction that prevents the history from being modified by
signing a single commit or tag.

> 2) Only a single bit error in the main repository can break everything!

git fsck is designed to detect this, and by default it's run every time
the repository is repacked (such as by git gc).  But yes, this is a
problem, and changing to an algorithm which isn't cryptographically
secure won't change that.  Prudent users back up data to prevent data
loss.

> 3) Illicit contents may be present in binary blobs, which in the future m=
ay
> be need to be removed without warrant and the only way to do that is by
> rebasing and force pushing, which will break "everything". It can be
> everything from child-porn to expired distribution licenses.

This is a problem in every Merkle tree-like system.  Most repositories
have some sort of code review or access control that prevents people
=66rom generally pushing inappropriate content.  For example, if somebody
proposed to push any sort of pornography or other inappropriate content
(e.g., a racist screed) to one of my repositories or one of my
employer's, I'd refuse to approve or merge such a change, because
that wouldn't be appropriate for the repository.

I don't feel this is enough of a problem that using a Merkle tree-like
construction is a bad idea, given the benefits it offers.

> Therefore I propose the following changes to GIT.
>=20
> 1) Use a CRC128 / 256 or 512 non-cryptographic based hashing algorithm as
> default.

As the person who wrote the SHA-256 support, I'm pleased to report that
adding a new hash algorithm isn't very difficult anymore.  The largest
part of the work is updating all the tests.  I've tried very hard to
make this substantially easier for everyone.

However, Git is moving in the direction of stronger cryptographic
algorithms, rather than insecure hashing algorithms.  I don't think your
proposal is a good idea, nor do I think it's likely to be adopted.

If it were adopted, the signing of commits and tags would be
meaningless, and because it would be trivial to create collisions[0], there
would clearly be some pairs of objects which could not be stored.  This
would make Git much less useful, and it might allow users to attempt to
forge or replace content without being detected.

That being said, you are free to create your own fork of the code which
does so, provided you comply with the terms of the license.

> 2) Add support for a CRC fixup field, which usually is zero, but when mer=
ges
> are needed, it can be non-zero, to allow the hash-tag-value to remain the
> same! This also allows for easy conversion of existing GIT repositories to
> the new scheme.

For the same reason as above, I don't think this is a good idea.

> 3) All git objects should be uncompressed.

This would dramatically increase the size of most repositories.  I've
easily seen repositories where the uncompressed contents exceed 1 TB in
size yet the repository is only double-digit gigabytes, if that.  Most
people will find the increase in disk usage unacceptable, and I'm
certain that includes Git hosterse.

[0] CRC is linear and the following relations apply, which makes forgery
trivial (see https://en.wikipedia.org/wiki/Cyclic_redundancy_check):

CRC(x XOR y) =3D CRC(x) XOR CRC(y) XOR c for some c
CRC(x XOR y XOR z) =3D CRC(x) XOR CRC(y) XOR CRC(z)
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--idKHPl6vSBLQL2Vg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY8NB2wAKCRB8DEliiIei
gVWVAPwKyOQM1N+9uHeDTuEz+hwFDtRBxw/fRsWlnROyt2gjRwD/XmrGdB43dNCf
rniHlnXpiTXM8qggVYv9fgsX2pNuUAI=
=zagO
-----END PGP SIGNATURE-----

--idKHPl6vSBLQL2Vg--
