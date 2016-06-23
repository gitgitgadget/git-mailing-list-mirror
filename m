Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61AE62018A
	for <e@80x24.org>; Thu, 23 Jun 2016 17:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbcFWRjL (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 13:39:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:59217 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751372AbcFWRjK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 13:39:10 -0400
Received: (qmail 30194 invoked by uid 102); 23 Jun 2016 17:39:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 13:39:09 -0400
Received: (qmail 12927 invoked by uid 107); 23 Jun 2016 17:39:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 13:39:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 13:39:07 -0400
Date:	Thu, 23 Jun 2016 13:39:07 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Simon Courtois <scourtois@cubyx.fr>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/7] color: support "italic" attribute
Message-ID: <20160623173907.GF15774@sigill.intra.peff.net>
References: <20160623173048.GA19923@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160623173048.GA19923@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We already support bold, underline, and similar attributes.
Let's add italic to the mix.  According to the Wikipedia
page on ANSI colors, this attribute is "not widely
supported", but it does seem to work on my xterm.

We don't have to bump the maximum color size because we were
already over-allocating it (but we do adjust the comment
appropriately).

Requested-by: Simon Courtois <scourtois@cubyx.fr>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt | 9 +++++----
 color.c                  | 1 +
 color.h                  | 3 ++-
 t/t4026-color.sh         | 5 +++--
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4b13c90..c7818ff 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -163,10 +163,11 @@ Colors may also be given as numbers between 0 and 255; these use ANSI
 your terminal supports it, you may also specify 24-bit RGB values as
 hex, like `#ff0ab3`.
 +
-The accepted attributes are `bold`, `dim`, `ul`, `blink`, and `reverse`.
-The position of any attributes with respect to the colors (before, after,
-or in between), doesn't matter. Specific attributes may be turned off
-by prefixing them with `no` or `no-` (e.g., `noreverse`, `no-ul`, etc).
+The accepted attributes are `bold`, `dim`, `ul`, `blink`, `reverse`, and
+`italic`.  The position of any attributes with respect to the colors
+(before, after, or in between), doesn't matter. Specific attributes may
+be turned off by prefixing them with `no` or `no-` (e.g., `noreverse`,
+`no-ul`, etc).
 +
 For git's pre-defined color slots, the attributes are meant to be reset
 at the beginning of each item in the colored output. So setting
diff --git a/color.c b/color.c
index a02a935..dcfaea8 100644
--- a/color.c
+++ b/color.c
@@ -133,6 +133,7 @@ static int parse_attr(const char *name, size_t len)
 #define ATTR(x, val, neg) { (x), strlen(x), (val), (neg) }
 		ATTR("bold",      1, 22),
 		ATTR("dim",       2, 22),
+		ATTR("italic",    3, 23),
 		ATTR("ul",        4, 24),
 		ATTR("blink",     5, 25),
 		ATTR("reverse",   7, 27)
diff --git a/color.h b/color.h
index e24fa0b..3af01a6 100644
--- a/color.h
+++ b/color.h
@@ -16,7 +16,8 @@ struct strbuf;
  *
  * The space for attributes is also slightly overallocated, as
  * the negation for some attributes is the same (e.g., nobold and nodim).
- * We also allocate space for 6 attributes (even though we have only 5).
+ *
+ * We allocate space for 6 attributes.
  */
 #define COLOR_MAXLEN 70
 
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index 2065752..13690f7 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -60,8 +60,9 @@ test_expect_success 'long color specification' '
 
 test_expect_success 'absurdly long color specification' '
 	color \
-	  "#ffffff #ffffff bold nobold dim nodim ul noul blink noblink reverse noreverse" \
-	  "[1;2;4;5;7;22;24;25;27;38;2;255;255;255;48;2;255;255;255m"
+	  "#ffffff #ffffff bold nobold dim nodim italic noitalic
+	   ul noul blink noblink reverse noreverse" \
+	  "[1;2;3;4;5;7;22;23;24;25;27;38;2;255;255;255;48;2;255;255;255m"
 '
 
 test_expect_success '0-7 are aliases for basic ANSI color names' '
-- 
2.9.0.209.g845fbc1

