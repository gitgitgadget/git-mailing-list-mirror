Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9357CF17
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621977; cv=none; b=RNIiVbazrnyPTPzla4AnEgl+ee8Ikbbl60qup38cS2mTkhtGYiGjoRAhndw5CHMvSeJCgMP15RotybLRCqGlLEbPqcUWxBkzQXCaPPQrQwWBzA3K1muF8DRBwR8ro03Zgwc5BR5wMqDGMxPzwN48nVxv99s70N6mLlrX5JquOD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621977; c=relaxed/simple;
	bh=FcXmgLG6NRoAgxteyoQH4yVdA4xTVd7qP294lE8ZI7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4RBPSgx9gAcWbkonol6NqMKJjFOSlTZ/yKcInzvpN+l3T6huRKPLuFLLcRgB573Hob0ygm25YCIlBhC+uPE4+rs5aAFxKa+Cw84N5PYsjnhgr5p/PLM36mPWHmJfEhR5rv095iW4xpU+pTM+xuQoXmymXCXO5+Fo6zu2iriZ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3677 invoked by uid 109); 28 Mar 2024 10:32:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Mar 2024 10:32:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4718 invoked by uid 111); 28 Mar 2024 10:32:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Mar 2024 06:32:59 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 28 Mar 2024 06:32:54 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Han Young <hanyang.tony@bytedance.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/1] quote: quote space
Message-ID: <20240328103254.GA898963@coredump.intra.peff.net>
References: <20240319095212.42332-1-hanyang.tony@bytedance.com>
 <xmqqttl2qml9.fsf@gitster.g>
 <xmqqfrwlltjn.fsf@gitster.g>
 <xmqqsf0bz5oj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsf0bz5oj.fsf@gitster.g>

On Wed, Mar 27, 2024 at 03:11:08PM -0700, Junio C Hamano wrote:

> This seems to fail only on Windows, and I have run out of my today's
> allotment of time for this topic.
> 
> The earlier part that creates the directory with a trailing SP,
> redirects to a file in such a directory to create an empty file, and
> adds that path to the index, all succeed and follow the &&-chain,
> but the step that runs "git diff" with "funny /" (i.e. the name of
> the directory a trailing slash) as the pathspec produces an empty
> patch, and "git apply" would of course choke on an empty file as an
> input.
> 
> With the following band-aid, we can skip the test and the output
> from "sh t4126-*.sh -i -v -x" might give us a clue that explains how
> such a failure happens.  Unfortunately GitHub CI's win test does not
> give us insight into a test that did not fail, so I did not get
> anything useful from the "ls -l" down there (I already knew that
> sample patches are empty files).

We package up the failed test output and trash directories for each run.
You can find the one for this case here:

  https://github.com/git/git/actions/runs/8458842054/artifacts/1364695605

It is sometimes misleading because we don't run with "-i", so subsequent
tests may stomp on things. But in this case the failing test is the last
one. Unfortunately, I don't think it shows us much, because the state we
tried to diff is removed by the test itself (both the funny dir and the
index after we tried to add it).

So I don't know if we failed to even create "funny /" in the first
place, if adding it to the index failed, or if the diff somehow failed.

On the plus side, while trying to find the failing CI job, I ran across
and diagnosed two other unrelated failures in "seen". ;)

-Peff
