Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EF86AB88
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22817 invoked by uid 109); 21 Dec 2023 11:13:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Dec 2023 11:13:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23348 invoked by uid 111); 21 Dec 2023 11:13:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Dec 2023 06:13:34 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Dec 2023 06:13:33 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/24] pack-objects: multi-pack verbatim reuse
Message-ID: <20231221111333.GE570888@coredump.intra.peff.net>
References: <cover.1701198172.git.me@ttaylorr.com>
 <20231212081238.GD1117953@coredump.intra.peff.net>
 <ZXxy1USjjjAbBi++@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXxy1USjjjAbBi++@nand.local>

On Fri, Dec 15, 2023 at 10:37:57AM -0500, Taylor Blau wrote:

> On Tue, Dec 12, 2023 at 03:12:38AM -0500, Jeff King wrote:
> > So my question is: how much of what you're seeing is from (1) and (2),
> > and how much is from (3)? Because there are other ways to trigger (3),
> > such as lowering the window size. For example, if you try your same
> > packing example with --window=0, how do the CPU and output size compare
> > to the results of your series? (I'd also check peak memory usage).
> 
> Interesting question! Here are some preliminary numbers on my machine
> (which runs Debian unstable with a Intel Xenon W-2255 CPU @ 3.70GHz and
> 64GB of RAM).
> 
> I ran the following hyperfine command on my testing repository, which
> has the Git repository broken up into ~75 packs or so:

Thanks for running these tests. The results are similar to what
expected, which is: yes, most of your CPU savings are from skipping
deltas, but not all.

Here's what I see (which I think is mostly redundant with what you've
said, but I just want to lay out my line of thinking). I'll reorder your
quoted sections a bit as I go:

>     Benchmark 2: multi-pack reuse, pack.window=0
>     [...]
>       Time (mean ± σ):      1.075 s ±  0.005 s    [User: 0.990 s, System: 0.188 s]
>       Range (min … max):    1.071 s …  1.088 s    10 runs
>
>     Benchmark 4: multi-pack reuse, pack.window=10
>     [...]
>       Time (mean ± σ):      1.028 s ±  0.002 s    [User: 1.150 s, System: 0.184 s]
>       Range (min … max):    1.026 s …  1.032 s    10 runs

OK, so when we're doing more full ("multi") reuse, the pack window
doesn't make a big difference either way. You didn't show the stderr
from each, but presumably most of the objects are hitting the "reuse"
path, and only a few are deltas (and that is backed up by the fact that
doing deltas only gives us a slight improvement in the output size:

>     Benchmark 2: multi-pack reuse, pack.window=0
>     268.670 MB
>     Benchmark 4: multi-pack reuse, pack.window=10
>     266.473 MB

Comparing the runs with less reuse:

>     Benchmark 1: single-pack reuse, pack.window=0
>     [...]
>       Time (mean ± σ):      1.248 s ±  0.004 s    [User: 1.160 s, System: 0.188 s]
>       Range (min … max):    1.244 s …  1.259 s    10 runs
>
>     Benchmark 3: single-pack reuse, pack.window=10
>     [...]
>       Time (mean ± σ):      6.281 s ±  0.024 s    [User: 43.727 s, System: 0.492 s]
>       Range (min … max):    6.252 s …  6.326 s    10 runs

there obviously is a huge amount of time saved by not doing deltas, but
we pay for it with a much bigger pack:

>     Benchmark 1: single-pack reuse, pack.window=0
>     264.443 MB
>     Benchmark 3: single-pack reuse, pack.window=10
>     194.355 MB

But of course that "much bigger" pack is about the same size as the one
we get from doing multi-pack reuse. Which is not surprising, because
both are avoiding looking for new deltas (and the packs after the
preferred one probably have mediocre deltas).

So I do actually think that disabling pack.window gives you a
similar-ish tradeoff to expanding the pack-reuse code (~6s down to ~1s,
and a 36% embiggening of the resulting pack size).

Which implies that one option is to scrap your entire series and just
set pack.window. Basically comparing multi/10 (your patches) to single/0
(a hypothetical config option), which have similar run-times and pack
sizes.

But that's not quite the whole story. There is still a CPU improvement
in your series (1.2s vs 1.0s, a 20% speedup). And as I'd expect, a
memory improvement from avoiding the extra book-keeping (almost 10%):

>     Benchmark 1: single-pack reuse, pack.window=0
>     354.224 MB (max RSS)
>     Benchmark 4: multi-pack reuse, pack.window=10
>     328.786 MB (max RSS)

So while it's a lot less code to just set the window size, I do think
those improvements are worth it. And really, it's the same tradeoff we
make for the single-pack case (i.e., one could argue that we
could/should rip out the verbatim-reuse code entirely in favor of just
tweaking the window size).

> It's pretty close between multi-pack reuse with a window size of 0 and
> a window size of 10. If you want to optimize for pack size, you could
> trade a ~4% reduction in pack size for a ~1% increase in peak memory
> usage.

I think if you want to optimize for pack size, you should consider
repacking all-into-one to get better on-disk deltas. ;) I know that's
easier said than done when the I/O costs are significant. I do wonder if
storing thin packs on disk would let us more cheaply reach a state that
could serve optimal-ish packs without spending CPU computing bespoke
deltas for each client. But that's a much larger topic.

-Peff
