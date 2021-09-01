Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEF9C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 12:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A686760BD3
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 12:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244019AbhIAMRd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 08:17:33 -0400
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:40735 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244028AbhIAMRc (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Sep 2021 08:17:32 -0400
Received: from MTA-15-3.privateemail.com (MTA-15-1.privateemail.com [198.54.118.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id 280A780AFA
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 08:16:34 -0400 (EDT)
Received: from mta-15.privateemail.com (localhost [127.0.0.1])
        by mta-15.privateemail.com (Postfix) with ESMTP id 278B71800190;
        Wed,  1 Sep 2021 08:16:32 -0400 (EDT)
Received: from hal-station.. (unknown [10.20.151.229])
        by mta-15.privateemail.com (Postfix) with ESMTPA id 7AF1F18000A1;
        Wed,  1 Sep 2021 08:16:31 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hamza Mahfooz <someguy@effective-light.com>
Subject: [PATCH] pretty: colorize pattern matches in commit messages
Date:   Wed,  1 Sep 2021 08:16:16 -0400
Message-Id: <20210901121616.2109658-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, for example when

  git log --grep=pattern

is executed, the outputted commits that are matched by the pattern do not
have the relevant substring matches highlighted.

Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
 pretty.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 98 insertions(+), 11 deletions(-)

diff --git a/pretty.c b/pretty.c
index 9631529c10..2886916ae6 100644
--- a/pretty.c
+++ b/pretty.c
@@ -431,15 +431,80 @@ const char *show_ident_date(const struct ident_split *ident,
 	return show_date(date, tz, mode);
 }
 
+static void append_matched_line(struct grep_opt *opt, const char *line,
+				size_t linelen, enum grep_pat_token token,
+				int field, struct strbuf *sb)
+{
+	struct grep_pat *pat;
+	struct strbuf tmp_sb;
+	regmatch_t tmp_match, match;
+	char *buf, *eol, *color;
+	int cflags = 0;
+
+	strbuf_init(&tmp_sb, linelen + 1);
+	strbuf_add(&tmp_sb, line, linelen);
+	buf = tmp_sb.buf;
+	eol = buf + linelen;
+
+	if (!opt || !want_color(opt->color))
+		goto skip;
+
+	color = opt->colors[GREP_COLOR_MATCH_CONTEXT];
+
+	for (;;) {
+		match.rm_so = match.rm_eo = -1;
+
+		for (pat = (token == GREP_PATTERN_HEAD ?
+			    opt->header_list : opt->pattern_list);
+		     pat; pat = pat->next) {
+			if (pat->token == token &&
+			    (field == -1 || pat->field == field) &&
+			    !regexec(&pat->regexp, buf, 1, &tmp_match,
+				     cflags)) {
+
+				if ((match.rm_so >= 0 && match.rm_eo >= 0) &&
+				    (tmp_match.rm_so > match.rm_so ||
+				     (tmp_match.rm_so == match.rm_so &&
+				      tmp_match.rm_eo < match.rm_eo)))
+					continue;
+
+				match.rm_so = tmp_match.rm_so;
+				match.rm_eo = tmp_match.rm_eo;
+			}
+		}
+
+		if (match.rm_so == match.rm_eo)
+			break;
+
+		strbuf_grow(sb, strlen(color) + strlen(GIT_COLOR_RESET));
+		strbuf_add(sb, buf, match.rm_so);
+		strbuf_add(sb, color, strlen(color));
+		strbuf_add(sb, buf + match.rm_so,
+			   match.rm_eo - match.rm_so);
+		strbuf_add(sb, GIT_COLOR_RESET,
+			   strlen(GIT_COLOR_RESET));
+		buf += match.rm_eo;
+		cflags = REG_NOTBOL;
+	}
+
+skip:
+	strbuf_add(sb, buf, eol - buf);
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
+	int field = -1;
+	struct grep_opt *opt = pp->rev ? &pp->rev->grep_filter : NULL;
 
 	if (pp->fmt == CMIT_FMT_ONELINE)
 		return;
@@ -496,9 +561,22 @@ void pp_user_info(struct pretty_print_context *pp,
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
+		append_matched_line(opt, id.buf, id.len,
+				    GREP_PATTERN_HEAD, field, sb);
+		strbuf_addch(sb, '\n');
+		strbuf_release(&id);
 	}
 
 	switch (pp->fmt) {
@@ -1855,6 +1933,7 @@ static void pp_header(struct pretty_print_context *pp,
 	}
 }
 
+
 void pp_title_line(struct pretty_print_context *pp,
 		   const char **msg_p,
 		   struct strbuf *sb,
@@ -1935,8 +2014,8 @@ static int pp_utf8_width(const char *start, const char *end)
 	return width;
 }
 
-static void strbuf_add_tabexpand(struct strbuf *sb, int tabwidth,
-				 const char *line, int linelen)
+static void strbuf_add_tabexpand(struct grep_opt *opt, struct strbuf *sb,
+				 int tabwidth, const char *line, int linelen)
 {
 	const char *tab;
 
@@ -1953,7 +2032,8 @@ static void strbuf_add_tabexpand(struct strbuf *sb, int tabwidth,
 			break;
 
 		/* Output the data .. */
-		strbuf_add(sb, line, tab - line);
+		append_matched_line(opt, line, tab - line, GREP_PATTERN_BODY,
+				    -1, sb);
 
 		/* .. and the de-tabified tab */
 		strbuf_addchars(sb, ' ', tabwidth - (width % tabwidth));
@@ -1968,7 +2048,8 @@ static void strbuf_add_tabexpand(struct strbuf *sb, int tabwidth,
 	 * worrying about width - there's nothing more to
 	 * align.
 	 */
-	strbuf_add(sb, line, linelen);
+	append_matched_line(opt, line, linelen,
+			    GREP_PATTERN_BODY, -1, sb);
 }
 
 /*
@@ -1980,11 +2061,14 @@ static void pp_handle_indent(struct pretty_print_context *pp,
 			     struct strbuf *sb, int indent,
 			     const char *line, int linelen)
 {
+	struct grep_opt *opt = pp->rev ? &pp->rev->grep_filter : NULL;
+
 	strbuf_addchars(sb, ' ', indent);
 	if (pp->expand_tabs_in_log)
-		strbuf_add_tabexpand(sb, pp->expand_tabs_in_log, line, linelen);
+		strbuf_add_tabexpand(opt, sb, pp->expand_tabs_in_log, line, linelen);
 	else
-		strbuf_add(sb, line, linelen);
+		append_matched_line(opt, line, linelen, GREP_PATTERN_BODY, -1,
+				    sb);
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
@@ -2023,14 +2109,15 @@ void pp_remainder(struct pretty_print_context *pp,
 		if (indent)
 			pp_handle_indent(pp, sb, indent, line, linelen);
 		else if (pp->expand_tabs_in_log)
-			strbuf_add_tabexpand(sb, pp->expand_tabs_in_log,
+			strbuf_add_tabexpand(opt, sb, pp->expand_tabs_in_log,
 					     line, linelen);
 		else {
 			if (pp->fmt == CMIT_FMT_MBOXRD &&
 					is_mboxrd_from(line, linelen))
 				strbuf_addch(sb, '>');
 
-			strbuf_add(sb, line, linelen);
+			append_matched_line(opt, line, linelen,
+					    GREP_PATTERN_BODY, -1, sb);
 		}
 		strbuf_addch(sb, '\n');
 	}
-- 
2.33.0

