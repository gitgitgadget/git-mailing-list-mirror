Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45F981F461
	for <e@80x24.org>; Fri,  6 Sep 2019 17:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395238AbfIFRhJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 13:37:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:42296 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2389271AbfIFRhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 13:37:09 -0400
Received: (qmail 21378 invoked by uid 109); 6 Sep 2019 17:37:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Sep 2019 17:37:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5289 invoked by uid 111); 6 Sep 2019 17:38:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Sep 2019 13:38:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Sep 2019 13:37:07 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 3/3] commit-graph.c: handle corrupt/missing trees
Message-ID: <20190906173707.GF23181@sigill.intra.peff.net>
References: <cover.1567720960.git.me@ttaylorr.com>
 <9fbd965e3892307bb5bb78952f017624fcc0b73a.1567720960.git.me@ttaylorr.com>
 <20190906061919.GA5122@sigill.intra.peff.net>
 <ad34871d-bdc4-5b52-eff4-da03c6be1004@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad34871d-bdc4-5b52-eff4-da03c6be1004@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 06, 2019 at 12:51:56PM -0400, Derrick Stolee wrote:

> > This one in theory benefits lots of other callsites, too, since it means
> > we'll actually return NULL instead of nonsense like "8". But grepping
> > around for calls to this function, I found literally zero of them
> > actually bother checking for a NULL result. So there are probably dozens
> > of similar segfaults waiting to happen in other code paths.
> > Discouraging.
> >
> > This is sort-of attributable to my 834876630b (get_commit_tree(): return
> > NULL for broken tree, 2019-04-09). Before then it was a BUG(). However,
> > that state was relatively short-lived. Before 7b8a21dba1 (commit-graph:
> > lazy-load trees for commits, 2018-04-06), we'd have similarly returned
> > NULL (and anyway, BUG() is clearly wrong since it's a data error).
> > 
> > None of which argues against your patches, but it's kind of sad that the
> > issue is present in so many code paths. I wonder if we could be handling
> > this in a more central way, but I don't see how short of dying.
> 
> This is due to the mechanical conversion from using commit->tree->oid to
> get_commit_tree_oid(commit). Those consumers were not checking if the
> tree pointer was NULL, either, but they probably assumed that the
> parse_commit() call would have failed earlier. Now that we are using this
> method (for performance reasons to avoid creating too many 'struct tree's)
> it makes sense to convert some of them to checking the return value more
> carefully.

Right, none of this is new at all. We have historically been very loose
about assuming that things like commit->tree were valid. And they
_usually_ are. Even if we're missing the object on disk, lookup_tree()
is happy to assign it a struct (unless the object was already seen as
another type!).  I think turning that case into an error from
parse_commit() would cover a lot of cases easily, without forcing each
caller to check for NULL.

-Peff
