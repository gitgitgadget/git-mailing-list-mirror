Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012973A3809
	for <git@vger.kernel.org>; Fri, 29 May 2026 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043682; cv=none; b=aBhBlE7xVz49TEOJC8NFgUp6r7f8QwJfd1KVU4DjWwI0m9Hdru2JaF97Mzobf+anOMbSoxkbrOkV4HuKfBpmdPqcWwk8mBhVYHTH77rjEAEX63qImMlPORoluvc0cQzOvjU/CCMQEJmTPfuXVmH2xnglWTC8oW9wWqPMUITUpm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043682; c=relaxed/simple;
	bh=F0x+MH+FpbVwZNV4lliGZZhnb7Uk1IzV8DNdsgkGNSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMZqB4/84PE6XkJ/xJMTDx6P7+z7J5Y5AglKJ50AHgKOEa7+ApKobhQvqOiCOKUrATxhRsEqKTd6tlPL4MgJajxBDwp7gCHSGSCCjkamiGVqocKOVsVi1d/hPFlGSWOjDqsBppUsA0o41EvshSi7VqlAMgWWZEpnTEWeJn6Pm90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RD0dRiHN; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RD0dRiHN"
Received: (qmail 5803 invoked by uid 106); 29 May 2026 08:34:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=F0x+MH+FpbVwZNV4lliGZZhnb7Uk1IzV8DNdsgkGNSE=; b=RD0dRiHNyRVIohpJAgi0rDcI8ocZibQByyeBjFPTbIAN9xqNkaPZ28LTOWMnoEDK3JIT5bvjPoicb7CQyU9QxteSrsiIH/xlPkCpbus12z3YTpSPYeqf7uh5FIrr0PaGgLm1ogxsf5rbH4UNA/CSqq9BV4LLxfBS0LIEXR4PZs44sQNkOdyUHm/3xj9+UnSP1ntayAEiuOjNWR3DOst9ZWxOeWckbDhoQ6dSB1E8dzHfoH6hssyewpVQGsrHXAY2ezYxNbs7Nz3dAlrJ8D7DB/9neq6VpkWWcKsfnuwbq0h20pgNiAgRri6c9gC9YP0RcPAUvZU5pGRhGncawIk3Bg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 May 2026 08:34:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9145 invoked by uid 111); 29 May 2026 08:34:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 May 2026 04:34:44 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 29 May 2026 04:34:39 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/8] pack-bitmap-write: speed up bitmap generation
Message-ID: <20260529083439.GD1106035@coredump.intra.peff.net>
References: <cover.1779207127.git.me@ttaylorr.com>
 <cover.1779911733.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779911733.git.me@ttaylorr.com>

On Wed, May 27, 2026 at 03:55:44PM -0400, Taylor Blau wrote:

> Here is a reroll of my series to improve the performance of reachability
> bitmap generation, focusing on very large repositories and the penalty
> to generate pseudo-merge reachability bitmaps.
> 
> The series is largely unchanged since last time. Notable changes in this
> round include:
> 
>  - minor refactoring in the pair of patches which consolidate the
>    `find_object_pos()` success path and introduce the object position
>    cache during bitmap fills, and
> 
>  - dropping a stale paragraph from the final patch's message, which
>    described follow-up commits that are no longer part of this series.

Thanks, this version looks good to me.

-Peff
