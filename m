Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76681B951
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 07:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708931327; cv=none; b=adW1S7+myCplf5flZ4o3CmG9qh/yjgyvnOQUhXjbdlU4rDweBgXvjou/tnjAZOtFvxJU/6jlf5QtHEXyUVoEu3h2GiTggw4LrdiJ/eRhHR0lHDRNd/v2UH6Cm5q3olA2IsTukJ6WzugDfToCqjyXnNeJPx60/WTJRofc4iogC1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708931327; c=relaxed/simple;
	bh=4qbZ6TMpPzeFH0L3rMeGAUvpHkvUOyXnsbMgHl66EQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scpAbX0lTkhgUZJJZVn7Xv5/afWQ666lveatcxtOX3hiL98GIQe8rpDPNNZZZr3C2SujNXWwEd+V4GbPgdrjUduXhoFJwY7WciCI6FP2lKMyoY7+LsJhGa8WqsrnmwFeCfIHSww2b9u/UfPGlHeeAeTBi/oH5uZmxIMIArCNRRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19281 invoked by uid 109); 26 Feb 2024 07:08:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 26 Feb 2024 07:08:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32760 invoked by uid 111); 26 Feb 2024 07:08:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Feb 2024 02:08:48 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 26 Feb 2024 02:08:44 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] mem-pool: add mem_pool_strfmt()
Message-ID: <20240226070844.GB780982@coredump.intra.peff.net>
References: <20240225113947.89357-1-l.s.r@web.de>
 <20240225113947.89357-2-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240225113947.89357-2-l.s.r@web.de>

On Sun, Feb 25, 2024 at 12:39:44PM +0100, René Scharfe wrote:

> +static char *mem_pool_strvfmt(struct mem_pool *pool, const char *fmt,
> +			      va_list ap)
> +{
> +	struct mp_block *block = pool->mp_block;
> +	char *next_free = block ? block->next_free : NULL;
> +	size_t available = block ? block->end - block->next_free : 0;
> +	va_list cp;
> +	int len, len2;
> +	char *ret;
> +
> +	va_copy(cp, ap);
> +	len = vsnprintf(next_free, available, fmt, cp);
> +	va_end(cp);
> +	if (len < 0)
> +		BUG("your vsnprintf is broken (returned %d)", len);
> +
> +	ret = mem_pool_alloc(pool, len + 1);  /* 1 for NUL */
> +
> +	/* Shortcut; relies on mem_pool_alloc() not touching buffer contents. */
> +	if (ret == next_free)
> +		return ret;
> +
> +	len2 = vsnprintf(ret, len + 1, fmt, ap);
> +	if (len2 != len)
> +		BUG("your vsnprintf is broken (returns inconsistent lengths)");
> +	return ret;
> +}

This is pulling heavily from strbuf_vaddf(). This might be a dumb idea,
but... would it be reasonable to instead push a global flag that causes
xmalloc() to use a memory pool instead of the regular heap?

Then you could do something like:

  push_mem_pool(pool);
  str = xstrfmt("%.*s~%d^%d", ...etc...);
  pop_mem_pool(pool);

It's a little more involved at the caller, but it means that it now
works for all allocations, not just this one string helper.

Obviously you'd want it to be a thread-local value to prevent races. But
I still wonder if it could cause havoc when some sub-function makes an
allocation that the caller does not expect.

-Peff
