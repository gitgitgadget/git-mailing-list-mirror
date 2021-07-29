Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75885C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 16:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 561E860E9B
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 16:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhG2QUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 12:20:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:60924 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhG2QUR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 12:20:17 -0400
Received: (qmail 8860 invoked by uid 109); 29 Jul 2021 16:20:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Jul 2021 16:20:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22213 invoked by uid 111); 29 Jul 2021 16:20:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Jul 2021 12:20:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 29 Jul 2021 12:20:12 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/7] Final optimization batch (#15): use memory pools
Message-ID: <YQLVPN9n5E1Yvi/q@coredump.intra.peff.net>
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
 <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 29, 2021 at 03:58:34AM +0000, Elijah Newren via GitGitGadget wrote:

> This series is more about strmaps & memory pools than merge logic. CC'ing
> Peff since he reviewed the strmap work[1], and that work included a number
> of decisions that specifically had this series in mind.

I haven't been following the other optimization threads very closely,
but I'll try to give my general impressions.

> === Basic Optimization idea ===
> 
> In this series, I make use of memory pools to get faster allocations and
> deallocations for many data structures that tend to all be deallocated at
> the same time anyway.
> 
> === Results ===
> 
> For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
> performance work; instrument with trace2_region_* calls", 2020-10-28), the
> changes in just this series improves the performance as follows:
> 
>                      Before Series           After Series
> no-renames:      204.2  ms ±  3.0  ms    198.3 ms ±  2.9 ms
> mega-renames:      1.076 s ±  0.015 s    661.8 ms ±  5.9 ms
> just-one-mega:   364.1  ms ±  7.0  ms    264.6 ms ±  2.5 ms

Pretty good results for the mega-renames case. I do wonder how much this
matters in practice. That case is intentionally stressing the system,
though I guess it's not too far-fetched (it's mostly a big directory
rename). However, just "git checkout" across the rename already takes
more than a second. So on the one hand, 400ms isn't nothing. On the
other, I doubt anybody is likely to notice in the grand scheme of
things.

And we're paying a non-trivial cost in code complexity to do it (though
I do think you've done an admirable job of making that cost as low as
possible). Dropping the USE_MEMORY_POOL flag and just always using a
pool would make a lot of that complexity go away. I understand how it
makes leak hunting harder, but I think simpler code would probably be
worth the tradeoff (and in a sense, there _aren't_ leaks in an
always-pool world; we're holding on to all of the memory through the
whole operation).

I assume your tests are just done using the regular glibc allocator. I
also wondered how plugging in a better allocator might fare. Here are
timings I did of your mega-renames case with three binaries: one built
with USE_MEMORY_POOL set to 0, one with it set to 1, and one with it set
to 0 but adding "-ltcmalloc" to EXTLIBS via config.mak.

  $ hyperfine \
      -p 'git checkout hwmon-updates &&
          git reset --hard fd8bdb23b91876ac1e624337bb88dc1dcc21d67e &&
          git checkout 5.4-renames^0' \
      -L version nopool,pool,tcmalloc \
      './test-tool.{version} fast-rebase --onto HEAD base hwmon-updates'
  
  Benchmark #1: ./test-tool.nopool fast-rebase --onto HEAD base hwmon-updates
    Time (mean ± σ):     921.1 ms ± 146.0 ms    [User: 843.0 ms, System: 77.5 ms]
    Range (min … max):   660.9 ms … 1112.2 ms    10 runs
   
  Benchmark #2: ./test-tool.pool fast-rebase --onto HEAD base hwmon-updates
    Time (mean ± σ):     635.4 ms ± 125.5 ms    [User: 563.7 ms, System: 71.3 ms]
    Range (min … max):   496.8 ms … 856.7 ms    10 runs
   
  Benchmark #3: ./test-tool.tcmalloc fast-rebase --onto HEAD base hwmon-updates
    Time (mean ± σ):     727.3 ms ± 139.9 ms    [User: 654.1 ms, System: 72.9 ms]
    Range (min … max):   476.3 ms … 900.5 ms    10 runs
   
  Summary
    './test-tool.pool fast-rebase --onto HEAD base hwmon-updates' ran
      1.14 ± 0.32 times faster than './test-tool.tcmalloc fast-rebase --onto HEAD base hwmon-updates'
      1.45 ± 0.37 times faster than './test-tool.nopool fast-rebase --onto HEAD base hwmon-updates'

The pool allocator does come out ahead when comparing means, but the
improvement is within the noise (and the fastest run was actually with
tcmalloc).

I was also curious about peak heap usage. According to massif, the pool
version peaks at ~800k extra (out of 82MB), which is negligible. Plus it
has fewer overall allocations, so it seems to actually save 4-5MB in
malloc overhead (though I would imagine that varies between allocators;
I'm just going from massif numbers here).

So...I dunno. It's hard to assess the real-world impact of the speedup,
compared to the complexity cost. Ultimately, this is changing code that
you wrote and will probably maintain. So I'd leave the final decision
for that tradeoff to you. I'm just injecting some thoughts and numbers. :)

-Peff
