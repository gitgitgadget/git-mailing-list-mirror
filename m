Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5E6C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 05:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AAEE61C65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 05:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhF3Frv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 01:47:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:37064 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229874AbhF3Fru (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 01:47:50 -0400
Received: (qmail 22692 invoked by uid 109); 30 Jun 2021 05:45:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Jun 2021 05:45:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2374 invoked by uid 111); 30 Jun 2021 05:45:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Jun 2021 01:45:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Jun 2021 01:45:03 -0400
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
Message-ID: <YNwE3wES3iv+Xynp@coredump.intra.peff.net>
References: <cover.1624858240.git.ps@pks.im>
 <7687dedd4722c39b5ecef2c2165147c25d16b8d9.1624858240.git.ps@pks.im>
 <YNovuzAsaEb2uIaa@nand.local>
 <YNuiM8TR5evSeNsN@nand.local>
 <YNvRSJI1oWN9W25Y@coredump.intra.peff.net>
 <YNvgA6RLIMdD77Hk@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YNvgA6RLIMdD77Hk@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 29, 2021 at 11:07:47PM -0400, Taylor Blau wrote:

> On Tue, Jun 29, 2021 at 10:04:56PM -0400, Jeff King wrote:
> > In the warm-cache case, the improvement seems to go away (or maybe I'm
> > holding it wrong; even in the cold-cache case I don't get anywhere near
> > as impressive a speedup as you showed above). Which isn't to say that
> > cold-cache isn't sometimes important, and this may still be worth doing.
> > But it really seems like the CPU involve in walking over the file isn't
> > actually that much.
> 
> Hmm. I think that you might be holding it wrong, or at least I'm able to
> reproduce some substantial improvements in the warm cache case with
> limited traversals.

OK, I definitely was holding it wrong. It turns out that it helps to run
the custom version of Git when passing in the pack.writebitmapcomittable
option. (I regret there is no portable way to communicate a facepalm
image over plain text).

So that helped, but I did seem some other interesting bits.

Here's my cold-cache time for the commit you selected:

  $ export commit=2ab38c17aac10bf55ab3efde4c4db3893d8691d2
  $ hyperfine \
      -L table 0,1 \
      'GIT_READ_COMMIT_TABLE={table} git.compile rev-list --count --objects --use-bitmap-index $commit' \
      --prepare='sync; echo 3 | sudo tee /proc/sys/vm/drop_caches'

  Benchmark #1: GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index $commit
    Time (mean ± σ):      1.420 s ±  0.162 s    [User: 196.1 ms, System: 293.7 ms]
    Range (min … max):    1.083 s …  1.540 s    10 runs
   
  Benchmark #2: GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index $commit
    Time (mean ± σ):      1.319 s ±  0.256 s    [User: 171.1 ms, System: 237.1 ms]
    Range (min … max):    0.773 s …  1.588 s    10 runs
   
  Summary
    'GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index $commit' ran
      1.08 ± 0.24 times faster than 'GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index $commit'

So better, but well within the noise (and I had a few runs where it
actually performed worse). But you picked that commit because you knew
it was bitmapped, and it's not in my repo. If I switch to a commit that
is covered in my repo, then I get similar results to yours:

  $ export commit=9b1ea29bc0d7b94d420f96a0f4121403efc3dd85
  $ hyperfine \
        -L table 0,1 \
        'GIT_READ_COMMIT_TABLE={table} git.compile rev-list --count --objects --use-bitmap-index $commit' \
        --prepare='sync; echo 3 | sudo tee /proc/sys/vm/drop_caches'

  Benchmark #1: GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index $commit
    Time (mean ± σ):     309.3 ms ±  61.0 ms    [User: 19.4 ms, System: 79.0 ms]
    Range (min … max):   154.4 ms … 386.7 ms    10 runs
   
  Benchmark #2: GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index $commit
    Time (mean ± σ):      33.7 ms ±   2.5 ms    [User: 3.3 ms, System: 3.6 ms]
    Range (min … max):    31.5 ms …  46.5 ms    33 runs

  Summary
  'GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index $commit' ran
    9.19 ± 1.94 times faster than 'GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index $commit'

And the effect continues in the warm cache case, though the absolute
numbers are much tinier:

  Benchmark #1: GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index $commit
    Time (mean ± σ):      12.0 ms ±   0.3 ms    [User: 4.6 ms, System: 7.4 ms]
    Range (min … max):    11.4 ms …  13.2 ms    219 runs

  Benchmark #2: GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index $commit
    Time (mean ± σ):       3.0 ms ±   0.4 ms    [User: 2.3 ms, System: 0.8 ms]
    Range (min … max):     2.6 ms …   5.5 ms    851 runs

  Summary
    'GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index $commit' ran
      3.95 ± 0.55 times faster than 'GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index $commit'

That implies to me that yes, it really is saving time, especially in the
cold-cache case. But if you have to do any actual fill-in traversal, the
benefits get totally lost in the noise. _Especially_ in the cold-cache
case, because then we're faulting in the actual object data, etc.

By the way, one other thing I noticed is that having a fully-build
commit-graph also made a big difference (much bigger than this patch),
especially for the non-bitmapped commit. Which makes sense, since it is
saving us from loading commit objects from disk during fill-in
traversal.

So I dunno. There's absolutely savings for some cases, but I suspect in
practice it's not going to really be noticeable. Part of me says "well,
if it ever provides a benefit and there isn't a downside, why not?". So
just devil's advocating on downsides for a moment:

  - there's some extra complexity in the file format and code to read
    and write these (and still fall back to the old system when they're
    absent). I don't think it's a deal-breaker, as it's really not that
    complicated a feature.

  - we're using extra bytes on disk (and the associated cold block cache
    effects there). It's not very many bytes, though (I guess 20 for the
    hash, plus a few offset integers; if we wanted to really
    penny-pinch, we could probably store 32-bit pointers to the hashes
    in the associated .idx file, at the cost of an extra level of
    indirection while binary searching). But that is only for a few
    hundred commits that are bitmapped, not all of them. And it's
    balanced by not needing to allocate a similar in-memory lookup table
    in each command. So it's probably a net win.

> > I got an even more curious result when adding in "--not --all" (which
> > the connectivity check under discussion would do). There the improvement
> > from your patch should be even less, because we'd end up reading most of
> > the bitmaps anyway. But I got:
> 
> Interesting. Discussion about that series aside, I go from 28.6ms
> without reading the table to 35.1ms reading it, which is much better in
> absolute timings, but much worse relatively speaking.

I suspect that's mostly noise. With "--not --all" in a regular linux.git
repo, I don't find any statistical difference.

In a fake repo with one ref per commit, everything is even more lost in
the noise (because we spend like 2000ms loading up all the tip commits).
I suspect it's worse on a real repo with lots of refs (the "spiky
branches" thing I mentioned earlier in the thread), since there we'd
have to do even more fill-in traversal.

> I can't quite seem to make sense of the perf report on that command.
> Most of the time is spent faulting pages in, but most of the time
> measured in the "git" object is in ubc_check. I don't really know how to
> interpret that, but I'd be curious if you had any thoughts.

ubc_check() is basically "computing sha1" (we check the sha1 on every
object we call parse_object() for). I'd guess it's just time spent
loading the negative tips (commits if you don't have a commit graph,
plus tags to peel, though I guess we should be using the packed-refs
peel optimization here).

-Peff
