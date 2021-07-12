Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C142C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE28861206
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbhGLRlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:41:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:46580 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233870AbhGLRlz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:41:55 -0400
Received: (qmail 19163 invoked by uid 109); 12 Jul 2021 17:39:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Jul 2021 17:39:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7954 invoked by uid 111); 12 Jul 2021 17:39:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Jul 2021 13:39:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Jul 2021 13:39:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [RFC] Bump {diff,merge}.renameLimit ?
Message-ID: <YOx+Ok/EYvLqRMzJ@coredump.intra.peff.net>
References: <CABPp-BFzp3TCWiF1QAVSfywDLYrz=GOQszVM-sw5p0rSB8RWvw@mail.gmail.com>
 <87a6ms4wgw.fsf@evledraar.gmail.com>
 <CABPp-BGE+8spsq9HZ6KNwWk_hYy5pj5vjJ8NQQuQiUN7qz7GCA@mail.gmail.com>
 <871r834gqz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871r834gqz.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 06:48:50PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > So I've read and re-read your response multiple times, but I am still
> > not sure what you're advocating for.  I think you're either advocating
> > for rename detection to be turned off by default, or for a new
> > "unlimited" mode to be introduced and be the default (maybe even
> > redefining what the value of "0" means in order to implement this),
> > but I can't tell which.  Could you clarify?
> 
> I'm advocating for an "unlimited" default as long as we have
> progress/advice or whatever other output would direct users for whom
> it's very slow to tweaking the setting (or not).
> 
> Anyway, yes some may disagree with this stance. I'm not saying it's
> demonstrably obvious that we should have "unlimited".
> 
> I do think that it's much better if git behaves that way, i.e. that we
> don't have arbitrary limits that completely change behavior once they're
> tripped.
> 
> Better to spend more CPU, and if it's too slow for someone they can
> tweak the limits.

This seems like a reasonable view to me for merges. As noted, we already
show progress for rename detection there, so at least the use knows that
we're working.

It might be nice to provide similar advice to what we show now when the
limit kicks in.  I.e., now we say "we turned off rename detection
because this merge is huge; you can bump this config to enable it". But
we may want to say "woah, this rename detection is taking a long time;
you can skip it by tweaking this config". Probably with a much higher
limit than the progress meter kicking in (I'm thinking something like
30+ seconds).

For diffs we don't ever show progress. There are two things that make
that a bit hairy:

  1. Most diff operations use the pager, and we send stderr there. That
     gets weird with our "\r" overwriting.

  2. Traversing via git-log, etc, will show a series of diffs, which
     means an unbounded number of progress meters. And potentially we're
     doing work that doesn't match what the user is looking at in the
     pager (e.g., they are looking at commit X, but we are computing
     X~30 while the pager has buffered all points in between; showing a
     progress meter for X~30 is distracting at that point).

I posted a series back in 2011 to try to deal with these. It's in the
sub-thread at:

  https://lore.kernel.org/git/20110324174556.GA30661@sigill.intra.peff.net/

It's also been part of my "rebase forward and merge into my custom
build" strategy for the past 10+ years (even though I had totally
forgotten it existed). So you can get working current patches by
fetching:

  https://github/com/peff/git jk/rename-progress

They do work, and running:

  git -c diff.renamelimit=65535 diff v2.6.12 --raw

in linux.git is very satisfying. I think one sticking point is that
sending separate lines to stderr (outside of the pager) only looks good
if your pager is careful not to take over the terminal until there's
something to show. "less" does this, and I'd expect most traditional
pagers to do so. But there may be those that don't, so we'd probably
need another config option to give an escape hatch.

-Peff
