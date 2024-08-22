Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1064C13A244
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330473; cv=none; b=hYOYNvWZxZHkJcxdQFjVzwtHSVvznsXHag2vNHjXehGDvR9U5ETXUm3m4o1etvk5sVaDmQbQ8KUd27sJMc1Liq3G5e9VVZdDELOysV7iX9DQ9ESrQd3ohLf77SyocYIGDfPq/5J7JmlWTwyHPfRPJSpH/yHrRtJiuEGXLY6whxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330473; c=relaxed/simple;
	bh=QAPLlSLEsBMdD4g1+/ykGFxGajVrWaXqtBds/ldD/ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gmt4ScOkLOsMqn3a57/1ppEc2VqhBsk1GD4kaOZpkSDz56WFd1gR17EHlaOKj85YBZ/Myudr80Bk4zFnPsdswkJ8jNi5t+w53LA8Lo1ybI4q7mchW9HI3SX8Xe8zdl0Pacz7qaDldo7fGjB7GctBBMq6aUQnmWqDfrsL2mr9c0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3231 invoked by uid 109); 22 Aug 2024 12:41:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Aug 2024 12:41:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28328 invoked by uid 111); 22 Aug 2024 12:41:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Aug 2024 08:41:01 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 22 Aug 2024 08:41:00 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/10] reftable: fix reload with active iterators
Message-ID: <20240822124100.GA1070988@coredump.intra.peff.net>
References: <cover.1724080006.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1724080006.git.ps@pks.im>

On Mon, Aug 19, 2024 at 05:39:38PM +0200, Patrick Steinhardt wrote:

> This patch series fixes that issue by starting to refcount the readers.
> Each iterator will bump the refcount, thus avoiding the problem. While
> at it, I also found a second issue where we segfault when reloading a
> table fails while reusing one of the table readers. In this scenario, we
> would end up releasing the reader of the stack itself, even though it
> would still be used by it.

I gave a fairly cursory look over this, as I'm not all that familiar
with the reftable code. But everything looked pretty sensible to me.

I wondered how we might test this. It looks like you checked the
--stress output (which I confirmed seems fixed for me), along with a
synthetic test directly calling various reftable functions. Both seem
good to me.

I had hoped to be able to have a non-racy external test, where running
actual Git commands showed the segfault in a deterministic way. But I
couldn't come up with one. One trick we've used for "pausing" a reading
process is to run "cat-file --batch" from a fifo. You can ask it to do
some ref lookups, then while it waits for more input, update the
reftable, and then ask it to do more.

But I don't think that's sufficient here, as the race happens while we
are actually iterating. You'd really need some for_each_ref() callback
that blocks in some externally controllable way. Possibly you could do
something clever with partial-clone lazy fetches (where you stall the
fetch and then do ref updates in the middle), but that is getting pretty
convoluted.

So I think the tests you included seem like a good place to stop.

I did have a little trouble applying this for testing. I wanted to do it
on 'next', which has the maintenance changes to cause the race. But
merging it there ended up with a lot of conflicts with other reftable
topics (especially the tests). I was able to resolve them all, but you
might be able to make Junio's life easier by coordinating the topics a
bit.

-Peff
