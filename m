Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E52C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 03:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E628C611C7
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 03:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhIUDuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:50:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:51424 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231551AbhIUDuO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 23:50:14 -0400
Received: (qmail 3414 invoked by uid 109); 21 Sep 2021 03:48:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 03:48:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27563 invoked by uid 111); 21 Sep 2021 03:48:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Sep 2021 23:48:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Sep 2021 23:48:44 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Hamza Mahfooz <someguy@effective-light.com>
Subject: [PATCH 3/5] grep: stop modifying buffer in grep_source_1()
Message-ID: <YUlWHASpQDJehiZH@coredump.intra.peff.net>
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We find the end of each matching line of a buffer, and then temporarily
write a NUL to turn it into a regular C string. But we don't need to do
so, because the only thing we do in the interim is pass the line and its
length (via an "eol" pointer) to match_line(). And that function should
only look at the bytes we passed it, whether it has a terminating NUL or
not.

We can drop this temporary write in order to simplify the code and make
it easier to use const buffers in more of grep.c.

Signed-off-by: Jeff King <peff@peff.net>
---
 grep.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index 70af01d1c1..32c4641443 100644
--- a/grep.c
+++ b/grep.c
@@ -1616,7 +1616,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 	bol = gs->buf;
 	left = gs->size;
 	while (left) {
-		char *eol, ch;
+		char *eol;
 		int hit;
 		ssize_t cno;
 		ssize_t col = -1, icol = -1;
@@ -1637,14 +1637,11 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		    && look_ahead(opt, &left, &lno, &bol))
 			break;
 		eol = end_of_line(bol, &left);
-		ch = *eol;
-		*eol = 0;
 
 		if ((ctx == GREP_CONTEXT_HEAD) && (eol == bol))
 			ctx = GREP_CONTEXT_BODY;
 
 		hit = match_line(opt, bol, eol, &col, &icol, ctx, collect_hits);
-		*eol = ch;
 
 		if (collect_hits)
 			goto next_line;
-- 
2.33.0.1023.gc687d0d3c8

