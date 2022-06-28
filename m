Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC032C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 21:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiF1VEc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 17:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiF1VEb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 17:04:31 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A286B39165
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 14:04:30 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B1ACF5A492;
        Tue, 28 Jun 2022 21:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1656450269;
        bh=K5ynq9bJAUCR4R+ZQXiDlmMY2Ott5WiXLl2TPKgrPGc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=S60pfvTRw9PmEHilyXBikQTdZ4+ymCjkC4mlBdiX+8TRHdOo/5y48pSKjSFnmZjKA
         D49A9gt10A6D3b6nKN62u6R0B24PSn6+wfUmWeE5tzwc5qwbg1+VcUcZ+NCdZyB+ZC
         wq2dMS3NZkZDWG7wE9DD+ReXiOYbHT0k7luRxeaq0QB0/X5NslC/TTKidB1YGsnobm
         bBJYBrGueeltHPlOkEPU3+WH0L1fechHg/ZXW1m3ReAkHF8XPvMPqd57UgziAu2+UL
         rSw40rCiQLq+T00MQs0I7JMZR9/7DilJigYi+/NzQ/kb+Ia6PCPenr3qNuxN7JVl4w
         KZ+le/1FMayvbtCJZVif6HD08si6sLcI/JNgoDF36Gf2mp1UqG37KOFKsl3dmuwPVN
         w9FPdUvARwkM/GY311ybL1ghg4oz7uTZmFUigDE+5lgMkC7Rpn0OCtm5HS3dx3uqLn
         g6tSDUzexrimRP1ASOiKrJJbsnknqYAdO8DPn3YSORGZuKoGWLK
Date:   Tue, 28 Jun 2022 21:04:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
Subject: Re: [PATCH] pack-objects.h: remove outdated pahole results
Message-ID: <Yrts22oGOS/igqH/@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, pclouds@gmail.com
References: <1379af2e9d271b501ef3942398e7f159a9c77973.1656440978.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ORMLCc+1TgFad5mC"
Content-Disposition: inline
In-Reply-To: <1379af2e9d271b501ef3942398e7f159a9c77973.1656440978.git.me@ttaylorr.com>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ORMLCc+1TgFad5mC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-06-28 at 18:30:20, Taylor Blau wrote:
> The size and padding of `struct object_entry` is an important factor in
> determining the memory usage of `pack-objects`. For this reason,
> 3b13a5f263 (pack-objects: reorder members to shrink struct object_entry,
> 2018-04-14) added a comment containing some information from pahole
> indicating the size and padding of that struct.
>=20
> Unfortunately, this comment hasn't been updated since 9ac3f0e5b3
> (pack-objects: fix performance issues on packing large deltas,
> 2018-07-22), despite the size of this struct changing many times since
> that commit.
>=20
> To see just how often the size of object_entry changes, I skimmed the
> first-parent history with this script:
>=20
>     for sha in $(git rev-list --first-parent --reverse 9ac3f0e..)
>     do
>       echo -n "$sha "
>       git checkout -q $sha
>       make -s pack-objects.o 2>/dev/null
>       pahole -C object_entry pack-objects.o | sed -n \
>         -e 's/\/\* size: \([0-9]*\).*/size \1/p' \
>         -e 's/\/\*.*padding: \([0-9]*\).*/padding \1/p' | xargs
>     done | uniq -f1
>=20
> In between each merge, the size of object_entry changes too often to
> record every instance here. But the important merges (along with their
> corresponding sizes and bit paddings) in chronological order are:
>=20
>     ad635e82d6 (Merge branch 'nd/pack-objects-pack-struct', 2018-05-23) s=
ize 80 padding 4
>     29d9e3e2c4 (Merge branch 'nd/pack-deltify-regression-fix', 2018-08-22=
) size 80 padding 9
>     3ebdef2e1b (Merge branch 'jk/pack-delta-reuse-with-bitmap', 2018-09-1=
7) size 80 padding 8
>     33e4ae9c50 (Merge branch 'bc/sha-256', 2019-01-29) size 96 padding 8
>=20
> (indicating that the current size of the struct is 96 bytes, with 8
> padding bits).
>=20
> Even though this comment was written in a good spirit, it is updated
> infrequently enough that is serves to confuse rather than to encourage

I think you wanted to say, "that it serves:.

> contributors to update the appropriate values when the modify the
> definition of object_entry.
>=20
> For that reason, eliminate the confusion by removing the comment
> altogether.
>=20
> Signed-off-by: Taylor Blau <me@ttaylorr.com>

I agree with your rationale and that we should remove this.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--ORMLCc+1TgFad5mC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYrts2wAKCRB8DEliiIei
gTh4AQDl9tBzDb5PyNVc0kekmutFuMvx58Hn1FUluWGalAIZ0wEA+Vzme5Huxl16
Cb+UivOg8LgITjSMStZHYSKuE5Sprgg=
=6q5M
-----END PGP SIGNATURE-----

--ORMLCc+1TgFad5mC--
