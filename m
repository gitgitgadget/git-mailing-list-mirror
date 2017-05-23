Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C7BB2023D
	for <e@80x24.org>; Tue, 23 May 2017 02:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936125AbdEWCli (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 22:41:38 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33099 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934784AbdEWClU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 22:41:20 -0400
Received: by mail-pf0-f175.google.com with SMTP id e193so99668741pfh.0
        for <git@vger.kernel.org>; Mon, 22 May 2017 19:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gZ7wil/5efqVpGRWczy8zP00xtreIR+Lj4R1xavqh+w=;
        b=SX0coCFHpnWvEvuecg2UFx1oXgT+MuIPmdBDn8fei2ZL7r0Ne0g1r9tGFVMutkRogn
         evOTLowumI7h4dlMEjzylwH4DDXUGhiL65D55mhFUzoBiVQZaKR7oGcviOFWeCK7oyFn
         6uEGDTx/ZtNxl+WHTNRpEdFXzCNXfV5EcH5ScSb9LIzBqAXjYQEVgFoYlNbaX6DaeheE
         Yd9ZrpJjRv1RUBKT+0Iv4EoMk9sGBKXCGACH6FlIkWsLWfg2pUObh58o9KQ+7YQVAK4+
         P88d+T+Z5UMtDPlsdfonAyPkImq6zbDBEUlWjL1KCwddDhgDBPKxrLTBYkk9d9ZDEbLx
         u3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gZ7wil/5efqVpGRWczy8zP00xtreIR+Lj4R1xavqh+w=;
        b=jPqEmGFvN7uEgIqGiYBiNXgopMDzKwuusEaICD9qukII0sZqElDG5E3pwQzhId5jSQ
         +N4J6zJoKDI45eBbIDHRrdPbUb9wbGWtif/rCjKNa3T3/FYEuycmvWfchjU1vLnt7Crc
         jRWGJaK4gJ7dieJ5NmjhqON2YKhN+ySV6seErQCzO+QSOw50sccavZVYQHnVk8ISrXEu
         WD3oQDLKY9lBf/ZGn0cupDsOS/21IWKlv0WpRcy/PbuTS3WiEmCGwXtUG3NylEiwL/GQ
         cEDnrIz+P1Gm0I4Zy6I0AxwirfoVUU6KkUW0Thks76/8ROyEov5rhHpz/wZthfJzvuY8
         GZ4A==
X-Gm-Message-State: AODbwcDP49+dSu7ogshBpah+TXN1FOeaJ0/9XeIFawMLUx3wUNrJqMf/
        TWwDZWGys/JqtXSH
X-Received: by 10.84.204.133 with SMTP id b5mr33318866ple.56.1495507279832;
        Mon, 22 May 2017 19:41:19 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6dc1:8d70:6f8f:1c2a])
        by smtp.gmail.com with ESMTPSA id g63sm8086224pgc.59.2017.05.22.19.41.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 19:41:19 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 15/17] diff.c: emit_line includes whitespace highlighting
Date:   Mon, 22 May 2017 19:40:46 -0700
Message-Id: <20170523024048.16879-16-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170523024048.16879-1-sbeller@google.com>
References: <20170518193746.486-1-sbeller@google.com>
 <20170523024048.16879-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently any whitespace highlighting happens outside the emit_line
function. Teach the highlighting to emit_line, triggered by a new
parameter.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 107 ++++++++++++++++++++++++++++++++++++++---------------------------
 diff.h |   2 ++
 2 files changed, 65 insertions(+), 44 deletions(-)

diff --git a/diff.c b/diff.c
index 76cafde4be..514c5facd7 100644
--- a/diff.c
+++ b/diff.c
@@ -516,15 +516,34 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
 }
 
-static void emit_line(struct diff_options *o, const char *set, const char *reset,
-		      int add_line_prefix, int sign, const char *line, int len)
+
+static void emit_line(struct diff_options *o,
+		      const char *set, const char *reset,
+		      int add_line_prefix, int markup_ws,
+		      int sign, const char *line, int len)
 {
+	const char *ws;
 	int has_trailing_newline, has_trailing_carriage_return;
 	FILE *file = o->file;
 
 	if (add_line_prefix)
 		fputs(diff_line_prefix(o), file);
 
+	if (markup_ws) {
+		ws = diff_get_color(o->use_color, DIFF_WHITESPACE);
+
+		if (set)
+			fputs(set, file);
+		if (sign)
+			fputc(sign, file);
+		if (reset)
+			fputs(reset, file);
+		ws = diff_get_color(o->use_color, DIFF_WHITESPACE);
+		ws_check_emit(line, len, o->ws_rule,
+			      file, set, reset, ws);
+		return;
+	}
+
 	has_trailing_newline = (len > 0 && line[len-1] == '\n');
 	if (has_trailing_newline)
 		len--;
@@ -558,14 +577,14 @@ static void emit_line_fmt(struct diff_options *o,
 	strbuf_vaddf(&sb, fmt, ap);
 	va_end(ap);
 
-	emit_line(o, set, reset, add_line_prefix, 0, sb.buf, sb.len);
+	emit_line(o, set, reset, add_line_prefix, 0, 0, sb.buf, sb.len);
 	strbuf_release(&sb);
 }
 
 void diff_emit_line(struct diff_options *o, const char *set, const char *reset,
 		    const char *line, int len)
 {
-	emit_line(o, set, reset, 1, 0, line, len);
+	emit_line(o, set, reset, 1, 0, 0, line, len);
 }
 
 static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
@@ -596,16 +615,15 @@ static void emit_line_checked(const char *reset,
 	}
 
 	if (!ws)
-		emit_line(ecbdata->opt, set, reset, 1, sign, line, len);
+		emit_line(ecbdata->opt, set, reset, 1, 0, sign, line, len);
 	else if (sign == '+' && new_blank_line_at_eof(ecbdata, line, len))
 		/* Blank line at EOF - paint '+' as well */
-		emit_line(ecbdata->opt, ws, reset, 1, sign, line, len);
+		emit_line(ecbdata->opt, ws, reset, 1, 1, sign, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line(ecbdata->opt, set, reset, 1, sign, "", 0);
-		ws_check_emit(line, len, ecbdata->ws_rule,
-			      ecbdata->opt->file, set, reset, ws);
+		emit_line(ecbdata->opt, set, reset, 1, 1, sign, line, len);
 	}
+
 }
 
 static void emit_add_line(const char *reset,
@@ -652,7 +670,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	if (len < 10 ||
 	    memcmp(line, atat, 2) ||
 	    !(ep = memmem(line + 2, len - 2, atat, 2))) {
-		emit_line(ecbdata->opt, context, reset, 1, 0, line, len);
+		emit_line(ecbdata->opt, context, reset, 1, 0, 0, line, len);
 		return;
 	}
 	ep += 2; /* skip over @@ */
@@ -688,7 +706,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	strbuf_add(&msgbuf, line + len, org_len - len);
 	strbuf_complete_line(&msgbuf);
 
-	emit_line(ecbdata->opt, "", "", 1, 0, msgbuf.buf, msgbuf.len);
+	emit_line(ecbdata->opt, "", "", 1, 0, 0, msgbuf.buf, msgbuf.len);
 	strbuf_release(&msgbuf);
 }
 
@@ -759,7 +777,7 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		static const char *nneof = "\\ No newline at end of file\n";
 		const char *context = diff_get_color(ecb->color_diff,
 						     DIFF_CONTEXT);
-		emit_line(ecb->opt, context, reset, 1, 0,
+		emit_line(ecb->opt, context, reset, 1, 0, 0,
 			    nneof, strlen(nneof));
 		strbuf_release(&sb);
 	}
@@ -835,7 +853,7 @@ static void emit_rewrite_diff(const char *name_a,
 	strbuf_addstr(&out, " +");
 	add_line_count(&out, lc_b);
 	strbuf_addstr(&out, " @@\n");
-	emit_line(o, fraginfo, reset, 1, 0, out.buf, out.len);
+	emit_line(o, fraginfo, reset, 1, 0, 0, out.buf, out.len);
 	strbuf_release(&out);
 
 	if (lc_a && !o->irreversible_delete)
@@ -908,7 +926,7 @@ static int fn_out_diff_words_write_helper(struct diff_options *o,
 	while (count) {
 		char *p = memchr(buf, '\n', count);
 		if (print)
-			emit_line(o, NULL, NULL, 1, 0, "", 0);
+			emit_line(o, NULL, NULL, 1, 0, 0, "", 0);
 
 		if (p != buf) {
 			const char *reset = st_el->color && *st_el->color ?
@@ -917,14 +935,14 @@ static int fn_out_diff_words_write_helper(struct diff_options *o,
 			strbuf_add(&sb, buf, p ? p - buf : count);
 			strbuf_addstr(&sb, st_el->suffix);
 			emit_line(o, st_el->color, reset,
-				  0, 0, sb.buf, sb.len);
+				  0, 0, 0, sb.buf, sb.len);
 			strbuf_reset(&sb);
 		}
 		if (!p)
 			goto out;
 
 		strbuf_addstr(&sb, newline);
-		emit_line(o, NULL, NULL, 0, 0, sb.buf, sb.len);
+		emit_line(o, NULL, NULL, 0, 0, 0, sb.buf, sb.len);
 		strbuf_reset(&sb);
 		count -= p + 1 - buf;
 		buf = p + 1;
@@ -1139,7 +1157,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	if (diff_words->current_plus != diff_words->plus.text.ptr +
 			diff_words->plus.text.size) {
 		if (color_words_output_graph_prefix(diff_words))
-			emit_line(diff_words->opt, NULL, NULL, 1, 0, "", 0);
+			emit_line(diff_words->opt, NULL, NULL, 1, 0, 0, "", 0);
 		fn_out_diff_words_write_helper(diff_words->opt,
 			&style->ctx, style->newline,
 			diff_words->plus.text.ptr + diff_words->plus.text.size
@@ -1298,7 +1316,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	o->found_changes = 1;
 
 	if (ecbdata->header) {
-		emit_line(o, NULL, NULL, 0, 0,
+		emit_line(o, NULL, NULL, 0, 0, 0,
 			  ecbdata->header->buf, ecbdata->header->len);
 		strbuf_release(ecbdata->header);
 		ecbdata->header = NULL;
@@ -1351,8 +1369,8 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		}
 		diff_words_flush(ecbdata);
 		if (ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN) {
-			emit_line(o, context, reset, 1, 0, line, len);
-			emit_line(o, NULL, NULL, 0, 0, "~\n", 2);
+			emit_line(o, context, reset, 1, 0, 0, line, len);
+			emit_line(o, NULL, NULL, 0, 0, 0, "~\n", 2);
 		} else {
 			/*
 			 * Skip the prefix character, if any.  With
@@ -1363,7 +1381,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			      line++;
 			      len--;
 			}
-			emit_line(o, context, reset, 1, 0, line, len);
+			emit_line(o, context, reset, 1, 0, 0, line, len);
 		}
 		return;
 	}
@@ -1386,7 +1404,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		/* incomplete line at the end */
 		ecbdata->lno_in_preimage++;
 		emit_line(o, diff_get_color(ecbdata->color_diff, DIFF_CONTEXT),
-			  reset, 1, 0, line, len);
+			  reset, 1, 0, 0, line, len);
 		break;
 	}
 }
@@ -1575,7 +1593,7 @@ static void print_stat_summary_0(struct diff_options *options, int files,
 	if (!files) {
 		assert(insertions == 0 && deletions == 0);
 		strbuf_addstr(&sb, " 0 files changed");
-		emit_line(options, NULL, NULL, 1, 0, sb.buf, sb.len);
+		emit_line(options, NULL, NULL, 1, 0, 0, sb.buf, sb.len);
 		return;
 	}
 
@@ -1603,7 +1621,7 @@ static void print_stat_summary_0(struct diff_options *options, int files,
 			    deletions);
 	}
 	strbuf_addch(&sb, '\n');
-	emit_line(options, NULL, NULL, 1, 0, sb.buf, sb.len);
+	emit_line(options, NULL, NULL, 1, 0, 0, sb.buf, sb.len);
 	strbuf_release(&sb);
 }
 
@@ -1787,7 +1805,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			strbuf_addf(&out, " %*s", number_width, "Bin");
 			if (!added && !deleted) {
 				strbuf_addch(&out, '\n');
-				emit_line(options, NULL, NULL, 1, 0, out.buf, out.len);
+				emit_line(options, NULL, NULL, 1, 0, 0, out.buf, out.len);
 				strbuf_reset(&out);
 				continue;
 			}
@@ -1797,14 +1815,14 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			strbuf_addf(&out, "%s%"PRIuMAX"%s",
 				add_c, added, reset);
 			strbuf_addstr(&out, " bytes\n");
-			emit_line(options, NULL, NULL, 1, 0, out.buf, out.len);
+			emit_line(options, NULL, NULL, 1, 0, 0, out.buf, out.len);
 			strbuf_reset(&out);
 			continue;
 		}
 		else if (file->is_unmerged) {
 			show_name(&out, prefix, name, len);
 			strbuf_addstr(&out, " Unmerged\n");
-			emit_line(options, NULL, NULL, 1, 0, out.buf, out.len);
+			emit_line(options, NULL, NULL, 1, 0, 0, out.buf, out.len);
 			strbuf_reset(&out);
 			continue;
 		}
@@ -1835,7 +1853,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		show_graph(&out, '+', add, add_c, reset);
 		show_graph(&out, '-', del, del_c, reset);
 		strbuf_addch(&out, '\n');
-		emit_line(options, NULL, NULL, 1, 0, out.buf, out.len);
+		emit_line(options, NULL, NULL, 1, 0, 0, out.buf, out.len);
 		strbuf_reset(&out);
 	}
 
@@ -1857,7 +1875,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		if (i < count)
 			continue;
 		if (!extra_shown)
-			emit_line(options, NULL, NULL, 1, 0,
+			emit_line(options, NULL, NULL, 1, 0, 0,
 				  " ...\n", strlen(" ...\n"));
 		extra_shown = 1;
 	}
@@ -2211,7 +2229,7 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 		fprintf(data->o->file, "%s%s:%d: %s.\n",
 			line_prefix, data->filename, data->lineno, err);
 		free(err);
-		emit_line(data->o, set, reset, 1, 0, line, 1);
+		emit_line(data->o, set, reset, 1, 0, 0, line, 1);
 		ws_check_emit(line + 1, len - 1, data->ws_rule,
 			      data->o->file, set, reset, ws);
 	} else if (line[0] == ' ') {
@@ -2307,9 +2325,9 @@ static void emit_binary_diff_body(struct diff_options *o,
 		line[len++] = '\n';
 		line[len] = '\0';
 
-		emit_line(o, NULL, NULL, 1, 0, line, len);
+		emit_line(o, NULL, NULL, 1, 0, 0, line, len);
 	}
-	emit_line(o, NULL, NULL, 1, 0, "\n", 1);
+	emit_line(o, NULL, NULL, 1, 0, 0, "\n", 1);
 	free(data);
 }
 
@@ -2318,7 +2336,7 @@ static void emit_binary_diff(struct diff_options *o,
 {
 	const char *s = "GIT binary patch\n";
 	const int len = strlen(s);
-	emit_line(o, NULL, NULL, 1, 0, s, len);
+	emit_line(o, NULL, NULL, 1, 0, 0, s, len);
 	emit_binary_diff_body(o, one, two);
 	emit_binary_diff_body(o, two, one);
 }
@@ -2461,7 +2479,7 @@ static void builtin_diff(const char *name_a,
 		if (complete_rewrite &&
 		    (textconv_one || !diff_filespec_is_binary(one)) &&
 		    (textconv_two || !diff_filespec_is_binary(two))) {
-			emit_line(o, NULL, NULL, 0, 0, header.buf, header.len);
+			emit_line(o, NULL, NULL, 0, 0, 0, header.buf, header.len);
 			strbuf_reset(&header);
 			emit_rewrite_diff(name_a, name_b, one, two,
 						textconv_one, textconv_two, o);
@@ -2471,7 +2489,7 @@ static void builtin_diff(const char *name_a,
 	}
 
 	if (o->irreversible_delete && lbl[1][0] == '/') {
-		emit_line(o, NULL, NULL, 0, 0, header.buf, header.len);
+		emit_line(o, NULL, NULL, 0, 0, 0, header.buf, header.len);
 		strbuf_reset(&header);
 		goto free_ab_and_return;
 	} else if (!DIFF_OPT_TST(o, TEXT) &&
@@ -2482,11 +2500,11 @@ static void builtin_diff(const char *name_a,
 		    !DIFF_OPT_TST(o, BINARY)) {
 			if (!oidcmp(&one->oid, &two->oid)) {
 				if (must_show_header)
-					emit_line(o, NULL, NULL, 0, 0,
+					emit_line(o, NULL, NULL, 0, 0, 0,
 						  header.buf, header.len);
 				goto free_ab_and_return;
 			}
-			emit_line(o, NULL, NULL, 0, 0,
+			emit_line(o, NULL, NULL, 0, 0, 0,
 				  header.buf, header.len);
 			emit_line_fmt(o, NULL, NULL, 1,
 				      "Binary files %s and %s differ\n",
@@ -2499,11 +2517,11 @@ static void builtin_diff(const char *name_a,
 		if (mf1.size == mf2.size &&
 		    !memcmp(mf1.ptr, mf2.ptr, mf1.size)) {
 			if (must_show_header)
-				emit_line(o, NULL, NULL, 0, 0,
+				emit_line(o, NULL, NULL, 0, 0, 0,
 					  header.buf, header.len);
 			goto free_ab_and_return;
 		}
-		emit_line(o, NULL, NULL, 0, 0,
+		emit_line(o, NULL, NULL, 0, 0, 0,
 			  header.buf, header.len);
 		strbuf_reset(&header);
 		if (DIFF_OPT_TST(o, BINARY))
@@ -2523,7 +2541,7 @@ static void builtin_diff(const char *name_a,
 		const struct userdiff_funcname *pe;
 
 		if (must_show_header) {
-			emit_line(o, NULL, NULL, 0, 0, header.buf, header.len);
+			emit_line(o, NULL, NULL, 0, 0, 0, header.buf, header.len);
 			strbuf_reset(&header);
 		}
 
@@ -2540,6 +2558,7 @@ static void builtin_diff(const char *name_a,
 		ecbdata.label_path = lbl;
 		ecbdata.color_diff = want_color(o->use_color);
 		ecbdata.ws_rule = whitespace_rule(name_b);
+		o->ws_rule = ecbdata.ws_rule;
 		if (ecbdata.ws_rule & WS_BLANK_AT_EOF)
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
 		ecbdata.opt = o;
@@ -4514,7 +4533,7 @@ static void show_file_mode_name(struct diff_options *opt, const char *newdelete,
 
 	quote_c_style(fs->path, &sb, NULL, 0);
 	strbuf_addch(&sb, '\n');
-	emit_line(opt, NULL, NULL, 1, 0, sb.buf, sb.len);
+	emit_line(opt, NULL, NULL, 1, 0, 0, sb.buf, sb.len);
 	strbuf_release(&sb);
 }
 
@@ -4566,7 +4585,7 @@ static void diff_summary(struct diff_options *opt, struct diff_filepair *p)
 			strbuf_addstr(&sb, " rewrite ");
 			quote_c_style(p->two->path, &sb, NULL, 0);
 			strbuf_addf(&sb, " (%d%%)\n", similarity_index(p));
-			emit_line(opt, NULL, NULL, 1, 0, sb.buf, sb.len);
+			emit_line(opt, NULL, NULL, 1, 0, 0, sb.buf, sb.len);
 		}
 		show_mode_change(opt, p, !p->score);
 		break;
@@ -4873,10 +4892,10 @@ void diff_flush(struct diff_options *options)
 			term[0] = options->line_termination;
 			term[1] = '\0';
 
-			emit_line(options, NULL, NULL, 1, 0, term, !!term[0]);
+			emit_line(options, NULL, NULL, 1, 0, 0, term, !!term[0]);
 			if (options->stat_sep) {
 				/* attach patch instead of inline */
-				emit_line(options, NULL, NULL, 0, 0,
+				emit_line(options, NULL, NULL, 0, 0, 0,
 					  options->stat_sep,
 					  strlen(options->stat_sep));
 			}
diff --git a/diff.h b/diff.h
index 56d8dd036e..85948ed65a 100644
--- a/diff.h
+++ b/diff.h
@@ -186,6 +186,8 @@ struct diff_options {
 	void *output_prefix_data;
 
 	int diff_path_counter;
+
+	unsigned ws_rule;
 };
 
 void diff_emit_line(struct diff_options *o, const char *set, const char *reset,
-- 
2.13.0.18.g7d86cc8ba0

