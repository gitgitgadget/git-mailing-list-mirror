Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C60C11F67
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 02:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 145EE61D2E
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 02:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhF3CH0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 22:07:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:36954 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232194AbhF3CHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 22:07:25 -0400
Received: (qmail 22193 invoked by uid 109); 30 Jun 2021 02:04:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Jun 2021 02:04:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 902 invoked by uid 111); 30 Jun 2021 02:04:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Jun 2021 22:04:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Jun 2021 22:04:56 -0400
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
Message-ID: <YNvRSJI1oWN9W25Y@coredump.intra.peff.net>
References: <cover.1624858240.git.ps@pks.im>
 <7687dedd4722c39b5ecef2c2165147c25d16b8d9.1624858240.git.ps@pks.im>
 <YNovuzAsaEb2uIaa@nand.local>
 <YNuiM8TR5evSeNsN@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YNuiM8TR5evSeNsN@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 29, 2021 at 06:44:03PM -0400, Taylor Blau wrote:

>     $ hyperfine \
>       'GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index 2ab38c17aac10bf55ab3efde4c4db3893d8691d2' \
>       'GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index 2ab38c17aac10bf55ab3efde4c4db3893d8691d2' \
>       --prepare='sync; echo 3 | sudo tee /proc/sys/vm/drop_caches'
> 
> 		Benchmark #1: GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index 2ab38c17aac10bf55ab3efde4c4db3893d8691d2
> 			Time (mean ± σ):     141.1 ms ±   2.5 ms    [User: 13.0 ms, System: 64.3 ms]
> 			Range (min … max):   136.2 ms … 143.4 ms    10 runs
> 
> 		Benchmark #2: GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index 2ab38c17aac10bf55ab3efde4c4db3893d8691d2
> 			Time (mean ± σ):      28.7 ms ±   3.2 ms    [User: 6.5 ms, System: 10.0 ms]
> 			Range (min … max):    22.0 ms …  31.0 ms    21 runs
> 
> 		Summary
> 			'GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index 2ab38c17aac10bf55ab3efde4c4db3893d8691d2' ran
> 				4.91 ± 0.55 times faster than 'GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index 2ab38c17aac10bf55ab3efde4c4db3893d8691d2'

I was curious why your machine is so much slower than mine. With the
current bitmap format, I can run that command pretty consistently in
~22ms. But I think the trick here is the cache-dropping. The cold-cache
performance is going to be very dependent on faulting in the extra
bytes (and you can see that the actual CPU time in the first case is
much smaller than the runtime, so it really is waiting on the disk).

In the warm-cache case, the improvement seems to go away (or maybe I'm
holding it wrong; even in the cold-cache case I don't get anywhere near
as impressive a speedup as you showed above). Which isn't to say that
cold-cache isn't sometimes important, and this may still be worth doing.
But it really seems like the CPU involve in walking over the file isn't
actually that much.

I got an even more curious result when adding in "--not --all" (which
the connectivity check under discussion would do). There the improvement
from your patch should be even less, because we'd end up reading most of
the bitmaps anyway. But I got:


  $ hyperfine \
       'GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index 2ab38c17aac10bf55ab3efde4c4db3893d8691d2 --not --all' \
       'GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index 2ab38c17aac10bf55ab3efde4c4db3893d8691d2 --not --all' \
       --prepare='sync; echo 3 | sudo tee /proc/sys/vm/drop_caches'

  Benchmark #1: GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index 2ab38c17aac10bf55ab3efde4c4db3893d8691d2 --not --all
    Time (mean ± σ):      4.197 s ±  0.823 s    [User: 284.7 ms, System: 734.5 ms]
    Range (min … max):    2.612 s …  5.009 s    10 runs
   
  Benchmark #2: GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index 2ab38c17aac10bf55ab3efde4c4db3893d8691d2 --not --all
    Time (mean ± σ):      4.498 s ±  0.612 s    [User: 315.3 ms, System: 829.7 ms]
    Range (min … max):    3.010 s …  5.072 s    10 runs
   
  Summary
    'GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index 2ab38c17aac10bf55ab3efde4c4db3893d8691d2 --not --all' ran
      1.07 ± 0.26 times faster than 'GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index 2ab38c17aac10bf55ab3efde4c4db3893d8691d2 --not --all'

which was actually faster _without_ the extra table. 7% isn't a lot,
especially for a cold-cache test, so that may just be noise. But it
doesn't seem like a clear win to me.

-Peff
