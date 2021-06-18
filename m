Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D955C48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 14:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 697F66128C
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 14:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbhFROMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 10:12:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:60026 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhFROMK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 10:12:10 -0400
Received: (qmail 26923 invoked by uid 109); 18 Jun 2021 14:10:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Jun 2021 14:10:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15863 invoked by uid 111); 18 Jun 2021 14:10:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Jun 2021 10:10:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Jun 2021 10:10:00 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] bitmaps: don't recurse into trees already in the bitmap
Message-ID: <YMypONmXt142dhbb@coredump.intra.peff.net>
References: <YMcExxF7DI6k+sZ+@coredump.intra.peff.net>
 <YMdGGL6v8LrbcAJP@coredump.intra.peff.net>
 <471cb9be-bb72-6a37-ede8-f9421d9d3ebe@gmail.com>
 <YMnvCI/jksyn2flD@tanuki>
 <YMyYz6Tavj5l6S8n@coredump.intra.peff.net>
 <YMyhCTaHmm6oNFpB@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMyhCTaHmm6oNFpB@xps>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 18, 2021 at 03:35:05PM +0200, Patrick Steinhardt wrote:

> > More than once I've spent many head-scratching hours trying to determine
> > why some real-world repo performs better or worse than expected. :)
> 
> I couldn't agree more. I've also had my fair share of weird performance
> characteristics in completely unexpected ways. Unfortunately, it has
> made me become quite cautious about bitmaps given that they've already
> caused their fair share of perfomance regressions.
> 
> But your work here actually encourages me to give it another try soonish
> and see what kind of repo shapes make them explode this time.

Not really for immediate work, but I just wanted to note while I'm
thinking about it: the two big things that can actually make bitmaps
_worse_ than a regular traversal are:

  - loading the bitmaps is inherently linear in the file size. We could
    do better with an mmap-able index of bitmapped commits in the file.
    This would be easy to add as an extension to the file. This matters
    most for really small queries (the absolute time to parse the bitmap
    file isn't that high, but if the non-bitmap query can be answered in
    a few milliseconds, it becomes relatively more important).

  - we produce a definite answer of reachability for the bitmaps by
    filling in a bitmap for the negative (UNINTERESTING) tips, then one
    for the regular tips, and then taking a set difference. Whereas a
    normal traversal walks both sides together until it hits a merge
    base, and then actually looks into the trees in the boundary
    commits. This normal-traversal technique may look at fewer objects
    overall for some cases (especially if you have a lot of negative
    tips, like with "--not --all" and not-so-good bitmap coverage). But
    it does mean we may report an object as in the traversal when it's
    actually not (if it was added/removed in part of the uninteresting
    history, and so not present at the boundary).

    We could possibly teach the bitmap traversal to behave more like
    a normal one. I suspect this would clear up most of the regressions
    you'd see using bitmaps with rev-list.

There is one other related case I've run into. If you put a bitmap on
every commit, you'd _think_ that would make everything faster, since
you'd never traverse at all. But there's an inflection point where you
spend more time going through each bitmap twiddling bits (which remember
is O(nr_of_objects * nr_bitmapped_commits) bits across all of them). And
most of those bits will already be "1", so there's a point where the
saved traversal is less than the cost of OR-ing bits.

Anyway, this is all big-picture stuff that I don't expect you to work on
or even respond to. I'm mostly just writing up some thoughts that I
don't think have made it to the list in a coherent form. I'm not sure if
I'll eventually work on some of them or not (but anybody who is
interested can be my guest :) ).

-Peff
