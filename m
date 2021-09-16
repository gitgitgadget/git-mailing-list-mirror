Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5763C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 14:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6BB360238
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 14:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbhIPOLa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 10:11:30 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:46314 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238469AbhIPOL3 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Sep 2021 10:11:29 -0400
Received: from MTA-12-3.privateemail.com (mta-12-1.privateemail.com [198.54.122.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 1963A813FE
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 10:10:05 -0400 (EDT)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
        by mta-12.privateemail.com (Postfix) with ESMTP id E5A2518001AE;
        Thu, 16 Sep 2021 10:10:03 -0400 (EDT)
Received: from hal-station.. (unknown [10.20.151.243])
        by mta-12.privateemail.com (Postfix) with ESMTPA id 706951800186;
        Thu, 16 Sep 2021 10:10:03 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hamza Mahfooz <someguy@effective-light.com>
Subject: [PATCH v5 1/2] grep: refactor next_match() and match_one_pattern() for external use
Date:   Thu, 16 Sep 2021 10:09:42 -0400
Message-Id: <20210916140943.2442184-1-someguy@effective-light.com>
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
the format of "bol" differs in the context that I require to use
match_one_pattern() in and because next_match() doesn't handle the case of
"ctx == GREP_CONTEXT_HEAD" at all. So, teach each function how to handle
the new cases.

Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
v5: separate grep changes from pretty changes.
---
 grep.c | 53 ++++++++++++++++++++++++++++++++++++-----------------
 grep.h |  3 +++
 2 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/grep.c b/grep.c
index 424a39591b..e77c8643d2 100644
--- a/grep.c
+++ b/grep.c
@@ -951,31 +951,38 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 			     enum grep_context ctx,
 			     regmatch_t *pmatch, int eflags)
 {
+	const char *field;
+	size_t len;
 	int hit = 0;
 	int saved_ch = 0;
 	const char *start = bol;
+	const char *end = eol;
 
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
 		switch (p->field) {
 		case GREP_HEADER_AUTHOR:
 		case GREP_HEADER_COMMITTER:
 			saved_ch = strip_timestamp(bol, &eol);
+			if (eol == end)
+				goto again;
 			break;
 		default:
 			break;
 		}
+
+		assert(p->field < ARRAY_SIZE(header_field));
+		field = header_field[p->field].field;
+		len = header_field[p->field].len;
+
+		if (strncmp(bol, field, len))
+			goto restore;
+
+		bol += len;
 	}
 
  again:
@@ -1021,12 +1028,17 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 				goto again;
 		}
 	}
-	if (p->token == GREP_PATTERN_HEAD && saved_ch)
-		*eol = saved_ch;
+
 	if (hit) {
 		pmatch[0].rm_so += bol - start;
 		pmatch[0].rm_eo += bol - start;
 	}
+
+restore:
+	if (p->token == GREP_PATTERN_HEAD && saved_ch)
+		*eol = saved_ch;
+
+
 	return hit;
 }
 
@@ -1159,21 +1171,27 @@ static int match_next_pattern(struct grep_pat *p, char *bol, char *eol,
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
+				if ((field == GREP_HEADER_FIELD_MAX) ||
+				    (p->field == field))
+					hit |= match_next_pattern(p, bol, eol,
+								  ctx, pmatch,
+								  eflags);
 				break;
 			default:
 				break;
@@ -1262,7 +1280,8 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
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
-- 
2.33.0

