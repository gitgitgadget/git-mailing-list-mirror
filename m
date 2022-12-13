Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F50C4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 11:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbiLMLOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 06:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbiLMLO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 06:14:28 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF691145A
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 03:12:59 -0800 (PST)
Received: (qmail 14480 invoked by uid 109); 13 Dec 2022 11:12:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Dec 2022 11:12:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4303 invoked by uid 111); 13 Dec 2022 11:13:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Dec 2022 06:13:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Dec 2022 06:12:58 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/9] ws: drop unused parameter from ws_blank_line()
Message-ID: <Y5heOlU9jlTVb8BE@coredump.intra.peff.net>
References: <Y5hdvpbLpXySHFRz@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5hdvpbLpXySHFRz@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We take a ws_rule parameter, but have never looked at it since the
function was added in 877f23ccb8 (Teach "diff --check" about new blank
lines at end, 2008-06-26). A comment in the function does mention how we
_could_ use it, but nobody has felt the need to do so for over a decade.

We could keep it around as reminder of what could be done, but the
comment serves that purpose. And in the meantime, it triggers
-Wunused-parameter.

So let's drop it, which in turn allows us to drop similar arguments
further up the callstack. I've left the comment intact. It does still
say "ws_rule", but that name is used consistently in the whitespace
code, so the meaning is clear.

Signed-off-by: Jeff King <peff@peff.net>
---
 apply.c |  4 ++--
 cache.h |  2 +-
 diff.c  | 11 +++++------
 ws.c    |  2 +-
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/apply.c b/apply.c
index bc33814313..8582228047 100644
--- a/apply.c
+++ b/apply.c
@@ -2911,11 +2911,11 @@ static int apply_one_fragment(struct apply_state *state,
 			add_line_info(&postimage, "\n", 1, LINE_COMMON);
 			is_blank_context = 1;
 			break;
 		case ' ':
 			if (plen && (ws_rule & WS_BLANK_AT_EOF) &&
-			    ws_blank_line(patch + 1, plen, ws_rule))
+			    ws_blank_line(patch + 1, plen))
 				is_blank_context = 1;
 			/* fallthrough */
 		case '-':
 			memcpy(old, patch + 1, plen);
 			add_line_info(&preimage, old, plen,
@@ -2940,11 +2940,11 @@ static int apply_one_fragment(struct apply_state *state,
 			}
 			add_line_info(&postimage, newlines.buf + start, newlines.len - start,
 				      (first == '+' ? 0 : LINE_COMMON));
 			if (first == '+' &&
 			    (ws_rule & WS_BLANK_AT_EOF) &&
-			    ws_blank_line(patch + 1, plen, ws_rule))
+			    ws_blank_line(patch + 1, plen))
 				added_blank_line = 1;
 			break;
 		case '@': case '\\':
 			/* Ignore it, we already handled it */
 			break;
diff --git a/cache.h b/cache.h
index 07d40b0964..fcf49706ad 100644
--- a/cache.h
+++ b/cache.h
@@ -1863,11 +1863,11 @@ unsigned whitespace_rule(struct index_state *, const char *);
 unsigned parse_whitespace_rule(const char *);
 unsigned ws_check(const char *line, int len, unsigned ws_rule);
 void ws_check_emit(const char *line, int len, unsigned ws_rule, FILE *stream, const char *set, const char *reset, const char *ws);
 char *whitespace_error_string(unsigned ws);
 void ws_fix_copy(struct strbuf *, const char *, int, unsigned, int *);
-int ws_blank_line(const char *line, int len, unsigned ws_rule);
+int ws_blank_line(const char *line, int len);
 #define ws_tab_width(rule)     ((rule) & WS_TAB_WIDTH_MASK)
 
 /* ls-files */
 void overlay_tree_on_index(struct index_state *istate,
 			   const char *tree_name, const char *prefix);
diff --git a/diff.c b/diff.c
index 1054a4b732..74ebe247b4 100644
--- a/diff.c
+++ b/diff.c
@@ -602,11 +602,11 @@ static unsigned long diff_filespec_size(struct repository *r,
 		return 0;
 	diff_populate_filespec(r, one, &dpf_options);
 	return one->size;
 }
 
-static int count_trailing_blank(mmfile_t *mf, unsigned ws_rule)
+static int count_trailing_blank(mmfile_t *mf)
 {
 	char *ptr = mf->ptr;
 	long size = mf->size;
 	int cnt = 0;
 
@@ -620,25 +620,24 @@ static int count_trailing_blank(mmfile_t *mf, unsigned ws_rule)
 	while (mf->ptr < ptr) {
 		char *prev_eol;
 		for (prev_eol = ptr; mf->ptr <= prev_eol; prev_eol--)
 			if (*prev_eol == '\n')
 				break;
-		if (!ws_blank_line(prev_eol + 1, ptr - prev_eol, ws_rule))
+		if (!ws_blank_line(prev_eol + 1, ptr - prev_eol))
 			break;
 		cnt++;
 		ptr = prev_eol - 1;
 	}
 	return cnt;
 }
 
 static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 			       struct emit_callback *ecbdata)
 {
 	int l1, l2, at;
-	unsigned ws_rule = ecbdata->ws_rule;
-	l1 = count_trailing_blank(mf1, ws_rule);
-	l2 = count_trailing_blank(mf2, ws_rule);
+	l1 = count_trailing_blank(mf1);
+	l2 = count_trailing_blank(mf2);
 	if (l2 <= l1) {
 		ecbdata->blank_at_eof_in_preimage = 0;
 		ecbdata->blank_at_eof_in_postimage = 0;
 		return;
 	}
@@ -1581,11 +1580,11 @@ static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line
 	      ecbdata->blank_at_eof_in_preimage &&
 	      ecbdata->blank_at_eof_in_postimage &&
 	      ecbdata->blank_at_eof_in_preimage <= ecbdata->lno_in_preimage &&
 	      ecbdata->blank_at_eof_in_postimage <= ecbdata->lno_in_postimage))
 		return 0;
-	return ws_blank_line(line, len, ecbdata->ws_rule);
+	return ws_blank_line(line, len);
 }
 
 static void emit_add_line(struct emit_callback *ecbdata,
 			  const char *line, int len)
 {
diff --git a/ws.c b/ws.c
index 6e69877f25..46a77bcad6 100644
--- a/ws.c
+++ b/ws.c
@@ -250,11 +250,11 @@ void ws_check_emit(const char *line, int len, unsigned ws_rule,
 unsigned ws_check(const char *line, int len, unsigned ws_rule)
 {
 	return ws_check_emit_1(line, len, ws_rule, NULL, NULL, NULL, NULL);
 }
 
-int ws_blank_line(const char *line, int len, unsigned ws_rule)
+int ws_blank_line(const char *line, int len)
 {
 	/*
 	 * We _might_ want to treat CR differently from other
 	 * whitespace characters when ws_rule has WS_CR_AT_EOL, but
 	 * for now we just use this stupid definition.
-- 
2.39.0.546.g5ea984bc66

