Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD39DC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 03:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7702611C5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 03:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhIUDvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:51:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:51428 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231735AbhIUDvS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 23:51:18 -0400
Received: (qmail 3420 invoked by uid 109); 21 Sep 2021 03:49:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 03:49:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27574 invoked by uid 111); 21 Sep 2021 03:49:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Sep 2021 23:49:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Sep 2021 23:49:49 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Hamza Mahfooz <someguy@effective-light.com>
Subject: [PATCH 4/5] grep: mark "haystack" buffers as const
Message-ID: <YUlWXRYv1KtZrxZ6@coredump.intra.peff.net>
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we're grepping in a buffer, we don't need to modify it. So we can
take "const char *" buffers, rather than "char *". This can avoid some
awkward casts in our callers, and make our expectations more clear (we
will not take ownership of the memory, nor will we ever write to it).

These spots don't all necessarily have to be converted at the same time,
but some of them are dependent on others, because we pass
pointers-to-pointers in a few cases. And none of this should change any
behavior, since we're just adding "const" qualifiers (and likewise, the
compiler will let us know if we missed any spots). So it's relatively
low-risk to just do this all at once.

Signed-off-by: Jeff King <peff@peff.net>
---
 grep.c | 61 +++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/grep.c b/grep.c
index 32c4641443..9603ac119d 100644
--- a/grep.c
+++ b/grep.c
@@ -867,7 +867,7 @@ void free_grep_patterns(struct grep_opt *opt)
 	free_pattern_expr(opt->pattern_expression);
 }
 
-static char *end_of_line(char *cp, unsigned long *left)
+static const char *end_of_line(const char *cp, unsigned long *left)
 {
 	unsigned long l = *left;
 	while (l && *cp != '\n') {
@@ -908,7 +908,8 @@ static void show_name(struct grep_opt *opt, const char *name)
 	opt->output(opt, opt->null_following_name ? "\0" : "\n", 1);
 }
 
-static int patmatch(struct grep_pat *p, char *line, char *eol,
+static int patmatch(struct grep_pat *p,
+		    const char *line, const char *eol,
 		    regmatch_t *match, int eflags)
 {
 	int hit;
@@ -922,9 +923,9 @@ static int patmatch(struct grep_pat *p, char *line, char *eol,
 	return hit;
 }
 
-static void strip_timestamp(char *bol, char **eol_p)
+static void strip_timestamp(const char *bol, const char **eol_p)
 {
-	char *eol = *eol_p;
+	const char *eol = *eol_p;
 
 	while (bol < --eol) {
 		if (*eol != '>')
@@ -943,7 +944,8 @@ static struct {
 	{ "reflog ", 7 },
 };
 
-static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
+static int match_one_pattern(struct grep_pat *p,
+			     const char *bol, const char *eol,
 			     enum grep_context ctx,
 			     regmatch_t *pmatch, int eflags)
 {
@@ -1023,8 +1025,9 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 	return hit;
 }
 
-static int match_expr_eval(struct grep_opt *opt, struct grep_expr *x, char *bol,
-			   char *eol, enum grep_context ctx, ssize_t *col,
+static int match_expr_eval(struct grep_opt *opt, struct grep_expr *x,
+			   const char *bol, const char *eol,
+			   enum grep_context ctx, ssize_t *col,
 			   ssize_t *icol, int collect_hits)
 {
 	int h = 0;
@@ -1091,15 +1094,17 @@ static int match_expr_eval(struct grep_opt *opt, struct grep_expr *x, char *bol,
 	return h;
 }
 
-static int match_expr(struct grep_opt *opt, char *bol, char *eol,
+static int match_expr(struct grep_opt *opt,
+		      const char *bol, const char *eol,
 		      enum grep_context ctx, ssize_t *col,
 		      ssize_t *icol, int collect_hits)
 {
 	struct grep_expr *x = opt->pattern_expression;
 	return match_expr_eval(opt, x, bol, eol, ctx, col, icol, collect_hits);
 }
 
-static int match_line(struct grep_opt *opt, char *bol, char *eol,
+static int match_line(struct grep_opt *opt,
+		      const char *bol, const char *eol,
 		      ssize_t *col, ssize_t *icol,
 		      enum grep_context ctx, int collect_hits)
 {
@@ -1131,7 +1136,8 @@ static int match_line(struct grep_opt *opt, char *bol, char *eol,
 	return hit;
 }
 
-static int match_next_pattern(struct grep_pat *p, char *bol, char *eol,
+static int match_next_pattern(struct grep_pat *p,
+			      const char *bol, const char *eol,
 			      enum grep_context ctx,
 			      regmatch_t *pmatch, int eflags)
 {
@@ -1152,7 +1158,8 @@ static int match_next_pattern(struct grep_pat *p, char *bol, char *eol,
 	return 1;
 }
 
-static int next_match(struct grep_opt *opt, char *bol, char *eol,
+static int next_match(struct grep_opt *opt,
+		      const char *bol, const char *eol,
 		      enum grep_context ctx, regmatch_t *pmatch, int eflags)
 {
 	struct grep_pat *p;
@@ -1208,7 +1215,8 @@ static void show_line_header(struct grep_opt *opt, const char *name,
 	}
 }
 
-static void show_line(struct grep_opt *opt, char *bol, char *eol,
+static void show_line(struct grep_opt *opt,
+		      const char *bol, const char *eol,
 		      const char *name, unsigned lno, ssize_t cno, char sign)
 {
 	int rest = eol - bol;
@@ -1297,7 +1305,8 @@ static inline void grep_attr_unlock(void)
 		pthread_mutex_unlock(&grep_attr_mutex);
 }
 
-static int match_funcname(struct grep_opt *opt, struct grep_source *gs, char *bol, char *eol)
+static int match_funcname(struct grep_opt *opt, struct grep_source *gs,
+			  const char *bol, const char *eol)
 {
 	xdemitconf_t *xecfg = opt->priv;
 	if (xecfg && !xecfg->find_func) {
@@ -1324,10 +1333,10 @@ static int match_funcname(struct grep_opt *opt, struct grep_source *gs, char *bo
 }
 
 static void show_funcname_line(struct grep_opt *opt, struct grep_source *gs,
-			       char *bol, unsigned lno)
+			       const char *bol, unsigned lno)
 {
 	while (bol > gs->buf) {
-		char *eol = --bol;
+		const char *eol = --bol;
 
 		while (bol > gs->buf && bol[-1] != '\n')
 			bol--;
@@ -1346,7 +1355,7 @@ static void show_funcname_line(struct grep_opt *opt, struct grep_source *gs,
 static int is_empty_line(const char *bol, const char *eol);
 
 static void show_pre_context(struct grep_opt *opt, struct grep_source *gs,
-			     char *bol, char *end, unsigned lno)
+			     const char *bol, const char *end, unsigned lno)
 {
 	unsigned cur = lno, from = 1, funcname_lno = 0, orig_from;
 	int funcname_needed = !!opt->funcname, comment_needed = 0;
@@ -1366,8 +1375,8 @@ static void show_pre_context(struct grep_opt *opt, struct grep_source *gs,
 
 	/* Rewind. */
 	while (bol > gs->buf && cur > from) {
-		char *next_bol = bol;
-		char *eol = --bol;
+		const char *next_bol = bol;
+		const char *eol = --bol;
 
 		while (bol > gs->buf && bol[-1] != '\n')
 			bol--;
@@ -1398,7 +1407,7 @@ static void show_pre_context(struct grep_opt *opt, struct grep_source *gs,
 
 	/* Back forward. */
 	while (cur < lno) {
-		char *eol = bol, sign = (cur == funcname_lno) ? '=' : '-';
+		const char *eol = bol, sign = (cur == funcname_lno) ? '=' : '-';
 
 		while (*eol != '\n')
 			eol++;
@@ -1426,12 +1435,12 @@ static int should_lookahead(struct grep_opt *opt)
 static int look_ahead(struct grep_opt *opt,
 		      unsigned long *left_p,
 		      unsigned *lno_p,
-		      char **bol_p)
+		      const char **bol_p)
 {
 	unsigned lno = *lno_p;
-	char *bol = *bol_p;
+	const char *bol = *bol_p;
 	struct grep_pat *p;
-	char *sp, *last_bol;
+	const char *sp, *last_bol;
 	regoff_t earliest = -1;
 
 	for (p = opt->pattern_list; p; p = p->next) {
@@ -1533,8 +1542,8 @@ static int is_empty_line(const char *bol, const char *eol)
 
 static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int collect_hits)
 {
-	char *bol;
-	char *peek_bol = NULL;
+	const char *bol;
+	const char *peek_bol = NULL;
 	unsigned long left;
 	unsigned lno = 1;
 	unsigned last_hit = 0;
@@ -1616,7 +1625,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 	bol = gs->buf;
 	left = gs->size;
 	while (left) {
-		char *eol;
+		const char *eol;
 		int hit;
 		ssize_t cno;
 		ssize_t col = -1, icol = -1;
@@ -1700,7 +1709,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		}
 		if (show_function && (!peek_bol || peek_bol < bol)) {
 			unsigned long peek_left = left;
-			char *peek_eol = eol;
+			const char *peek_eol = eol;
 
 			/*
 			 * Trailing empty lines are not interesting.
-- 
2.33.0.1023.gc687d0d3c8

