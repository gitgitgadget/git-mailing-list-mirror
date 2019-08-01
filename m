Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD7EE1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 01:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfHABwL (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 21:52:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57240 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726334AbfHABwL (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 Jul 2019 21:52:11 -0400
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2ED5A6047B
        for <git@vger.kernel.org>; Thu,  1 Aug 2019 01:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1564624329;
        bh=g2MtJa31ntv5m8h0E/JwXmYkUnZshOdWoSNPbQ04LLU=;
        h=Date:From:To:Subject:Content-Type:Content-Disposition:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=dZRq+57XqT8a8k5eScoXqWxeq9RB08nrynbhNAtvXq5x3MKPk5OsY1lOmLxRBwUwp
         D+EHJiTpw1U563ewPxjK2xfoLbvZhNzgOzxWZiGuoPlPCTiFLnuFgAtar7BxmV1erR
         8VgWfbar5gvd/HdTbbbdVcEiXDKISExrrD8ydPpOTwh2dqEpFvCKpfrXaVOfded72e
         eVngFAeJmuMQYZBje5gY9CerHU/VTCk8DNliKxcUdyg7owtJVQ+UXWO/PgoOjZk2LG
         pcOGFYXAkqmXyURuwDzrg1J/nT/lymS3T7gyiyJO/i6klTiSlQUbncB4RAyEA2gosG
         2zZcyys97nYG71EBF/wUaXEtQNdnmVypj1O1w7kHldsoMb5XLEhJwcdzrNKhHDjFB9
         xIVv8Eb2cF3/+6x0d8jO0rue07GLWQhmpcN8Y0VkiCFib0WWA+Z6d6mFB5QT2XyfdP
         uwWMw1HNtqLtsUxAnZzWnzkhNJRTaRGz1LgDiowTPCa04Ky9gjz
Date:   Thu, 1 Aug 2019 01:52:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: am-based rebase not applying filters
Message-ID: <20190801015204.GA12118@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Recently, someone[0] pointed out to me that am-based rebases don't apply
smudge and clean filters on the final checkout.

Reproduction:
-----
#!/bin/sh -e

mkdir test-repo
cd test-repo
git init
git config filter.test.clean "sed -e 's/smudged/clean/g'"
git config filter.test.smudge "sed -e 's/clean/smudged/g'"

echo a >a.bin
git add a.bin
git commit -m 'Add a.bin'

echo b >b.bin
git add b.bin
git commit -m 'Add b.bin'

git checkout -b test HEAD^

echo '*.txt filter=3Dtest' >.gitattributes
git add .gitattributes
git commit -m 'Add .gitattributes'

echo 'This text is smudged.' >a.txt
git add a.txt
git commit -m 'Add a.txt'

git rebase master
grep 'smudged' a.txt
-----

The correct behavior is to have the script print that the text is
smudged, but with an am-based rebase, the text is clean. If you change
the rebase to use -i or -m, the test succeeds (the filters are applied).
This may also affect things like working-tree encodings or line endings;
I'm not sure.

I'm planning on taking a look at fixing this (unless of course someone
gets to it before me), but I wanted to mention this as in case it rang a
bell for anyone.

I have no reason to think this is version-specific behavior, but I'm
using Git 2.23.0.rc0.142.g4dedae46a2 from Debian experimental, and this
also reproduces on a fairly recent master on macOS.

[0] This was brought to my attention by Erika Ellison.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1CRcQACgkQv1NdgR9S
9ov+iA//f6cpVsJXvKRG28sUbMvZoe4uaAqTQunxo4a4kqYF451TTY7+GsWPq5SX
IkTX2YJzbQjeOZjHCnTk8LO5Lql7XMC/XcuFiZ+lmBb8dMvAKaeTy6MRdn1gGEGM
LXa2htfo3b8d1VQsjMe1ZkJ7DO4Z+LzrSZWg0OioZ4jDrQ6fsafxvIDuinhoHhum
9uX6UQoK9fE0E1RAMH6pqVgJvFshSkMmRmJoVTNEeEpOenu6DUNHimvvnD2wOQRo
3JOUxqvYfOEK+Gnsv3pEtSBiAZ5NlW6egwPQ+z8nnHQamCSD0rY4T2KZxm8l0hCH
fxjgWquckTrVkxV3WWKbWtYsFyUiL1V/oZlXVfLWPtxGT+rZv4V8tRhkY9zl6a7k
1vOkBk1xtAfKouZSoPZzVPJh8cajd2LWTRvGjTFudU6QFFmA4CtmxNeoeoUVLgGD
V0AnI4Z3QUybCpJbDWHSZwW5ACJUtbgTaM15eqqsGR5gn/aTUe64w8CgOICeYhWQ
mCwWJE4d0uPyelPiZh4Nuq1aNXoFwW375BEpc/wDVNoU5yazXdFfYZrSzkyJqc+q
xNcYRRm768wAXZ0+1vQEzW3SVO6pItAPbhfQmDskk19LzqwUAxLygnQqQg+6YM9S
Xox/QKAHPHgt8hmfJobhIZedpJESfQ9UIUmgtPhcsCuHaphipgU=
=/L2f
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
