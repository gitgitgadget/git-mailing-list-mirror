Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D305648CD3
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18032 invoked by uid 109); 10 Jan 2024 11:44:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jan 2024 11:44:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26269 invoked by uid 111); 10 Jan 2024 11:44:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Jan 2024 06:44:59 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Jan 2024 06:44:56 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] index-pack: spawn threads atomically
Message-ID: <20240110114456.GF16674@coredump.intra.peff.net>
References: <20240105085034.GA3078476@coredump.intra.peff.net>
 <ZZgvUyQK6X/MacDC@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZgvUyQK6X/MacDC@nand.local>

On Fri, Jan 05, 2024 at 11:33:23AM -0500, Taylor Blau wrote:

> -	test_must_fail git index-pack --fix-thin --stdin <recoverable.pack
> +	test_must_fail git index-pack --threads=1 --fix-thin --stdin <recoverable.pack
> [...]
> For what it's worth, I'm fine with either approach, mostly to avoid
> tying up more of the list's time discussing the options. But I have a
> vague preference towards `--threads=1` since it doesn't require us to
> touch production code.

That's quite tempting, actually. The flip side, though, is that the test
no longer reflects the production code as well. That is, in the real
world we'd still call exit() from a thread. That obviously works OK now
(modulo LSan), but if we ever had a regression where that left us in an
inconsistent state, we'd be less likely to notice it. Feels kind of
unlikely in practice, though.

I dunno. I guess the real least-bad thing is seeing if LSan can be
fixed to handle this atomically. I haven't even reported it there.

If do go with "--threads=1", I suspect several tests in that file need
it.

-Peff
