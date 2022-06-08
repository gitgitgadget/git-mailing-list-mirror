Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0989C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 22:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbiFHW1P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 18:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiFHW1O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 18:27:14 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D5C140AB
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 15:27:12 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 952755A26C;
        Wed,  8 Jun 2022 22:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1654727231;
        bh=xOViX7froc6Dg+unBozvaKJSs1sTjxr5z/2JTScb1nM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=S5WWw3TxEGhX/pJsCRuCYtj5uk+18m3oM+6W24N/23i8rw+aRr8Qq/cXJkgK4esMh
         gIk2V30sj6emI4JtHylt7lQAKhHY12MSItyQMkMJkMf/4mlVKjEgcuw+5n4u1L2gfk
         i55UVdk2PhvkUAdqQi+YieDFZgU3b2lCv4hSswa5N6ADWbv5cxLP9okjU6N1Xo4039
         8tC7PZl7AR7oqxnxy0I6FWnKjeWTttPo4hiRRxKDhOkpcD14GqQLEYXQaz7jl+Jddx
         t8FsaSB/YvAMaIfuAqyT6egNcZfSxnbjahla2ClCuO8vhwmxWpBWb/qYyc8fBsCl2c
         LeOURH2rWJD8RVmuzFsk0sF4mxKQYm8GaT+kfdkbgqSI1ezb6fD2gJ0liFEt5Sznbl
         IJTw/QHqyu0tPSvepp9srYHp64KcaifHY3wF0UTpfLc4bnLwRDhf9PdznPTv8ngEb4
         xxJznLyuHA1pTOLccQilcSwqcAkTaD4Z5IJwcRNz7aGn7nkv4yi
Date:   Wed, 8 Jun 2022 22:27:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>
Subject: Re: Git apply fails on case-only rename on case-insensitive
 filesystem
Message-ID: <YqEiPf/JR/MEc3C/@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
References: <CAPMMpojwV+f=z9sgc_GaUOTFBCUVdbrGW8WjatWWmC3WTcsoXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1NidnHMId5GvKQkc"
Content-Disposition: inline
In-Reply-To: <CAPMMpojwV+f=z9sgc_GaUOTFBCUVdbrGW8WjatWWmC3WTcsoXw@mail.gmail.com>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--1NidnHMId5GvKQkc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-06-08 at 13:07:05, Tao Klerks wrote:
> Hi folks,
>=20
> I just found out that "git apply" has a faulty existence check on
> case-insensitive filesystems (or, at least, windows?).
>=20
> Simplest repro I could come up with:
>=20
> git init renamefun
> cd renamefun
> echo "Test" > file1
> git add .
> git commit -m "first commit"
> git mv file1 File1
> git commit -m "second commit"
> git checkout master~1
> git diff master~1..master | git apply
>=20
> -> error:
> error: File1: already exists in working directory

Your problem here is that the file does already exist.  To Windows
"file1" and "File1" are the same file.  Git wants to create the new
file before deleting the old one, but it already exists.

> (on linux, the same sequence of commands completes correctly)
>=20
> I was able to work around this for my purposes by avoiding rename
> detection on the diff, and only passing the "Add" (and "Modify")
> operations through to the "apply", after having separately/manually
> handled the deletions.
>=20
> Is this a known issue that someone might be working on, or worth
> digging into / trying to fix?

As I explained to someone else just today, the rules for case-folding on
Windows differ based on the version of the tool that was used to format
the file system and cannot be inspected without reading the raw file
system.  (This is also true of macOS.)  Thus, we cannot know ahead of
time whether two files differ only in case.

The way we could determine this on Unix would be to stat both files and
compare device and inode data when we get EEXIST, but I don't think our
Windows stat emulation supports that.  Having said that, for
case-insensitive macOS, I think the rename detection could be fixed here
using that technique.  I don't think anyone's working on such a thing at
the moment, though.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--1NidnHMId5GvKQkc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYqEiPQAKCRB8DEliiIei
gQSOAQDoIJyyyhhb3TvEXltl/vyXyT1bJkh2GYddJWCwr/S5bwEA/rB+rlkMPX/C
fTUGkSYShMWRSYfj1zpkK3H1twTaSAk=
=e/nt
-----END PGP SIGNATURE-----

--1NidnHMId5GvKQkc--
