Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C579446AF
	for <git@vger.kernel.org>; Thu, 23 May 2024 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716462337; cv=none; b=s1zS2N65KcZLWu9uSHZj58Pb0UWe2s7uTiaG14Fa4kwljQ1Tjle7XqoxVXil9QpDP9sy1mFmHeAAXph5z9ggKeTEOCcnGpHSxaosYGXAOjTa00cDi4eXKBzgPE7swKhWu/iP3lS1CdPKtmlvlixniZ4h2qGT1bh0EKto93NNIq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716462337; c=relaxed/simple;
	bh=AALB6S0WKfGg7typcLOBlzFhEuoPUA5jufbgN0NRMiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m181/P2+dD8q0B4pqHIf3Qtvr4vGw1vy8o1a9+tE89uCLawktWKGt+WZlj4NrXu9NW019kvUTQeU//ZsAGhKUa9OCMEovmK5RLIyysAG2l6eEUiibs+f5+/5elDF8UDCzgloBldtn0YbqMJBxWHPki+KGxl1nNQu7FmR16/ak1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31405 invoked by uid 109); 23 May 2024 11:05:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 May 2024 11:05:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29568 invoked by uid 111); 23 May 2024 11:05:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 May 2024 07:05:33 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 May 2024 07:05:32 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/30] pack-bitmap: pseudo-merge reachability bitmaps
Message-ID: <20240523110532.GA1326297@coredump.intra.peff.net>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716318088.git.me@ttaylorr.com>

On Tue, May 21, 2024 at 03:01:38PM -0400, Taylor Blau wrote:

> Here is another reroll my topic to introduce pseudo-merge bitmaps.

OK, I got through the whole thing. I left a few small comments, but
mostly just observations. Overall, the shape of it looks pretty good.
The much bigger question to me is: does it work?

The perf results you showed at the end are underwhelming, but I think
that's mostly because it's not an interesting repository. I think it
would be nice to see at least some point-in-time benchmarks on a
single repository.

But much more interesting to me is how it performs in the real world in
aggregate, over time:

  - how often / how much do pseudo-merges speed up queries in the real
    world. Clones/fetches, but also reachability queries. Could
    connectivity checks use bitmaps with this?

  - how often do pseudo-merge groups get invalidated by refs changing
    (and thus we lose the speedups from above)?

  - what's the cost like to generate them initially?

  - what's the cost like for subsequent repacks? Does the selection /
    grouping algorithm do a good job of keeping the older, larger groups
    stable (so that we can reuse them verbatim)?

I know you don't have those answers yet, and I know there's some
chicken-and-egg with getting this integrated so that you can start to
explore that. So I mostly reviewed this with an eye towards:

  - does the idea make sense (I think it does, but I'm kind of biased)

  - are the patches going to hurt anybody who isn't using the new
    feature (I think the answer is no)

  - does the on-disk representation seem right, since that is hard to
    change later (I didn't see any issues)

  - does the implementation look clean and plausibly correct (yes, but
    what I'm getting at is that I didn't pore over all of the new code
    with a microscope. Mostly I think the proof is in the pudding that
    it provides the same correct answers more quickly).

So to my eyes it looks good to move forward and let people start playing
with it. The big "experimental" warning in the config is good. Maybe
we'd want want in gitpacking(7), too?

I did wonder briefly what the backup plan is if there are problems with
the on-disk format (or worst case, if it turns out to be a dead end).
We've allocated a flag bit which I think we'd need to respect forever
(though as an optional extension, it's OK to understand and ignore it).
If we needed a "pseudo-merge bitmaps v2", how would that work? I think
we'd have to allocate another bit in the flags field.

I wonder if the start of the pseudo-merge section should have a 4-byte
version/flags field itself? I don't think that's something we've done
before, and maybe it's overkill. I dunno. It's just a lot easier to do
now than later.

-Peff
