Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0957F20A29
	for <e@80x24.org>; Wed, 20 Sep 2017 19:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751675AbdITTz2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 15:55:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:45054 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751669AbdITTz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 15:55:28 -0400
Received: (qmail 10727 invoked by uid 109); 20 Sep 2017 19:55:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 19:55:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15693 invoked by uid 111); 20 Sep 2017 19:56:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 15:56:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Sep 2017 15:55:25 -0400
Date:   Wed, 20 Sep 2017 15:55:25 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] commit: fix memory leak in `prepare_index()`
Message-ID: <20170920195525.3fx5oq7i4arjnun4@sigill.intra.peff.net>
References: <1505936846-2195-1-git-send-email-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1505936846-2195-1-git-send-email-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 20, 2017 at 09:47:23PM +0200, Martin Ågren wrote:

> Release `pathspec` and the string list `partial`.

Makes sense.

> When we clear the string list, make sure we do not free the `util`
> pointers. That would result in double-freeing, since we set them up as
> `item->util = item` in `list_paths()`.

Also makes sense (and is kind of weird; it looks like we're just using
it as a magic flag. But that's outside the scope of your patch).

> Initialize the string list early, so that we can always release it. That
> introduces some unnecessary overhead in various code paths, but means
> there is one and only one way out of the function. If we ever accumulate
> more things we need to free, it should be straightforward to do so.

The overhead is fine. It's just writing the struct entries, not
allocating anything. I wondered if the pathspec needed a similar
initialization (since you can't tell just from reading the context), but
no, it's initialized as the first thing in the function.

> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  builtin/commit.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Looks good to me. Thanks.

-Peff
