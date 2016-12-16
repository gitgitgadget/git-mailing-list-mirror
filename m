Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDF791FF6D
	for <e@80x24.org>; Fri, 16 Dec 2016 01:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756647AbcLPBiF (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 20:38:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:57359 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754581AbcLPBiF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 20:38:05 -0500
Received: (qmail 5825 invoked by uid 109); 16 Dec 2016 01:37:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Dec 2016 01:37:32 +0000
Received: (qmail 8106 invoked by uid 111); 16 Dec 2016 01:38:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Dec 2016 20:38:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Dec 2016 20:37:28 -0500
Date:   Thu, 15 Dec 2016 20:37:28 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: index-pack outside of repository?
Message-ID: <20161216013728.in2dazshtarrnnq3@sigill.intra.peff.net>
References: <20161215204000.avlcfaqjwstkptu2@sigill.intra.peff.net>
 <xmqqshpou3wt.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshpou3wt.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2016 at 04:13:38PM -0800, Junio C Hamano wrote:

> > So I think complaining to the user is the right thing to do here. I
> > started to write a patch to have index-pack notice when it needs a repo
> > and doesn't have one, but the logic is actually a bit unclear.  Do we
> > need to complain early _just_ when --stdin is specified, or does that
> > miss somes cases?  Likewise, are there cases where --stdin can operate
> > without a repo? I couldn't think of any.
> 
> I think there are two and only two major modes; --stdin wants to put
> the result in the repository it is working on, while the other mode
> takes a filename to deposit the result in, so the latter does not
> technically need a repository.

OK. That's easy to check for, then.  Reverse-engineering that logic from
the actual calls in index-pack.c:final() is complicated.  But certainly
basing it on --stdin is what I would have expected.

> > That strategy _might_ be a problem for some programs, which would want
> > to notice the issue early before doing work. But it seems like a
> > reasonable outcome for index-pack. Thoughts?
> 
> That is, once we know which codepaths should require a repository, I
> think it is reasonable to add a check that is done earlier than the
> place where we currently try to see where we have one (which could
> be deep in the callchain).  But we are all human and can miss things,
> so the BUG() thing is probably fine.  We are cooking it exactly because
> we would want to find such corner cases we missed, no?

Right, that was my original intent in adding the BUG(): to catch
unhandled cases, and then do the appropriate thing earlier. I was just
questioning whether the appropriate thing in some cases might be dying
at the BUG(), just with a more friendly message. That has the benefit of
being very easy to implement, and never wrong (e.g., forbidding a case
that actually _doesn't_ need to look at the repo).

But if this case really is just "if (from_stdin)" that's quite easy,
too.

-Peff
