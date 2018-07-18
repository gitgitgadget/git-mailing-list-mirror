Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35DD21F597
	for <e@80x24.org>; Wed, 18 Jul 2018 17:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbeGRSYF (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 14:24:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:51296 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731186AbeGRSYE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 14:24:04 -0400
Received: (qmail 9854 invoked by uid 109); 18 Jul 2018 17:45:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Jul 2018 17:45:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 807 invoked by uid 111); 18 Jul 2018 17:45:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 18 Jul 2018 13:45:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2018 13:45:05 -0400
Date:   Wed, 18 Jul 2018 13:45:05 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitgitgadget@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] repack -ad: prune the list of shallow commits
Message-ID: <20180718174505.GA3084@sigill.intra.peff.net>
References: <pull.9.git.gitgitgadget@gmail.com>
 <b4e01a963fd16f50d12c1f67c6e64bec8b1e9673.1531513093.git.gitgitgadget@gmail.com>
 <20180713203140.GB17670@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1807142351100.75@tvgsbejvaqbjf.bet>
 <20180716173636.GA18636@sigill.intra.peff.net>
 <CACsJy8BV3ii3MkYf6UObsX_JdDbT9ovY_K9dCCeYvQ3FWqnRUQ@mail.gmail.com>
 <20180717194148.GC30594@sigill.intra.peff.net>
 <CACsJy8DW8=FoRyEwAy48S76q0gxQbrS3emHou7QDhHqzwJRu+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DW8=FoRyEwAy48S76q0gxQbrS3emHou7QDhHqzwJRu+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 07:31:40PM +0200, Duy Nguyen wrote:

> > Sort of an aside to the patch under discussion, but I think it may make
> > sense for prune_shallow() to take a callback function for determining
> > whether a commit is reachable.
> >
> > I have an old patch that teaches git-prune to lazily do the reachability
> > check, since in many cases "git repack" will have just packed all of the
> > loose objects. But it just occurred to me that this patch is totally
> > broken with respect to prune_shallow(), because it would not set the
> > SEEN flag (I've literally been running with it for years, which goes to
> > show how often I use the shallow feature).
> >
> > And if we were to have repack do a prune_shallow(), it may want to use a
> > different method than traversing and marking each object SEEN.
> 
> All of this sounds good. The only thing I'd like to do a bit
> differently is to pass the reachable commits in prune_shallow() as a
> commit-slab instead of taking a callback function. I'll refactor this
> code, move prune_shallow() to a separate command prune-shallow and do
> the locking thing.

I think using a slab is much nicer than the current global-struct flags.
But it's not as flexible as a callback, for two reasons:

  - in the lazy case, the caller might not even have loaded the slab
    yet. On the other hand, it might be sufficient to just be broad
    there, and just always pre-populate the slab when
    is_repository_shallow(), before we even call into prune_shallow().
    If we have _any_ entries in the shallow file, we'd need to compute
    reachability.

  - it precludes any optimizations that compute partial reachability.
    Asking "is XYZ reachable" is a much easier question to answer than
    "show me the full reachability graph." At the least, it lets you
    stop the graph traversal early. And with generation numbers, it can
    even avoid traversing down unproductive segments of the graph.

I think it's OK to switch to a slab for now if you don't want to do the
callback thing. But I think a callback is probably long-term the right
thing (and I actually think it may be _less_ work to implement, since
then prune would probably be OK sticking with the global struct flags).

-Peff
