Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E403E959D
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774910795; cv=none; b=RpOqzXe30+Z5Yq35zd2wRC3XlNLKo1Db6zgRfEyBxJjd7QA3yjxFoQDZlel/fVMKp3x1SasWJnz+CZUr1sDFiC5jgd67ylI0QJT8lH+rwmXCwiZcjq+Q3zfB7baAjax6EkX6zIcpsgz8YJgmrtRx3v/pV8azYnLVpZDsch9CymI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774910795; c=relaxed/simple;
	bh=rnV/Xeal/VXNWR5OzjLMrZ5ISbKlugs/qv0b9eBtUb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lh3/E5EN+8k2Hql3+GTB/dvsw6pPhuYwgorndCByPpFV95iyJWIm9+UEfrM4/IfZ8bKe5XajEo3CNawwfMSmXc9qxJ8KrFDUrQFxlZ5rzZF525riD19AVvBhikKur4rGtvZraVIN0b8RmYiqhR6AXinRYVu1R/XrAvICL6F9ytI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=empMldNM; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="empMldNM"
Received: (qmail 199250 invoked by uid 106); 30 Mar 2026 22:46:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=rnV/Xeal/VXNWR5OzjLMrZ5ISbKlugs/qv0b9eBtUb0=; b=empMldNMIu8GqVB6+KA+8A8tlxIWx2HTVmolKmSBnPv3f01zSYau6sDnjoWFU8UJf6hUrn2GVI1CIXPxQh55BStAMsf/t/mLRXcUTfEQsxX4Tj4HzIExKYfat2Hn1K/PfW3uQIc0KffYU+i3/+Ab0UbllS9dZ4UPph3dUJrPHCyZ9X6FjlPnMLR3iHy9o7BzZo1WeVFMcbBDuE5L9yF51flBY/BXpWBzmB0hfZTujRTKJ4TCSJI2nLtNz2WylGI8oXfuUEDaw9coRyUA/5uAy1r/DxBMJKL9WeZUEhOTUDvmQoiBwoaPEDFLnSPIMPWR2vl2SYgqzPSUWzwHYEutCg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Mar 2026 22:46:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 306082 invoked by uid 111); 30 Mar 2026 22:46:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Mar 2026 18:46:31 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 30 Mar 2026 18:46:31 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 03/16] strvec: introduce `strvec_init_alloc()`
Message-ID: <20260330224631.GC41843@coredump.intra.peff.net>
References: <cover.1774820449.git.me@ttaylorr.com>
 <aea6aad695336a974df9c90ce7bd02ddcc33582f.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aea6aad695336a974df9c90ce7bd02ddcc33582f.1774820449.git.me@ttaylorr.com>

On Sun, Mar 29, 2026 at 05:40:58PM -0400, Taylor Blau wrote:

> When the caller knows upfront how many elements will be pushed onto a
> `strvec`, it is useful to pre-allocate enough space in the array to fit
> that many elements (and one additional slot to store NULL, indicating
> the end of the list.)

The main reason I didn't add an "alloc" parameter to the initializer
originally is that if you know how many elements you are going to push,
you probably don't need a strvec in the first place (you can just make
an array). But let's wait and see how it gets used in a future patch.

> +void strvec_init_alloc(struct strvec *array, size_t alloc)
> +{
> +	if (!alloc) {
> +		struct strvec blank = STRVEC_INIT;
> +		memcpy(array, &blank, sizeof(*array));
> +	} else {
> +		CALLOC_ARRAY(array->v, st_add(alloc, 1));
> +		array->nr = 0;
> +		array->alloc = alloc + 1;
> +	}
>  }

We use the blank+memcpy approach so that we don't duplicate knowledge of
which elements are in the struct (and which might need to be
initialized). But now there's an implicit zero-ing happening when alloc
is non-zero. Can we write this as:

  struct strvec blank = STRVEC_INIT;
  memcpy(array, &blank, sizeof(*array));
  if (alloc) {
	CALLOC_ARRAY(array->v, st_add(alloc, 1));
	array->alloc = alloc + 1;
  }

The worst case is a useless write of a few struct elements, but I
suspect that an optimizing compiler can even get rid of those.

I doubt we are going to add new elements to a strvec, so this is
arguably just pedantry. It just feels like it's easy enough to do now
while we're thinking about it.

  As an aside, it is sad that we have to CALLOC() ourselves here, as
  there is no reusable "grow" operation. Probably not worth refactoring
  it out, though, though.

-Peff
