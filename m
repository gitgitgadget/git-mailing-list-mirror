Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A35521F461
	for <e@80x24.org>; Fri,  5 Jul 2019 05:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfGEFJ6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 01:09:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:59634 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725763AbfGEFJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 01:09:58 -0400
Received: (qmail 2149 invoked by uid 109); 5 Jul 2019 05:09:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Jul 2019 05:09:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6619 invoked by uid 111); 5 Jul 2019 05:10:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Jul 2019 01:10:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Jul 2019 01:09:55 -0400
Date:   Fri, 5 Jul 2019 01:09:55 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: Surprising use of memory and time when repacking mozilla's gecko
 repository
Message-ID: <20190705050955.GA25459@sigill.intra.peff.net>
References: <20190704100530.smn4rpiekwtfylhz@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190704100530.smn4rpiekwtfylhz@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 04, 2019 at 07:05:30PM +0900, Mike Hommey wrote:

> With 36 threads, the overall process takes 45 minutes:
> - 50 seconds enumerating and counting objects.
> - ~22 minutes compressing objects
> - ~22 minutes writing objects

I noticed the long writing phase when I repacked as well. The main cost
there is going to be reconstructing deltas that wouldn't fit in the
cache. During the compression phase we generated a bunch of candidate
deltas. If we have space in our in-memory cache, we then store the
actual delta there so we can write it out immediately during the writing
phase. Otherwise, we just note the base object we used, and during the
writing phase we regenerate the delta on the fly.

So spending time there implies (and the perf output you posted in the
followup supports this) that we have a lot of entries that could not be
cached.

You might try poking at pack.deltaCacheSize and pack.deltaCacheLimit to
see if they help.

But...

> Finally, with 1 thread, the picture changes greatly. The overall process
> takes 2.5h:
> - 50 seconds enumerating and counting objects.
> - ~2.5h compressing objects.
> - 3 minutes and 25 seconds writing objects!

That's weird. I'd expect us to find similar amounts of deltas, but we
don't have the writing slow-down. I wonder if there is some bad
interaction between the multi-threaded code and the delta cache.

Did you run the second, single-thread run against the exact same
original repository you had? Or did you re-run it on the result of the
multi-thread run? Another explanation is that the original repository
had some poor patterns that made objects expensive to access (say, a ton
of really deep delta chains). And so the difference between the two runs
was not the threads, but just the on-disk repository state.

Kind of a long shot, but if that is what happened, try running another
multi-threaded "repack -f" and see if its writing phase is faster.

> Of the 22 minutes compressing objects, more than 15 minutes are spent on
> the last percent of objects, and only during that part the memory usage
> balloons above 20GB.

That's not surprising. To find deltas, we make an array with all of the
objects, sort it into a list in a way that puts "like" objects near to
each other, and then walk over that list with a sliding window, looking
for candidates. With multiple threads, each thread gets its own segment
of the array to look at. So two implications are:

  - one of the sorting criteria is size. So you'll often end up
    comparing a bunch of large objects to each other at the end, and the
    last few percent will take much more than the earlier parts.

  - each thread is holding $window_size objects in memory at once. There
    are a bunch of biggish objects, up to 17MB, in the mozilla/gecko
    repository. So during that last part with the large objects, the
    worst case is something like window*threads*17 = 250*36*17 = 150GB.

    It's not nearly that bad because you don't have enough large
    objects. ;) The 9000 (256*36) largest objects in that repo are only
    55GB. And we don't hit even that at peak because some threads are
    probably working on parts of the array with smaller objects.

You can compute that largest-9000 objects like:

  git cat-file --batch-all-objects --unordered --batch-check='%(objectsize)' |
  sort -rn | head -9000 |
  perl -lne '$total += $_; END { print $total }'

The simplest solution if you're running into RAM problems is to turn
down the number of threads. You can also disable deltas for certain
objects (over a certain size with core.bigFileThreshold or for certain
paths with the "delta" gitattribute). But in your case those big objects
really do make good deltas:

  $ git cat-file --batch-all-objects --unordered \
      --batch-check='%(objectsize) %(objectsize:disk) %(deltabase)' |
      sort -nr | head -10
  17977953 17963093 0000000000000000000000000000000000000000
  17817405 153050 a4ef0cf1db10163141b827863671050a58612408
  17816806 733 529a3ffd873183abf85c78e61e50da61ccb85976
  17816776 17939 410cc404992142e68dc53c9ecafca14adf21a839
  17815901 571 529a3ffd873183abf85c78e61e50da61ccb85976
  17815698 617 529a3ffd873183abf85c78e61e50da61ccb85976
  17815668 797 d687483fbb3982bb9953ea6e67e78a5c496e9b08
  17815668 560 10a7c4fbd756c1d961f71b7d55034011dbc0ec28
  17815379 539 f50422a9701a018dd5c57f29d70e37c637cd8e4b
  17815379 518 59303aa24bbbf7074ccef5dbabf0906e1c82f980

So those objects are all deltas (except the first, with all zeroes,
which is the root of the base tree for all the others). And we're
getting lots of savings (a few hundred bytes instead of 17MB).

So I wouldn't recommend disabling deltas. Most repacks will just reuse
those deltas verbatim, and you won't pay any cost for them. You only do
here because of the aggressive, --no-delta-reuse repack.

> Memory usage goes back to 2.4G after finishing to compress.
> 
> With 16 threads, the overall process takes about the same time as above,
> with about the same repartition.
> 
> But less time is spent on compressing the last percent of objects, and
> memory usage goes above 20GB later than with 36 threads.

I think most of this follows from the explanations above.

> Memory usage stays reasonable, except at some point after 47 minutes,
> where it starts to increase up to 12.7GB, and then goes back down about
> half an hour later, all while stalling around the 13% progress mark.

Again, sounds like that's where one (or more) of the threads hits that
chunk of big objects.

> My guess is all those stalls are happening when processing the files I
> already had problems with in the past[3], except there are more of them
> now (thankfully, they were removed, so there won't be more, but that
> doesn't make the existing ones go away).

Yep, I think that's right.

> I never ended up working on trying to make that diff faster, maybe that
> would help a little here, but that would probably not help much wrt the
> memory usage. I wonder what git could reasonably do to avoid OOMing in
> this case. Reduce the window size temporarily? Trade memory with time,
> by not keeping the objects in memory?

There is a config option, pack.windowMemory, which tries to do this.
I've had mixed results experimenting with it, and never really used it
beyond experiments.

> I'm puzzled by the fact writing objects is so much faster with 1 thread.

Yes, that part puzzles me too. If your answer to my earlier question is
negative, then it might be worth digging more into the delta-base-cache
(perhaps starting with instrumenting it to print out which deltas did or
didn't get cached, along with their sizes).

-Peff
