Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519A83806DC
	for <git@vger.kernel.org>; Fri, 15 May 2026 19:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872101; cv=none; b=q+xZxT/RpkW5OZxapK2GngqKveMk/0onrwMzBMVi0Q3qggdPuNoNL2YpKQtw79AYhUHYSZCoHvp3Yu5KqCqUIaLMiXgshdsN0bfGqYkW3vcH+xZSwVboWUz9KD0gqcl1Xmi0Vip3y6KEbTFDUlUTI50QrF+3S6J/DyaALGF/KQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872101; c=relaxed/simple;
	bh=P6GzRvS/rxUaEokC1gclhTE8NX74PBC/6e1iHpXN+Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIChOdBDK5/kqjEflZul86prqv4Vbm1L9YGHDxtACcNgNX8ZF8It/gSeEctL0J3fRIDRaI1YVsdNcc4tt53ZryyNs72aH3TCib41YChD534LwqxSzlzFp5WNQb1H+TV5AB42IPr9awKbU7yXGltAsF8Wuru2acc8BDCPQWXKm8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QP3r9WU5; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QP3r9WU5"
Received: (qmail 56608 invoked by uid 106); 15 May 2026 19:08:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=P6GzRvS/rxUaEokC1gclhTE8NX74PBC/6e1iHpXN+Co=; b=QP3r9WU5ttx7vj1DgdQiB2xgj3Pdim5riruO45623LQMr5YwktCKk5Qj5FI0eVKJWOQkM5uAVLm47RcV2psA1J+Pv7H4w9F1JyugwSlNAbFUX8rkhLKKjc/ycYM27Z1RZajG9FHTExDfUylifW7qy+X8qQsMIuCxCLfKgyozlUfhdyIIapG7TbJ6IfggHlEWvxbuuH47JKE/Cd/7D7VtJjEioht10pJpIYCVpI8P8LLcvpwFtOgeSqvfmHWQOS7Y1aZBwCQK0BTtROw+xanhsByE846ilukOTMcQ3aWDh7Sz5Xn9mywdpDJWEKkhpY3zK9m5GSyXtAHi+y3Ypd1ruw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 May 2026 19:08:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 105322 invoked by uid 111); 15 May 2026 19:08:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2026 15:08:18 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 15 May 2026 15:08:18 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] evaluate the second argument of ALLOC_GROW only once
Message-ID: <20260515190818.GA98370@coredump.intra.peff.net>
References: <323f5677-301b-4d7a-b552-6606597c2b1f@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <323f5677-301b-4d7a-b552-6606597c2b1f@web.de>

On Fri, May 15, 2026 at 08:16:50PM +0200, René Scharfe wrote:

> +		size_t alloc_grow_new_alloc_; \
> +		if (st_alloc_nr((nr), (alloc), &alloc_grow_new_alloc_)) { \
> +			alloc = alloc_grow_new_alloc_; \
> +			REALLOC_ARRAY(x, alloc_grow_new_alloc_); \
>  		} \

What happens if a caller passes in an argument that isn't a size_t?
We'll check for overflow in the size_t space, and then truncate it when
we assign to alloc, I think.

I think we generally try to hold allocations in size_t these days, but
I'd be surprised if there weren't a few "int" holdouts. Grepping around,
alloc_node() seems to be an example.

BTW, non-size_t arguments nullifies my earlier hand-waving around "nr +
1 overflowing implies we've filled up the address space". But we are
still protected in the existing code by the:

  if (alloc_nr(alloc) < (nr))
	alloc = (nr);

logic. But with your patch, that all happens in the size_t space, so I
think it would actually introduce possible array overflows when the
caller is using a smaller type.

-Peff
