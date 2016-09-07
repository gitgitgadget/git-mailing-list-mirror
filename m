Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CEBE1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 22:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbcIGWIH (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 18:08:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:39713 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750727AbcIGWIG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 18:08:06 -0400
Received: (qmail 29904 invoked by uid 109); 7 Sep 2016 22:08:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 22:08:06 +0000
Received: (qmail 8601 invoked by uid 111); 7 Sep 2016 22:08:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 18:08:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2016 18:08:03 -0400
Date:   Wed, 7 Sep 2016 18:08:03 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH 2/2] patch-ids: skip merge commits
Message-ID: <20160907220803.3cvjkchpmyff7h5f@sigill.intra.peff.net>
References: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net>
 <20160907075425.6jgamuwm66xbklu3@sigill.intra.peff.net>
 <alpine.DEB.2.20.1609071338310.129229@virtualbox>
 <20160907184653.ed5c4oklyywjj2gp@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160907184653.ed5c4oklyywjj2gp@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2016 at 02:46:53PM -0400, Jeff King wrote:

> > With this change, commit_patch_id() will return 0 for merge commits
> > (indicating success) but it will not have touched the sha1! Which means it
> > may very well have all kinds of crap in the sha1 that may, or may not,
> > match another, real patch ID randomly.
> 
> Eek, thanks. Somehow I got it into my head that diff_flush_patch_id()
> below was what added it to the list, but clearly that is not the case.
> Looking at it again, I can't imagine how that is the case.

Ah, I see. I initially was looking at an older git (v2.6.x), in which
commit_patch_id() is a static function inside patch-ids.c, and we do not
do any lazy-load trickery. But note that the patch is still wrong even
there; it should return "-1" from commit_patch_id() to instruct the
caller not to add it to the hash.

Anyway...

> > I would suggest to simply copy the merge commit's SHA-1. It is no patch
> > ID, of course, but collisions are as unlikely as commit name collisions,
> > and it would make the "patch ID" of a merge commit deterministic again.
> 
> I agree that would work, though it does mean carrying extra useless
> entries in the patch_id hash. I'll see how bad it would be to simply
> omit them entirely, but this seems like a good fallback plan.

It's not too hard to do so, but it raises a question of what
"format-patch --base" would want. I've just sent another RFC cc-ing
folks interested in that area.

Thanks again for the review.

-Peff
