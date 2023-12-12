Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE00FE
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 00:12:39 -0800 (PST)
Received: (qmail 9615 invoked by uid 109); 12 Dec 2023 08:12:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Dec 2023 08:12:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12358 invoked by uid 111); 12 Dec 2023 08:12:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Dec 2023 03:12:38 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Dec 2023 03:12:38 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/24] pack-objects: multi-pack verbatim reuse
Message-ID: <20231212081238.GD1117953@coredump.intra.peff.net>
References: <cover.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1701198172.git.me@ttaylorr.com>

On Tue, Nov 28, 2023 at 02:07:54PM -0500, Taylor Blau wrote:

> Performing verbatim pack reuse naturally trades off between CPU time and
> the resulting pack size. In the above example, the single-pack reuse
> case produces a clone size of ~194 MB on my machine, while the
> multi-pack reuse case produces a clone size closer to ~266 MB, which is
> a ~37% increase in clone size.

Right, it's definitely a tradeoff. So taking a really big step back,
there are a few optimizations all tied up in the verbatim reuse code:

  1. in some cases we get to dump whole swaths of the on-disk packfile
     to the output, covering many objects with a few memcpy() calls.
     (This is still O(n), of course, but it's fewer instructions per
     object).

  2. any other reused objects have only a small-ish amount of work to
     fix up ofs deltas, handle gaps, and so on. We get to skip adding
     them to the packing_list struct (this saves some CPU, but also a
     lot of memory)

  3. we skip the delta search for these reused objects. This is where
     your big CPU / output size tradeoff comes into play, I'd think.

So my question is: how much of what you're seeing is from (1) and (2),
and how much is from (3)? Because there are other ways to trigger (3),
such as lowering the window size. For example, if you try your same
packing example with --window=0, how do the CPU and output size compare
to the results of your series? (I'd also check peak memory usage).

-Peff
