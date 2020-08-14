Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF16CC433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 16:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8865C20774
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 16:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgHNQ1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:27:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:59318 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgHNQ1v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 12:27:51 -0400
Received: (qmail 1188 invoked by uid 109); 14 Aug 2020 16:27:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Aug 2020 16:27:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27142 invoked by uid 111); 14 Aug 2020 16:27:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Aug 2020 12:27:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Aug 2020 12:27:49 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/6] more small leak fixes
Message-ID: <20200814162749.GB595840@coredump.intra.peff.net>
References: <20200814161328.GA153929@coredump.intra.peff.net>
 <20200814162525.GA595840@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200814162525.GA595840@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 14, 2020 at 12:25:25PM -0400, Jeff King wrote:

> On Fri, Aug 14, 2020 at 12:13:28PM -0400, Jeff King wrote:
> 
> > Based on the discussion over in [1], I wondered how close we were to
> > being able to run some test scripts with a leak-checker like LSan not
> > complaining. The answer is...not close.
> > 
> > I picked t5526 more or less at random (it was the first failure when I
> > did a parallel "make test") to see what it would take to get it passing.
> > After much effort...I have t5526.1, the setup test, running clean. :)
> 
> For reference, here are the UNLEAK() calls I had to add to silence the
> false positives. Some of these are kind of sketchy. For example,
> declaring that wt_status_collect_changes_index() is allowed to leak is a
> bit low-level for my tastes (in general it's probably only called once
> per program, but it's getting quite far from the bottom of the stack).
> But there's actually no convenient way to free the various bits of a
> rev_info, so marking it with UNLEAK() is an expedient hack.

And by the way, having gone through this exercise, I'm re-convinced that
UNLEAK() is reasonable to keep. A lot of these cases would have been
very awkward with free(). Not insurmountable, but cases where a variable
is sometimes-allocated and sometimes-not get rather tricky.

-Peff
