Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD1CC433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 10:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8237206A4
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 10:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgHNKez (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 06:34:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:58878 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgHNKez (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 06:34:55 -0400
Received: (qmail 30680 invoked by uid 109); 14 Aug 2020 10:34:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Aug 2020 10:34:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23716 invoked by uid 111); 14 Aug 2020 10:34:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Aug 2020 06:34:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Aug 2020 06:34:51 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] UNLEAK style fixes
Message-ID: <20200814103451.GD3312240@coredump.intra.peff.net>
References: <20200813155426.GA896769@coredump.intra.peff.net>
 <CAPig+cTOcQymWWtSY3UN73_fpaWUs3u66+EZWBp1SvXeUrgsQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTOcQymWWtSY3UN73_fpaWUs3u66+EZWBp1SvXeUrgsQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 03:32:56PM -0400, Eric Sunshine wrote:

> On Thu, Aug 13, 2020 at 11:54 AM Jeff King <peff@peff.net> wrote:
> > (As a side note, if we want to declare UNLEAK() a failure because nobody
> > cares enough to really use it, I'm OK with that, too).
> 
> Perhaps the reason that UNLEAK() has not been particularly successful,
> in general, is that it requires extra knowledge and reasoning to know
> when to use it and how to do so properly. Couple that with the fact
> that the scope of cases where it can be used is quite narrow compared
> to sum total of all code in project for which we simply free resources
> when we're done with them. So, it's hard to keep the specialized
> UNLEAK() knowledge in one's head.
> 
> Speaking from personal experience, the several times I have had to
> deal with UNLEAK(), I had to re-learn it from scratch each time. That
> meant studying the header comment, studying the implementation, and
> studying existing callers before things "clicked" enough to be able to
> feel confident about how to use it (assuming it wasn't false
> confidence).

I think this is really the meat of it. I never intended UNLEAK() to be
something people dealt with unless they were trying to get LSAN or
valgrind to run without complaining.

> That all represents a lot of cognitive overhead versus the common
> practice of simply freeing resources when you're done with them, which
> requires no extra cognitive load since it is something we think about
> _always_ when working with a language like C with no built-in garbage
> collection.

To be clear, I have no problem with _actually_ freeing resources if
that's an option. The point of UNLEAK() was:

  - to help with structs that don't have an easy way to free all
    elements (e.g., rev_info)

  - to preempt arguments about whether calling free(buf) right before
    programming exit is wasted effort. Whereas UNLEAK() is true
    zero-cost for non-leak-checking builds.

  - to avoid asking people to rewrite:

      return foo(bar);

     into:

       ret = foo(bar);
       free(bar);
       return ret;

So we could go that direction, but I'd wait on it until somebody feels
like sinking some time into getting us leak-checker-clean.

In the meantime, I have a slight preference to leave UNLEAK() there as a
potential tool for somebody digging into leak-checkers. But we almost
certainly shouldn't be asking new authors to use it in reviews, etc.
TBH, I'm not sure why people starting sprinkling UNLEAK() around in the
first place. ;)

-Peff
