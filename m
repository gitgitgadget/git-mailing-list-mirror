Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F7CC4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 20:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ADE761104
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 20:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbhHEUsL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 16:48:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:40800 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232591AbhHEUsK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 16:48:10 -0400
Received: (qmail 12805 invoked by uid 109); 5 Aug 2021 20:47:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Aug 2021 20:47:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7466 invoked by uid 111); 5 Aug 2021 20:47:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Aug 2021 16:47:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Aug 2021 16:47:54 -0400
From:   Jeff King <peff@peff.net>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH] diff: drop unused options parameter from
 cmp_in_block_with_wsd()
Message-ID: <YQxOevw7Q+NYX2YF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 8e809cbb2f (diff --color-moved-ws=allow-indentation-change:
simplify and optimize, 2021-07-20) stopped looking at o->emitted_symbols
and instead took the symbol as a parameter, we no longer need to look at
the diff_options struct at all.

Dropping the unused parameter makes it clear that the function is
independent of the diff options.

Signed-off-by: Jeff King <peff@peff.net>
---
Just a small cleanup on top of pw/diff-color-moved-fix, which is now in
'next'. I noticed due to my -Wunused-parameters patches (which one day
I'll finally clean up enough to send to the list).

 diff.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 2956c8f710..164af13b4f 100644
--- a/diff.c
+++ b/diff.c
@@ -863,8 +863,7 @@ static int compute_ws_delta(const struct emitted_diff_symbol *a,
 	return a_width - b_width;
 }
 
-static int cmp_in_block_with_wsd(const struct diff_options *o,
-				 const struct moved_entry *cur,
+static int cmp_in_block_with_wsd(const struct moved_entry *cur,
 				 const struct emitted_diff_symbol *l,
 				 struct moved_block *pmb)
 {
@@ -1016,7 +1015,7 @@ static void pmb_advance_or_null(struct diff_options *o,
 		if (o->color_moved_ws_handling &
 		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
 			match = cur &&
-				!cmp_in_block_with_wsd(o, cur, l, &pmb[i]);
+				!cmp_in_block_with_wsd(cur, l, &pmb[i]);
 		else
 			match = cur && cur->es->id == l->id;
 
-- 
2.33.0.rc0.523.g07fb5e6bbb
