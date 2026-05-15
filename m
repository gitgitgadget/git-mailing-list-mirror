Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE3132AABA
	for <git@vger.kernel.org>; Fri, 15 May 2026 04:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778818604; cv=none; b=nqmtQStuxT0crQuoXgsPlPWTp5SWci0Pjs6wuqA8eZY2dG+OCwaThbeWwseEUW8kv36ttl0Y4rcTYxyU2kg3NwN5BGTyuePb31v6AlviQsBIzKrwOKOWwXOQ8IwP3MTT1yNx9m91ZOjpdDaRDHGrNgSqsZWlWE+ATAXOA2nzMBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778818604; c=relaxed/simple;
	bh=rBPdYhzv9pkOViggDTsYRwVo9TSnP+37EbNc+WnT3os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1XidT8g/Tza7jCDGbIy0vrOC3Zmv97XOY8FvzXUiJwGJtZc/dkwhkX1OAuZ4bKo9P6I0u8kPVMT4qEfMTyXbMUWjBcndFDA4jYZKb+FqwSwyaRb5ma5/S8OEMu4R7mD9bykTWkglhzay+Ix8BY76/yP47thS60trLBw2BwdYtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=a+NJqqla; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="a+NJqqla"
Received: (qmail 52723 invoked by uid 106); 15 May 2026 04:16:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=rBPdYhzv9pkOViggDTsYRwVo9TSnP+37EbNc+WnT3os=; b=a+NJqqlak2dVLAJ7YmWoVZSzZ05PUO+mfmNdM3ggut2ufuXFJWZUc6t/G9p24fGYr+4gZZW1KGHTZOCr6mg/taaskBYSz8qCgAH8qtCR20vz/va3NTAeEbsIdYRc1Kk/7XD57LXEryS8cM+3/Z0c2nxMH/9KY+/yd9w2vvTbeRXnMPP5DNmDHFiKyfzeSjxBPLDu7NQ9wSnnTX2x78E3E1+CGDOWoOUOWy8D1fYEWZDgy66d71Eu+xF7h1olFFpx70yTaTwuEM4c+tJuT9Oc539Ddtp3lCfZkfmITxBtE+GB61BKMlCpR7Q9QV/ASzUp1nL2+fZGU+2nSric1uP5Fg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 May 2026 04:16:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 96501 invoked by uid 111); 15 May 2026 04:16:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2026 00:16:41 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 15 May 2026 00:16:41 -0400
From: Jeff King <peff@peff.net>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH] revision: use priority queue in limit_list()
Message-ID: <20260515041641.GA81292@coredump.intra.peff.net>
References: <pull.2114.git.1778777491939.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2114.git.1778777491939.gitgitgadget@gmail.com>

On Thu, May 14, 2026 at 04:51:31PM +0000, Kristofer Karlsson via GitGitGadget wrote:

> @@ -1451,6 +1447,7 @@ static int limit_list(struct rev_info *revs)
>  	struct commit_list *newlist = NULL;
>  	struct commit_list **p = &newlist;
>  	struct commit *interesting_cache = NULL;
> +	struct prio_queue queue = { .compare = compare_commits_by_commit_date };
>  
>  	if (revs->ancestry_path_implicit_bottoms) {
>  		collect_bottom_commits(original_list,
> @@ -1461,6 +1458,11 @@ static int limit_list(struct rev_info *revs)
>  
>  	while (original_list) {
>  		struct commit *commit = pop_commit(&original_list);
> +		prio_queue_put(&queue, commit);
> +	}
> +
> +	while (queue.nr) {
> +		struct commit *commit = prio_queue_get(&queue);

Here we push the whole starting list into the prio-queue, which will let
us pull the commits out in date order. But is the incoming list always
in date order?

If revs->unsorted_input, then we don't sort the initial list. So we'd
now see the commits in a different order, and put them onto newlist in
that different order.

I _think_ it may not matter because we don't call limit_list() when
revs->no_walk is set, and we only have revs->unsorted_input when no_walk
is also set. If that wasn't true, it would get weird when limit_list()
calls process_parents(), which uses commit_list_insert_by_date().


I was on the lookout for this issue particularly because I have another
patch which converts revs.commits to a prio_queue totally. And I
remember running into issues (and the solution is that sometimes the
prio_queue has a NULL comparator and acts like a LIFO queue). But if my
analysis is right above, we can ignore that for now. And if we
eventually move to revs.commits as a prio_queue, then it will just slot
in nicely here (we can drop the queue generation step and just use it
directly).

The rest of the patch looks as I'd expect from what my other patch does.

-Peff
