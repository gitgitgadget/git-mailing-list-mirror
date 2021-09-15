Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E751C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 11:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E03D61244
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 11:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhIOLBZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 07:01:25 -0400
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:56361 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232313AbhIOLBV (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Sep 2021 07:01:21 -0400
Received: from MTA-15-3.privateemail.com (MTA-15-1.privateemail.com [198.54.118.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id 638598008A
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 07:00:00 -0400 (EDT)
Received: from mta-15.privateemail.com (localhost [127.0.0.1])
        by mta-15.privateemail.com (Postfix) with ESMTP id 469F118001B0;
        Wed, 15 Sep 2021 06:59:59 -0400 (EDT)
Received: from hal-station.. (unknown [10.20.151.213])
        by mta-15.privateemail.com (Postfix) with ESMTPA id C1CA718001BF;
        Wed, 15 Sep 2021 06:59:58 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hamza Mahfooz <someguy@effective-light.com>
Subject: [PATCH v4] pretty: colorize pattern matches in commit messages
Date:   Wed, 15 Sep 2021 06:59:43 -0400
Message-Id: <20210915105943.650308-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "git log" command limits its output to the commits that contain strings
matched by a pattern when the "--grep=<pattern>" option is used, but unlike
output from "git grep -e <pattern>", the matches are not highlighted,
making them harder to spot.

Teach the pretty-printer code to highlight matches from the
"--grep=<pattern>", "--author=<pattern>" and "--committer=<pattern>"
options (to view the last one, you may have to ask for --pretty=fuller).

Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
v2: make the commit message whole (add the missing ingredients), rename
    append_matched_line() to append_line_with_color(), use
    colors[GREP_COLOR_MATCH_SELECTED] instead of
    colors[GREP_COLOR_MATCH_CONTEXT], allow the background color to be
    customized, don't copy strings to a buffer when not coloring in
    append_line_with_color(), rename next_match() to grep_next_match(),
    repurpose grep_next_match()/match_one_pattern() for use in
    append_line_with_color() (allowing us to remove duplicated matching
    code in append_line_with_color()), document how to customize the
    feature and modify some of the tests to fit the feature better.

v3: fix a formatting issue with the added documentation.

v4: add strbuf_add_with_color(), use the correct color code scheme in the
    unit tests and add more unit tests.
---
 Documentation/git-log.txt |   8 +++
 grep.c                    |  41 +++++++++-----
 grep.h                    |   3 +
 pretty.c                  | 113 ++++++++++++++++++++++++++++++++++----
 t/t4202-log.sh            |  55 +++++++++++++++++++
 5 files changed, 193 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 0498e7bacb..c689f7d235 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -241,6 +241,14 @@ This setting can be disabled by the `--no-notes` option,
 overridden by the `GIT_NOTES_DISPLAY_REF` environment variable,
 and overridden by the `--notes=<ref>` option.
 
+color.grep.selected::
+	Determines the non matching text (background) color of selected lines,
+	when `--grep`, `--author` or `--committer` are used.
+
+color.grep.matchSelected::
+	Determines the matching text (foreground) color of selected lines, when
+	`--grep`, `--author` or `--committer` are used.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/grep.c b/grep.c
index 424a39591b..6b036ee18a 100644
--- a/grep.c
+++ b/grep.c
@@ -956,18 +956,23 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 	const char *start = bol;
 
 	if ((p->token != GREP_PATTERN) &&
-	    ((p->token == GREP_PATTERN_HEAD) != (ctx == GREP_CONTEXT_HEAD)))
+	    ((p->token == GREP_PATTERN_HEAD) != (ctx == GREP_CONTEXT_HEAD)) &&
+	    ((p->token == GREP_PATTERN_BODY) != (ctx == GREP_CONTEXT_BODY)))
 		return 0;
 
 	if (p->token == GREP_PATTERN_HEAD) {
-		const char *field;
-		size_t len;
-		assert(p->field < ARRAY_SIZE(header_field));
-		field = header_field[p->field].field;
-		len = header_field[p->field].len;
-		if (strncmp(bol, field, len))
-			return 0;
-		bol += len;
+		if (!(eflags & REG_NOTBOL)) {
+			const char *field;
+			size_t len;
+
+			assert(p->field < ARRAY_SIZE(header_field));
+			field = header_field[p->field].field;
+			len = header_field[p->field].len;
+			if (strncmp(bol, field, len))
+				return 0;
+			bol += len;
+		}
+
 		switch (p->field) {
 		case GREP_HEADER_AUTHOR:
 		case GREP_HEADER_COMMITTER:
@@ -1159,21 +1164,26 @@ static int match_next_pattern(struct grep_pat *p, char *bol, char *eol,
 	return 1;
 }
 
-static int next_match(struct grep_opt *opt, char *bol, char *eol,
-		      enum grep_context ctx, regmatch_t *pmatch, int eflags)
+int grep_next_match(struct grep_opt *opt, char *bol, char *eol,
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
 			case GREP_PATTERN: /* atom */
 			case GREP_PATTERN_HEAD:
 			case GREP_PATTERN_BODY:
-				hit |= match_next_pattern(p, bol, eol, ctx,
-							  pmatch, eflags);
+				if ((field == GREP_HEADER_FIELD_MAX) || (p->field == field))
+					hit |= match_next_pattern(p, bol, eol,
+								  ctx, pmatch,
+								  eflags);
 				break;
 			default:
 				break;
@@ -1262,7 +1272,8 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 				line_color = opt->colors[GREP_COLOR_FUNCTION];
 		}
 		*eol = '\0';
-		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
+		while (grep_next_match(opt, bol, eol, ctx, &match,
+				       GREP_HEADER_FIELD_MAX, eflags)) {
 			if (match.rm_so == match.rm_eo)
 				break;
 
diff --git a/grep.h b/grep.h
index 72f82b1e30..d2943e29ea 100644
--- a/grep.h
+++ b/grep.h
@@ -177,6 +177,9 @@ void append_header_grep_pattern(struct grep_opt *, enum grep_header_field, const
 void compile_grep_patterns(struct grep_opt *opt);
 void free_grep_patterns(struct grep_opt *opt);
 int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size);
+int grep_next_match(struct grep_opt *opt, char *bol, char *eol,
+		    enum grep_context ctx, regmatch_t *pmatch,
+		    enum grep_header_field field, int eflags);
 
 struct grep_source {
 	char *name;
diff --git a/pretty.c b/pretty.c
index 9631529c10..51f69f86af 100644
--- a/pretty.c
+++ b/pretty.c
@@ -431,15 +431,77 @@ const char *show_ident_date(const struct ident_split *ident,
 	return show_date(date, tz, mode);
 }
 
+static inline void strbuf_add_with_color(struct strbuf *sb, const char *color,
+					 char *buf, size_t buflen)
+{
+	strbuf_add(sb, color, strlen(color));
+	strbuf_add(sb, buf, buflen);
+	if (strlen(color))
+		strbuf_add(sb, GIT_COLOR_RESET, strlen(GIT_COLOR_RESET));
+}
+
+static void append_line_with_color(struct strbuf *sb, struct grep_opt *opt,
+				   const char *line, size_t linelen,
+				   int color, enum grep_context ctx,
+				   enum grep_header_field field)
+{
+	char *buf, *eol;
+	const char *line_color, *match_color;
+	regmatch_t match;
+	struct strbuf tmp_sb;
+	int eflags = 0;
+
+	if (!opt || !want_color(color) || opt->invert) {
+		strbuf_add(sb, line, linelen);
+		return;
+	}
+
+	if (ctx == GREP_CONTEXT_HEAD)
+		eflags = REG_NOTBOL;
+
+	strbuf_init(&tmp_sb, linelen + 1);
+	strbuf_add(&tmp_sb, line, linelen);
+
+	buf = tmp_sb.buf;
+	eol = buf + linelen;
+	line_color = opt->colors[GREP_COLOR_SELECTED];
+	match_color = opt->colors[GREP_COLOR_MATCH_SELECTED];
+
+	while (grep_next_match(opt, buf, eol, ctx, &match, field, eflags)) {
+		if (match.rm_so == match.rm_eo)
+			break;
+
+		strbuf_grow(sb, strlen(line_color) + strlen(match_color) +
+			    (2 * strlen(GIT_COLOR_RESET)));
+		strbuf_add_with_color(sb, line_color, buf, match.rm_so);
+		strbuf_add_with_color(sb, match_color, buf + match.rm_so,
+				      match.rm_eo - match.rm_so);
+		buf += match.rm_eo;
+		eflags = REG_NOTBOL;
+	}
+
+	if (buf != line) {
+		strbuf_grow(sb, strlen(line_color) + strlen(GIT_COLOR_RESET));
+		strbuf_add_with_color(sb, line_color, buf, eol - buf);
+	} else {
+		strbuf_add(sb, buf, eol - buf);
+	}
+
+	strbuf_release(&tmp_sb);
+}
+
 void pp_user_info(struct pretty_print_context *pp,
 		  const char *what, struct strbuf *sb,
 		  const char *line, const char *encoding)
 {
+	struct strbuf id;
 	struct ident_split ident;
 	char *line_end;
 	const char *mailbuf, *namebuf;
 	size_t namelen, maillen;
 	int max_length = 78; /* per rfc2822 */
+	enum grep_header_field field = GREP_HEADER_FIELD_MAX;
+	struct grep_opt *opt = pp->rev ? &pp->rev->grep_filter : NULL;
 
 	if (pp->fmt == CMIT_FMT_ONELINE)
 		return;
@@ -496,9 +558,22 @@ void pp_user_info(struct pretty_print_context *pp,
 			strbuf_addch(sb, '\n');
 		strbuf_addf(sb, " <%.*s>\n", (int)maillen, mailbuf);
 	} else {
-		strbuf_addf(sb, "%s: %.*s%.*s <%.*s>\n", what,
-			    (pp->fmt == CMIT_FMT_FULLER) ? 4 : 0, "    ",
-			    (int)namelen, namebuf, (int)maillen, mailbuf);
+		strbuf_init(&id, namelen + maillen + 4);
+
+		if (!strcmp(what, "Author"))
+			field = GREP_HEADER_AUTHOR;
+		else if (!strcmp(what, "Commit"))
+			field = GREP_HEADER_COMMITTER;
+
+		strbuf_addf(sb, "%s: %.*s", what,
+			    (pp->fmt == CMIT_FMT_FULLER) ? 4 : 0, "    ");
+		strbuf_addf(&id, "%.*s <%.*s>", (int)namelen, namebuf,
+			    (int)maillen, mailbuf);
+
+		append_line_with_color(sb, opt, id.buf, id.len, pp->color,
+				       GREP_CONTEXT_HEAD, field);
+		strbuf_addch(sb, '\n');
+		strbuf_release(&id);
 	}
 
 	switch (pp->fmt) {
@@ -1935,8 +2010,9 @@ static int pp_utf8_width(const char *start, const char *end)
 	return width;
 }
 
-static void strbuf_add_tabexpand(struct strbuf *sb, int tabwidth,
-				 const char *line, int linelen)
+static void strbuf_add_tabexpand(struct strbuf *sb, struct grep_opt *opt,
+				 int color, int tabwidth, const char *line,
+				 int linelen)
 {
 	const char *tab;
 
@@ -1953,7 +2029,9 @@ static void strbuf_add_tabexpand(struct strbuf *sb, int tabwidth,
 			break;
 
 		/* Output the data .. */
-		strbuf_add(sb, line, tab - line);
+		append_line_with_color(sb, opt, line, tab - line, color,
+				       GREP_CONTEXT_BODY,
+				       GREP_HEADER_FIELD_MAX);
 
 		/* .. and the de-tabified tab */
 		strbuf_addchars(sb, ' ', tabwidth - (width % tabwidth));
@@ -1968,7 +2046,8 @@ static void strbuf_add_tabexpand(struct strbuf *sb, int tabwidth,
 	 * worrying about width - there's nothing more to
 	 * align.
 	 */
-	strbuf_add(sb, line, linelen);
+	append_line_with_color(sb, opt, line, linelen, color, GREP_CONTEXT_BODY,
+			       GREP_HEADER_FIELD_MAX);
 }
 
 /*
@@ -1980,11 +2059,16 @@ static void pp_handle_indent(struct pretty_print_context *pp,
 			     struct strbuf *sb, int indent,
 			     const char *line, int linelen)
 {
+	struct grep_opt *opt = pp->rev ? &pp->rev->grep_filter : NULL;
+
 	strbuf_addchars(sb, ' ', indent);
 	if (pp->expand_tabs_in_log)
-		strbuf_add_tabexpand(sb, pp->expand_tabs_in_log, line, linelen);
+		strbuf_add_tabexpand(sb, opt, pp->color, pp->expand_tabs_in_log,
+				     line, linelen);
 	else
-		strbuf_add(sb, line, linelen);
+		append_line_with_color(sb, opt, line, linelen, pp->color,
+				       GREP_CONTEXT_BODY,
+				       GREP_HEADER_FIELD_MAX);
 }
 
 static int is_mboxrd_from(const char *line, int len)
@@ -2002,7 +2086,9 @@ void pp_remainder(struct pretty_print_context *pp,
 		  struct strbuf *sb,
 		  int indent)
 {
+	struct grep_opt *opt = pp->rev ? &pp->rev->grep_filter : NULL;
 	int first = 1;
+
 	for (;;) {
 		const char *line = *msg_p;
 		int linelen = get_one_line(line);
@@ -2023,14 +2109,17 @@ void pp_remainder(struct pretty_print_context *pp,
 		if (indent)
 			pp_handle_indent(pp, sb, indent, line, linelen);
 		else if (pp->expand_tabs_in_log)
-			strbuf_add_tabexpand(sb, pp->expand_tabs_in_log,
-					     line, linelen);
+			strbuf_add_tabexpand(sb, opt, pp->color,
+					     pp->expand_tabs_in_log, line,
+					     linelen);
 		else {
 			if (pp->fmt == CMIT_FMT_MBOXRD &&
 					is_mboxrd_from(line, linelen))
 				strbuf_addch(sb, '>');
 
-			strbuf_add(sb, line, linelen);
+			append_line_with_color(sb, opt, line, linelen,
+					       pp->color, GREP_CONTEXT_BODY,
+					       GREP_HEADER_FIELD_MAX);
 		}
 		strbuf_addch(sb, '\n');
 	}
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 9dfead936b..943c00e338 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -449,6 +449,61 @@ test_expect_success !FAIL_PREREQS 'log with various grep.patternType configurati
 	)
 '
 
+cat > expect << EOF
+Author: <BOLD;RED>A U<RESET> Thor <author@example.com>
+EOF
+
+test_expect_success 'log --author' '
+	git log -1 --color=always --author="A U" >log &&
+	grep Author log >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expect actual
+'
+
+cat > expect << EOF
+Commit:     C O Mitter <committer@<BOLD;RED>example<RESET>.com>
+EOF
+
+test_expect_success 'log --committer' '
+	git log -1 --color=always --pretty=fuller --committer="example" >log &&
+	grep "Commit:" log >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expect actual
+'
+
+cat > expect << EOF
+    <BOLD;RED>Sec<RESET>ond
+    <BOLD;RED>sec<RESET>ond
+EOF
+
+test_expect_success 'log -i --grep with color' '
+	git log --color=always -i --grep=sec >log &&
+	grep -i sec log >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expect actual
+'
+cat > expect << EOF
+    <GREEN>th<RESET><BOLD;RED>ir<RESET><GREEN>d<RESET>
+EOF
+
+test_expect_success '-c color.grep.selected log --grep' '
+	git -c color.grep.selected="green" log --color=always --grep=ir >log &&
+	grep ir log >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expect actual
+'
+
+cat > expect << EOF
+    <BLUE>i<RESET>n<BLUE>i<RESET>t<BLUE>i<RESET>al
+EOF
+
+test_expect_success '-c color.grep.matchSelected log --grep' '
+	git -c color.grep.matchSelected="blue" log --color=always --grep=i >log &&
+	grep al log >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expect actual
+'
+
 cat > expect <<EOF
 * Second
 * sixth
-- 
2.33.0

