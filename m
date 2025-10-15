Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00B831BCB2
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524118; cv=none; b=K9YxVraeik8fP8RFAmiKBM7YInAx6qIwPyk8QkPyOK3m90gzVYkTmkJvUI2fT5bP3LAtSHjDRGDJ52Sfj0ZIl+8o2Y7Ea2K/VNrqJjjYtxTp2WsbyKL8Ul2z09b5lqM2L9c5RwYwdxymymOW+vJmnzNaECE9sJhIrodkVAoQSes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524118; c=relaxed/simple;
	bh=HF4aE2oWHyY1LgF2gQfi7tY1Cr4j0pi6ZwRLWQ4P2WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WS61PEsBAPiInvg/vr7m4ACw9F3tKtMn5k1GCzffnB3uyvUcFiwoNWks94Q//ahsigqyEvBuCSkf2J9n5CSqbwYrgsEEqbJUCUee+EL7Jvk2YKcDefve2Dl1EUwbz5MhjOtCoQ58075Xs3B2qrONx6r5HJJpy1Jmgb+3yIeExR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IJIozx95; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IJIozx95"
Received: (qmail 226737 invoked by uid 109); 15 Oct 2025 10:28:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HF4aE2oWHyY1LgF2gQfi7tY1Cr4j0pi6ZwRLWQ4P2WA=; b=IJIozx95yEU21Do2YqfOMfQLf0Z2BnN5+IvWImpX3/ItsyJK8gvAR4cfMQZCAD8wiBAASJenpcyweGeDL/8Uv65Dvxq5wqrOTjkxy/Xi/FRc3Zn9C6Cj+NkFofhsdVsG5ofzeEMUhhf0AHvdGipbRM+CLfxTYYyVRUbt7SPWs+4DqhEcNMxiWFSXiTH6Tl2musEFJo05V+Te99G10VRzrkhD1/bYXGatPFdIlloj5zwixWvLRaDf966zo6n65fMi13xWqUdv3BEDwrLb8ZsUtkUF1NKUEHVlUISDw5ylk7DrIepyrnAYvhxJlDT7H04dgpOuksDBJZ7fDOoZesYL4g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Oct 2025 10:28:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 362950 invoked by uid 111); 15 Oct 2025 10:28:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Oct 2025 06:28:34 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 15 Oct 2025 06:28:33 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 40/49] builtin/repack.c: introduce `struct
 write_pack_opts`
Message-ID: <20251015102833.GB2250228@coredump.intra.peff.net>
References: <cover.1759097191.git.me@ttaylorr.com>
 <109109618687efeb932bee7dd5882557ab0576f4.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <109109618687efeb932bee7dd5882557ab0576f4.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:09:51PM -0400, Taylor Blau wrote:

> Instead of repeating those arguments for each function, let's extract an
> options struct called "write_pack_opts" which has these three parameters
> as member fields. While we're at it, add fields for "packdir," and
> "packtmp", both of which are static variables within the builtin, and
> need to be read from within these two functions.

Makes sense, although...

> +		struct write_pack_opts opts = {
> +			.po_args = &po_args,
> +			.destination = filter_to,
> +			.pack_prefix = find_pack_prefix(packdir, packtmp),
> +			.packdir = packdir,
> +			.packtmp = packtmp,
> +		};

...since we are now passing packdir and packtmp anyway, and pack_prefix
is derived from those, should the called function just do that
derivation itself? Or do we expect that some callers may eventually use
a different prefix?

Probably not a huge deal either way, but maybe an easy way to tighten up
the interface a bit.

-Peff
