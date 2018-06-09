Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21EC21F403
	for <e@80x24.org>; Sat,  9 Jun 2018 20:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753250AbeFIU4h (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 16:56:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36266 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753221AbeFIU4g (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Jun 2018 16:56:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:54a4:7f2e:59a2:6beb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C08D06046C
        for <git@vger.kernel.org>; Sat,  9 Jun 2018 20:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528577793;
        bh=MvCN77JLRVIUXw3yAgJnFsTQdMK2f39XxoHgL62u5+c=;
        h=Date:From:To:Subject:Content-Type:Content-Disposition:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=Gm2tIjRl6T6NJ9mLrBjB3W/flEcpSCJhbp36k7mUxPfFCqtjn8CSHbU/vIK8HZpyg
         Bw9dzgOidJulszBKgYszg7Xc5L89cPcXoNCwOZWVyXELR7+ZhUKMqWam6lSE3FIxsZ
         IUevJ4O6pSY0A7+NQydHIdcwQQTesfGNAg5Ia2UIzwDKOJzLeNFD91VfgVEw7Dm6SH
         c1mo4wcFU87FrKLtlaCTzhFE+LNsdc8tHlWWJlJxWOdvEUVClgiJV7JjLuxtbYZPGV
         EjZ4FNlZNsV18SgE91Nr0non6AV5GCB3LN2rDcNnmpu0945hMldCzk2ohj+425HpNr
         tCb2X6L7WjrS4zT1h3hxxlfA26PCatu1gyDZ4aBlV8MfqXRQ66vojED98egcMwmJ1y
         CI23t1d68GMRcFx0mvLjgNxMPdFIw8PayKWpDmfy4CfZeNujgB2Gyxo/6kdkxxPoaa
         JrrqddJkKM1HN1UlZrWWQwDfuNxHLCw7XVYIMWeOfXlggx9UqB6
Date:   Sat, 9 Jun 2018 20:56:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: State of NewHash work, future directions, and discussion
Message-ID: <20180609205628.GB38834@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Since there's been a lot of questions recently about the state of the
NewHash work, I thought I'd send out a summary.

=3D=3D Status

I have patches to make the entire codebase work, including passing all
tests, when Git is converted to use a 256-bit hash algorithm.
Obviously, such a Git is incompatible with the current version, but it
means that we've fixed essentially all of the hard-coded 20 and 40
constants (and therefore Git doesn't segfault).

I'm working on getting a 256-bit Git to work with SHA-1 being the
default.  Currently, this involves doing things like writing transport
code, since in order to clone a repository, you need to be able to set
up the hash algorithm correctly.  I know that this was a non-goal in the
transition plan, but since the testsuite doesn't pass without it, it's
become necessary.

Some of these patches will be making their way to the list soon.
They're hanging out in the normal places in the object-id-part14 branch
(which may be rebased).

=3D=3D Future Design

The work I've done necessarily involves porting everything to use
the_hash_algo.  Essentially, when the piece I'm currently working on is
complete, we'll have a transition stage 4 implementation (all NewHash).
Stage 2 and 3 will be implemented next.

My vision of how data is stored is that the .git directory is, except
for pack indices and the loose object lookup table, entirely in one
format.  It will be all SHA-1 or all NewHash.  This algorithm will be
stored in the_hash_algo.

I plan on introducing an array of hash algorithms into struct repository
(and wrapper macros) which stores, in order, the output hash, and if
used, the additional input hash.

Functions like get_oid_hex and parse_oid_hex will acquire an internal
version, which knows about parsing things (like refs) in the internal
format, and one which knows about parsing in the UI formats.  Similarly,
oid_to_hex will have an internal version that handles data in the .git
directory, and an external version that produces data in the output
format.  Translation will take place at the outer edges of the program.

The transition plan anticipates a stage 1 where accept only SHA-1 on
input and produce only SHA-1 on output, but store in NewHash.  As I've
worked with our tests, I've realized such an implementation is not
entirely possible.  We have various tools that expect to accept invalid
object IDs, and obviously there's no way to have those continue to work.
We'd have to either reject invalid data in such a case or combine stages
1 and 2.

=3D=3D Compatibility with this Work

If you're working on new features and you'd like to implement the best
possible compatibility with this work, here are some recommendations:

* Assume everything in the .git directory but pack indices and the loose
  object index will be in the same algorithm and that that algorithm is
  the_hash_algo.
* For the moment, use the_hash_algo to look up the size of all
  hash-related constants.  Use GIT_MAX_* for allocations.
* If you are writing a new data format, add a version number.
* If you need to serialize an algorithm identifier into your data
  format, use the format_id field of struct git_hash_algo.  It's
  designed specifically for that purpose.
* You can safely assume that the_hash_algo will be suitably initialized
  to the correct algorithm for your repository.
* Keep using the object ID functions and struct object_id.
* Try not to use mmap'd structs for reading and writing formats on disk,
  since these are hard to make hash size agnostic.

=3D=3D Discussion about an Actual NewHash

Since I'll be writing new code, I'll be writing tests for this code.
However, writing tests for creating and initializing repositories
requires that I be able to test that objects are being serialized
correctly, and therefore requires that I actually know what the hash
algorithm is going to be.  I also can't submit code for multi-hash packs
when we officially only support one hash algorithm.

I know that we have long tried to avoid discussing the specific
algorithm to use, in part because the last discussion generated more
heat than light, and settled on referring to it as NewHash for the time
being.  However, I think it's time to pick this topic back up, since I
can't really continue work in this direction without us picking a
NewHash.

If people are interested, I've done some analysis on availability of
implementations, performance, and other attributes described in the
transition plan and can send that to the list.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlscPvwACgkQv1NdgR9S
9otu8A/+N4Pn5gJfJrxKrF9DZEBYV1DTgU4aLx78ED63eGhOXyUp+bOUm9PKE9Yy
0pZVl0X4x523eySU/dzYsZhPxjyyE7oTo6U7+J1NpfcWcpd4Tr7/w8mnp9GdS3WE
udXSz9kovXqmXXQU9bCspZZZAUWcULtn5U7nQ7tDWAWgD3oPVt23lBsF8y6V5QRQ
ezrYyalPKaIIFMIxFC40cpg/SXn4BYfRirlXl032vBbOMnF8v4q5FI0Z5cyyLO1e
LJfCBOu4xxUcTee+2y9ApYAWuyNW8GhDxzltCpfnGsEONKQ/6l/ymVHOgHyH8dZ9
HsTaWA/1j/77ZEvsXqMQYTSfdRyKNzYEfki29qR9Am3XgOSeiqsawK1oLH7jtod6
0Lvm6zhbmvF0/xJn+YbS02qJKhKjw2FOQVEbO1jRwPOxClZlEs4SD/ig9tqtrh2M
mCDeovcLv/etpTCYTU/zHZ4o/oQlLtbSGq1fUqI3kgvdJjH3gHNPLoItaCO1OXg/
FDDZPUqpIbsnwLRxZhCNUPe72B9MHg1k/64Ys7bK12Vz4HgogQyDY1bzQ/qMaVE5
lEhldB0lhmCtaeHH9Z1DvtHZA9GDGeNTwfxWxUeOE4NuyUb2/HdX4NWIehzPWfPD
C0jJy0AHPWV0kcHq0a4cppyvAq+Pb+YA9ucP6evXv2VVL5wiOU8=
=kNlf
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
