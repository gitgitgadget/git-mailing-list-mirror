Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE76C433E3
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 10:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA371207DA
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 10:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgHNKRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 06:17:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:58868 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgHNKRH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 06:17:07 -0400
Received: (qmail 30542 invoked by uid 109); 14 Aug 2020 10:17:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Aug 2020 10:17:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23608 invoked by uid 111); 14 Aug 2020 10:17:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Aug 2020 06:17:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Aug 2020 06:17:06 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] stop calling UNLEAK() before die()
Message-ID: <20200814101706.GC3312240@coredump.intra.peff.net>
References: <20200813155426.GA896769@coredump.intra.peff.net>
 <20200813155500.GA897132@coredump.intra.peff.net>
 <275f3f6c-77ed-fddd-8f79-28f25b257362@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <275f3f6c-77ed-fddd-8f79-28f25b257362@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 02:08:45PM -0400, Derrick Stolee wrote:

> On 8/13/2020 11:55 AM, Jeff King wrote:
> > The point of UNLEAK() is to make a reference to a variable that is about
> > to go out of scope so that leak-checkers will consider it to be
> > not-leaked. Doing so right before die() is therefore pointless; even
> > though we are about to exit the program, the variable will still be on
> > the stack and accessible to leak-checkers.
> > 
> > These annotations aren't really hurting anything, but they clutter the
> > code and set a bad example of how to use UNLEAK().
> 
> Good justification. I'll stop being a bad example ;)

To be fair, it seems clear that UNLEAK() as a concept is rather
confusing. I really never intended anybody to start sprinkling it around
the code. It was meant to be a tool for folks who are interested in
running leak-checkers to do in-code annotations (for "yes, I know this
leaks but not until the program effectively ends").

I certainly don't mind if people writing new code preemptively annotate
this kind of leak. But I also wouldn't really encourage authors to put a
lot of effort into it, given the current state of the annotations.

-Peff
