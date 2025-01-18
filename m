Received: from mail-10698.protonmail.ch (mail-10698.protonmail.ch [79.135.106.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3E519CC24
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737219436; cv=none; b=q0YfxUxsZEJUW5D/fJJbw+tMwLUUyRbPHZsc2tKwqXoQZXA37B0u8ilHFiI1vySUheCFk1CUhvSvZyFXc2JsH2ZJ8UsB5r9R1MWSdZB0CgYcjFd/9THm1ZGZEgDwrWPMyAVul51lS9lVPpWsJreSs7LLPRL0TO2doIkabp1ejn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737219436; c=relaxed/simple;
	bh=z1zy1Ue6xfOB3rpw06mHPgvbKGEIGbzRxA8U4IXBmEw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvdnADkgQBGbAtBl3Ut/aIFGR9Cyy2ApcFavjE07dXsJj68CId78QLo4e5X/2c8Cw5hMEjWMsJFkvslfikKLop1PcwTDxy2mbqEbSdknrSujPXEKylQgEGcdG/no6RY+0ff12PXnrpZBjRdFve+J6ifBd/lwJMcTafxLxvbJdlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=XsV5QEeF; arc=none smtp.client-ip=79.135.106.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="XsV5QEeF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1737219426; x=1737478626;
	bh=z1zy1Ue6xfOB3rpw06mHPgvbKGEIGbzRxA8U4IXBmEw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=XsV5QEeFrsXYprqlmDt5QIj7QpTiNeJRThjNYWesLPo5QEZMh52Wj74OozQNL0zZA
	 HkSftW7B62vBt7O7Aj53TSDGvnQC2CAsGpFzdNX5Dd2Q8RE0d/VR8u7/mr4Oj9mRSE
	 2d/W8Ki7Fmvis6CAmjU60UBQWI/QtBhdrP3WSZ6ta/ISqIsf+vJtOvGDRbor9Z8YWw
	 AGFGhrP40dhue6em7GM1kkvP7suswTw9K+WTgV3TNjwS+Q/A2R/i8KbP3+e0dIW+1N
	 kyUlEv0WttqVOlo2Jn9DvN4uZTpa+yEUFSf0qln/bb0eOzg4Xo645sQasGbRQvQR3i
	 SrFMBD2iTH+rw==
Date: Sat, 18 Jan 2025 16:57:02 +0000
To: Jeff King <peff@peff.net>
From: Koakuma <koachan@protonmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] packfile: factor out --pack_header argument parsing
Message-ID: <oyahQoMDgyHL5zm-JuAtwlkUM2gHqO67zs83WP5Cm2h07S0x_xt8m4CNiShDFe2epznxlJF3kC-X_g414dRhDdrko44xo_yfsDXq1esVYVo=@protonmail.com>
In-Reply-To: <20250118092351.GB3474411@coredump.intra.peff.net>
References: <20250117125207.GB2356599@coredump.intra.peff.net> <20250117125459.GA2893666@coredump.intra.peff.net> <xmqqo705hxfz.fsf@gitster.g> <20250118092351.GB3474411@coredump.intra.peff.net>
Feedback-ID: 6608610:user:proton
X-Pm-Message-ID: 3f12daa4c4873f42da75e8b70042e314243c6644
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> wrote:
> Junio C Hamano wrote:
> > Jeff King peff@peff.net writes:
> > Interesting. So the file-scope static input_buffer[] sits in the
> > BSS and happens to be well aligned not to cause the problem, but ...
>=20
> I suspect it is a problem, but either:
>=20
> - The OP's test case was small enough to trigger unpack-objects, not
> index-pack. Possibly:
>=20
> git index-pack --stdin --pack_header=3D2,2 <no-header.pack
>=20
> would fail for them.
>=20
> - We simply got lucky with alignment based on the other things in BSS,
> the whim of the compiler, etc. But it is an accident waiting to
> happen.
>=20
> -Peff

That particular command doesn't seem to crash for me right now, but, as you
said, that is probably just a lucky coincidence that the compiler happens t=
o
place the buffer on aligned memory.
