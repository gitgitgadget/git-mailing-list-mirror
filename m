Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03771482E8
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770239891; cv=none; b=CHYhoC4tk29VCMpBpppIi35FPFbK3CLF46vJFoTSaTfBZXyqrXNGTuPIxo9zKeYtRyFj75i0i/BUfCSJKqA9HgF8qGi036shbq76nu2Ur/1PA6nc0bNEMxs9QRQyCZlNCpDQH6FFe70fddOeegEdWD8ZLoPiGgtev+PbssOU8EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770239891; c=relaxed/simple;
	bh=Js5VWxVVHjlqhZIvkH2r4v9BMUGvpo92WRIfp/9QIYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApqAWVqE2AFDKhjdXew9pYXWQn5bbdSwMdG6h0R+YcALN1sn+0zceNdUklV6NA+hPKAPGRkc31JgqJXkFGIiukhKjrgxcMJj/gecRxIsIoRFKff4+KRz0IBCkL3w02Cf56TDPhHXo8s3x1BPpTOGobl32LvBFdmyKyvhKoAVFcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzK3Ha8c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzK3Ha8c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6759C4CEF7;
	Wed,  4 Feb 2026 21:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770239891;
	bh=Js5VWxVVHjlqhZIvkH2r4v9BMUGvpo92WRIfp/9QIYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RzK3Ha8c0S7vKBTd7ATU0ZOEqwv4BBeG4J71LXAmZLBr42Xa2R5hC/3vtIZiapiSh
	 s2CpeyzDb2hEcSQ93I220HGlI+L2Dq51m8ljqIIZ46Ebs3sKax38P5kQxKIk7ZmyLj
	 F0IJtoZVBM8fme88nDmJjxKyR+vO8ICZbgCqbThVgCEjuGK+AjPjXjoXOEsnurCP4Z
	 19GvQODUF4pjo7F9gvIMIj7fWzwC46X9XarJcf9tFHW+LqYJRKuJ4cSDhm6CR30okM
	 CodROe2Fc/SjrGp4AboxSiy/Tcxl7TVmP8SKSToB6PIq+9iI1rPNag0xwmUiNIqfM6
	 DgRhbMSH6SRBQ==
Date: Wed, 4 Feb 2026 22:18:08 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	"Neal H. Walfield" <neal@walfield.org>
Subject: Re: [PATCH v1] gpg-interface: Signatures by expired keys are fine
Message-ID: <o2xni4463jlbmv226ngrlvepluqm43vg3fsifubanw6unhei77@wwzsa4ciqexw>
References: <20260204152306.1767112-2-ukleinek@kernel.org>
 <xmqqjywspgi6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yhrn6z45r6r4xp2p"
Content-Disposition: inline
In-Reply-To: <xmqqjywspgi6.fsf@gitster.g>


--yhrn6z45r6r4xp2p
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] gpg-interface: Signatures by expired keys are fine
MIME-Version: 1.0

Hello,

On Wed, Feb 04, 2026 at 09:26:09AM -0800, Junio C Hamano wrote:
> Uwe Kleine-K=F6nig <ukleinek@kernel.org> writes:
>=20
> > If a signature is done with a valid key and that key later expires, the
> > signature should still be considered good.
> >
> > GnuPG exmits in this case something like:
>=20
> "emits".
>=20
> > diff --git a/gpg-interface.c b/gpg-interface.c
> > index 47222bf31b6e..6635c6c8e16f 100644
> > --- a/gpg-interface.c
> > +++ b/gpg-interface.c
> > @@ -382,7 +382,7 @@ static int verify_gpg_signed_buffer(struct signatur=
e_check *sigc,
> > =20
> >  	delete_tempfile(&temp);
> > =20
> > -	ret |=3D !strstr(gpg_stdout.buf, "\n[GNUPG:] GOODSIG ");
> > +	ret |=3D !strstr(gpg_stdout.buf, "\n[GNUPG:] GOODSIG ") && !strstr(gp=
g_stdout.buf, "\n[GNUPG:] EXPKEYSIG ");
>=20
> Makes sense; I'll wrap this overlong line while queuing, though.

Just to be sure: That means I don't resent with the typo fixed and an
additional line break and you care to apply this patch?

Thanks
Uwe

--yhrn6z45r6r4xp2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmDt44ACgkQj4D7WH0S
/k7QRQf9H9oQ7fDAjnSrsBg32dXewLH1eGaDrv06Ne014Il20ZGkc8Ub7AyqVw+f
KBa5+Oc9U2qFLVnTTjO0XU13vTJp+sqfL+GeJx5DzlchhhYoiGxrnHp7/HaLrGfe
Le2U91IxNxoqbtVIZRDerwVoCFV9G+iZvW4BMfFE2OD6x7txYvU02/iHtYpWx5qE
YybAJi6FK/tsityogzSAuZ0SLYcLcU6fQMutEBxPBCFZc08YHPBZad89hX5Xqsug
mlS0m5RN6JueMHAtbnEhrE1wyfky5Cshx9MvMO1sik/t7zUxOnc5uZCJvrJ2ilw7
RBWcltgFxJOrD59b4ixPOJyzNqBYCg==
=dvbm
-----END PGP SIGNATURE-----

--yhrn6z45r6r4xp2p--
