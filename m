Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E9A420365
	for <e@80x24.org>; Mon,  2 Oct 2017 05:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750940AbdJBFl3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:41:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:57172 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750763AbdJBFl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:41:29 -0400
Received: (qmail 7166 invoked by uid 109); 2 Oct 2017 05:41:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 05:41:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25845 invoked by uid 111); 2 Oct 2017 05:42:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 01:42:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 01:41:27 -0400
Date:   Mon, 2 Oct 2017 01:41:27 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 05/11] cache-tree: simplify locking logic
Message-ID: <20171002054126.xkvv2zglefxcvbia@sigill.intra.peff.net>
References: <cover.1506862824.git.martin.agren@gmail.com>
 <3475f0eee33ca0c4b2bc928191f0b06576ee29fb.1506862824.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3475f0eee33ca0c4b2bc928191f0b06576ee29fb.1506862824.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 01, 2017 at 04:56:06PM +0200, Martin Ågren wrote:

> After we have taken the lock using `LOCK_DIE_ON_ERROR`, we know that
> `newfd` is non-negative. So when we check for exactly that property
> before calling `write_locked_index()`, the outcome is guaranteed.
> 
> If we write and commit successfully, we set `newfd = -1`, so that we can
> later avoid calling `rollback_lock_file` on an already-committed lock.
> But we might just as well unconditionally call `rollback_lock_file()` --
> it will be a no-op if we have already committed.
> 
> All in all, we use `newfd` as a bool and the only benefit we get from it
> is that we can avoid calling a no-op. Remove `newfd` so that we have one
> variable less to reason about.

Nice, this looks much simpler and the reasoning above is all sound.

I think cmd_checkout_index() has the exact same thing going on.

-Peff
