Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCA641FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 13:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbcFWNKb (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 09:10:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:59023 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752046AbcFWNKb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 09:10:31 -0400
Received: (qmail 18737 invoked by uid 102); 23 Jun 2016 13:10:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 09:10:30 -0400
Received: (qmail 10339 invoked by uid 107); 23 Jun 2016 13:10:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 09:10:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 09:10:28 -0400
Date:	Thu, 23 Jun 2016 09:10:28 -0400
From:	Jeff King <peff@peff.net>
To:	Simon Courtois <scourtois@cubyx.fr>
Cc:	git@vger.kernel.org
Subject: [PATCH 2/2] color: support "italic" attribute
Message-ID: <20160623131028.GB12653@sigill.intra.peff.net>
References: <20160623130828.GA25209@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160623130828.GA25209@sigill.intra.peff.net>
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
 Documentation/config.txt | 2 +-
 color.c                  | 8 ++++----
 color.h                  | 3 ++-
 t/t4026-color.sh         | 4 ++--
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 58673cf..4b97d8d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -154,7 +154,7 @@ color::
        colors (at most two) and attributes (at most one), separated
        by spaces.  The colors accepted are `normal`, `black`,
        `red`, `green`, `yellow`, `blue`, `magenta`, `cyan` and
-       `white`; the attributes are `bold`, `dim`, `ul`, `blink` and
+       `white`; the attributes are `bold`, `dim`, `italic`, `ul`, `blink` and
        `reverse`.  The first color given is the foreground; the
        second is the background.  The position of the attribute, if
        any, doesn't matter. Attributes may be turned off specifically
diff --git a/color.c b/color.c
index 8f85153..698682c 100644
--- a/color.c
+++ b/color.c
@@ -125,11 +125,11 @@ static int parse_color(struct color *out, const char *name, int len)
 
 static int parse_attr(const char *name, int len)
 {
-	static const int attr_values[] = { 1, 2, 4, 5, 7,
-					   22, 22, 24, 25, 27 };
+	static const int attr_values[] = { 1, 2, 3, 4, 5, 7,
+					   22, 22, 23, 24, 25, 27 };
 	static const char * const attr_names[] = {
-		"bold", "dim", "ul", "blink", "reverse",
-		"nobold", "nodim", "noul", "noblink", "noreverse"
+		"bold", "dim", "italic", "ul", "blink", "reverse",
+		"nobold", "nodim", "noitalic", "noul", "noblink", "noreverse"
 	};
 	int i;
 	for (i = 0; i < ARRAY_SIZE(attr_names); i++) {
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
index 2b32c4f..05625c5 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -56,8 +56,8 @@ test_expect_success 'long color specification' '
 
 test_expect_success 'absurdly long color specification' '
 	color \
-	  "#ffffff #ffffff bold nobold dim nodim ul noul blink noblink reverse noreverse" \
-	  "[1;2;4;5;7;22;24;25;27;38;2;255;255;255;48;2;255;255;255m"
+	  "#ffffff #ffffff bold nobold dim nodim italic noitalic ul noul blink noblink reverse noreverse" \
+	  "[1;2;3;4;5;7;22;23;24;25;27;38;2;255;255;255;48;2;255;255;255m"
 '
 
 test_expect_success '0-7 are aliases for basic ANSI color names' '
-- 
2.9.0.209.g845fbc1
