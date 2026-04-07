Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61897386550
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 06:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775542728; cv=none; b=Sl0S8kVpUsycDKDs5rMx+4UNMrNm/p5Sjer9zGktMmQVxaWkeejNG3iQa6LU6hS2Ri/y8PpQzE88lm/B/y/wqf1N6q4MCHkQSuZaAmvO2f9OBgrsNIb0O9L4oQObdIGTI2+24gUY7xNGnMh6OKr2f0E8dOROQdRkpux5l1ed6MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775542728; c=relaxed/simple;
	bh=fDw5z/IEXjEn7tqH62r/TxD9q0NURBCUd0U9gjZA0U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHgHJARA20oyVgDFVkv8salm94tq7HTnxBHZ3JshwYZtR0k9z5ZnbtU4qWoG88B1+NmP2zD+uXolpDYm9d9BEys+9FwMgSqFYz0yizB6ZSYl50/I+uzSs7u3jqCQoCTIYRbd0xH0Zts+5cfwWjtyoWd2aJHaW2qnMRS7fZPtDf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Msdq+Mkl; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Msdq+Mkl"
Received: (qmail 269517 invoked by uid 106); 7 Apr 2026 06:18:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fDw5z/IEXjEn7tqH62r/TxD9q0NURBCUd0U9gjZA0U4=; b=Msdq+MklcujqBbZfPmz7AdCVYZvT98tD50ovMQj9PSXu+7DpDrp/wPfDzgo0QxPSxHL3cLQJi5Qf2LcGCDKzu2GaUIHZYabfXP/i5boJm1tN4K//fSgYgb5ImgQvFouvIEcYY7xXwfD4beKQNFphOlUH+HporzwYM+lCZSDC6370NoBBWHs3B4XH0Aqd2yadrHARYYgoUgswJwtdK4VsyqBK8F5D5KBUMfeP/POzvQYXmr74Xmku956fg4YnOl2OnSpI5Bv0HBMWfCaELHku4Iv3iY0MOCKKEoRPmrSlPlBm/TqC/bkqJX+EL0O/O603NEg9zKCM+I5z/TOVzJPP+A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Apr 2026 06:18:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 441916 invoked by uid 111); 7 Apr 2026 06:18:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Apr 2026 02:18:38 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Apr 2026 02:18:37 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 12/16] builtin/repack.c: convert `--write-midx` to an
 `OPT_CALLBACK`
Message-ID: <20260407061837.GF714878@coredump.intra.peff.net>
References: <cover.1774820449.git.me@ttaylorr.com>
 <56dc6d55974ffe08647d57915d0861181e1d7d41.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56dc6d55974ffe08647d57915d0861181e1d7d41.1774820449.git.me@ttaylorr.com>

On Sun, Mar 29, 2026 at 05:41:21PM -0400, Taylor Blau wrote:

> diff --git a/repack.h b/repack.h
> index 77d24ee45fb..81907fcce7f 100644
> --- a/repack.h
> +++ b/repack.h
> @@ -134,6 +134,11 @@ void pack_geometry_release(struct pack_geometry *geometry);
>  
>  struct tempfile;
>  
> +enum repack_write_midx_mode {
> +	REPACK_WRITE_MIDX_NONE,
> +	REPACK_WRITE_MIDX_DEFAULT,
> +};

Since the name of the variable did not change, the compiler would not
catch any old cases that did:

  if (write_midx)

for us. Which made me wonder if we should set _NONE to 0 explicitly here
so that continues to work, in case we missed a spot.

But after manually checking each spot that uses the enum (and there are
not that many), they have all been faithfully converted. So it's
probably not worth trying to preserve that compatibility (and anyway,
once we introduce a third mode, it's not clear that such a site would be
correct anymore anyway).

-Peff
