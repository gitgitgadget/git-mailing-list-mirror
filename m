Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05026C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E254B20735
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgHUSly (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:41:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:37358 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgHUSlx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 14:41:53 -0400
Received: (qmail 19462 invoked by uid 109); 21 Aug 2020 18:41:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2020 18:41:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30663 invoked by uid 111); 21 Aug 2020 18:41:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Aug 2020 14:41:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Aug 2020 14:41:52 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] index-pack: adjust default threading cap
Message-ID: <20200821184152.GA3263614@coredump.intra.peff.net>
References: <20200821175153.GA3263018@coredump.intra.peff.net>
 <20200821175800.GC3263141@coredump.intra.peff.net>
 <CAPig+cRQG6EN7Zq_fYMQOM7y9a6rgwWORZhN=px21-7RorWNdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRQG6EN7Zq_fYMQOM7y9a6rgwWORZhN=px21-7RorWNdg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 02:08:55PM -0400, Eric Sunshine wrote:

> On Fri, Aug 21, 2020 at 1:58 PM Jeff King <peff@peff.net> wrote:
> > So what's a good default value? It's clear that the current cap of 3 is
> > too low; our default values are 42% and 57% slower than the best times
> > on each machine. The results on the 40-core machine imply that 20
> > threads is an actual barrier regardless of the number of cores, so we'll
> > take that as a maximum. We get the best results on these machines at
> > half of the online-cpus value. That's presumably a result of the
> > hyperthreading. That's common on multi-core Intel processors, but not
> > necessarily elsewhere. But if we take it as an assumption, we can
> > perform optimally on hyperthreaded machines and still do much better
> > than the status quo on other machines, as long as we never half below
> > the current value of 3.
> 
> I'm not familiar with the index-pack machinery, so this response may
> be silly, but the first question which came to my mind was whether or
> not SSD vs. spinning-platter disk impacts these results, and which of
> the two you were using for the tests (which I don't think was
> mentioned in any of the commit messages). So, basically, I'm wondering
> about the implication of this change for those of us still stuck with
> old spinning-platter disks.

They were both SSD machines, but it wouldn't matter for these tests
because they easily fit the whole pack into memory anyway.

But in the general case, I don't think disk performance would be
relevant. Delta resolution is very CPU-bound, because it's
de-compressing data and then computing its SHA-1. So linux.git, for
instance, is looking at ~1.3GB on disk that expands to 87.5GB of bytes
to run through SHA-1.

And it would be pretty unlikely to hit the disk anyway, as the thing we
primarily index is incoming packs which we've literally just written. So
I'd expect them to be in cache.

Of course, if you can get different numbers from p5302, I'd be curious
to hear them. :)

A more plausible downside might be that memory usage would increase as
we operate on multiple deltas at once. But pack-objects is already much
more hungry here, as it runs online_cpus() delta-compression threads
simultaneously, each of which may have up to window_size entries in
memory at once.

-Peff
