Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E492420970
	for <e@80x24.org>; Fri, 14 Apr 2017 19:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754187AbdDNTdp (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 15:33:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:33657 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752447AbdDNTdo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 15:33:44 -0400
Received: (qmail 4384 invoked by uid 109); 14 Apr 2017 19:33:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Apr 2017 19:33:44 +0000
Received: (qmail 3309 invoked by uid 111); 14 Apr 2017 19:34:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Apr 2017 15:34:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Apr 2017 15:33:41 -0400
Date:   Fri, 14 Apr 2017 15:33:41 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        mfick@codeaurora.org, jacob.keller@gmail.com
Subject: Re: [PATCH] repack: respect gc.pid lock
Message-ID: <20170414193341.itr3ybiiu2brt63b@sigill.intra.peff.net>
References: <20170413202712.22192-1-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170413202712.22192-1-dturner@twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 04:27:12PM -0400, David Turner wrote:

> Git gc locks the repository (using a gc.pid file) so that other gcs
> don't run concurrently. Make git repack respect this lock.
> 
> Now repack, by default, will refuse to run at the same time as a gc.
> This fixes a concurrency issue: a repack which deleted packs would
> make a concurrent gc sad when its packs were deleted out from under
> it.  The gc would fail with: "fatal: ./objects/pack/pack-$sha.pack
> cannot be accessed".  Then it would die, probably leaving a large temp
> pack hanging around.
> 
> Git repack learns --no-lock, so that when run under git gc, it doesn't
> attempt to manage the lock itself.

This also means that two repack invocations cannot run simultaneously,
because they want to take the same lock.  But depending on the options,
the two don't necessarily conflict. For example, two simultaneous
incremental "git repack -d" invocations should be able to complete.

Do we know where the error message is coming from? I couldn't find the
error message you've given above; grepping for "cannot be accessed"
shows only error messages that would have "packfile" after the "fatal:".
Is it a copy-paste error?

If that's the case, then it's the one in use_pack(). Do we know what
program/operation is causing the error? Having a simultaneous gc delete
a packfile is _supposed_ to work, through a combination of:

  1. Most sha1-access operations can re-scan the pack directory if they
     find the packfile went away.

  2. The pack-objects run by a simultaneous repack is somewhat special
     in that once it finds and commits to a copy of an object in a pack,
     we need to use exactly that pack, because we record its offset,
     delta representation, etc. Usually this works because we open and
     mmap the packfile before making that commitment, and open packfiles
     are only closed if you run out of file descriptors (which should
     only happen when you have a huge number of packs).

So I'm worried that this repack lock is going to regress some other
cases that run fine together. But I'm also worried that it's a band-aid
over a more subtle problem. If pack-objects is not able to run alongside
a gc, then you're also going to have problems serving fetches, and
obviously you wouldn't want to take a lock there.

-Peff
