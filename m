Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB64E1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 19:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754624AbcIITiB (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 15:38:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:40958 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754619AbcIITiA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 15:38:00 -0400
Received: (qmail 2454 invoked by uid 109); 9 Sep 2016 19:37:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Sep 2016 19:37:59 +0000
Received: (qmail 27615 invoked by uid 111); 9 Sep 2016 19:38:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Sep 2016 15:38:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Sep 2016 15:37:56 -0400
Date:   Fri, 9 Sep 2016 15:37:56 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 2/3] diff_flush_patch_id: stop returning error result
Message-ID: <20160909193756.okvgzjiqcr5jo6hf@sigill.intra.peff.net>
References: <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net>
 <20160907220409.oowxymhvkof2xsk5@sigill.intra.peff.net>
 <alpine.DEB.2.20.1609091219350.129229@virtualbox>
 <20160909104007.pwki2ir6et3vvk55@sigill.intra.peff.net>
 <alpine.DEB.2.20.1609091455180.129229@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1609091455180.129229@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 09, 2016 at 02:58:25PM +0200, Johannes Schindelin wrote:

> > Yes, I agree that this is the opposite direction of libification. And I
> > agree that the current message is not very helpful.
> > 
> > But I am not sure that returning the error up the stack will actually
> > help somebody move forward. The reason these are all die() calls in the
> > rest of the diff code is that they are generally indicative of
> > unrecoverable repository corruption. So any advice does not really
> > depend on what operation you are performing; it is always "stop what you
> > are doing immediately, run fsck, and try to get the broken objects from
> > somebody else".
> > 
> > So IMHO, on balance this is not hurting anything.
> 
> Well, you make such a situation even worse than it already is.
> 
> It would be one thing to change the code to actually say "stop what you
> are doing immediately, run `git fsck` and try to get the broken objects
> from somewhere else", *before* saying how to proceed after that.
> 
> But that is not what your patch does.
> 
> What your patch does is to remove *even the possibility* of saying how to
> proceed after getting the repository corruption fixed. And instead of
> saying how the corruption could be fixed, it outputs a terse "cannot read
> files to diff".
> 
> I do not think that is a wise direction.

First, do not blame me for the terse "cannot read files to diff". That
is the current message. And my patch does not make changing that message
any more difficult. You are welcome to change it in its error() form.
You are welcome to change it in the resulting die().

The quality of that message is totally orthogonal to what the patch is
doing.

The _only_ thing it is losing is the ability to for the caller to then
additionally say "once you have finished uncorrupting the repository,
you can resume your operation with ...".

My point is that this is not useful advice. No callers give it, and I
don't foresee other callers giving it. My argument above was basically
that it is such an exceptional condition it is not worth worrying about.

-Peff
