Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7513CC433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 23:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245448AbiAFXXD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 18:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbiAFXXD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 18:23:03 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2498BC061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 15:23:03 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 2CFF15B256;
        Thu,  6 Jan 2022 23:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1641511382;
        bh=mFPixkSN3Ycen3oIQrLQtT5O9nEuD3tghrQ2WrUUrEs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=AhBE0jj6BCJJulMVTKcDZl4DeUJEQchGYKPM47l11Gp2UnQMTgHXX4X3TwAsHlNcd
         iFYGz7dxJP60M9Agp8dI6e8Bv/kL06WlCA0x5ca5mpXUyP+teC2WFaPRXomTT8Uf5s
         4PaPNojsrU3WmWDJb/CGkh52gpTCuI1Xbwg1lmMqECFRY2u4t0qzmMbsTBozDgd4d3
         4HT/5dsvTG1GAC65jc5pflx9sibsLBnK1CPiW6V3eFSFvX5k/px6THcCkUvaR62/L4
         BlBON2BPbpbII6CtbJ2WKvZC5T36vnmsUToS4qGRotlNv+x8IV+iEkFNixyx7MhKR2
         JKN2FIO/KFQA9UyANMTWRKMAKVCV/hoLtY2y9ig7+dgWl6db/PUl26FkIq4zKH5J5m
         HusxRKgTQ8lGQnmbTdeFfH3ZTGzjkMSoWhdZdrzWZlC/BVu2Oy69pGWvhfhs0WJSWz
         Xjrn3T8/DDKJTN+wgraSxcPC6AtktrODAVBvO6HeEBT5bs+4LF1
Date:   Thu, 6 Jan 2022 23:22:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
Message-ID: <Ydd50/BLKlbK+Wj4@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jessica Clarke <jrtc27@jrtc27.com>, git@vger.kernel.org
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+UeddTN10XKdkj5k"
Content-Disposition: inline
In-Reply-To: <20220105132324.6651-1-jrtc27@jrtc27.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+UeddTN10XKdkj5k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-05 at 13:23:24, Jessica Clarke wrote:
> Currently git_qsort_s allocates a buffer on the stack that has no
> alignment, and mem_pool_alloc assumes uintmax_t's size is adequate
> alignment for any type.
>=20
> On CHERI, and thus Arm's Morello prototype, pointers are implemented as
> hardware capabilities which, as well as having a normal integer address,
> have additional bounds, permissions and other metadata in a second word,
> so on a 64-bit architecture they are 128-bit quantities, including their
> alignment requirements. Despite being 128-bit, their integer component
> is still only a 64-bit field, so uintmax_t remains 64-bit, and therefore
> uintmax_t does not sufficiently align an allocation.
>=20
> Moreover, these capabilities have an additional "129th" tag bit, which
> tracks the validity of the capability and is cleared on any invalid
> operation that doesn't trap (e.g. partially overwriting a capability
> will invalidate it) which, combined with the architecture's strict
> checks on capability manipulation instructions, ensures it is
> architecturally impossible to construct a capability that gives more
> rights than those you were given in the first place. To store these tag
> bits, each capability sized and aligned word in memory gains a single
> tag bit that is stored in unaddressable (to the processor) memory. This
> means that it is impossible to store a capability at an unaligned
> address: a normal load or store of a capability will always take an
> alignment fault even if the (micro)architecture supports unaligned
> loads/stores for other data types, and a memcpy will, if the destination
> is not appropriately aligned, copy the byte representation but lose the
> tag, meaning that if it is eventually copied back and loaded from an
> aligned location any attempt to dereference it will trap with a tag
> fault. Thus, even char buffers that are memcpy'ed to or from must be
> properly aligned on CHERI architectures if they are to hold pointers.

I think this is going to be a problem in a lot of places, not just in
Git.  I'm pretty sure that copying data this way is specifically allowed
by C and POSIX, and thus this approach is going to break a whole lot of
things.

For example, casting a void * to uintptr_t and back should produce two
pointers that compare equal.  The C standard says that two pointers
compare equal if they're both null, both point to the same object, or
one points one past the end of an array and the other happens to point
to the beginning of another object.  If the pointers aren't null and the
original one points to valid data, then the resulting pointer (after the
two casts) would point to the same object (since that's the only valid
option that's left), and therefore could be used to access it, but that
wouldn't necessarily work in this case.

The CHERI paper I'm reading also specifically says it is not changing
uintmax_t, which is a direct violation of the C standard.  If uintptr_t
must be larger than 64 bits, then so must uintmax_t, even if that
happens to be inconvenient (because it changes the ABI from the normal
system ABI).  It sounds like, in fact, that you can't actually provide
uintptr_t with the current architecture, because it can't be provided in
a standard-compliant way.

Is there something I'm missing here, or is it the case that CHERI's
behavior isn't compliant with the C standard?
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--+UeddTN10XKdkj5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYdd50gAKCRB8DEliiIei
gbL4AP9ar4s0YrguMKLHrCaPBveRJ9qZHOuRFqg4WkLyfFA6igEAzh1yVFAc/A1z
Gxif3xGNOimmyRc6IHlhhJMteuYvdQ0=
=c15v
-----END PGP SIGNATURE-----

--+UeddTN10XKdkj5k--
