Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3B74A0F
	for <git@vger.kernel.org>; Sun,  9 Mar 2025 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741489273; cv=none; b=MaLGipBvytgx8amUzioMHnELVCFRnXN1DlgmT6wMpqyjf2dl9BlAj2S9ZoIR02QOIkkPKLVWaQJNJU4TgYkExIaYrvMVuyTjSofuNy/t2PA+isJNWzqhxS2VRclgLoAD3D0WdhyB9PFFjNQIZmcbIFfCk/WnXnkXdD0KCE4xqpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741489273; c=relaxed/simple;
	bh=YlKOmceLtkd+4/3BgAOs0Qpb8YVvwiZmNreK22JSruQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHHOui+vKoCWC8ISDyX/WANWYvyUlvs/A7IQzCysDFeSkKGTj9CudiatuotUtAohIqgUljXLDMw8GHbAhR7wZj3F7p8ISC72Msxz6QoyclJ6aPHEGJSkMKGlPAzAyMz8vc7A7vQZz23NEacPeskRSV7ahibj+yr6wEs+BBpsuws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XkBZkQdw; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XkBZkQdw"
Received: (qmail 4608 invoked by uid 109); 9 Mar 2025 03:01:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YlKOmceLtkd+4/3BgAOs0Qpb8YVvwiZmNreK22JSruQ=; b=XkBZkQdw36q1RrGbYTRvD7wNoTa0dIm0tcBlUwlllgu4C2nGFv5h/aH8CBY1p9lkPgflfBG8uxWnYX63EhML7wjt3NQbFuwsGuhudeKg7KVLrAXZKUCQTEvp2+zEbfSUe8EUR07qOpFGdETTfolrg3O3ovLM1yVOsnr9PAIjLu1SAGI/mbpf8uYK8G1E2AvAyglbo6+hHFYewiF2kS+yelP6X7I3pDqv0+D9m9mZ696yAYZH7bNLlaNYslbt0znu78e87dQHzvWx+xjl6gjFGnDagyBn8q7XXXw4tE9hFBA0UBiY8jOloI2OzEjRUgSNydmxMymB3Dz+aYUZ8ieXug==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 09 Mar 2025 03:01:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4797 invoked by uid 111); 9 Mar 2025 03:01:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Mar 2025 22:01:02 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Mar 2025 22:01:01 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH 0/9] fetch: further ref-prefix cleanups and optimizations
Message-ID: <20250309030101.GA2334064@coredump.intra.peff.net>
References: <71075837-D0AA-4F01-9F5D-CA10BFE93B63@ca.ibm.com>
 <61147be4b9a0ee76f1fe0f3376d7316205da350c.1741389941.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61147be4b9a0ee76f1fe0f3376d7316205da350c.1741389941.git.me@ttaylorr.com>

On Fri, Mar 07, 2025 at 06:27:03PM -0500, Taylor Blau wrote:

> Peff and I talked about this today, and neither of us could find any
> reasons not to pursue the approach listed in the footnote of
> 
>   <20250221072558.GA572877@coredump.intra.peff.net>
> 
> , but this is a more conservative approach that should fix the issue and
> apply cleanly on top of 'maint'. It may be worth picking this into 2.49,
> even though we are already quite late into the -rc cycle, this is a
> fairly nasty bug.

Yeah, I favor doing this simple fix first, and then trying the larger
(and slightly riskier) change on top.

I started to write up that larger patch, and found a number of
interesting things. ;) So here's a 9-patch series, which would apply on
top of tb/fetch-follow-tags-fix (but can very much wait to cook in the
next development cycle).

  [1/9]: t5702: fix typo in test name
  [2/9]: t5516: prefer "oid" to "sha1" in some test titles
  [3/9]: t5516: drop NEEDSWORK about v2 reachability behavior

    Just some cosmetic fixes in nearby areas.

  [4/9]: t5516: beef up exact-oid ref prefixes test

    Improving test coverage in an area I'm about to touch.

  [5/9]: refspec_ref_prefixes(): clean up refspec_item logic

    Code clean-up. Not necessary (textually or semantically) for the
    other patches.

  [6/9]: fetch: ask server to advertise HEAD for config-less fetch
  [7/9]: fetch: stop protecting additions to ref-prefix list
  [8/9]: fetch: avoid ls-refs only to ask for HEAD symref update

    Here we get to the interesting bits. These get rid of the subtle
    dependency that led to this bug in the first place, and also
    optimize a few cases where we can narrow the ref advertisement.

    The third one is a bit optimization, where we avoid a whole
    round-trip to the server. It's correct as far as the rest of the
    code behaves, but I'm not 100% sure that the new origin/HEAD update
    feature isn't a little buggy. See my comments there.

  [9/9]: fetch: use ref prefix list to skip ls-refs

    And then this is just a final bit of cleanup enabled by the earlier
    patches.

 builtin/fetch.c        | 46 +++++++++++++++++-------------------------
 refspec.c              | 22 ++++++++++++++------
 t/t5516-fetch-push.sh  | 12 ++++++-----
 t/t5702-protocol-v2.sh | 44 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 85 insertions(+), 39 deletions(-)

-Peff
