Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A45B34DB7C
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939471; cv=none; b=ZD7hx8+vEvDhlzNZPjLxtBqOuURYpQGo68/SZxyLgCTnMrz+8UvQTnGjF96TocGBAyvhr2dbUnDaNZ7pSjKyDneFWrzRh91XUYlgBbvQLUQ0+jwm572JRCGy0L4CZAWCSXYja2dKuCcy/f3ArPjDgtotJU68l2WFNAitl0lyyVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939471; c=relaxed/simple;
	bh=9AklyW7B9KOK9KO84eJ10gb5YYlAdfGNJsP1/n1DQRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxrQB+YJH2Ok4xhLfFUT7CmXYp8BC6lfucqNpjKvjgGTaTVz3/ZjPs0zPZ0jw7wpqXkCNOxMvTMfRLDeBfCAqS/l6sg1BoTiskZq2xNE1zBsXWlNqvlXWTGivd3IaSaYdEZfC2397DN0sm1quRCr/3ARY1ASXR5Ho8WfNhTBcD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WcvOHBrD; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WcvOHBrD"
Received: (qmail 56609 invoked by uid 106); 19 Mar 2026 16:57:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=9AklyW7B9KOK9KO84eJ10gb5YYlAdfGNJsP1/n1DQRo=; b=WcvOHBrDP+i9A/8vVBEC1urBUv9rsHLu+QsoKw0wk+SfsAIwhs0Ne59clJVS+tKd9VR100aqHlKa8K2a+QQa0lZ8rL+Hid3fvaClw7JEoiEbIi1mj69sYehKQT2PIaOT0RD7iAhb/Sk2rODOw5Ppjm83DsReGb7VYhsL5fHUCogZ/4YPelM5fzvXsR5euYfh8I1+YfPWpGft59a31ANmcwW7FNWB3oEy1WXZkiTdqWPyrF+86jYkOsVUHcTl5geQpTNXGY4qja8mmKEPKIDlbHg58iBJJPUuJMxDQ4UpPoLreNZwwpedqZycLtP8j+ZAn2Lce1LKlLDobo2Yy9vjyw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Mar 2026 16:57:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 85057 invoked by uid 111); 19 Mar 2026 16:57:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2026 12:57:47 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 19 Mar 2026 12:57:47 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] commit-reach: simplify cleanup of remaining bitmaps in
 ahead_behind()
Message-ID: <20260319165747.GA3615867@coredump.intra.peff.net>
References: <06000e28-c1b1-472f-bd6b-367b6c8d208d@web.de>
 <c01eb1e3-d839-4cf6-ba47-5a9edd336ae3@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c01eb1e3-d839-4cf6-ba47-5a9edd336ae3@web.de>

On Wed, Mar 18, 2026 at 05:09:37PM +0100, René Scharfe wrote:

> > -	while (prio_queue_peek(&queue)) {
> > -		struct commit *c = prio_queue_get(&queue);
> > -		free_bit_array(c);
> > -	}
> > -	clear_bit_arrays(&bit_arrays);
> > +	deep_clear_bit_arrays(&bit_arrays, free_bitmap_pointer);
> 
> The prio_queue contains just a few unvisited entries at this point (or
> perhaps even none), while deep_clear_*() will visit all commits that
> ever had a bitmap, even if their bitmap pointer is NULL now.

It is potentially even worse than that. A commit-slab must over-allocate
because it provides a pseudo-array over _all_ commits in the program. So
if the commit with index 123 gets a bitmap, then we will allocate a
pointer for the whole chunk, even if 124, 125, etc, never got one.

Looking at ahead_behind(), though, I think it's probably pretty dense.
We'll be creating new commits from parent pointers and then immediately
queuing them. So the index values we allocate should have high locality.

But it might be something interesting to double-check.

> We could still access them in array order, which must be cheaper:
> 
> 	for (size_t i = 0; i < queue.nr; i++)
> 		free_bit_array(queue.array[i].data);
> 
> Performance is the same for my local Git repo clone, though.

Yeah, I agree that is a reasonable simplification.

-Peff
