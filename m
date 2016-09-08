Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41B291F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 07:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757225AbcIHHao (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 03:30:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:39949 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756112AbcIHHan (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 03:30:43 -0400
Received: (qmail 520 invoked by uid 109); 8 Sep 2016 07:30:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 07:30:21 +0000
Received: (qmail 12073 invoked by uid 111); 8 Sep 2016 07:30:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 03:30:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2016 03:30:19 -0400
Date:   Thu, 8 Sep 2016 03:30:19 -0400
From:   Jeff King <peff@peff.net>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH v2 0/3] patch-id for merges
Message-ID: <20160908073019.jqgocmvjuzwixvdk@sigill.intra.peff.net>
References: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net>
 <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net>
 <20160907225104.f5wi2yo4d2f26tti@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160907225104.f5wi2yo4d2f26tti@x>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2016 at 03:51:04PM -0700, Josh Triplett wrote:

> > This is still marked RFC, because there are really two approaches here,
> > and I'm not sure which one is better for "format-patch --base". I'd like
> > to get input from Xiaolong Ye (who worked on --base), and Josh Triplett
> > (who has proposed some patches in that area, and is presumably using
> > them).
> 
> Thanks.
> 
> I'd love to see a more resilient patch-id mechanism, to make it easier
> to match up patches between branches.  I don't think it makes sense to
> talk about the patch-id of a merge commit (though it might make sense
> for a merge which makes additional changes not present in any of the
> parents).  Even if someone wants to match up merge commits with merge
> commits, I don't think that should happen via patch-id; I think that
> should happen in terms of "what patches does this merge introduce",
> without constructing a merge-patch-id via a Merkle tree of commit
> patch-ids.
> 
> So, I think this patch series makes sense (modulo the comments about the
> commit message in patch 3).  We already don't respect merge commits when
> doing format-patch; this seems consistent with that.  If we ever make it
> possible for format-patch to handle merge commits, then we should also
> allow it to have merge commits as prerequisites.

Thanks for the input. I knew that format-patch doesn't show merge
commits, but I didn't realize that merges were skipped entirely for the
base preparation (but I see it now; there is a "rev.max_parents = 1"
setting in prepare_bases).

So this really doesn't change the output there at all. And in fact, the
switch to:

   if (commit_patch_id(commit, &diffopt, sha1, 0))
  -         die(_("cannot get patch id"))
  +         continue;

should never hit that continue. It could be:

    die("BUG: somehow a merge got fed to commit_patch_id?");

but the "continue" somehow seems like the right thing to me.

I'll wait another day or so for comments and then send the re-roll using
this approach.

-Peff
