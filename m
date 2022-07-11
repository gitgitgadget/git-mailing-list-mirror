Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C47C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 17:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiGKRsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 13:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiGKRr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 13:47:58 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4499E509FC
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 10:47:57 -0700 (PDT)
Received: (qmail 8605 invoked by uid 109); 11 Jul 2022 17:47:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Jul 2022 17:47:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21798 invoked by uid 111); 11 Jul 2022 17:47:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Jul 2022 13:47:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Jul 2022 13:47:55 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] ref-filter: disable save_commit_buffer while traversing
Message-ID: <YsxiSwQGvLhzNQrt@coredump.intra.peff.net>
References: <Ysw4JtoHW1vWmqhz@coredump.intra.peff.net>
 <220711.8635f77j7s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220711.8635f77j7s.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 11, 2022 at 05:12:37PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Hrm, so for doing the format we're leaving some performance on the table
> as we're currently not making use of this cache, so this makes nothing
> worse on that front.
> 
> But doesn't this approach then also close the door on using the same
> cache for performance improvements in that area? I.e. spotting that
> we've already parsed that commit, so we can get it from the cache?

Yes, it does close that door, or at least make it more challenging. But
I suspect it's not a very fruitful door in the first place:

  - it only helps at all if your sort field or format dereferences the
    tag to get to the commit

  - it only helps if you actually use the traversal options

  - done naively, it's a tradeoff. You might traverse a million commits,
    but display only a handful of them. Is using all of that memory
    worth avoiding re-inflating a few commits? Certainly you can come up
    with a pathological case, but I doubt that it helps in practice.

  - you _could_ do it less naively by caching only the commits directly
    pointed to by refs. But the depths of the traversals don't know what
    those are. So you'd probably do it by pre-loading those commits
    before any traversal, which would work just fine before or after my
    patch. But I probably wouldn't because of the extra code complexity,
    and because...

  - if the commit is in a commit-graph file, then pre-loading it is
    actively harmful (because you might not need it anyway!). So really,
    the best performance will come from just having a commit graph. I
    don't see the point in writing more code to micro-optimize the
    fallback case. For this patch, it's just that the existing code is
    being actively stupid.

> B.t.w. did you try to benchmark this with --no-contains too, I tried e.g.:
> 
>     ./git -P tag --contains 88ce3ef636b --no-contains a39b4003f0e -- "v*"

I didn't, but doing it now showed the same 5% speedup.

> Which gives me:
> 
> 	$ git hyperfine -L rev HEAD~1,HEAD -s 'make CFLAGS=-O3' './git -P tag --contains 88ce3ef636b --no-contains a39b4003f0e -- "v*"' -w 1 
> 	Benchmark 1: ./git -P tag --contains 88ce3ef636b --no-contains a39b4003f0e -- "v*"' in 'HEAD~1
> 	  Time (mean ± σ):      1.437 s ±  0.107 s    [User: 1.252 s, System: 0.082 s]
> 	  Range (min … max):    1.306 s …  1.653 s    10 runs
> 	 
> 	Benchmark 2: ./git -P tag --contains 88ce3ef636b --no-contains a39b4003f0e -- "v*"' in 'HEAD
> 	  Time (mean ± σ):      1.335 s ±  0.044 s    [User: 1.230 s, System: 0.050 s]
> 	  Range (min … max):    1.260 s …  1.417 s    10 runs
> 	 
> 	Summary
> 	  './git -P tag --contains 88ce3ef636b --no-contains a39b4003f0e -- "v*"' in 'HEAD' ran
> 	    1.08 ± 0.09 times faster than './git -P tag --contains 88ce3ef636b --no-contains a39b4003f0e -- "v*"' in 'HEAD~1'

Isn't that showing that it's slightly faster with my patch? It's not as
fast as your "just --contains" example, but the exact improvement will
depend on how many commits your particular query has to traverse (and
from the improved overall time, it seems that "just --contains" is
traversing less). And I'd expect a fair bit of noise here. This really
isn't making anything faster; it's just using less memory, so any
speedup is coming from things like less-full memory caches.

BTW, I picked "--contains 1da177e4c3" in linux.git because I thought it
would have to traverse a lot (because that's the oldest commit), but it
actually isn't the worst case. Just asking about "--contains HEAD"
requires more traversal, but still shows a speed improvement (7.45s
before my patch, 7.26s after).

But I was curious about the heap savings there, since the numbers should
be larger. And indeed they are. Here's peak heap for two runs:

  1093721590 ./git.old --no-pager tag --contains HEAD
   218077941 ./git.new --no-pager tag --contains HEAD

Whoops, that is indeed 1GB of heap, which is what Olaf was seeing
(though I don't know what repo he's using, it's roughly proportional to
the number of commits). And 200MB afterwards. So indeed, I'd expect this
patch (or the hackier version I showed earlier) to make a significant
dent in his workload.

Of course the even better solution is to use commit-graphs. That drops
the memory usage to a few megabytes, and the time to only a few
milliseconds (because generation numbers let us avoid most of the
traversal).

-Peff
