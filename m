Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6B171F453
	for <e@80x24.org>; Mon,  5 Nov 2018 01:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeKEKRl (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 05:17:41 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53262 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726012AbeKEKRl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Nov 2018 05:17:41 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AD1A16077B
        for <git@vger.kernel.org>; Mon,  5 Nov 2018 01:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1541379638;
        bh=ROmrM2Yphn4C+DTHv7fL0ILFLpZTRIXJMHgox87TZQs=;
        h=Date:From:To:Subject:Content-Type:Content-Disposition:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=V74DxONu6l1pB43e6TZDFfUyiCbjEvicnx+Atky646euqxkTK7eSYLKNmlCKb16rK
         GOMYuOdKsYNnNJ7RZ6ENsiXjcK20jXqD9+uLc/wyXSwPVxnjs/b/Uyb3InhCA6jGSJ
         GTgG+41JI4z2op57M1kR8EMZezb5fEYqbXzQ1FSEosxa3zCEeYzkt/5iJH2r0RkUnj
         u4CNYgdokZgHNM9XMNFZM6SRiYnpUEGWksWUPt6/bXI0kerzazNhwhTUu6qAKhs02A
         05J30138Fzb4M2Q7OEeCScD27j1ZxUVwh/yXDimG17JyclbG/ZXttx0ik1u3yrMwXD
         GLCOIJkJoO4Jn9rtTopPBqIoLUFdVXR4hw9AhD9Ho3Wu8wVR+IZkVzVEhYsUfiOyZs
         KJQRBaywIXgJMrBIbdqIi0ykq/q50LOJKRyUmCcYf9MKiC7mXSbac87oDgufPWNj8p
         42X6y5UDtwj9PQGZsR86vaCKvvv0hU13gFIHBpSCPYGG9PoOILO
Date:   Mon, 5 Nov 2018 01:00:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: Design of multiple hash support
Message-ID: <20181105010032.GN731755@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CaPKgh3XHpq3rEUV"
Content-Disposition: inline
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CaPKgh3XHpq3rEUV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm currently working on getting Git to support multiple hash algorithms
in the same binary (SHA-1 and SHA-256).  In order to have a fully
functional binary, we'll need to have some way of indicating to certain
commands (such as init and show-index) that they should assume a certain
hash algorithm.

There are basically two approaches I can take.  The first is to provide
each command that needs to learn about this with its own --hash
argument.  So we'd have:

  git init --hash=3Dsha256
  git show-index --hash=3Dsha256 <some-file

The other alternative is that we provide a global option to git, which
is parsed by all programs, like so:

  git --hash=3Dsha256 init
  git --hash=3Dsha256 show-index <some-file

There's also the question of what we want to call the option.  The
obvious name is --hash, which is intuitive and straightforward.
However, the transition plan names the config option
extensions.objectFormat, so --object-format is also a possibility.  If
we ever decide to support, say, zstd compression instead of zlib, we
could leverage the same option (say, --object-format=3Dsha256:zstd) and
avoid the need for an additional option.  This might be planning for a
future that never occurs, though.

I'd like to write this code in the way most acceptable to the list, so
I'd appreciate input from others on what they'd like to see in the final
series.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--CaPKgh3XHpq3rEUV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvfljAACgkQv1NdgR9S
9ovkpQ/9HEfVEDDvzzZDeWoYNh/WZ/7eWa6OwtHoyPacPRXBBwvNTttGDdgKoC1T
g6hnBJMnIbG7T7vsc3bqWCV/nypnS6v4NvN746hgp8Vp5qBfbdPRnDJWU7XpCDd4
IWbtbPE5NRqhbQcQT3PZYBv/DJpYZKASvjwhlszDXIszHbZLkwwmzoE2pIY6moRX
Aw1COOaKFuKwYpkxQFQgvD3YJK4R7deZTZKshJQ9rW6jXjuEHQ4ydyMCZ0E2/yIg
zfq/NUNvweXm3t9/Zyd3VJWwpkSlnwrEgZ5584kbCllTx5DOuJikhQ9luMQfUqGH
tnWR1Q/6dAoHIO1HZtBtV9HSKxYBOkWPkH6HtpstcNWhLwc4/Y4TeldrJyzGxjwh
qY4Wud8z7IHM4AGASyivQLz+v2kZnTdTYJ4JIUgdFRwZXW1xqQcZ+jEyIQb7pKA0
TIs/opNbhGGDq7MqyVbnwmwziUtpFDJw7SlKJRz8onL95KDMwA41APPiOuYtkmyB
ZNbUrQ633LpizLjwWmY7LpWyuFida6G5NN7MOfxAsuEwC6ZhNi6RUjKo5QNTB+Mn
K1LTCz381eK6bJja7CMadpuJjIegcwVYBUZcI8963ypCPMZ7j5AOdN9yVkk1vEy2
BYB2mhhw41SPt9cvwI7qVAw/uxmAoPqKrsdQJTIOmEnS3+afz4U=
=ECDl
-----END PGP SIGNATURE-----

--CaPKgh3XHpq3rEUV--
