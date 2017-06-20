Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D7C01FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbdFTCsk (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:48:40 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33089 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbdFTCsf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:35 -0400
Received: by mail-pf0-f173.google.com with SMTP id 83so62783122pfr.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LDKZwMXWmRcG4qiazk6tlXC84JeJfkdw/Rjsi3wpPro=;
        b=aXDy6daDvRPA+xgUgMQ9DQkGkkzVF+WyjcaF2JN1bqgqvQBphaaHG1gNeurNjaHswg
         LW8QPUpo7TLf7LRzLj7IVyKnrRTYB8KgYiF+C4AUxHnv5bahXVwKLlQ+IgsE23fB/NNQ
         j17Tk2LVQIjSn7ayQFviAqnpY6Zq7V+f0WcxDaPVt9s/nmX+Qy4rKIgvXovghaKotXfz
         yoLpkZ/PG/8fll12gus1GzMrNfniqfeUuq2WWrz+iUaI3E6sIoV1n46l8gbhVOE9jYP0
         6T0JPc/GVJEv/KcpR5FW5Pj84lqnr9JKrnx5YLMWlMK3rnUd5T5KnpF1opNHyuxCLtI0
         HjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LDKZwMXWmRcG4qiazk6tlXC84JeJfkdw/Rjsi3wpPro=;
        b=uOw8Wf0N/Fps9xgnN50iEPvGfMzAyqUGE/pEbGxvN+5BpO7aPY/l92xjiJRjj7wj/q
         RJVnpBptWPfZP6zjoUD/lVm+ApM4S3P1+64sgMuerTMCGRYIvnWfRgjJziOGtvmOAQGZ
         8EQFm9c7StlP5zY8NQZPVmeMp7Ab2UFlv94RXHy4lo7Jb4S59AVDG5B+Vm8rhsVHpcj0
         zsXLZUfQ7W89HcxZAmq3YuO9n8z3v9MzqR7QcdDQy35vYLkGZGePgoQNy67kYhY4Hz0S
         5KdIzCAudculpiBknmD8GlDIZXnP6odOKLHTo1jRADORfgDwjNwU99GVXmmPbqR0yiXT
         rR8g==
X-Gm-Message-State: AKS2vOxHQpr+MCygKa6UDI6EuMSflUL3h1xPUHiSZ6oqq+CqqLGdzox9
        reG11al32HM356jX
X-Received: by 10.101.73.193 with SMTP id t1mr28652521pgs.115.1497926914591;
        Mon, 19 Jun 2017 19:48:34 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id 204sm22988735pfu.23.2017.06.19.19.48.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:34 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 08/26] diff.c: migrate emit_line_checked to use emit_diff_symbol
Date:   Mon, 19 Jun 2017 19:47:58 -0700
Message-Id: <20170620024816.20021-9-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170620024816.20021-1-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new flags field to emit_diff_symbol, that will be used by
context lines for:
* white space rules that are applicable (The first 12 bits)
* how the rules are evaluated (actually this double encodes the sign
  of the line, but the code is easier to keep this way, bits 13,14,15)
* if the line a blank line at EOF (bit 16)


Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h |   1 +
 diff.c  | 112 ++++++++++++++++++++++++++++++++++++++++------------------------
 diff.h  |   6 ++--
 3 files changed, 75 insertions(+), 44 deletions(-)

diff --git a/cache.h b/cache.h
index e1f0e182ad..4d63c44f07 100644
--- a/cache.h
+++ b/cache.h
@@ -2168,6 +2168,7 @@ void shift_tree_by(const struct object_id *, const struct object_id *, struct ob
 #define WS_TRAILING_SPACE      (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
 #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
 #define WS_TAB_WIDTH_MASK        077
+#define WS_RULE_MASK           07777
 extern unsigned whitespace_rule_cfg;
 extern unsigned whitespace_rule(const char *);
 extern unsigned parse_whitespace_rule(const char *);
diff --git a/diff.c b/diff.c
index 28be3226c2..42c9f48dc2 100644
--- a/diff.c
+++ b/diff.c
@@ -564,13 +564,50 @@ enum diff_symbol {
 	DIFF_SYMBOL_CONTEXT_MARKER,
 	DIFF_SYMBOL_CONTEXT_FRAGINFO,
 	DIFF_SYMBOL_NO_LF_EOF,
+	DIFF_SYMBOL_CONTEXT,
+	DIFF_SYMBOL_PLUS,
+	DIFF_SYMBOL_MINUS,
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
 	case DIFF_SYMBOL_SEPARATOR:
 		fprintf(o->file, "%s%c",
@@ -592,6 +629,25 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 		emit_line_0(o, context, reset, '\\',
 			    nneof, strlen(nneof));
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
@@ -608,57 +664,31 @@ static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line
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
@@ -682,7 +712,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	    memcmp(line, atat, 2) ||
 	    !(ep = memmem(line + 2, len - 2, atat, 2))) {
 		emit_diff_symbol(ecbdata->opt,
-				 DIFF_SYMBOL_CONTEXT_MARKER, line, len);
+				 DIFF_SYMBOL_CONTEXT_MARKER, line, len, 0);
 		return;
 	}
 	ep += 2; /* skip over @@ */
@@ -718,7 +748,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	strbuf_add(&msgbuf, line + len, org_len - len);
 	strbuf_complete_line(&msgbuf);
 	emit_diff_symbol(ecbdata->opt,
-			 DIFF_SYMBOL_CONTEXT_FRAGINFO, msgbuf.buf, msgbuf.len);
+			 DIFF_SYMBOL_CONTEXT_FRAGINFO, msgbuf.buf, msgbuf.len, 0);
 	strbuf_release(&msgbuf);
 }
 
@@ -777,7 +807,7 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		data += len;
 	}
 	if (!endp)
-		emit_diff_symbol(ecb->opt, DIFF_SYMBOL_NO_LF_EOF, NULL, 0);
+		emit_diff_symbol(ecb->opt, DIFF_SYMBOL_NO_LF_EOF, NULL, 0, 0);
 }
 
 static void emit_rewrite_diff(const char *name_a,
@@ -4866,7 +4896,7 @@ void diff_flush(struct diff_options *options)
 
 	if (output_format & DIFF_FORMAT_PATCH) {
 		if (separator) {
-			emit_diff_symbol(options, DIFF_SYMBOL_SEPARATOR, NULL, 0);
+			emit_diff_symbol(options, DIFF_SYMBOL_SEPARATOR, NULL, 0, 0);
 			if (options->stat_sep) {
 				/* attach patch instead of inline */
 				fputs(options->stat_sep, options->file);
diff --git a/diff.h b/diff.h
index 5be1ee77a7..8483ca0991 100644
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
2.12.2.575.gb14f27f917

