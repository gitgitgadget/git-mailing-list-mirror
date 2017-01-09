Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A24220756
	for <e@80x24.org>; Mon,  9 Jan 2017 10:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759150AbdAIK43 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 05:56:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:36944 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754448AbdAIKzt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 05:55:49 -0500
Received: (qmail 3595 invoked by uid 109); 9 Jan 2017 10:55:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Jan 2017 10:55:47 +0000
Received: (qmail 2944 invoked by uid 111); 9 Jan 2017 10:56:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Jan 2017 05:56:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jan 2017 05:55:45 -0500
Date:   Mon, 9 Jan 2017 05:55:45 -0500
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: Preserve/Prune Old Pack Files
Message-ID: <20170109105545.gchfklcuzwhlfbtf@sigill.intra.peff.net>
References: <24abd0ed58c25ce832014f9bd5bb2090@codeaurora.org>
 <5172470.bsscxDU4yv@mfick1-lnx>
 <20170109062137.zghmurndlbts5x44@sigill.intra.peff.net>
 <20170109070119.lite2o7k3t2wuvtt@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170109070119.lite2o7k3t2wuvtt@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 09, 2017 at 04:01:19PM +0900, Mike Hommey wrote:

> > That's _way_ more complicated than your problem, and as I said, I do not
> > have a finished solution. But it seems like they touch on a similar
> > concept (a post-delete holding area for objects). So I thought I'd
> > mention it in case if spurs any brilliance.
> 
> Something that is kind-of in the same family of problems is the
> "loosening" or objects on repacks, before they can be pruned.
> 
> When you have a large repository and do large rewrite operations
> (extreme case, a filter-branch on a multi-hundred-thousands commits),
> and you gc for the first time, git will possibly create a *lot* of loose
> objects, each of which will consume an inode and a file system block. In
> the extreme case, you can end up with git gc filling up multiple extra
> gigabytes on your disk.

I think we're getting pretty far off-field here. :)

Yes, this can be a problem. The repack is smart enough not to write out
objects which would just get pruned immediately, but since the grace
period is 2 weeks, that can include a lot of objects (especially with
history rewriting as you note). It would be possible to write those
loose objects to a "cruft" pack, but there are some management issues
around the cruft pack. You do not want to keep repacking them into a new
cruft pack at each repack, since then they would never expire. So you
need some way of marking the pack as cruft, letting it age out, and then
deleting it after the grace period expires.

I don't think it would be _that_ hard, but AFAIK nobody has ever made
patches.

-Peff
