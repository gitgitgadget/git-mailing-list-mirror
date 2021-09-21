Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A3DC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 03:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71347611C5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 03:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhIUDtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:49:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:51420 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231551AbhIUDth (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 23:49:37 -0400
Received: (qmail 3406 invoked by uid 109); 21 Sep 2021 03:48:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 03:48:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27557 invoked by uid 111); 21 Sep 2021 03:48:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Sep 2021 23:48:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Sep 2021 23:48:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Hamza Mahfooz <someguy@effective-light.com>
Subject: [PATCH 2/5] grep: stop modifying buffer in show_line()
Message-ID: <YUlV+RPMHGGfk25d@coredump.intra.peff.net>
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When showing lines via grep (or looking for funcnames), we call
show_line() on a multi-line buffer. It finds the end of line and marks
it with a NUL. However, we don't need to do so, as the resulting line is
only used along with its "eol" marker:

 - we pass both to next_match(), which takes care to look at only the
   bytes we specified

 - we pass the line to output_color() without its matching eol marker.
   However, we do use the "match" struct we got from next_match() to
   tell it how many bytes to look at (which can never exceed the string
   we passed it).

So we can stop setting and restoring this NUL marker. That makes the
code simpler, and will allow us to take a const buffer in a future
patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 grep.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/grep.c b/grep.c
index 5b1f2da4d3..70af01d1c1 100644
--- a/grep.c
+++ b/grep.c
@@ -1239,7 +1239,6 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 	if (opt->color || opt->only_matching) {
 		regmatch_t match;
 		enum grep_context ctx = GREP_CONTEXT_BODY;
-		int ch = *eol;
 		int eflags = 0;
 
 		if (opt->color) {
@@ -1254,7 +1253,6 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 			else if (sign == '=')
 				line_color = opt->colors[GREP_COLOR_FUNCTION];
 		}
-		*eol = '\0';
 		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
 			if (match.rm_so == match.rm_eo)
 				break;
@@ -1272,7 +1270,6 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 			rest -= match.rm_eo;
 			eflags = REG_NOTBOL;
 		}
-		*eol = ch;
 	}
 	if (!opt->only_matching) {
 		output_color(opt, bol, rest, line_color);
-- 
2.33.0.1023.gc687d0d3c8

