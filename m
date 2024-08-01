Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CB71898E4
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510854; cv=none; b=ifP8oKcLSR5WCdvw8H2Aaohc9RCWskuG8TCQkzZwuT+OtcllHY2BDA/Xm8YhQk/ugEru9nPL08KV9SFISqBMhP535qXW0zPJMDtDQ+4B8SOF6m7z8VSFeVB7u9FQbOjH/a1zs3QCPMU9/XqsBBkP4EIEeFkJ74+Frj6HyBfnkTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510854; c=relaxed/simple;
	bh=ohVfl24BayVs7PRkS5bQFlbw+aTe0sICuXYtN6vni+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEARP/3iWZ/J1BMGY/8UkWELDX1wux4iVZJpEif715yd1i8y4/GHs5hbVlVkAi5Dx1J31kYipc9otJEKvAQhUo5A+1DCG7FgVBmj9HiIv86pUmITs3hUi1lguDFpKL/lryWqPnsVf2LQWaPq6pHQhFuHM8FknBh4SBmkCWDhivE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19825 invoked by uid 109); 1 Aug 2024 11:14:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 11:14:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31316 invoked by uid 111); 1 Aug 2024 11:14:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 07:14:11 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 07:14:10 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/19] midx: incremental multi-pack indexes, part one
Message-ID: <20240801111410.GS1159276@coredump.intra.peff.net>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1721250704.git.me@ttaylorr.com>

On Wed, Jul 17, 2024 at 05:11:54PM -0400, Taylor Blau wrote:

> This series implements incremental MIDXs, which allow for storing
> a MIDX across multiple layers, each with their own distinct set of
> packs.
> 
> This round is mostly unchanged from the previous since there has not yet
> been substantial review. But it does rebase to current 'master' (which
> is 04f5a52757 (Post 2.46-rc0 batch #2, 2024-07-16), at the time of
> writing).
> 
> Importantly, this rebase moves this topic to be based on an ancestor of
> 0c5a62f14b (midx-write.c: do not read existing MIDX with
> `packs_to_include`, 2024-06-11), which resulted in a non-trivial
> conflict prior to this rebase.
> 
> The rest of the topic is unchanged. I don't expect that we'll see much
> review here for the next couple of weeks while we are in the -rc phase,
> but I figured it would be useful to have it on the list for folks that
> are interested in taking a look.
> 
> Thanks in advance for any review! :-)

I gave it a pretty thorough look. Everything looks good for the most
part. I left a few comments, but mostly just thinking my way through
things.

The trickiest parts were:

  - the confusion between when we want local per-layer positions versus
    global positions within the whole chainfile, or whether functions
    are operating on a single layer versus the whole chain. I mused a
    bit on how we could do it differently, but ultimately I'm not sure
    there any good solutions.

  - the changes you did make look good, but it's hard to know if there's
    code lurking that still needs to be adjusted for chained midx's. For
    that I think I'd turn more towards testing than code review. I'm not
    sure how much interesting coverage we're getting from the GIT_TEST
    variable, just because the repositories made in most of the tests
    are so trivial.

    I'd love to see the results on a real workload (both a big repo, but
    also how things behave over days or weeks of repository maintenance
    done with incremental midxs). I know that can be hard to do, though.

-Peff
