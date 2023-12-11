Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="b38o27sE"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC31C2
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 14:18:00 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 294255B115;
	Mon, 11 Dec 2023 22:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1702333079;
	bh=ZL+fZv9b/H02sRQwsz/f7jAKofqTsT4InxFafqGKYKg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=b38o27sEvAKUsMJhUIKWrSgjDefGxa9X2vCMZaMX5VFEPabuuqJy52HUPy8Pai6bs
	 viNwgKs1njykmixwl/9ApQokJOfJL7hXqnl5BAHjq8OIKiWaLDMK9hjk1BpuHxLGxw
	 qSeF4nCAACfFwQDO5p6aHhPY27oXQ4fk/W5hCuFWgf9qqNNcTFN52rnQairtTt2l2O
	 BOmslsR/jEMdDuHYqATK9paTEJal7XLlTTt1/b0MVGjCskbETuDZlyF5PBQ8UY8sdx
	 Ylq6Yw9HI+e924w8ho+SFEkgULWUaH0BubuQwDR6mXfqbXeKrOC8d6QOtwDUzHJoDs
	 7dTtkZvvJY6Am9xAXv8DlkASHNpd/X/UOdWfZVjNBqjO4WF4nviOU5CY5RZPFjV7+7
	 qVIS8hvKcOtWRj6vaOZhxV1JN4lys05A4wjHRZp8B2UG9RKCvpOF/13N87YKL7YH4b
	 H/K/8MPCeEfpRxm/i63kMwRoNHlr0pzSZxIPpgt42aWZ13vvilt
Date: Mon, 11 Dec 2023 22:17:57 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/7] clone: fix init of refdb with wrong object format
Message-ID: <ZXeKldqyqN9ofTcF@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
References: <cover.1701863960.git.ps@pks.im>
 <xmqq7clmn3w1.fsf@gitster.g>
 <ZXbzzlyWC3HTUyDA@tanuki>
 <xmqqmsugvlbe.fsf@gitster.g>
 <ZXcrpGQhH121AQ7y@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a+3FmmTokCNLe+xk"
Content-Disposition: inline
In-Reply-To: <ZXcrpGQhH121AQ7y@tanuki>
User-Agent: Mutt/2.2.12 (2023-09-09)


--a+3FmmTokCNLe+xk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-12-11 at 15:32:52, Patrick Steinhardt wrote:
> On Mon, Dec 11, 2023 at 06:57:25AM -0800, Junio C Hamano wrote:
> > We have "no way to do so"?  We have "not done so"?
>=20
> We have not done so until now, and we have no easy way to change this on
> the server-side as the server is not controlled by us in the first
> place. That leaves two options I can think of:
>=20
>   - Try harder on the client-side, e.g. by trying to download the
>     gitconfig as you propose further down. I wonder whether admins would
>     typically block access to the config, but doubt they do.
>=20
>   - Change the format of `info/refs` to include the hash format, as this
>     file _is_ controlled by us on the server-side. Doesn't help though
>     in an empty repository, where the file is likely to never have been
>     generated in the first place.
>=20
> So it seems like downloading the gitconfig is the only viable option
> that I can think of right now.

I mean, we can add an `info/capabilities` file with capabilities and
assume the repository is SHA-1 without it.  I'm fine with that approach
as well, and it can be implemented as part of `git update-server-info`
pretty easily.

But yes, absent that approach or parsing the config file, we'll have to
just use the default settings.

> > The simplest "fix" might be to leave what happens in this narrow
> > case (i.e. cloning over dumb HTTP from an empty repository)
> > undefined by not testing (or not insisting on one particular
> > outcome), but ...
>=20
> I would be fine with that outcome, as well. It's not like the current
> behaviour is correct in all cases either. The only benefit of that
> behaviour is that a user can in fact work around the broken cases by
> setting `GIT_HASH_DEFAULT` to the correct hash, and that benefit would
> be retained by the diff I sent that made remote-curl.c aware of this
> environment variable.

That would also be fine with me.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--a+3FmmTokCNLe+xk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZXeKlAAKCRB8DEliiIei
gYj8AQCTBwAfoG3mTnULz+D5vTSnLiCJS64pg//d4HiGXa62AgD+OzbcqTsQxcC4
Kq7pbuykawoj6yCkx12RwqF5k7+0Awc=
=U71V
-----END PGP SIGNATURE-----

--a+3FmmTokCNLe+xk--
