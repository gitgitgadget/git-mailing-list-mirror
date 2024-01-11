Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58E563A0
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 28954 invoked by uid 109); 11 Jan 2024 06:53:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jan 2024 06:53:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3316 invoked by uid 111); 11 Jan 2024 06:53:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jan 2024 01:53:40 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jan 2024 01:53:38 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] index-pack: spawn threads atomically
Message-ID: <20240111065338.GA48154@coredump.intra.peff.net>
References: <20240105085034.GA3078476@coredump.intra.peff.net>
 <ZZgvUyQK6X/MacDC@nand.local>
 <20240110114456.GF16674@coredump.intra.peff.net>
 <ZZ7VEVXSg1T8ZkIK@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZ7VEVXSg1T8ZkIK@nand.local>

On Wed, Jan 10, 2024 at 12:34:09PM -0500, Taylor Blau wrote:

> > If do go with "--threads=1", I suspect several tests in that file need
> > it.
> 
> Yeah, there are a couple of others. I think the ones that need modifying
> are at the intersection of "expected to fail" and "in a test which is
> expected to pass leak-free":
> 
>     $ grep -l 'TEST_PASSES_SANITIZE_LEAK=true' t????-*.sh |
>       xargs grep -l 'test_must_fail git index-pack'
>     t5302-pack-index.sh
>     t5308-pack-detect-duplicates.sh
>     t5309-pack-delta-cycles.sh
>     t5313-pack-bounds-checks.sh
>     t5325-reverse-index.sh

I think that is more than we need. It's only a problem when we hit a
die() inside a thread, which happens only during delta resolution. So
your patch 2, for example, touches a test which triggers the
--max-input-size check. But we would find that out on the initial
unthreaded pass over the pack.

The one in patch 3 seems at first glance like it might be a problem
(it's another duplicate-object case, like the one of them in 5309). But
it isn't a problem because the duplicate object isn't a delta, so we
notice the problem in write_idx_file() from the main thread (which I
verified by running it under gdb and setting a breakpoint at die()).

I suspect patch 4 is the same, but didn't run gdb on each case. And
patch 5 is about a corrupt reverse index, so almost certainly the main
thread. So I suspect that patch 1 is the only one that matters here (and
probably all of those are needed, because it is all about broken
deltas).

All that said, I am on the fence between the two approaches. If Junio
prefers the atomic-spawn direction, I'm fine with that, and there's not
much point in polishing the --threads=1 approach further.

-Peff
