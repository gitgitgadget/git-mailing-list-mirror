Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2286BC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 22:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 032AE60EB6
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 22:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhJHWvU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 18:51:20 -0400
Received: from mta-05-3.privateemail.com ([68.65.122.15]:32797 "EHLO
        MTA-05-3.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhJHWvT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 18:51:19 -0400
Received: from mta-05.privateemail.com (localhost [127.0.0.1])
        by mta-05.privateemail.com (Postfix) with ESMTP id 45CE71800315;
        Fri,  8 Oct 2021 18:49:23 -0400 (EDT)
Received: from hal-station.. (unknown [10.20.151.238])
        by mta-05.privateemail.com (Postfix) with ESMTPA id C63D5180030E;
        Fri,  8 Oct 2021 18:49:22 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hamza Mahfooz <someguy@effective-light.com>
Subject: [PATCH v12 1/3] grep: refactor next_match() and match_one_pattern() for external use
Date:   Fri,  8 Oct 2021 18:49:16 -0400
Message-Id: <20211008224918.603392-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These changes are made in preparation of, the colorization support for the
"git log" subcommands that, rely on regex functionality (i.e. "--author",
"--committer" and "--grep"). These changes are necessary primarily because
match_one_pattern() expects header lines to be prefixed, however, in
pretty, the prefixes are stripped from the lines because the name-email
pairs need to go through additional parsing, before they can be printed and
because next_match() doesn't handle the case of
"ctx == GREP_CONTEXT_HEAD" at all. So, teach next_match() how to handle the
new case and move match_one_pattern()'s core logic to
headerless_match_one_pattern() while preserving match_one_pattern()'s uses
that depend on the additional processing.

Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
v5: separate grep changes from pretty changes.

v6: rescope some variables.

v7: export header_field[] and allow for subsequent matches on header lines
    in match_one_pattern().

v8: add headerless_match_one_pattern() and move header_field[] back.

v9: get rid of the new check in headerless_match_one_pattern(), move the
    header pattern filtering logic in grep_next_match() and document
    grep_next_match() in grep.h.

v10: add a "magic" comment in grep_next_match() to signify a fall through
     in the switch statement.
---
 grep.c | 79 ++++++++++++++++++++++++++++++++++++----------------------
 grep.h |  9 +++++++
 2 files changed, 58 insertions(+), 30 deletions(-)

diff --git a/grep.c b/grep.c
index 14fe8a0fd2..fe847a0111 100644
--- a/grep.c
+++ b/grep.c
@@ -944,10 +944,10 @@ static struct {
 	{ "reflog ", 7 },
 };
 
-static int match_one_pattern(struct grep_pat *p,
-			     const char *bol, const char *eol,
-			     enum grep_context ctx,
-			     regmatch_t *pmatch, int eflags)
+static int headerless_match_one_pattern(struct grep_pat *p,
+					const char *bol, const char *eol,
+					enum grep_context ctx,
+					regmatch_t *pmatch, int eflags)
 {
 	int hit = 0;
 	const char *start = bol;
@@ -956,25 +956,6 @@ static int match_one_pattern(struct grep_pat *p,
 	    ((p->token == GREP_PATTERN_HEAD) != (ctx == GREP_CONTEXT_HEAD)))
 		return 0;
 
-	if (p->token == GREP_PATTERN_HEAD) {
-		const char *field;
-		size_t len;
-		assert(p->field < ARRAY_SIZE(header_field));
-		field = header_field[p->field].field;
-		len = header_field[p->field].len;
-		if (strncmp(bol, field, len))
-			return 0;
-		bol += len;
-		switch (p->field) {
-		case GREP_HEADER_AUTHOR:
-		case GREP_HEADER_COMMITTER:
-			strip_timestamp(bol, &eol);
-			break;
-		default:
-			break;
-		}
-	}
-
  again:
 	hit = patmatch(p, bol, eol, pmatch, eflags);
 
@@ -1025,6 +1006,36 @@ static int match_one_pattern(struct grep_pat *p,
 	return hit;
 }
 
+static int match_one_pattern(struct grep_pat *p,
+			     const char *bol, const char *eol,
+			     enum grep_context ctx, regmatch_t *pmatch,
+			     int eflags)
+{
+	const char *field;
+	size_t len;
+
+	if (p->token == GREP_PATTERN_HEAD) {
+		assert(p->field < ARRAY_SIZE(header_field));
+		field = header_field[p->field].field;
+		len = header_field[p->field].len;
+		if (strncmp(bol, field, len))
+			return 0;
+		bol += len;
+
+		switch (p->field) {
+		case GREP_HEADER_AUTHOR:
+		case GREP_HEADER_COMMITTER:
+			strip_timestamp(bol, &eol);
+			break;
+		default:
+			break;
+		}
+	}
+
+	return headerless_match_one_pattern(p, bol, eol, ctx, pmatch, eflags);
+}
+
+
 static int match_expr_eval(struct grep_opt *opt, struct grep_expr *x,
 			   const char *bol, const char *eol,
 			   enum grep_context ctx, ssize_t *col,
@@ -1143,7 +1154,7 @@ static int match_next_pattern(struct grep_pat *p,
 {
 	regmatch_t match;
 
-	if (!match_one_pattern(p, bol, eol, ctx, &match, eflags))
+	if (!headerless_match_one_pattern(p, bol, eol, ctx, &match, eflags))
 		return 0;
 	if (match.rm_so < 0 || match.rm_eo < 0)
 		return 0;
@@ -1158,19 +1169,26 @@ static int match_next_pattern(struct grep_pat *p,
 	return 1;
 }
 
-static int next_match(struct grep_opt *opt,
-		      const char *bol, const char *eol,
-		      enum grep_context ctx, regmatch_t *pmatch, int eflags)
+int grep_next_match(struct grep_opt *opt,
+		    const char *bol, const char *eol,
+		    enum grep_context ctx, regmatch_t *pmatch,
+		    enum grep_header_field field, int eflags)
 {
 	struct grep_pat *p;
 	int hit = 0;
 
 	pmatch->rm_so = pmatch->rm_eo = -1;
 	if (bol < eol) {
-		for (p = opt->pattern_list; p; p = p->next) {
+		for (p = ((ctx == GREP_CONTEXT_HEAD)
+			   ? opt->header_list : opt->pattern_list);
+			  p; p = p->next) {
 			switch (p->token) {
-			case GREP_PATTERN: /* atom */
 			case GREP_PATTERN_HEAD:
+				if ((field != GREP_HEADER_FIELD_MAX) &&
+				    (p->field != field))
+					continue;
+				/* fall thru */
+			case GREP_PATTERN: /* atom */
 			case GREP_PATTERN_BODY:
 				hit |= match_next_pattern(p, bol, eol, ctx,
 							  pmatch, eflags);
@@ -1261,7 +1279,8 @@ static void show_line(struct grep_opt *opt,
 			else if (sign == '=')
 				line_color = opt->colors[GREP_COLOR_FUNCTION];
 		}
-		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
+		while (grep_next_match(opt, bol, eol, ctx, &match,
+				       GREP_HEADER_FIELD_MAX, eflags)) {
 			if (match.rm_so == match.rm_eo)
 				break;
 
diff --git a/grep.h b/grep.h
index 3cb8a83ae8..808ad76f0c 100644
--- a/grep.h
+++ b/grep.h
@@ -191,6 +191,15 @@ void compile_grep_patterns(struct grep_opt *opt);
 void free_grep_patterns(struct grep_opt *opt);
 int grep_buffer(struct grep_opt *opt, const char *buf, unsigned long size);
 
+/* The field parameter is only used to filter header patterns
+ * (where appropriate). If filtering isn't desirable
+ * GREP_HEADER_FIELD_MAX should be supplied.
+ */
+int grep_next_match(struct grep_opt *opt,
+		    const char *bol, const char *eol,
+		    enum grep_context ctx, regmatch_t *pmatch,
+		    enum grep_header_field field, int eflags);
+
 struct grep_source {
 	char *name;
 
-- 
2.33.0

