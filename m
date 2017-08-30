Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E0791F4DD
	for <e@80x24.org>; Wed, 30 Aug 2017 04:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750774AbdH3Ebu (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 00:31:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:52532 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750749AbdH3Ebu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 00:31:50 -0400
Received: (qmail 30708 invoked by uid 109); 30 Aug 2017 04:31:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 30 Aug 2017 04:31:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15783 invoked by uid 111); 30 Aug 2017 04:32:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 30 Aug 2017 00:32:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Aug 2017 00:31:48 -0400
Date:   Wed, 30 Aug 2017 00:31:48 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Brandon Williams <bmwill@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] config: use a static lock_file struct
Message-ID: <20170830043147.culn63luzdsbpuuw@sigill.intra.peff.net>
References: <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com>
 <179AC8FB-5991-4200-9AAC-2F8D0914D5F9@gmail.com>
 <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net>
 <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
 <B1E291F2-86FF-4982-A092-92FAED65385C@gmail.com>
 <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
 <20170829185850.tfmjoa5u5sfuwpgi@sigill.intra.peff.net>
 <20170829190928.GD131745@google.com>
 <20170829191217.dt65wazf7qh5qs3k@sigill.intra.peff.net>
 <01375356-5d39-99af-9e91-35083ed03f42@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01375356-5d39-99af-9e91-35083ed03f42@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2017 at 05:25:18AM +0200, Michael Haggerty wrote:

> >>> In the long run we may want to drop the "tempfiles must remain forever"
> >>> rule. This is certainly not the first time it has caused confusion or
> >>> leaks. And I don't think it's a fundamental issue, just the way the code
> >>> is written. But in the interim, this fix is probably worth doing.
> > 
> > The main issue is that the caller needs to make sure they're removed
> > from the list (via commit or rollback) before being freed.
> > 
> > As far as I know anyway. This restriction dates back to the very early
> > days of the lockfile code and has been carried through the various
> > tempfile-cleanup refactorings over the years (mostly because each was
> > afraid to make functional changes).
> > 
> > +cc Michael, who did most comprehensive cleanup of that code.
> 
> It was surprisingly hard trying to get that code to do the right thing,
> non-racily, in every error path. Since `remove_tempfiles()` can be
> called any time (even from a signal handler), the linked list of
> `tempfile` objects has to be kept valid at all times but can't use
> mutexes. I didn't have the energy to keep going and make the lock
> objects freeable.
> 
> I suppose the task could be made a bit easier by using `sigprocmask(2)`
> or `pthread_sigmask(3)` to make its running environment a little bit
> less hostile.

I think there are really two levels of carefulness here:

  1. Avoiding complicated things during a signal handler that may rely
     on having a sane state from the rest of the program (e.g.,
     half-formed entries, stdio locks, etc).

  2. Being truly race-free in the face of a signal arriving while we're
     running arbitrary code that might have a tempfile struct in a funny
     state.

I feel like right now we meet (1) and not (2). But I think if we keep to
that lower bar of (1), it might not be that bad. We're assuming now that
there's no race on the tempfile->active flag, for instance. We could
probably make a similar assumption about putting items onto or taking
them off of a linked list (it's not really atomic, but a single pointer
assignment is probably "atomic enough" for our purposes).

Or I dunno. There's a lot of "volatile" modifiers sprinkled around.
Maybe those are enough to give us (2) as well (though in that case, I
think we'd still be as OK with the list manipulation as we are with the
active flag manipulation).

-Peff
