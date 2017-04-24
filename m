Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1846A1FE90
	for <e@80x24.org>; Mon, 24 Apr 2017 11:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1169296AbdDXLtZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 07:49:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:39009 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1169293AbdDXLtX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 07:49:23 -0400
Received: (qmail 25624 invoked by uid 109); 24 Apr 2017 11:49:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Apr 2017 11:49:22 +0000
Received: (qmail 5968 invoked by uid 111); 24 Apr 2017 11:49:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Apr 2017 07:49:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Apr 2017 07:49:20 -0400
Date:   Mon, 24 Apr 2017 07:49:20 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/5] add SWAP macro
Message-ID: <20170424114919.kvgiybj2cm7xecpp@sigill.intra.peff.net>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
 <20170424112928.rty5xejep4mnxph2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170424112928.rty5xejep4mnxph2@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 07:29:28AM -0400, Jeff King wrote:

> A related question is whether the caller should ever be asking to swap
> something with itself. This particular case[1] comes from
> prio_queue_reverse(). I suspect its "<=" could become a "<", but I
> haven't thought it through carefully.

OK, I actually looked closer and we definitely should drop the "<=".  I
was thrown off by the assignment of "j" inside the loop condition. IMHO
it might be more obvious to write as:

  for (i = 0, j = queue->nr - 1; i < j; i++, j--)
	swap(queue, i, j);

but I left it as-is.

So I think this patch is an obvious improvement whatever we do with
SWAP().  There's still an open question of whether SWAP() should be more
careful about its inputs (normally I'd say yes, but I know this is a
potentially performance critical call).

-- >8 --
Subject: [PATCH] prio_queue_reverse: don't swap elements with themselves

Our array-reverse algorithm does the usual "walk from both
ends, swapping elements". We can quit when the two indices
are equal, since:

  1. Swapping an element with itself is a noop.

  2. If i and j are equal, then in the next iteration i is
     guaranteed to be bigge than j, and we will exit the
     loop.

So exiting the loop on equality is slightly more efficient.
And more importantly, the new SWAP() macro does not expect
to handle noop swaps; it will call memcpy() with the same src
and dst pointers in this case. It's unclear whether that
causes a problem on any platforms by violating the
"overlapping memory" constraint of memcpy, but it does cause
valgrind to complain.

Signed-off-by: Jeff King <peff@peff.net>
---
 prio-queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/prio-queue.c b/prio-queue.c
index 17252d231..fc3860fdc 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -21,7 +21,7 @@ void prio_queue_reverse(struct prio_queue *queue)
 
 	if (queue->compare != NULL)
 		die("BUG: prio_queue_reverse() on non-LIFO queue");
-	for (i = 0; i <= (j = (queue->nr - 1) - i); i++)
+	for (i = 0; i < (j = (queue->nr - 1) - i); i++)
 		swap(queue, i, j);
 }
 
-- 
2.13.0.rc0.459.g06dc2b676

