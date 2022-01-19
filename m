Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0CCC433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 22:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbiASWUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 17:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiASWUT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 17:20:19 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0D6C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 14:20:19 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 8353B5B227;
        Wed, 19 Jan 2022 22:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1642630818;
        bh=JZUya+imHzjyalTdV5J/nnxoeao/bfd7A5qP3p0TZJ0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XIpQ5Uxm6bmQQ2eLsjMAVqi5PyEU9qeTFsFtIiUOynsWWLpdESi727Gcs07BAkQnZ
         o/k0t3/laK+Pz98arjyibJwpcFynNiwd8uCM0bzxSKFZoyPgwDFWwHCpsdumbV8dFN
         MC+WtqbK3sGOam3FAiuxdAoC1ZxA6UrdTLwpAotwkl+wWIRb3+6GIci6GL1lfA4+qX
         Y6xEhjUv9h5OvC2I1T3ns7tAQ2zkpM7IpIUoyJdokLYBMWijYXes4uknZMrz7LUJqZ
         ZAWoCWNPYCrBFLbWNXL6bA+E8IbRZBmz7szQiURslwOGGjhc3F2jAfA9r8oWuJutq7
         BIYnb7rkM4znAw0PRQUDGsSYDd8h4rdgGOV0XEYuz/HNgJjll2j4C6QrrpAXM/8lzh
         IROndXVEQ2nH20/0xXzuHye/6zHBGQZAxIpNg0I4l8Zn/+OSivdBjPfSySK4PVWIj/
         YH+Uysixn9rCOCt44JGZ7R8/unhaCdpvfXo7sumgjgNY7/LrYue
Date:   Wed, 19 Jan 2022 22:20:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Michael Herrmann <michael@herrmann.io>
Cc:     git@vger.kernel.org
Subject: Re: A puzzle: reset --hard and hard links
Message-ID: <YeiOoAcM7TMK2pgz@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Herrmann <michael@herrmann.io>, git@vger.kernel.org
References: <CABrKpmDseZkPCpRb8KmBJaxDp24sySJay5ffZrxqgSMGKyj5qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="izuHVMmazJPCoBLI"
Content-Disposition: inline
In-Reply-To: <CABrKpmDseZkPCpRb8KmBJaxDp24sySJay5ffZrxqgSMGKyj5qQ@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--izuHVMmazJPCoBLI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-19 at 20:37:48, Michael Herrmann wrote:
> Hi all,
>=20
> It seems `git reset --hard` recreates files that have external hard
> links. Is this intended?
>=20
> The example below highlights the behavior. I have an unchanged Git
> repository. When I create an (outside) hard link to a file in the
> repository, then `git reset --hard` re-creates the file with a new
> modification time and inode. This occurs on Debian 11 with Git 2.30.2
> but not on Debian 10 with Git 2.20.1
>=20
> > git init
> Initialized empty Git repository in .../git-test/.git/
> > echo "test" > file.txt
> > git add file.txt
> > git commit -m "Import"
> [main (root-commit) f73709f] Import
>  1 file changed, 1 insertion(+)
>  create mode 100644 file.txt
> > stat -c '%y' file.txt
> 2022-01-19 18:43:52.147781748 +0100
> > ls -i file.txt
> 74458979 file.txt
> > ln file.txt ../file.txt
> > git reset --hard
> HEAD is now at f73709f Import
> > stat -c '%y' file.txt
> 2022-01-19 18:44:47.013167127 +0100
> > ls -i file.txt
> 74458995 file.txt
>=20
> Can this behavior be avoided?

Git generally doesn't guarantee that it will preserve hard links in any
particular situation.  It can and does replace files rather than writing
over the existing ones, so this behavior is expected in at least some
circumstances.

Whether it happens in this particular case probably depends on what data
is in the index and whether it's considered stale, since if the file is
out of date, I believe a git reset --hard will replace it rather than
try to determine whether it's up to date.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--izuHVMmazJPCoBLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYeiOnwAKCRB8DEliiIei
gfp3AQDbGzNT3AJ+h1p8E43+QZl/YsV18ab3sY8dSWxsxOwU4wEA9HZW/In8j/TY
lge3gnXlLj1nD/DeOxFAtLxs/S2QuA4=
=A0JF
-----END PGP SIGNATURE-----

--izuHVMmazJPCoBLI--
