Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4A5C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 17:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D21420838
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 17:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgHMRiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:38:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:58084 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgHMRiq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 13:38:46 -0400
Received: (qmail 21231 invoked by uid 109); 13 Aug 2020 17:38:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 17:38:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16788 invoked by uid 111); 13 Aug 2020 17:38:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 13:38:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 13:38:45 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] make git-bugreport a builtin
Message-ID: <20200813173845.GA1598703@coredump.intra.peff.net>
References: <20200813145515.GA891139@coredump.intra.peff.net>
 <20200813145936.GC891370@coredump.intra.peff.net>
 <f576fdce-9005-4653-3f91-0ddd2fff125d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f576fdce-9005-4653-3f91-0ddd2fff125d@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 01:01:42PM -0400, Derrick Stolee wrote:

> On 8/13/2020 10:59 AM, Jeff King wrote:
> > There's no reason that bugreport has to be a separate binary. And since
> > it links against libgit.a, it has a rather large disk footprint. Let's
> > make it a builtin, which reduces the size of a stripped installation
> > from 24MB to 22MB.
> > 
> > This also simplifies our Makefile a bit. And we can take advantage of
> > builtin niceties like RUN_SETUP_GENTLY.
> 
> I agree that this is a good change. I'm a bit surprised that a
> feature added so recently wasn't added as a builtin in the first
> place. Perhaps that was a conscious decision? Maybe it was just
> because there was some point in time where it might have been
> relegated to contrib.

I looked in the history for any rationale, but couldn't find any. There
is some discussion in the list, though. It looks like we moved from a
builtin to standalone between v3 and v4 of the series, due to this
sub-thread:

  https://lore.kernel.org/git/xmqqr2284is5.fsf@gitster-ct.c.googlers.com/

My take is:

  - I agree with Johannes that in terms of resource usage, builtins are
    better. I'm skeptical that extra code within the Git binary produces
    a meaningful impact on running other builtins (but I'd be happy to
    look at evidence if somebody has it).

  - Adding shared-library dependencies definitely _does_ impact other
    builtin commands. And I think last November when the series was
    shaping up that it wasn't clear if we might link to system-specific
    data gathering libraries. But that wasn't how the series shook out;
    we gather very little general system info, and we do it with basic
    and lightweight techniques (like uname, or compiler preprocessor
    macros). That could change eventually of course, but it's not like
    switching back to a stand-alone at that point is a big deal.

-Peff
