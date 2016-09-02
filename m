Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEBA31F6BF
	for <e@80x24.org>; Fri,  2 Sep 2016 01:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750873AbcIBBJG (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 21:09:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:36920 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750737AbcIBBJF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 21:09:05 -0400
Received: (qmail 13001 invoked by uid 109); 2 Sep 2016 01:09:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Sep 2016 01:09:05 +0000
Received: (qmail 21103 invoked by uid 111); 2 Sep 2016 01:09:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Sep 2016 21:09:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Sep 2016 21:09:01 -0400
Date:   Thu, 1 Sep 2016 21:09:01 -0400
From:   Jeff King <peff@peff.net>
To:     gjarms <gjarms@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: bitmap creation failed
Message-ID: <20160902010900.yvsrwe3tkq3fmvea@sigill.intra.peff.net>
References: <1472753809733-7657450.post@n2.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1472753809733-7657450.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 01, 2016 at 11:16:49AM -0700, gjarms wrote:

> Hi Git Experts,
> 
> We have been exploring various ways to improve git cloning time, one among
> them is using bitmap which is suppose to save time "counting objects".  but
> i have problem creating bitmap since the repository contains 100's of pack
> files. the bitmap file is not created when i use "git gc".
> 
> I have the following entries in my .gitconfig.
> 
> [pack]
>         packSizeLimit = 10m
>         writebitmaps = on
>         writeBitmapHashCache = on
> 
> If i just dont use "packSizeLimit = 10m", then bitmap is created just by
> running git gc
> 
> Can you please make me understand ?, What i understood is that the bitmap is
> created when there is a single pack file, but if i split it into multiple
> pack file, the bitmap generation fails with the warning
> "warning: disabling bitmap writing, as some objects are not being packed".

That's weird. I'd expect it to say:

  disabling bitmap writing, packs are split due to pack.packSizeLimit

At least since v2.8.3, which has 9cea46cdda. Before that it wouldn't
have printed anything, and just silently turned off bitmaps.

The "some objects are not being packed" warning should only come when
want_object_in_pack() says we don't want an object. That's generally
because the object is either found in a shared alternates repository, or
is in a .keep pack. Though in the latter case, unless you've set
repack.packKeptObjects manually, we'll pack it anyway when bitmaps are
in effect (since ee34a2bead, in v2.0.0).

That confusion aside, you almost certainly should not be setting
packSizeLimit, and definitely not to something so low. Git will not
store cross-pack deltas, so you miss out on tons of delta opportunities.
As a result:

  1. Your on-disk repository size will balloon. So you'll have a hundred
     10m packs rather than one 200mb pack.

  2. Your clone times will also grow, as git will try to find new deltas
     between the objects in various packs independently for each clone.

-Peff
