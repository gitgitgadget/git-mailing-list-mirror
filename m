Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BEC61FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 17:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbcFWRiV (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 13:38:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:59207 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751964AbcFWRiU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 13:38:20 -0400
Received: (qmail 30121 invoked by uid 102); 23 Jun 2016 17:38:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 13:38:15 -0400
Received: (qmail 12890 invoked by uid 107); 23 Jun 2016 17:38:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 13:38:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 13:38:13 -0400
Date:	Thu, 23 Jun 2016 13:38:13 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Simon Courtois <scourtois@cubyx.fr>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/7] color: refactor parse_attr
Message-ID: <20160623173812.GD15774@sigill.intra.peff.net>
References: <20160623173048.GA19923@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160623173048.GA19923@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The list of attributes we recognize is a bit unwieldy, as we
actually have two arrays that must be kept in sync. Instead,
let's have a single array-of-struct to represent our
mapping. That means we can never have an accident that
causes us to read off the end of an array, and it makes
diffs for adding new attributes much easier to read.

This also makes it easy to handle the "no" cases without
having to repeat each attribute (this shortens the list,
making it easier to read, but also also cuts the size of our
linear search in half). Technically this makes it impossible
for us to add an attribute that starts with "no" (we could
confuse "nobody" for the negation of "body"), but since this
is a constrained set of attributes, that's OK.

Since we can also store the length of each name in the
struct, that makes it easy for us to avoid reading past the
"len" parameter given to us (though in practice it was not a
bug, since all of our current callers are interested in a
subset of a NUL-terminated buffer, not a true undelimited
range of memory).

Signed-off-by: Jeff King <peff@peff.net>
---
 color.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/color.c b/color.c
index 8f85153..d787dec 100644
--- a/color.c
+++ b/color.c
@@ -123,19 +123,30 @@ static int parse_color(struct color *out, const char *name, int len)
 	return -1;
 }
 
-static int parse_attr(const char *name, int len)
+static int parse_attr(const char *name, size_t len)
 {
-	static const int attr_values[] = { 1, 2, 4, 5, 7,
-					   22, 22, 24, 25, 27 };
-	static const char * const attr_names[] = {
-		"bold", "dim", "ul", "blink", "reverse",
-		"nobold", "nodim", "noul", "noblink", "noreverse"
+	static const struct {
+		const char *name;
+		size_t len;
+		int val, neg;
+	} attrs[] = {
+#define ATTR(x, val, neg) { (x), sizeof(x)-1, (val), (neg) }
+		ATTR("bold",      1, 22),
+		ATTR("dim",       2, 22),
+		ATTR("ul",        4, 24),
+		ATTR("blink",     5, 25),
+		ATTR("reverse",   7, 27)
+#undef ATTR
 	};
+	int negate = 0;
 	int i;
-	for (i = 0; i < ARRAY_SIZE(attr_names); i++) {
-		const char *str = attr_names[i];
-		if (!strncasecmp(name, str, len) && !str[len])
-			return attr_values[i];
+
+	if (skip_prefix_mem(name, len, "no", &name, &len))
+		negate = 1;
+
+	for (i = 0; i < ARRAY_SIZE(attrs); i++) {
+		if (attrs[i].len == len && !memcmp(attrs[i].name, name, len))
+			return negate ? attrs[i].neg : attrs[i].val;
 	}
 	return -1;
 }
-- 
2.9.0.209.g845fbc1

