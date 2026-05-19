Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0354C3D904F
	for <git@vger.kernel.org>; Tue, 19 May 2026 21:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227790; cv=none; b=L5zbPjpNP+jcmVhdXG8oFObkQdhZ3T98uHSAGuKzvp3u5rFdsVzSKmr4VlfUlG50urdhRPWzLbMjd2SIuAOs7oWSbj4XELBQFIgsYx5DXfy50m4PJWSif3gSMd7YOqIlSt/gm1aRKd8BIHGyikOC2JJWDwjuZO1R+dcpgggz0K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227790; c=relaxed/simple;
	bh=VvZBvHWPWrdVVkxGDNh/ZORr+SdFZF11snnRXwdQ6pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUoVhegNszNgIry82LgJJyKL6YCuimUoAjhKXc1SjhoW9kZhH3oRNgh43GQoyO5BKTmDtvvMLIfXRBPNLmfLyMXPDwF7Fyw6rc9bQyXCNpLvUI5YUCiyx9FOt8zoQhKkzDMTMq3Gsk3VIwL3Rd18KxlpYmfHVeOs/N6UR7Fyygk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WJ1S1Onq; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WJ1S1Onq"
Received: (qmail 24163 invoked by uid 106); 19 May 2026 21:56:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VvZBvHWPWrdVVkxGDNh/ZORr+SdFZF11snnRXwdQ6pc=; b=WJ1S1OnqamxEulY0vduOroJfp8OMPQkKbG+1Oatb+UMaluE5MXm9wR09t8wl+69kTy7PiLZZ3kaX5fLHDj3ui48F7BUmC/AuC9OEW0eBjNQI5BFwAz/Kh9B06lw3Qip8c3poQW4mH/N4hgkxaZamBOppKOCTbhcwydlrArO1871bD1GAt7o8A7t3TLQtOZ6eO6EWHVe8Qt8mJHXPqsUqcWKeSL61uzWuJXr0vDs7rXzKELW2IVFBh90v36rZ9dD1+jXs5HF9q46aBmVnRUPQgSBObk35qux8Tcfy79T69cCW0uWoBRVqJzE5YRkoTyMgL+3TnUfValskddl85aAGLA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 May 2026 21:56:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 57480 invoked by uid 111); 19 May 2026 21:56:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 May 2026 17:56:29 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 May 2026 17:56:27 -0400
From: Jeff King <peff@peff.net>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] revision: use priority queue in limit_list()
Message-ID: <20260519215627.GB2278669@coredump.intra.peff.net>
References: <pull.2114.git.1778777491939.gitgitgadget@gmail.com>
 <20260515041641.GA81292@coredump.intra.peff.net>
 <CAL71e4Mfq3SCO7vnTbFCxpzH9txWPTencV-vq-aQ=wJ7dPMV2g@mail.gmail.com>
 <aad34ac2-4cd5-4c85-b8ff-14c0caaa1c7b@gmail.com>
 <CAL71e4MxhcZqxPVEe38Shuqt7h5dxLDGi66hN2cFXnmg-POKWA@mail.gmail.com>
 <20260519005429.GD1612961@coredump.intra.peff.net>
 <CAL71e4O6UcnqmxDgqyGqvgvfruSzeoz6Wj5muXiwEp_8y2wAcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL71e4O6UcnqmxDgqyGqvgvfruSzeoz6Wj5muXiwEp_8y2wAcg@mail.gmail.com>

On Tue, May 19, 2026 at 11:33:19AM +0200, Kristofer Karlsson wrote:

> I took a look at your branch. Our approaches differ mainly in
> how broadly the prio_queue replaces the linked list. Here's a summary
> of the tradeoffs as I see them:
> 
> Your approach: replace commits entirely with struct prio_queue.
> Every access site is converted, and boundary cases (bisect,
> topo-sort, simplify_merges) convert queue->list->queue when they need
> list-based APIs.
> 
> My approach: keep the linked list for setup and add a separate
> commit_queue for the walk phase. External callers that read the
> list between prepare_revision_walk() and the walk are unchanged.
> The conversion happens once when the walk begins.

Yeah, I think that is an accurate summary. What I worry about with your
approach is any code that looks at or modifies the commit list during
the traversal. It has to know whether to use the queue or the list.

> On the walk side, my second and third commits refactor
> get_revision_1() to use a vtable ("walk_ops") that selects the right
> pop/expand strategy once and caches it:
> 
>     struct revision_walk_ops {
>         void (*init)(struct rev_info *);
>         struct commit *(*next)(struct rev_info *);
>         int (*expand)(struct rev_info *, struct commit *);
>     };
> 
>     static struct revision_walk_ops streaming_ops =
>         { rev_info_commit_list_to_queue, next_streaming, expand_streaming };
>     static struct revision_walk_ops limited_ops =
>         { NULL, next_commit_list, NULL };
>     /* ...reflog_ops, topo_ops, no_walk_ops... */

I looked at the patch you linked for this. I'm undecided on whether this
makes things simpler (because the if/else-cascade is in one spot) or
more confusing (because now the details are all hidden behind a layer of
abstraction). 

> I benchmarked both approaches against a 2.4M-commit squash-merge-
> heavy monorepo (best of 3 runs each, commit-graph present):
> 
>   Benchmark                             mainline    kk      jk
>   rev-list HEAD (streaming, full DAG)    21.8s     6.9s    6.9s
>   --ancestry-path ~100K (limited)        21.8s     4.8s    5.0s
>   rev-list --count HEAD~10000..HEAD      17.7s     3.7s    3.8s
>   log --oneline -1000                     0.1s     0.1s    0.1s
> 
> Both give ~3-5x speedups over mainline. The streaming walk is
> identical. On limited walks kk is ~4% faster, which I think comes
> from avoiding the queue rebuild at the end of limit_list() -- jk's
> commit_list_to_queue() drains the result list back into the queue,
> while kk leaves the result as a linked list (which the limited walk
> then just pops from directly).

It would be easy-ish to further convert limit_list() to store newlist as
a queue, and then transfer ownership of its fields into revs->commits
(i.e., a struct assignment).

One possible complication is that we do pass "newlist" into a few
sub-functions, like cherry_pick_list(). Looking at that function, it
iterates over the list, but it's not clear to me if the order matters.
Certainly not in the first loop, but later we do some flag assignments.
I _think_ they're all independent, but I'm not sure.

Obviously we can iterate over the prio_queue in date order with a series
of get() calls, but that is roughly equivalent to building a list (and
we have to rebuild the queue after, too). Of course that is already
happening in limit_to_ancestry(), which builds the reverse-order list.

So I dunno. Moving to the dual-structure state feels messy and
error-prone to me, but it does perhaps let us move a little more
incrementally.

-Peff
