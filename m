Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67F193
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 00:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="COhC3cx1"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ACCF7
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 17:42:29 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 41BA95B084;
	Wed, 18 Oct 2023 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1697589748;
	bh=hXX4SYHLHFocPfH9bsetAH66zonnwDqX+t71mTG+fHQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=COhC3cx1j8riJs9HiO3/qEWa+lz5TRamEVwzf/P+HG7qgQKr+Wt/5ldsJctqQEUWC
	 cmUkaJZ/cysAQY9cPkjl+1vyHF1baDrk7xSnNssBSvyJeHy+QM19DqWwRSIaGcpfmz
	 6f8c4YVpEFyYuHkiXeo+NMFXJ/1YcPziOmbbrPN1DtWmubrYjgv/qGTCERqU7WkYR1
	 xkhnEZ3S7c1v+XaKDAcxEpVzhqpa5B+Fka//28kYkTrJhdSnCUYfDnD39J1Ix1T6FO
	 6lda8LNahB941682EuwDIwtQDOfLGsEP1Wkzzuc9EdI9ysmtGd73wmKSXfQBW6tM99
	 fv5uTiG7JACchhKvGFYg9Y1jKgcjuhdf5NQZaaz2Btljy6VoVqIZmtnjSrarnqHxwh
	 SXQoml+fH4aTznH7QNIubpbgeDgs+yccz7/btkhbhZ/rdpF1MZTYgfX9djYuZir1kM
	 4C8phVaRGrdDKTq0Mo7ASfxavDwlk1XkJuxeUaOeUSBMxy+fBSo
Date: Wed, 18 Oct 2023 00:42:26 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Jason Hatton <jhatton@globalfinishing.com>
Subject: Re: [PATCH v2 2/2] Prevent git from rehashing 4GiB files
Message-ID: <ZS8p8pdUiM6NmiVo@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Jason Hatton <jhatton@globalfinishing.com>
References: <20231012160930.330618-1-sandals@crustytoothpaste.net>
 <20231012160930.330618-3-sandals@crustytoothpaste.net>
 <20231017000019.GB551672@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sZJl1fKu4BDZcuCL"
Content-Disposition: inline
In-Reply-To: <20231017000019.GB551672@coredump.intra.peff.net>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--sZJl1fKu4BDZcuCL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-10-17 at 00:00:19, Jeff King wrote:
> On Thu, Oct 12, 2023 at 04:09:30PM +0000, brian m. carlson wrote:
>=20
> > +static unsigned int munge_st_size(off_t st_size) {
> > +	unsigned int sd_size =3D st_size;
> > +
> > +	/*
> > +	 * If the file is an exact multiple of 4 GiB, modify the value so it
> > +	 * doesn't get marked as racily clean (zero).
> > +	 */
> > +	if (!sd_size && st_size)
> > +		return 0x80000000;
> > +	else
> > +		return sd_size;
> > +}
>=20
> Coverity complained that the "true" side of this conditional is
> unreachable, since sd_size is assigned from st_size, so the two values
> cannot be both true and false. But obviously we are depending here on
> the truncation of off_t to "unsigned int". I'm not sure if Coverity is
> just dumb, or if it somehow has a different size for off_t.

Technically, on 32-bit machines, you can have a 32-bit off_t if you
don't compile with -D_FILE_OFFSET_BITS=3D64.  However, such a program is
not very useful on modern systems, since it wouldn't be able to handle
files that are 2 GiB or larger, and so everyone considers that a silly
and buggy way to compile programs.

> I don't _think_ this would ever cause confusion in a real compiler, as
> assignment from a larger type to a smaller has well-defined truncation,
> as far as I know.
>=20
> But I do wonder if an explicit "& 0xFFFFFFFF" would make it more obvious
> what is happening (which would also do the right thing if in some
> hypothetical platform "unsigned int" ended up larger than 32 bits).

Such a hypothetical platform is of course allowed by the C standard, but
it's also going to run near zero real Unix programs or kernels.  I am at
this point reflecting on the prudent decision Rust made to make
almost everything an explicit bit size (e.g., u32, i64).

Nonetheless, I'll reroll this with the other things you mentioned, and
I'll switch that "unsigned int" above to "uint32_t", which I think makes
this more obvious.

I don't, however, intend to change the constant from 0x8000000 to 1,
because I think that's a poorer choice, but I'll try to explain it
better in the commit message.  (I had originally aimed to avoid editing
it as much as possible since it's not my name on the commit to avoid
Jason getting blamed unnecessarily for any mistakes I might make.)
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--sZJl1fKu4BDZcuCL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZS8p8gAKCRB8DEliiIei
gfC+AP4nONBJA+wPqrKjsbSCUDD2kws1nofR+GbMkS8XO33pDAD8D6Nbavkqa3iJ
2cPm4coZEm6hXL5rKlwUUtkLyso9GAU=
=8w/X
-----END PGP SIGNATURE-----

--sZJl1fKu4BDZcuCL--
