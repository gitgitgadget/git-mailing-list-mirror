Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DB3E2023D
	for <e@80x24.org>; Tue, 23 May 2017 02:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965595AbdEWClz (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 22:41:55 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33017 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935975AbdEWClH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 22:41:07 -0400
Received: by mail-pf0-f169.google.com with SMTP id e193so99664384pfh.0
        for <git@vger.kernel.org>; Mon, 22 May 2017 19:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kee/cVD05qFVH4qy55ekHGUz1g3yhBlUaC86J3f3x9Q=;
        b=PQ3LeUbJx7oPCrPDxm6SkTJbsst9rp1/ErhK4FNC9LM9lQFikBSlUg83MHnDpZHW5a
         wozk2kp+iOMJctLQQtFSf1xZH12Pb+qZnULiSlLrr6tkL95XeLWskSAGzdGqwcLOVTEW
         n55DZx0YUvDx8z3XlElna8kejCfzijzdi0BNUELFEP0791vKqhWAA7q542I4vvBRtgkR
         882anN7IkR152LC7ScsC0saAM12UmRbHKt4VFH6tZ6Km6vekJpkpeGFGIXHlu0lHoIa6
         mkJKq+hqW4jjpggJEciy+rGYFFFwd9q3FX6pXH/EPkdc2cQoddvYWtqP+8An9R5MkU/B
         SJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kee/cVD05qFVH4qy55ekHGUz1g3yhBlUaC86J3f3x9Q=;
        b=m/AV0EOULQ6bhac5xuFbOje7z70JQwP5ZalREo/S2hgtljrN60xq/G2pK46fUncgI3
         Glgi9kltq26WqCMgY0Zvu6X/pCyxc3LV8+AiLWT0mKTFsDQ1ayr0rmQCNLXH6KfIZAnd
         +9KiTOqIXPj61G3/3Gm7ljImcNGUrNIpqqYvJT4Agav1XnpRB1VB1lQ9Me5leBWpZq4u
         2wwZWEJNgzBHJG9OefmgmG1tZVegih8cZ2ZmMJs4I/tm0yo2RKt8m3phl3lyRHODPl97
         VENkb82LbXS8QgGbLP6StKRew8oIFR2VBQwNiAp2bFOuu6keelhqVdzjwXlNyqKh5BTr
         e78Q==
X-Gm-Message-State: AODbwcCEgnwnqZdf7AEx4wM0nx82IeoU0/fy4eBxvR4Z710qj8bamhw9
        62/PHYQW/ogqL3Ns
X-Received: by 10.99.104.136 with SMTP id d130mr29672675pgc.27.1495507267054;
        Mon, 22 May 2017 19:41:07 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6dc1:8d70:6f8f:1c2a])
        by smtp.gmail.com with ESMTPSA id u194sm32836773pgc.2.2017.05.22.19.41.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 19:41:06 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 04/17] diff: introduce more flexible emit function
Date:   Mon, 22 May 2017 19:40:35 -0700
Message-Id: <20170523024048.16879-5-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170523024048.16879-1-sbeller@google.com>
References: <20170518193746.486-1-sbeller@google.com>
 <20170523024048.16879-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, diff output is written either through the emit_line_0
function or through the FILE * in struct diff_options directly. To
make it easier to teach diff to buffer its output (which will be done
in a subsequent commit), introduce a more flexible emit_line() function.
In this commit, direct usages of emit_line_0() are replaced with
emit_line(); subsequent commits will also replace usages of the
FILE * with emit().

Instead of having a 'first' parameter containing the first character
of a line, have a dedicated 'sign' parameter that is just set when
the first character of the line is part of the actual content, i.e.
' ', '+', '-'.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 76 +++++++++++++++++++++++++++++-------------------------------------
 1 file changed, 33 insertions(+), 43 deletions(-)

diff --git a/diff.c b/diff.c
index 2f9722b382..3569857818 100644
--- a/diff.c
+++ b/diff.c
@@ -516,36 +516,30 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
 }
 
-static void emit_line_0(struct diff_options *o, const char *set, const char *reset,
-			int first, const char *line, int len)
+static void emit_line(struct diff_options *o, const char *set, const char *reset,
+		      int add_line_prefix, int sign, const char *line, int len)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
-	int nofirst;
 	FILE *file = o->file;
 
-	fputs(diff_line_prefix(o), file);
+	if (add_line_prefix)
+		fputs(diff_line_prefix(o), file);
 
-	if (len == 0) {
-		has_trailing_newline = (first == '\n');
-		has_trailing_carriage_return = (!has_trailing_newline &&
-						(first == '\r'));
-		nofirst = has_trailing_newline || has_trailing_carriage_return;
-	} else {
-		has_trailing_newline = (len > 0 && line[len-1] == '\n');
-		if (has_trailing_newline)
-			len--;
-		has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
-		if (has_trailing_carriage_return)
-			len--;
-		nofirst = 0;
-	}
+	has_trailing_newline = (len > 0 && line[len-1] == '\n');
+	if (has_trailing_newline)
+		len--;
+	has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
+	if (has_trailing_carriage_return)
+		len--;
 
-	if (len || !nofirst) {
-		fputs(set, file);
-		if (!nofirst)
-			fputc(first, file);
+	if (len || sign) {
+		if (set)
+			fputs(set, file);
+		if (sign)
+			fputc(sign, file);
 		fwrite(line, len, 1, file);
-		fputs(reset, file);
+		if (reset)
+			fputs(reset, file);
 	}
 	if (has_trailing_carriage_return)
 		fputc('\r', file);
@@ -553,12 +547,6 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 		fputc('\n', file);
 }
 
-static void emit_line(struct diff_options *o, const char *set, const char *reset,
-		      const char *line, int len)
-{
-	emit_line_0(o, set, reset, line[0], line+1, len-1);
-}
-
 static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
 {
 	if (!((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
@@ -587,13 +575,13 @@ static void emit_line_checked(const char *reset,
 	}
 
 	if (!ws)
-		emit_line_0(ecbdata->opt, set, reset, sign, line, len);
+		emit_line(ecbdata->opt, set, reset, 1, sign, line, len);
 	else if (sign == '+' && new_blank_line_at_eof(ecbdata, line, len))
 		/* Blank line at EOF - paint '+' as well */
-		emit_line_0(ecbdata->opt, ws, reset, sign, line, len);
+		emit_line(ecbdata->opt, ws, reset, 1, sign, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(ecbdata->opt, set, reset, sign, "", 0);
+		emit_line(ecbdata->opt, set, reset, 1, sign, "", 0);
 		ws_check_emit(line, len, ecbdata->ws_rule,
 			      ecbdata->opt->file, set, reset, ws);
 	}
@@ -643,7 +631,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	if (len < 10 ||
 	    memcmp(line, atat, 2) ||
 	    !(ep = memmem(line + 2, len - 2, atat, 2))) {
-		emit_line(ecbdata->opt, context, reset, line, len);
+		emit_line(ecbdata->opt, context, reset, 1, 0, line, len);
 		return;
 	}
 	ep += 2; /* skip over @@ */
@@ -679,7 +667,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	strbuf_add(&msgbuf, line + len, org_len - len);
 	strbuf_complete_line(&msgbuf);
 
-	emit_line(ecbdata->opt, "", "", msgbuf.buf, msgbuf.len);
+	emit_line(ecbdata->opt, "", "", 1, 0, msgbuf.buf, msgbuf.len);
 	strbuf_release(&msgbuf);
 }
 
@@ -742,8 +730,8 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		const char *context = diff_get_color(ecb->color_diff,
 						     DIFF_CONTEXT);
 		putc('\n', ecb->opt->file);
-		emit_line_0(ecb->opt, context, reset, '\\',
-			    nneof, strlen(nneof));
+		emit_line(ecb->opt, context, reset, 1, '\\',
+			  nneof, strlen(nneof));
 	}
 }
 
@@ -1341,7 +1329,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		}
 		diff_words_flush(ecbdata);
 		if (ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN) {
-			emit_line(o, context, reset, line, len);
+			emit_line(o, context, reset, 1, 0, line, len);
 			fputs("~\n", o->file);
 		} else {
 			/*
@@ -1353,7 +1341,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			      line++;
 			      len--;
 			}
-			emit_line(o, context, reset, line, len);
+			emit_line(o, context, reset, 1, 0, line, len);
 		}
 		return;
 	}
@@ -1376,7 +1364,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		/* incomplete line at the end */
 		ecbdata->lno_in_preimage++;
 		emit_line(o, diff_get_color(ecbdata->color_diff, DIFF_CONTEXT),
-			  reset, line, len);
+			  reset, 1, 0, line, len);
 		break;
 	}
 }
@@ -2188,7 +2176,7 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 		fprintf(data->o->file, "%s%s:%d: %s.\n",
 			line_prefix, data->filename, data->lineno, err);
 		free(err);
-		emit_line(data->o, set, reset, line, 1);
+		emit_line(data->o, set, reset, 1, 0, line, 1);
 		ws_check_emit(line + 1, len - 1, data->ws_rule,
 			      data->o->file, set, reset, ws);
 	} else if (line[0] == ' ') {
@@ -4833,9 +4821,11 @@ void diff_flush(struct diff_options *options)
 
 	if (output_format & DIFF_FORMAT_PATCH) {
 		if (separator) {
-			fprintf(options->file, "%s%c",
-				diff_line_prefix(options),
-				options->line_termination);
+			char term[2];
+			term[0] = options->line_termination;
+			term[1] = '\0';
+
+			emit_line(options, NULL, NULL, 1, 0, term, !!term[0]);
 			if (options->stat_sep) {
 				/* attach patch instead of inline */
 				fputs(options->stat_sep, options->file);
-- 
2.13.0.18.g7d86cc8ba0

