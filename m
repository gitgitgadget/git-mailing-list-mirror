Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18220101F2
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 02:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729133311; cv=none; b=H5axs1Lj9kBYnoSCK5Cwoiknh6pWd0LMp909BbocKAKGMwLZU0fCLVmqbq0p3f0LBmqvNYKEzM5W4rybxDj8nn7bHfx0IAL5H60aQGIvTUWSOedcFicqHefThxIsetgRodyxawjyeomS0v8q0FodpbUHT1Jj/q/K56fhnltFSZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729133311; c=relaxed/simple;
	bh=TAjKMPvwgguj+3kPML+oF3fFTZy7qZl2iJZvRtxlDUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnzpg7rgDezSUQ/ObgsJbcQINjtp/P8Kr6VaP4w45MuwwHk7wsmP51LyITxgQyZP0NVCERTUzhCR65QP2JWMkawToF9Qe7xLZ+OG4VtXIJVVe74nZtOQt1ULE0doAJTQxwJoZyD1Bmwbsk6h/hEIeEuW/qdGEOs8CFNhgw+cncc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NVkaDvUz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NVkaDvUz"
Received: (qmail 22971 invoked by uid 109); 17 Oct 2024 02:48:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=TAjKMPvwgguj+3kPML+oF3fFTZy7qZl2iJZvRtxlDUU=; b=NVkaDvUzxXk6MM7K7HZ6SSlyG48VgqNK1LmjssHyzfioC+NaxoI+blExwQ5daIlf9w9SYYNma7R57oqsXmcosTmoRX8ShxGc1oxihCB6tv0DSyCvGgTmdDT9lWBrv0VgNdjEDa8r1T4v/A/2oEnZsDwU3P9VRKsSxmw8D73fXkhM54hFnPPOyGmtMXShse5UESHiHXl1iv4zIKFhek4GejqS4WjlxXfs1HQQeEcQSGPCusKxgBazV55EysAvQ+4VCFo5HURRS2poBkdelTl9f7RIQpBAsKD58AK0142B/TmwHSgEHduSnPFEM5i3UZ+KRApDNGA6q4OyI6U+3YxxNg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Oct 2024 02:48:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27476 invoked by uid 111); 17 Oct 2024 02:48:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Oct 2024 22:48:28 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 16 Oct 2024 22:48:28 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] ref-filter: format iteratively with lexicographic
 refname sorting
Message-ID: <20241017024828.GC1858436@coredump.intra.peff.net>
References: <a873ed828ccae426214cc8f87610df97ff9a269e.1729055871.git.ps@pks.im>
 <ZxA6I67FfPe4fV2F@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxA6I67FfPe4fV2F@nand.local>

On Wed, Oct 16, 2024 at 06:11:47PM -0400, Taylor Blau wrote:

> On Wed, Oct 16, 2024 at 08:00:30AM +0200, Patrick Steinhardt wrote:
> > But there is one exception here where we _can_ get away with sorting
> > refs while streaming: ref backends sort references returned by their
> > iterators in lexicographic order. So if the following conditions are all
> > true we can do iterative streaming:
> >
> >   - The caller uses at most a single name pattern. Otherwise we'd have
> >     to sort results from multiple invocations of the iterator.
> >
> >   - There must be at most a single sorting specification, as otherwise
> >     we're not using plain lexicographic ordering.
> >
> >   - The sorting specification must use the "refname".
> >
> >   - The sorting specification must not be using any flags, like
> >     case-insensitive sorting.
> 
> Perhaps a niche case, but what about ancient packed-refs files that were
> written before the 'sorted' capability was introduced?

We should be OK there. In that case we actually read in and sort the
packed-refs entries ourselves. We have to, since we do an in-order merge
with the loose refs while iterating.

I do think this optimization is worth doing, and not a problem with our
current backends. The biggest worries would be:

  1. Some new ref backend that doesn't return sorted results. I find
     this unlikely, and anyway it's easily caught by having coverage in
     the test suite (which I assume we already have, but I didn't look).

  2. Some new flag combination that requires disabling the optimization,
     and which must be dealt with in the code. This seems unlikely to me
     but not impossible. I think enabling the optimization is worth it,
     though.

> >   - The caller uses at most a single name pattern. Otherwise we'd have
> >     to sort results from multiple invocations of the iterator.

I think this part is erring on the cautious side, as we can often
collapse these into a single iteration due to the ref-prefix work. It
may be OK to keep using the slower code here if multiple patterns aren't
commonly used, but I'd suspect that:

  git for-each-ref --sort=refname refs/heads refs/tags

could benefit.

-Peff
