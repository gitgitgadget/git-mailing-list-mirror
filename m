Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82220201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753138AbdF3UyR (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:54:17 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36144 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753045AbdF3Uxa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:53:30 -0400
Received: by mail-pg0-f54.google.com with SMTP id u62so68687607pgb.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z1dr9nWMXFJcjZ9TP6Bd2ZzdN1f07PoLdORIimGvt08=;
        b=pMX+ec0Ma6j4c+CT8moC2i9mSycfjVuK3DvadvCygGy/Y89KHcoG1qjyIzwW5kZu+Y
         EImWoWZP+hf5OCKlYyDbkzIJctgOwyJ6dtc7Asw/jmGXUL8+8jN6V6NZfDigFegQ0VQH
         ji2cJBo9rS4cqq4d0QwZFslbzZb+bJXGAPuO4HPBb8PkdfyesLMAT2n+egJpsEXppB9F
         zSweD1G6ZmKRButpMRntL4EjWLizc29mJ1ZTBA9l//puPADQIyEX0eCnKbMagaEFKy+E
         2nwlQnySELBdbj0UunGyz37ZCD2bpGpjw8L8iRxIZl7XLRAWv0DvZttuteAsf49lpCPO
         x4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z1dr9nWMXFJcjZ9TP6Bd2ZzdN1f07PoLdORIimGvt08=;
        b=ONErNKbl4MDEuM3R5bt7BDxZGOORg29u8h/aBvMTEEHqSBt0zcrsVljZ85PF/ERqA2
         YUg2y8KUIDDwe0/0yJT//NJtUVwgtbR6PxTiOOZ/R7Piw6k4mUxec3OlPLcpdQtGPfN2
         A/gVQIfqLWst1IRxve7KR/TQoKPpGjeyVwlYH1WO6hK68aEaA/6EmftIvO2MUZW4ZSVj
         NuQOVK+RwTGDPb7/Vuph/o2/sKYdPOfdImWHX3res/QQu980I+2itZg8LPimbyYOBTsO
         +GC7oqaBTyEt0/3tibrOZNbnV027zhRxQ8/wtUGnDbcUEURNWUPzcNBtZLkKBNo9d1v4
         QIWw==
X-Gm-Message-State: AKS2vOxqURjoQq4FAgsUMdqUVGwJFaLfI4eVVPw8aQQEfs+feJV4VTPp
        ADjPpWldQGnLyB53bQQ5MQ==
X-Received: by 10.84.231.134 with SMTP id g6mr16334778plk.241.1498856004510;
        Fri, 30 Jun 2017 13:53:24 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id u9sm21187491pfg.127.2017.06.30.13.53.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:53:23 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, simon@ruderich.org
Subject: [PATCHv2 08/25] diff.c: migrate emit_line_checked to use emit_diff_symbol
Date:   Fri, 30 Jun 2017 13:52:53 -0700
Message-Id: <20170630205310.7380-9-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630205310.7380-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
 <20170630205310.7380-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new flags field to emit_diff_symbol, that will be used by
context lines for:
* white space rules that are applicable (The first 12 bits)
  Take a note in cahe.c as well, when this ws rules are extended we have
  to fix the bits in the flags field.
* how the rules are evaluated (actually this double encodes the sign
  of the line, but the code is easier to keep this way, bits 13,14,15)
* if the line a blank line at EOF (bit 16)

The check if new lines need to be marked up as extra lines at the end of
file, is now done unconditionally. That should be ok, as
'new_blank_line_at_eof' has a quick early return.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h |   2 ++
 diff.c  | 116 +++++++++++++++++++++++++++++++++++++++++-----------------------
 diff.h  |   6 ++--
 3 files changed, 80 insertions(+), 44 deletions(-)

diff --git a/cache.h b/cache.h
index 96055c2229..18aabacba5 100644
--- a/cache.h
+++ b/cache.h
@@ -1996,6 +1996,8 @@ void shift_tree_by(const struct object_id *, const struct object_id *, struct ob
 #define WS_TRAILING_SPACE      (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
 #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
 #define WS_TAB_WIDTH_MASK        077
+/* All WS_* -- when extended, adapt diff.c emit_symbol */
+#define WS_RULE_MASK           07777
 extern unsigned whitespace_rule_cfg;
 extern unsigned whitespace_rule(const char *);
 extern unsigned parse_whitespace_rule(const char *);
diff --git a/diff.c b/diff.c
index 488096b757..e5430d56da 100644
--- a/diff.c
+++ b/diff.c
@@ -561,17 +561,54 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_CONTEXT,
+	DIFF_SYMBOL_PLUS,
+	DIFF_SYMBOL_MINUS,
 	DIFF_SYMBOL_NO_LF_EOF,
 	DIFF_SYMBOL_CONTEXT_FRAGINFO,
 	DIFF_SYMBOL_CONTEXT_MARKER,
 	DIFF_SYMBOL_SEPARATOR
 };
+/*
+ * Flags for content lines:
+ * 0..12 are whitespace rules
+ * 13-15 are WSEH_NEW | WSEH_OLD | WSEH_CONTEXT
+ * 16 is marking if the line is blank at EOF
+ */
+#define DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF (1<<16)
+#define DIFF_SYMBOL_CONTENT_WS_MASK (WSEH_NEW | WSEH_OLD | WSEH_CONTEXT | WS_RULE_MASK)
+
+static void emit_line_ws_markup(struct diff_options *o,
+				const char *set, const char *reset,
+				const char *line, int len, char sign,
+				unsigned ws_rule, int blank_at_eof)
+{
+	const char *ws = NULL;
+
+	if (o->ws_error_highlight & ws_rule) {
+		ws = diff_get_color_opt(o, DIFF_WHITESPACE);
+		if (!*ws)
+			ws = NULL;
+	}
+
+	if (!ws)
+		emit_line_0(o, set, reset, sign, line, len);
+	else if (blank_at_eof)
+		/* Blank line at EOF - paint '+' as well */
+		emit_line_0(o, ws, reset, sign, line, len);
+	else {
+		/* Emit just the prefix, then the rest. */
+		emit_line_0(o, set, reset, sign, "", 0);
+		ws_check_emit(line, len, ws_rule,
+			      o->file, set, reset, ws);
+	}
+}
 
 static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
-			     const char *line, int len)
+			     const char *line, int len, unsigned flags)
 {
 	static const char *nneof = " No newline at end of file\n";
-	const char *context, *reset;
+	const char *context, *reset, *set;
 	switch (s) {
 	case DIFF_SYMBOL_NO_LF_EOF:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
@@ -593,6 +630,25 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			diff_line_prefix(o),
 			o->line_termination);
 		break;
+	case DIFF_SYMBOL_CONTEXT:
+		set = diff_get_color_opt(o, DIFF_CONTEXT);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		emit_line_ws_markup(o, set, reset, line, len, ' ',
+				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
+		break;
+	case DIFF_SYMBOL_PLUS:
+		set = diff_get_color_opt(o, DIFF_FILE_NEW);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		emit_line_ws_markup(o, set, reset, line, len, '+',
+				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
+				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
+		break;
+	case DIFF_SYMBOL_MINUS:
+		set = diff_get_color_opt(o, DIFF_FILE_OLD);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		emit_line_ws_markup(o, set, reset, line, len, '-',
+				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -609,57 +665,31 @@ static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line
 	return ws_blank_line(line, len, ecbdata->ws_rule);
 }
 
-static void emit_line_checked(const char *reset,
-			      struct emit_callback *ecbdata,
-			      const char *line, int len,
-			      enum color_diff color,
-			      unsigned ws_error_highlight,
-			      char sign)
-{
-	const char *set = diff_get_color(ecbdata->color_diff, color);
-	const char *ws = NULL;
-
-	if (ecbdata->opt->ws_error_highlight & ws_error_highlight) {
-		ws = diff_get_color(ecbdata->color_diff, DIFF_WHITESPACE);
-		if (!*ws)
-			ws = NULL;
-	}
-
-	if (!ws)
-		emit_line_0(ecbdata->opt, set, reset, sign, line, len);
-	else if (sign == '+' && new_blank_line_at_eof(ecbdata, line, len))
-		/* Blank line at EOF - paint '+' as well */
-		emit_line_0(ecbdata->opt, ws, reset, sign, line, len);
-	else {
-		/* Emit just the prefix, then the rest. */
-		emit_line_0(ecbdata->opt, set, reset, sign, "", 0);
-		ws_check_emit(line, len, ecbdata->ws_rule,
-			      ecbdata->opt->file, set, reset, ws);
-	}
-}
-
 static void emit_add_line(const char *reset,
 			  struct emit_callback *ecbdata,
 			  const char *line, int len)
 {
-	emit_line_checked(reset, ecbdata, line, len,
-			  DIFF_FILE_NEW, WSEH_NEW, '+');
+	unsigned flags = WSEH_NEW | ecbdata->ws_rule;
+	if (new_blank_line_at_eof(ecbdata, line, len))
+		flags |= DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF;
+
+	emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_PLUS, line, len, flags);
 }
 
 static void emit_del_line(const char *reset,
 			  struct emit_callback *ecbdata,
 			  const char *line, int len)
 {
-	emit_line_checked(reset, ecbdata, line, len,
-			  DIFF_FILE_OLD, WSEH_OLD, '-');
+	unsigned flags = WSEH_OLD | ecbdata->ws_rule;
+	emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_MINUS, line, len, flags);
 }
 
 static void emit_context_line(const char *reset,
 			      struct emit_callback *ecbdata,
 			      const char *line, int len)
 {
-	emit_line_checked(reset, ecbdata, line, len,
-			  DIFF_CONTEXT, WSEH_CONTEXT, ' ');
+	unsigned flags = WSEH_CONTEXT | ecbdata->ws_rule;
+	emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_CONTEXT, line, len, flags);
 }
 
 static void emit_hunk_header(struct emit_callback *ecbdata,
@@ -683,7 +713,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	    memcmp(line, atat, 2) ||
 	    !(ep = memmem(line + 2, len - 2, atat, 2))) {
 		emit_diff_symbol(ecbdata->opt,
-				 DIFF_SYMBOL_CONTEXT_MARKER, line, len);
+				 DIFF_SYMBOL_CONTEXT_MARKER, line, len, 0);
 		return;
 	}
 	ep += 2; /* skip over @@ */
@@ -719,7 +749,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	strbuf_add(&msgbuf, line + len, org_len - len);
 	strbuf_complete_line(&msgbuf);
 	emit_diff_symbol(ecbdata->opt,
-			 DIFF_SYMBOL_CONTEXT_FRAGINFO, msgbuf.buf, msgbuf.len);
+			 DIFF_SYMBOL_CONTEXT_FRAGINFO, msgbuf.buf, msgbuf.len, 0);
 	strbuf_release(&msgbuf);
 }
 
@@ -778,7 +808,7 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		data += len;
 	}
 	if (!endp)
-		emit_diff_symbol(ecb->opt, DIFF_SYMBOL_NO_LF_EOF, NULL, 0);
+		emit_diff_symbol(ecb->opt, DIFF_SYMBOL_NO_LF_EOF, NULL, 0, 0);
 }
 
 static void emit_rewrite_diff(const char *name_a,
@@ -4771,6 +4801,10 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 {
 	int i;
 	struct diff_queue_struct *q = &diff_queued_diff;
+
+	if (WSEH_NEW & WS_RULE_MASK)
+		die("BUG: WS rules bit mask overlaps with diff symbol flags");
+
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		if (check_pair_status(p))
@@ -4861,7 +4895,7 @@ void diff_flush(struct diff_options *options)
 
 	if (output_format & DIFF_FORMAT_PATCH) {
 		if (separator) {
-			emit_diff_symbol(options, DIFF_SYMBOL_SEPARATOR, NULL, 0);
+			emit_diff_symbol(options, DIFF_SYMBOL_SEPARATOR, NULL, 0, 0);
 			if (options->stat_sep) {
 				/* attach patch instead of inline */
 				fputs(options->stat_sep, options->file);
diff --git a/diff.h b/diff.h
index 2d442e296f..ea66168454 100644
--- a/diff.h
+++ b/diff.h
@@ -148,9 +148,9 @@ struct diff_options {
 	int abbrev;
 	int ita_invisible_in_index;
 /* white-space error highlighting */
-#define WSEH_NEW 1
-#define WSEH_CONTEXT 2
-#define WSEH_OLD 4
+#define WSEH_NEW (1<<12)
+#define WSEH_CONTEXT (1<<13)
+#define WSEH_OLD (1<<14)
 	unsigned ws_error_highlight;
 	const char *prefix;
 	int prefix_length;
-- 
2.13.0.31.g9b732c453e

