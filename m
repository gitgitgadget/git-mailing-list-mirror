Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE900202A5
	for <e@80x24.org>; Sat, 23 Sep 2017 04:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751609AbdIWEff (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 00:35:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:47782 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750738AbdIWEfe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 00:35:34 -0400
Received: (qmail 23789 invoked by uid 109); 23 Sep 2017 04:35:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Sep 2017 04:35:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10870 invoked by uid 111); 23 Sep 2017 04:36:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Sep 2017 00:36:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Sep 2017 00:35:32 -0400
Date:   Sat, 23 Sep 2017 00:35:32 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 6/6] pack-bitmap[-write]: use `object_array_clear()`,
 don't leak
Message-ID: <20170923043532.in6pcrf7roxhfrrq@sigill.intra.peff.net>
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net>
 <cover.1506120291.git.martin.agren@gmail.com>
 <30407fada0ee65ca61e5cc52b1dafc708ab90883.1506120292.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30407fada0ee65ca61e5cc52b1dafc708ab90883.1506120292.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 23, 2017 at 01:34:54AM +0200, Martin Ågren wrote:

> Instead of setting the fields of rev->pending to 0/NULL, thereby leaking
> memory, call `object_array_clear(&rev->pending)`.

I wondered if these cases might sometimes work on an uninitialized
struct (so setting the fields unconditionally without looking at them
would be the right thing). But nope, they are always initialized by the
revision machinery. So freeing is the right thing.

Like the earlier patch, we'd want to be sure there are no dangling
pointers here to the name/path fields. But I looked over the code and I
feel confident there are not (famous last words...).

> In pack-bitmap.c, we make copies of those fields as `pending_nr` and
> `pending_e`. We never update the aliases and the original fields never
> change, so the aliases are not really needed and just make it harder
> than necessary to understand the code. While we're here, remove the
> aliases to make the code easier to follow.

Agreed. Sometimes aliasing like this helps readability when the original
variable is wordy to access. But I don't think that is the case here.

It _can_ also allow the compiler to optimize harder (e.g., by putting
"pending_nr" into a register, because it's not 100% sure that
revs->pending.nr is unchanged by function calls within the loop). But
unless we know something is a tight loop, I don't think that level of
micro-optimization is worth the readability hit.

> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  pack-bitmap-write.c |  4 +---
>  pack-bitmap.c       | 10 +++-------
>  2 files changed, 4 insertions(+), 10 deletions(-)

Patch itself is as advertised. Looks good.

-Peff
