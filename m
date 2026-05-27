Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F202379EDA
	for <git@vger.kernel.org>; Wed, 27 May 2026 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877538; cv=none; b=sKe0fxXNHJJ87+aeZ6MDkd321BsGtMn6lgwOP8UGv+Y/1WeHa2fRgXd98ZL/51PVOXiRbXpLOX6OvWEs8So2Xae6v5hOtwflcMSE2eSftDVceFflZiHTx6affbzGphcPeiBfocS+tP3ShHzsyLcqLWrQNxtQVmxvAb5kMq5oYbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877538; c=relaxed/simple;
	bh=fIilEl0pSHRsWXwH0oZlBLY6CYsELLbVNINsiSu9Q1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUJoKLHfQ8jzwYSSV3KnN69diPKttHY+bLAwSnuPh/R/hLSZw/eQdMeA5QqtTDHkKZ/ZI1SuxDR+2tTPCpTZXoLgN7u7C0gGA6TUlaXkLReFkfLmmOiHTiZrTltnw8LppDtTwuG43X9mmBu1KGG+WKudiRhaSSdCgjYZaL4GMns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gBCPsnzs; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gBCPsnzs"
Received: (qmail 29258 invoked by uid 106); 27 May 2026 10:25:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fIilEl0pSHRsWXwH0oZlBLY6CYsELLbVNINsiSu9Q1s=; b=gBCPsnzsOqusr1U0OFWuYwoP13pVWiEQQ0zQx2CoJnn9FeK6IZGlfx4VtZZYPTiZeS61wTLcN/2K8Um3919CGB7eGxjMUbp92L+gyfmoO3vnAYIwL0sCDOuTIqQ/pOxqPnYV+juYkt+f/9LUhgJ1Qtra8MClcab2h3YK75pHwFphjognlB+Dzi8VS/xal2V1KMswW9DY+cbJQKT5XkTBiN1eooWK79MlEi+d79wTH6+fiWiRlE5hcIV2doIyYWftrVdDQF9hg5IAfMgB996RADJ7qf6cbBa52sKMn1jD8EDf+f6c5LfA/iExQzLXHX4w8x5E3dQzhaoZKnBEDwINDw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2026 10:25:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 73187 invoked by uid 111); 27 May 2026 10:25:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2026 06:25:40 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 May 2026 06:25:34 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 8/8] pack-bitmap: build pseudo-merge bitmaps after
 regular bitmaps
Message-ID: <20260527102534.GH981444@coredump.intra.peff.net>
References: <cover.1779207127.git.me@ttaylorr.com>
 <30ce254312cfee2a2a82f08246c3a2546ae32578.1779207127.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30ce254312cfee2a2a82f08246c3a2546ae32578.1779207127.git.me@ttaylorr.com>

On Tue, May 19, 2026 at 12:12:55PM -0400, Taylor Blau wrote:

> Each selected commit starts with one commit_mask bit in its "commit
> mask" bitmap. Then, we walk the first-parent history in topological
> order and OR each commit's mask into its (first) parent. Whenever that
> OR results in the parent having more bits set, the child is deemed to be
> non-maximal, and the frontier is pushed further back along the first
> parent history.
> 
> That approach works extremely well for ordinary selected commits, whose
> first-parent histories often describe real sharing between the bitmaps
> we are going to write.
> 
> It struggles, however, to efficiently generate pseudo-merge bitmaps.
> Unlike ordinary commits for which the above algorithm is designed,
> pseudo-merges don't represent any "real" commit in history, just a
> grouping of non-bitmapped reference tips. In that sense, their first
> parent is just a part of a larger set, and treating them like ordinary
> selected commits imposes a significant slow-down when generating bitmaps
> with pseudo-merges enabled.

This is a great explanation of the problem, and especially this:

> In other words, we pay a nearly ~5 minute penalty to generate
> pseudo-merge bitmaps, but only save ~50 seconds during traversal.

makes it clear that we're doing something sub-optimal. And it points us
in the right direction, since that traversal should be able to generate
the pseudo-merge bitmap we need in the first place! So that should be
our goal to work towards.

> Instead, build the regular selected commit bitmaps first, considering
> only non-pseudo-merge commits in `bitmap_builder_init()`. Once those
> bitmaps have been stored, build each pseudo-merge bitmap separately and
> attach its parent and object bitmaps to the corresponding pseudo-merge
> entry before writing the extension.

And then this solution follows naturally from the earlier explanations.
Good.

In some ways this goes back to the pre-v2.31 way of generating bitmaps,
which is to just traverse for each bitmap independently. But as you
note, the whole idea of pseudo-merge bitmaps is that they aren't
overlapping in any meaningful way. So doing one fill-in traversal per
pseudo-merge makes sense, and hopefully we hit enough real bitmaps that
it's not too costly.

> As a result, the overhead cost for generating pseudo-merges in the above
> configuration is much smaller:
> 
>     +------------------+-----------------+---------------+-------------------+
>     |                  | no pseudo-merge | pseudo-merges | Delta             |
>     |                  |                 | (HEAD)        |                   |
>     +------------------+-----------------+---------------+-------------------+
>     | elapsed          |   294.1 s       |   328.4 s     |  +34.3 s (+11.7%) |
>     | cycles           | 1,365.5 B       | 1,529.3 B     | +163.7 B (+12.0%) |
>     | instructions     | 1,389.8 B       | 1,552.8 B     | +163.0 B (+11.7%) |
>     | CPI              |     0.983       |     0.985     |  +0.002   (+0.2%) |
>     +------------------+-----------------+---------------+-------------------+

Nice. The time savings are going to depend on how many pseudo-merges we
generate, I think. And I'd guess that the numbers above come from making
one big pseudo-merge bitmap, per the config you showed earlier. But you
probably only want a handful of them in any repo, so hopefully it
doesn't scale _too_ badly.

> Recall that at the start of this series, generating reachability bitmaps
> took 612.5 seconds *without* pseudo-merges. With this commit, it is
> still ~46.38% *faster* to generate reachability bitmaps *with*
> pseudo-merges than it was to generate bitmaps wihtout them at the
> beginning of this series.

Sure, though 612.5 seconds is all in the distant past. We only care
about 294.1 seconds now. ;)

More seriously, I do think the interesting question here is how the time
scales for various pseudo-merge configurations. I don't know if we have
any real operational experience with them yet. The original idea is that
you might slice up the ref space into a few chunks. I'd guess that the
old code performed badly-ish overall, but the time did not grow all that
much as you increased the number of chunks. But with the new code, I
suspect that the cost grows more linearly with number of chunks. That's
just a guess, though.

The other thing we hope for with pseudo-merges is that the chunks are
selected such that most of the chunks don't change (because they are
composed of old, stable refs). So in subsequent bitmap generations, we
can either reuse them either verbatim or as a starting point (if there
were only additions). But all of that is going to be heuristic and
depend on your config, the changes the repo sees over time, and so on.

So I don't know if we'd really have good numbers on that.

> Now that we have decoupled how we generate pseudo-merges from their
> representation, the following commits will improve the API around
> specifying pseudo-merge groupings during bitmap generation.

I think we're at patch 8/8 here. I guess you have more to come
eventually, but for now this part is just misleading. ;)

>  pack-bitmap-write.c | 210 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 174 insertions(+), 36 deletions(-)

The patch looks reasonable, though I'm not all that familiar with the
ins and outs of the pseudo-merge code. I'd trust the tests here more
than my review.

> @@ -696,12 +700,32 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
>  		 * walk ensures we cover all parents.
>  		 */
>  		if (!(c->object.flags & BITMAP_PSEUDO_MERGE)) {
> +			struct tree *tree;
> +
> +			if (from_pseudo_merge && !c->object.parsed) {
> +				/*
> +				 * Commits reachable from selected
> +				 * non-pseudo-merges are already parsed
> +				 * by the regular bitmap build.
> +				 *
> +				 * However, pseudo-merge fills can also
> +				 * reach commits that were not covered
> +				 * there, so parse any such leftovers
> +				 * before reading their tree or parents.
> +				 */
> +				if (repo_parse_commit(writer->repo, c))
> +					return -1;
> +			}

Makes sense. This should be a quick noop for the regular bitmap build,
since we'll have the parsed flag set. And it should even allow use of
the commit-graph if it's available.

-Peff
