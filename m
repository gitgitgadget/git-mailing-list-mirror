Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C7701F454
	for <e@80x24.org>; Wed,  6 Nov 2019 21:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732439AbfKFV0B (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 16:26:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:41008 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726779AbfKFV0B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 16:26:01 -0500
Received: (qmail 25187 invoked by uid 109); 6 Nov 2019 21:26:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Nov 2019 21:26:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27358 invoked by uid 111); 6 Nov 2019 21:29:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Nov 2019 16:29:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Nov 2019 16:25:59 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] "fatal: bad object .alternate" during fetch with alternates
Message-ID: <20191106212559.GA8521@sigill.intra.peff.net>
References: <nycvar.QRO.7.76.6.1911041053190.46@tvgsbejvaqbjf.bet>
 <20191106205907.GA4122@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191106205907.GA4122@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 06, 2019 at 03:59:07PM -0500, Jeff King wrote:

> On Wed, Nov 06, 2019 at 08:48:05PM +0100, Johannes Schindelin wrote:
> 
> > Now, I think the two factors that trigger this bug over here are:
> > 
> > - I had all the objects locally already, as I had pushed from a topic
> >   branch to `master` [*1*].
> > 
> > - My worktree's `.git/objects` is connected to an alternate that is
> >   connected to the current Git repository (yes, it is circular, long
> >   story...) and has refs pointing to commits its alternate that have
> >   been gc'ed away.
> 
> I think this second one is the crux of the issue. Your alternate is a
> corrupt repository, and I don't think that's something we ought to be
> worried about supporting in general.

Thinking on this a bit more, the whole thing is a bit subtle.

Imagine what would happen in the fetch or push code paths from before my
patches. We'd tell the other side "hey, I have object X" when in fact we
don't. So we'd end up missing some objects from the transfer.

Before my patches, we'd have done a full connectivity check, with no
regard to the alternate, and complained.

After my patches, we make the assumption that the alternate isn't
corrupt, and trust its refs. So there's an opportunity for corruption in
the alternate to spread to the child repository. We're actually saved
somewhat by the current behavior where rev-list bails on the broken
refs, rather than accepting them at face value. But it wouldn't protect
us from deeper corruptions in the alternate.

I have trouble getting too worked up about that, though. If your
alternate is corrupt, this is only one of many ways that the corruption
can spread to your repository.

However, it would make sense to me that if we can cheaply notice a
corruption in the alternate, that we should avoid it spreading. And
noticing that the object pointed to by a ref is missing is reasonably
cheap (in fact, it's done by most ref iteration; for-each-ref explicitly
uses FILTER_REFS_INCLUDE_BROKEN). So I think the right direction is
probably to teach for-each-ref an "--omit-broken" option, and use that
for enumerating the alternate refs.

That would let us not only notice this corruption, but we'd "route
around" it by avoiding advertising the broken alternate tip in the first
place.

And it would fix your problem, too. In your case it sounds like you're
not working with any of the corrupted objects at all; rather it's just
an unrelated corruption that's causing rev-list to bail.

-Peff
