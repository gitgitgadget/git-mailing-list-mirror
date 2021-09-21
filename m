Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3CFC433FE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08D5961264
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347619AbhIUCV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:21:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:51354 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234537AbhIUBoz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:44:55 -0400
Received: (qmail 2924 invoked by uid 109); 21 Sep 2021 01:43:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 01:43:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26088 invoked by uid 111); 21 Sep 2021 01:43:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Sep 2021 21:43:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Sep 2021 21:43:26 -0400
From:   Jeff King <peff@peff.net>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] grep: mark "haystack" buffers as const
Message-ID: <YUk4vnMQHApY99Lb@coredump.intra.peff.net>
References: <YUk3zwuse56v76ze@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUk3zwuse56v76ze@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we're grepping in a buffer, we don't need to modify it. So we can
take "const char *" buffers, rather than "char *". This can avoid some
awkward casts in our callers.

Signed-off-by: Jeff King <peff@peff.net>
---
This step should be quite safe, because we're not changing any behavior,
and the compiler will alert us if we missed any spots.

There may be further cleanup possible that the compiler doesn't tell us
about (i.e., other callers which have "char *" but could themselves
tighten to "const char *"), since that implicit conversion is OK without
a cast.

 grep.c   | 12 ++++++++----
 grep.h   |  3 ++-
 pretty.c |  6 +++---
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/grep.c b/grep.c
index 3b372ec29d..2cb65d191f 100644
--- a/grep.c
+++ b/grep.c
@@ -908,7 +908,8 @@ static void show_name(struct grep_opt *opt, const char *name)
 	opt->output(opt, opt->null_following_name ? "\0" : "\n", 1);
 }
 
-static int patmatch(struct grep_pat *p, char *line, char *eol,
+static int patmatch(struct grep_pat *p,
+		    const char *line, const char *eol,
 		    regmatch_t *match, int eflags)
 {
 	int hit;
@@ -943,7 +944,8 @@ static struct {
 	{ "reflog ", 7 },
 };
 
-static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
+static int match_one_pattern(struct grep_pat *p,
+			     const char *bol, const char *eol,
 			     enum grep_context ctx,
 			     regmatch_t *pmatch, int eflags)
 {
@@ -1141,7 +1143,8 @@ static int match_line(struct grep_opt *opt, char *bol, char *eol,
 	return hit;
 }
 
-static int match_next_pattern(struct grep_pat *p, char *bol, char *eol,
+static int match_next_pattern(struct grep_pat *p,
+			      const char *bol, const char *eol,
 			      enum grep_context ctx,
 			      regmatch_t *pmatch, int eflags)
 {
@@ -1162,7 +1165,8 @@ static int match_next_pattern(struct grep_pat *p, char *bol, char *eol,
 	return 1;
 }
 
-int grep_next_match(struct grep_opt *opt, char *bol, char *eol,
+int grep_next_match(struct grep_opt *opt,
+		    const char *bol, const char *eol,
 		    enum grep_context ctx, regmatch_t *pmatch,
 		    enum grep_header_field field, int eflags)
 {
diff --git a/grep.h b/grep.h
index b82e5de982..a1880899ba 100644
--- a/grep.h
+++ b/grep.h
@@ -190,7 +190,8 @@ void append_header_grep_pattern(struct grep_opt *, enum grep_header_field, const
 void compile_grep_patterns(struct grep_opt *opt);
 void free_grep_patterns(struct grep_opt *opt);
 int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size);
-int grep_next_match(struct grep_opt *opt, char *bol, char *eol,
+int grep_next_match(struct grep_opt *opt,
+		    const char *bol, const char *eol,
 		    enum grep_context ctx, regmatch_t *pmatch,
 		    enum grep_header_field field, int eflags);
 
diff --git a/pretty.c b/pretty.c
index 943a2d2ee2..be4efd9364 100644
--- a/pretty.c
+++ b/pretty.c
@@ -432,7 +432,7 @@ const char *show_ident_date(const struct ident_split *ident,
 }
 
 static inline void strbuf_add_with_color(struct strbuf *sb, const char *color,
-					 char *buf, size_t buflen)
+					 const char *buf, size_t buflen)
 {
 	strbuf_addstr(sb, color);
 	strbuf_add(sb, buf, buflen);
@@ -445,7 +445,7 @@ static void append_line_with_color(struct strbuf *sb, struct grep_opt *opt,
 				   int color, enum grep_context ctx,
 				   enum grep_header_field field)
 {
-	char *buf, *eol;
+	const char *buf, *eol;
 	const char *line_color, *match_color;
 	regmatch_t match;
 	int eflags = 0;
@@ -455,7 +455,7 @@ static void append_line_with_color(struct strbuf *sb, struct grep_opt *opt,
 		return;
 	}
 
-	buf = (char *)line;
+	buf = line;
 	eol = buf + linelen;
 
 	line_color = opt->colors[GREP_COLOR_SELECTED];
-- 
2.33.0.1023.gc687d0d3c8
