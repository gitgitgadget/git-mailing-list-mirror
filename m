Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A84C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 21:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D96AD60F70
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 21:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbhIUVPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 17:15:05 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:43833 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234412AbhIUVPE (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Sep 2021 17:15:04 -0400
Received: from MTA-10-3.privateemail.com (mta-10-1.privateemail.com [68.65.122.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id AB65281904
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 17:13:31 -0400 (EDT)
Received: from mta-10.privateemail.com (localhost [127.0.0.1])
        by mta-10.privateemail.com (Postfix) with ESMTP id 9708F1800220;
        Tue, 21 Sep 2021 17:13:28 -0400 (EDT)
Received: from hal-station.. (unknown [10.20.151.237])
        by mta-10.privateemail.com (Postfix) with ESMTPA id F265518003F2;
        Tue, 21 Sep 2021 17:13:27 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Hamza Mahfooz <someguy@effective-light.com>
Subject: [PATCH v7 1/2] grep: refactor next_match() and match_one_pattern() for external use
Date:   Tue, 21 Sep 2021 17:13:23 -0400
Message-Id: <20210921211324.1426938-1-someguy@effective-light.com>
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
pairs needs to go through additional parsing, before they can be printed
and because next_match() doesn't handle the case of
"ctx == GREP_CONTEXT_HEAD" at all. So, teach next_match() how to handle the
new case, move header_field[] so it can be used by pretty to reappend
relevant prefixes and teach match_one_pattern() how to handle subsequent
header line match attempts.

Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
v5: separate grep changes from pretty changes.

v6: rescope some variables.

v7: export header_field[] and allow for subsequent matches on header lines
    in match_one_pattern().
---
 grep.c | 53 ++++++++++++++++++++++++++++-------------------------
 grep.h | 13 +++++++++++++
 2 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/grep.c b/grep.c
index 14fe8a0fd2..f4126011c5 100644
--- a/grep.c
+++ b/grep.c
@@ -935,15 +935,6 @@ static void strip_timestamp(const char *bol, const char **eol_p)
 	}
 }
 
-static struct {
-	const char *field;
-	size_t len;
-} header_field[] = {
-	{ "author ", 7 },
-	{ "committer ", 10 },
-	{ "reflog ", 7 },
-};
-
 static int match_one_pattern(struct grep_pat *p,
 			     const char *bol, const char *eol,
 			     enum grep_context ctx,
@@ -953,18 +944,23 @@ static int match_one_pattern(struct grep_pat *p,
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
+			assert(p->field < ARRAY_SIZE(grep_header_fields));
+			field = grep_header_fields[p->field].field;
+			len = grep_header_fields[p->field].len;
+			if (strncmp(bol, field, len))
+				return 0;
+			bol += len;
+		}
+
 		switch (p->field) {
 		case GREP_HEADER_AUTHOR:
 		case GREP_HEADER_COMMITTER:
@@ -1158,22 +1154,28 @@ static int match_next_pattern(struct grep_pat *p,
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
 			case GREP_PATTERN: /* atom */
 			case GREP_PATTERN_HEAD:
 			case GREP_PATTERN_BODY:
-				hit |= match_next_pattern(p, bol, eol, ctx,
-							  pmatch, eflags);
+				if ((field == GREP_HEADER_FIELD_MAX) ||
+				    (p->field == field))
+					hit |= match_next_pattern(p, bol, eol,
+								  ctx, pmatch,
+								  eflags);
 				break;
 			default:
 				break;
@@ -1261,7 +1263,8 @@ static void show_line(struct grep_opt *opt,
 			else if (sign == '=')
 				line_color = opt->colors[GREP_COLOR_FUNCTION];
 		}
-		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
+		while (grep_next_match(opt, bol, eol, ctx, &match,
+				       GREP_HEADER_FIELD_MAX, eflags)) {
 			if (match.rm_so == match.rm_eo)
 				break;
 
diff --git a/grep.h b/grep.h
index 3cb8a83ae8..4847c37280 100644
--- a/grep.h
+++ b/grep.h
@@ -23,6 +23,15 @@ typedef int pcre2_general_context;
 #include "thread-utils.h"
 #include "userdiff.h"
 
+static const struct {
+	const char *field;
+	size_t len;
+} grep_header_fields[] = {
+	{ "author ", 7 },
+	{ "committer ", 10 },
+	{ "reflog ", 7 },
+};
+
 struct repository;
 
 enum grep_pat_token {
@@ -190,6 +199,10 @@ void append_header_grep_pattern(struct grep_opt *, enum grep_header_field, const
 void compile_grep_patterns(struct grep_opt *opt);
 void free_grep_patterns(struct grep_opt *opt);
 int grep_buffer(struct grep_opt *opt, const char *buf, unsigned long size);
+int grep_next_match(struct grep_opt *opt,
+		    const char *bol, const char *eol,
+		    enum grep_context ctx, regmatch_t *pmatch,
+		    enum grep_header_field field, int eflags);
 
 struct grep_source {
 	char *name;
-- 
2.33.0

