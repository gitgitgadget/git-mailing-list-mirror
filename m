Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA233ABDA2
	for <git@vger.kernel.org>; Mon, 25 May 2026 07:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779692480; cv=none; b=UCC87QOk13k47DlgA0Fb5o/G9FeNQ7ctXbLsOeQrgmWRvWjmI07yP/KhM+pryjFl2ild3E5LudNsdS4jeZ/jhLgMiC9IyKwpst7KJhz9y2+ka5efGoiy5RB6qSL0UM2ErIebfqz+rtEfHss2Go8fOPTeqk1d8c0boieAAthm4SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779692480; c=relaxed/simple;
	bh=W8J+w9xOX9vvn03EwFhbsrjlUuGi4Bxu/cKO1aK1USQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBlwMOQU1gyt9aFka2/A3lhDGb5d6fW7LWZV+DSdJ29QW96QFAzo/XZn29xjfW7HHP9HJLM3OBfo6hMrz1ybvEmHlYBnV+tL51lHJkBQv4LRh3MV+xgkBpyoTjybP/egUTih17dC65yyCXYH2TH3t7aMM+hzGU7f8qhl7Y+hMwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NjtWkwfO; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NjtWkwfO"
Received: (qmail 10030 invoked by uid 106); 25 May 2026 07:01:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=W8J+w9xOX9vvn03EwFhbsrjlUuGi4Bxu/cKO1aK1USQ=; b=NjtWkwfOZvXVS4bEyLz8fU2X2Sva028ik9Lvof7rBYvymWxgGVG2o8V8pXRJT0osEkD9lwGP672HWdL2ZPfTFW0vGRb9SIpY9a98E5lri1mbEm6nYjiukvySCqUIXy9RLLD0W7OhzJ6r68T0JGR4O7VXsGpYfwOl504mtz472tRryy5LL7WQ0BCmXmhz7LSzphRJzNkZSRAoITuzcIIp/4MIQx2ehkoEI37NNLd4zoWBnuDSWhCoEdcRmPhGATYUYIR/pSemRqsibtESYYRj0p5pZWUjbMOIowfnMcZsBKAmLFM/lWevvPqaHpgZewjHyGJw1mtG2PVgRoDBbL+aaA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 May 2026 07:01:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13621 invoked by uid 111); 25 May 2026 07:01:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 May 2026 03:01:18 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 25 May 2026 03:01:14 -0400
From: Jeff King <peff@peff.net>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH 1/3] commit-reach: deduplicate queue entries in
 paint_down_to_common
Message-ID: <20260525070114.GB2737798@coredump.intra.peff.net>
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
 <1d3751569ba3a5f0c353fb468578d6c5bcd0b738.1779644541.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d3751569ba3a5f0c353fb468578d6c5bcd0b738.1779644541.git.gitgitgadget@gmail.com>

On Sun, May 24, 2026 at 05:42:18PM +0000, Kristofer Karlsson via GitGitGadget wrote:

> +static void maybe_enqueue(struct prio_queue *queue, struct commit *c)
> +{
> +	if (c->object.flags & ENQUEUED)
> +		return;
> +	c->object.flags |= ENQUEUED;
> +	prio_queue_put(queue, c);
> +}

OK, so we mark each commit with ENQUEUED when we queue it, and then...

> @@ -83,6 +92,8 @@ static int paint_down_to_common(struct repository *r,
>  		int flags;
>  		timestamp_t generation = commit_graph_generation(commit);
>  
> +		commit->object.flags &= ~ENQUEUED;
> +

...clear that when we pop it. But the loop may terminate early before
popping everything, and we get to this cleanup code at the end:

	clear_prio_queue(&queue);

When we drop all of those queue elements, they'll all be left with the
ENQUEUED flag set. Should we clear those?

The ahead_behind() variant doesn't have the same problem, because it
uses PARENT2 to check for queueing, and then does:

	/* STALE is used here, PARENT2 is used by insert_no_dup(). */
	repo_clear_commit_marks(r, PARENT2 | STALE);

So it's cleaning up both flags, whereas paint_down_to_common() is
already leaving the STALE flag set. I'm not sure how much that matters
(or if it is even an intentional thing communicated to the caller). But
now we'd be adding ENQUEUED.

-Peff
