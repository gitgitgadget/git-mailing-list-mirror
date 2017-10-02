Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0B2F202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 06:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750878AbdJBGUr (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 02:20:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:57248 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750773AbdJBGUr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 02:20:47 -0400
Received: (qmail 8879 invoked by uid 109); 2 Oct 2017 06:20:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 06:20:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26113 invoked by uid 111); 2 Oct 2017 06:21:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 02:21:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 02:20:45 -0400
Date:   Mon, 2 Oct 2017 02:20:45 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 10/11] read-cache: don't leave dangling pointer in
 `do_write_index()`
Message-ID: <20171002062044.j7xnmmqqiz5tzguu@sigill.intra.peff.net>
References: <cover.1506862824.git.martin.agren@gmail.com>
 <6d36f0a8e3c7b81e8c815782fb67fc69f86f2837.1506862824.git.martin.agren@gmail.com>
 <20171002061529.xaiqccwjrthc74gf@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171002061529.xaiqccwjrthc74gf@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2017 at 02:15:30AM -0400, Jeff King wrote:

> I'm not sure I follow here. It seems like write_locked_index() has three
> outcomes:
> 
>   - if there was an error, the lock is rolled back
> 
>   - if we were successful and the caller asked for CLOSE_LOCK, we remain
>     locked
> 
>   - if we were successful and the caller asked for COMMIT_LOCK, we
>     commit the lock
> 
> It sounds like you are considering the first outcome a bug, but I think
> it is intentional. Without that, every caller of write_locked_index()
> would need to release the lock themselves. That's especially cumbersome
> if they called with COMMIT_LOCK, as they otherwise can assume that
> write_locked_index() has released the lock one way or another.
> 
> So I actually think that just switching to a "struct tempfile **" here
> is a reasonable solution (I'd also be fine with doing this and then
> having do_write_locked_index() rollback the lock itself on error).
> 
> Or am I missing something?

Well, one thing I was certainly missing was reading your patch 11. :)

That fixes the COMMIT_LOCK case. We are still changing the behavior of
CLOSE_LOCK on error, though.  The existing callers all seem to die
immediately so it wouldn't matter either way, but there could in theory
be new ones in topics-in-flight.

The other thing I was missing is that we are absolutely inconsistent
about this "close on error". It only happens for _one_ of the error
returns of do_write_index(), and the others would have left the file
open and not rolled-back.

So in retrospect, I think your approach is the right direction.

-Peff
