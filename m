Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0EFC07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 21:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BF936141C
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 21:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhGBVYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 17:24:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:40306 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231500AbhGBVYW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 17:24:22 -0400
Received: (qmail 32612 invoked by uid 109); 2 Jul 2021 21:21:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Jul 2021 21:21:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28490 invoked by uid 111); 2 Jul 2021 21:21:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Jul 2021 17:21:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 2 Jul 2021 17:21:48 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] connected: implement connectivity check using
 bitmaps
Message-ID: <YN+DbDhMrqOnJbcO@coredump.intra.peff.net>
References: <cover.1624858240.git.ps@pks.im>
 <7687dedd4722c39b5ecef2c2165147c25d16b8d9.1624858240.git.ps@pks.im>
 <YNovuzAsaEb2uIaa@nand.local>
 <YNuiM8TR5evSeNsN@nand.local>
 <YNvRSJI1oWN9W25Y@coredump.intra.peff.net>
 <YNvgA6RLIMdD77Hk@nand.local>
 <YNwE3wES3iv+Xynp@coredump.intra.peff.net>
 <YN9QbEaWgP09PfeD@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YN9QbEaWgP09PfeD@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 02, 2021 at 01:44:12PM -0400, Taylor Blau wrote:

> I would add that these effects change with the size of the bitmap.
> Let's just consider the "count the number of objects in a bitmapped
> commit". On my local copy of the kernel, I see a relatively modest
> improvement:
> 
>     $ tip=2ab38c17aac10bf55ab3efde4c4db3893d8691d2
>     $ hyperfine \
>       'GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index $tip' \
>       'GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index $tip' \
>       --warmup=3
>     Benchmark #1: GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index $tip
>       Time (mean ± σ):      21.5 ms ±   5.6 ms    [User: 8.7 ms, System: 12.7 ms]
>       Range (min … max):    12.4 ms …  34.2 ms    170 runs
> 
>     Benchmark #2: GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index $tip
>       Time (mean ± σ):      10.6 ms ±   1.6 ms    [User: 7.1 ms, System: 3.5 ms]
>       Range (min … max):     4.5 ms …  11.9 ms    258 runs
> 
> but on my copy of the kernel's fork network repo (that containing all of
> torvalds/linux's objects, as well as all of its fork's objects, too),
> the magnitude of the effect is much bigger:
> 
>     Benchmark #1: GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index $tip
>       Time (mean ± σ):     332.3 ms ±  12.6 ms    [User: 210.4 ms, System: 121.8 ms]
>       Range (min … max):   322.7 ms … 362.4 ms    10 runs
> 
>     Benchmark #2: GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index $tip
>       Time (mean ± σ):     260.0 ms ±   9.3 ms    [User: 191.0 ms, System: 69.0 ms]
>       Range (min … max):   250.4 ms … 272.8 ms    11 runs
> 
> That's a more modest 1.28x improvement (versus 2.03x in just linux.git),
> but the overall magnitude is much bigger.

Thanks, this is much more compelling. 70ms is a lot of startup time to
save. I am a little surprised that a no-traversal bitmap query like this
would still take 300ms. I wonder if 2ab38c17aac actually got a bitmap in
your second example (and if not, then there are probably cases where the
relative speedup would be even more impressive).

> This clouded up some of my timings in p5310, which made me think that it
> would be a good idea to `git config pack.writeReverseIndex true` in the
> setup for those tests, but an even better direction would be to change
> the default of pack.writeReverseIndex to true everywhere.

Yes, I'd be in favor of that. IMHO the reason to make it configurable at
all was not because it's ever a bad idea, but just to phase it in and
get experience with it (and to give an escape hatch for debugging it).

It's probably _less_ useful for local clones that are not serving
fetches. But every push is already generating the same thing in-memory,
so it seems like a good tradeoff to just use it everywhere.

> >   - there's some extra complexity in the file format and code to read
> >     and write these (and still fall back to the old system when they're
> >     absent). I don't think it's a deal-breaker, as it's really not that
> >     complicated a feature.
> 
> I agree with both of these. The complexity is manageable, I think,
> especially since I dropped support for the extended offset table (having
> a bitmap file that is >2GiB seems extremely unlikely to me, and it's
> possible to add support for it in the future) and
> fanout table (there are usually less than <1k commits with bitmaps, so
> a 256-entry fanout table doesn't seem to help much in benchmarking).
> 
> So what's left of the format is really just:
> 
>   - a table of object id's
>   - a table of (uint32_t, uint32_t) tuples describing the (short) offset
>     of the bitmap, and an index position of the xor'd bitmap (if one
>     exists).

Yeah, that really seems quite simple. I'd have to judge after seeing the
cleaned up code, but I suspect it's not going to be a burden.

> I'll be offline for the next ~week and a half for my wedding, but I'll
> post some patches to the list shortly after I get back.

Yep, no rush. Thanks for looking into this.

-Peff
