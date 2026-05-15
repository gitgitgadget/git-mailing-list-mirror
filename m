Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03713F9287
	for <git@vger.kernel.org>; Fri, 15 May 2026 21:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879703; cv=none; b=d9NTNh/5sKmA8byDc2WZ47Dbql0Ec1YE9lkLYdwTbcEDDTiEuGPrhG4KRCjVLIOXUWuGB433NJselBDpNYVe5iI97NRX/S8uOiA/YVtBl8J+7Q+rcBSlnngg1gOI2+mlyD9rfnwi7w+J0qPJECaSKdBbMT+13hnv0K7AavQH7IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879703; c=relaxed/simple;
	bh=2Bec67qeWbYGmit+osf6CWmdDPnedN9x1pIKcStYeT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG9X0K/+G0y187QP4RUmqVf+AcZUtusA58zWjPUN5NWIcYcp5Qt+EwDh+6ETOfeZwEbfZfOZR3Eje256iDdifKf0dep7P3rvq9qQE/A9bV/BExyRjl7Dg5ok37dYtbDMMYTK0jhRWxIx3AR3xW42fejiF55+CN2lsPXFOa1vGW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=H8FYiF1d; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="H8FYiF1d"
Received: (qmail 1424 invoked by uid 106); 15 May 2026 21:15:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=2Bec67qeWbYGmit+osf6CWmdDPnedN9x1pIKcStYeT4=; b=H8FYiF1dC4NIyjbDz3OhMfIqw9JM4e2jriaQDC5HNAjU6xl7Rko/50rRPSeTh5rAI+JlAXINphacpfVE5cYuoFUW7YzbOdz/RMlU6ODlOdXmIwcscxHIx1hfGNhtLFjVwop/E0e3DiVokBxFIoA7KpOa1OHc+heGAsVRqYBgl/C/bHwWtAJKskJIh++dzTMU+/w3en3rNdw8A6zeBCKsZAZqpRZadbL9y0LPtrT3A2/Gl3SiFKWkehgmiXyTwjttoMY1lhZkueNaLHLM1quUgwGp8Jglfzeq4peV8viG1uZQPPZlSpiC+jmGJuCsEWeiAiPK6DJlH9FyC11RxTAJmg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 May 2026 21:15:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3012 invoked by uid 111); 15 May 2026 21:14:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2026 17:14:59 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 15 May 2026 17:14:59 -0400
From: Jeff King <peff@peff.net>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH] commit-reach: use the decoration hash for
 tips_reachable_from_bases()
Message-ID: <20260515211459.GA158762@coredump.intra.peff.net>
References: <pull.2116.git.1778868463992.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2116.git.1778868463992.gitgitgadget@gmail.com>

On Fri, May 15, 2026 at 06:07:43PM +0000, Kristofer Karlsson via GitGitGadget wrote:

> From: Kristofer Karlsson <krka@spotify.com>
> 
> tips_reachable_from_bases() walks the commit graph from a set of base
> commits to find which tip commits are reachable.  The inner loop does
> a linear scan over the tips array to check whether each visited commit
> is a tip, making the overall cost O(C * T) where C is commits walked
> and T is the number of tips.
> 
> Replace the linear scan with the decoration hash for lookups, reducing
> the per-commit tip check from O(T) to O(1) and the overall cost from
> O(C * T) to O(C + T).
> 
> This function is called by `git for-each-ref --merged` and
> `git branch/tag --contains/--no-contains` via reach_filter() in
> ref-filter.c.
> 
> Benchmark on a merge-heavy monorepo (2.3M commits, 10,000 refs):
> 
>   Command                           Before    After   Speedup
>   for-each-ref --merged HEAD        6.64s     1.66s     4.0x
>   for-each-ref --no-merged HEAD     6.75s     1.74s     3.9x
>   branch --merged HEAD              0.68s     0.61s      10%
>   branch --no-merged HEAD           0.65s     0.61s       8%
>   tag --merged HEAD                 0.12s     0.12s       -
> 
> The large speedup for for-each-ref is because it checks all 10,000
> refs as tips, making the O(T) inner loop expensive.  The branch
> subcommand only checks local branches (fewer tips), so the improvement
> is smaller.

Hmm, I couldn't reproduce the speedup on something like linux.git (~1.4M
commits) with a lot of synthetic branches. I'd think that old branches
would be the most expensive, so I did:

  old=$(git rev-list --reverse HEAD | head -n1)
  seq --format="update refs/heads/branch%g $old" 10000 |
  git update-ref --stdin

Running "git for-each-ref --no-merged HEAD" takes ~650ms with stock Git.
But with your patch, it goes to ~830ms!

So what am I missing about your repo that it is so slow in the first
place?

>      * Hacking the array index into the decoration value as (void *)(i + 1)
>        instead of storing a proper pointer

The decoration API is not the most generic option here. There's an
oidmap type, but you have to embed the hashmap bits into your struct,
which is a lot of boilerplate if you're just storing an int. You can
define a khash with a custom value type, and I think the existing
oid_pos uses an int, which might be enough. All of those will store an
extra copy of the oid, though for the sizes we're talking about that's
not the end of the world.

Since we're always mapping commits, you could define a commit-slab (each
commit struct gets a unique id which we then index into a big array).
See commit-slab.h for an example.

I'm not very familiar with this code, but I wonder if we actually need
to map at all. It looks like we are mostly interested in set inclusion,
so perhaps an oidset() would work. Or even a bit in the object-flags.

-Peff
