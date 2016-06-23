Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B41472018A
	for <e@80x24.org>; Thu, 23 Jun 2016 17:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbcFWRbr (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 13:31:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:59185 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750979AbcFWRbr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 13:31:47 -0400
Received: (qmail 29831 invoked by uid 102); 23 Jun 2016 17:31:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 13:31:46 -0400
Received: (qmail 12757 invoked by uid 107); 23 Jun 2016 17:32:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 13:32:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 13:31:44 -0400
Date:	Thu, 23 Jun 2016 13:31:44 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Simon Courtois <scourtois@cubyx.fr>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/7] color: fix max-size comment
Message-ID: <20160623173144.GA15774@sigill.intra.peff.net>
References: <20160623173048.GA19923@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160623173048.GA19923@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We use fixed-size buffers for colors, because we know our
parsing cannot grow beyond a particular bound. However, our
comment description has two issues:

  1. It has the description in two forms: a short one, and
     one with more explanation. Over time the latter has
     been updated, but the former has not. Let's just drop
     the short one (after making sure everything it says
     is in the long one).

  2. As of ff40d18 (parse_color: recognize "no$foo" to clear
     the $foo attribute, 2014-11-20), the per-attribute size
     bumped to "3" (because "nobold" is actually "21;"). But
     that's not quite enough, as somebody may use both
     "bold" and "nobold", requiring 5 characters.

     This wasn't a problem for the final count, because we
     over-estimated in other ways, but let's clarify how we
     got to the final number.

Signed-off-by: Jeff King <peff@peff.net>
---
Unchanged from v1.

 color.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/color.h b/color.h
index e155d13..e24fa0b 100644
--- a/color.h
+++ b/color.h
@@ -3,18 +3,20 @@
 
 struct strbuf;
 
-/*  2 + (2 * num_attrs) + 8 + 1 + 8 + 'm' + NUL */
-/* "\033[1;2;4;5;7;38;5;2xx;48;5;2xxm\0" */
 /*
  * The maximum length of ANSI color sequence we would generate:
  * - leading ESC '['            2
- * - attr + ';'                 3 * 10 (e.g. "1;")
+ * - attr + ';'                 2 * num_attr (e.g. "1;")
+ * - no-attr + ';'              3 * num_attr (e.g. "22;")
  * - fg color + ';'             17 (e.g. "38;2;255;255;255;")
  * - bg color + ';'             17 (e.g. "48;2;255;255;255;")
  * - terminating 'm' NUL        2
  *
- * The above overcounts attr (we only use 5 not 8) and one semicolon
- * but it is close enough.
+ * The above overcounts by one semicolon but it is close enough.
+ *
+ * The space for attributes is also slightly overallocated, as
+ * the negation for some attributes is the same (e.g., nobold and nodim).
+ * We also allocate space for 6 attributes (even though we have only 5).
  */
 #define COLOR_MAXLEN 70
 
-- 
2.9.0.209.g845fbc1

