Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C3D21F859
	for <e@80x24.org>; Fri,  9 Sep 2016 10:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753511AbcIIKkM (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 06:40:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:40630 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751596AbcIIKkL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 06:40:11 -0400
Received: (qmail 2063 invoked by uid 109); 9 Sep 2016 10:40:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Sep 2016 10:40:10 +0000
Received: (qmail 23208 invoked by uid 111); 9 Sep 2016 10:40:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Sep 2016 06:40:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Sep 2016 06:40:08 -0400
Date:   Fri, 9 Sep 2016 06:40:08 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 2/3] diff_flush_patch_id: stop returning error result
Message-ID: <20160909104007.pwki2ir6et3vvk55@sigill.intra.peff.net>
References: <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net>
 <20160907220409.oowxymhvkof2xsk5@sigill.intra.peff.net>
 <alpine.DEB.2.20.1609091219350.129229@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1609091219350.129229@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 09, 2016 at 12:28:38PM +0200, Johannes Schindelin wrote:

> I like the simplification, but I *hate* the fact that the calling code has
> *no way* to inform the user about the proper next steps.
> 
> You are touching code that is really quite at the bottom of a lot of call
> chains. For example in the one of `git pull --rebase`. I just spent an
> insane amount of time trying to make sure that this command will not
> simply die() somewhere deep in the code, leaving the user puzzled.
> 
> Please see 3be18b4 (t5520: verify that `pull --rebase` shows the helpful
> advice when failing, 2016-07-26) for more details.

Yes, I agree that this is the opposite direction of libification. And I
agree that the current message is not very helpful.

But I am not sure that returning the error up the stack will actually
help somebody move forward. The reason these are all die() calls in the
rest of the diff code is that they are generally indicative of
unrecoverable repository corruption. So any advice does not really
depend on what operation you are performing; it is always "stop what you
are doing immediately, run fsck, and try to get the broken objects from
somebody else".

So IMHO, on balance this is not hurting anything.

> A much better way, in my opinion, would be to introduce a new flag, say,
> skip_merges, and pass that to the diff_flush_patch_id() function. You
> could also consider consolidating that flag with the diff_header_only flag
> into a "flags" argument via something like

diff_flush_patch_id() doesn't care about merges; that's too late. The
change has to happen in commit_patch_id(). And the problem is not one of
passing in "skip merges" (we _always_ want to skip merges). It is rather
distinguishing the reason that commit_patch_id() told us it did not fill
in the sha1: because it was an error, or because the patch id is
undefined (one triggers a die(), the other a silent continue).

I think I laid out that path already in the cover letter of the
original. If the consensus is that this is too ugly, I can implement
that approach.

-Peff
