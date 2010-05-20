From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 1/6 v2] Add a prefix output callback to diff output.
Date: Thu, 20 May 2010 03:25:33 -0700
Message-ID: <1274351138-11813-2-git-send-email-struggleyb.nku@gmail.com>
References: <1274351138-11813-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 20 12:26:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF2x8-0006qW-Jm
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 12:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147Ab0ETKZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 06:25:50 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53807 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab0ETKZs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 06:25:48 -0400
Received: by pwi5 with SMTP id 5so2016350pwi.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 03:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=NieBugJVsulJGM2rOSl5GTuEYHR4gaXxLzJ9K9pcf2c=;
        b=FTF3wF8YanLRyvWUCR57o66QHdZf8seWS3KfuD3AOMqsX6UPxAms5db+RKhyUEKc5l
         MmZ6CUQvh3Ng/ho/eqFq34gXNfho26R69QalvoPERQrRTZo9kZaGe7mD9Wd1D0/zunn0
         JhSxkDw2MHio2RclOxs40jhYFfyEyU2uzTPjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=e7dU6/k7zUNGikhH3ew3ctgBfUWMXuFK93U4IjBznNoW9LLySTETnWAgZ4bThPwASv
         NcIILNTXtTc0xGl3Xym3wlmXbbrpJ2ukzvHxZAmRfeas6r/uTpzhcFUobGdqaAyhwuD3
         ATJCFlWtp08lJH19EY831rYIgDwKQO3oj189I=
Received: by 10.114.214.33 with SMTP id m33mr8536900wag.107.1274351147825;
        Thu, 20 May 2010 03:25:47 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id n32sm76160636wae.22.2010.05.20.03.25.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 May 2010 03:25:46 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1274351138-11813-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147374>

The callback allow to output some prefix string for
each line of diff output.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 diff.c |   56 ++++++++++++++++++++++++++++++++------------------------
 diff.h |    5 +++++
 2 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/diff.c b/diff.c
index 43a313d..b2df2d5 100644
--- a/diff.c
+++ b/diff.c
@@ -194,8 +194,8 @@ struct emit_callback {
 	sane_truncate_fn truncate;
 	const char **label_path;
 	struct diff_words_data *diff_words;
+	struct diff_options *opt;
 	int *found_changesp;
-	FILE *file;
 	struct strbuf *header;
 };
 
@@ -282,11 +282,19 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
 }
 
-static void emit_line_0(FILE *file, const char *set, const char *reset,
+static void emit_line_0(struct diff_options *o, const char *set, const char *reset,
 			int first, const char *line, int len)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
 	int nofirst;
+	FILE *file = o->file;
+
+	if (o->output_prefix) {
+		struct strbuf *msg = NULL;
+		msg = o->output_prefix(file, o->output_prefix_data);
+		assert(msg);
+		fwrite(msg->buf, msg->len, 1, file);
+	}
 
 	if (len == 0) {
 		has_trailing_newline = (first == '\n');
@@ -316,10 +324,10 @@ static void emit_line_0(FILE *file, const char *set, const char *reset,
 		fputc('\n', file);
 }
 
-static void emit_line(FILE *file, const char *set, const char *reset,
+static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(file, set, reset, line[0], line+1, len-1);
+	emit_line_0(o, set, reset, line[0], line+1, len-1);
 }
 
 static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
@@ -341,15 +349,15 @@ static void emit_add_line(const char *reset,
 	const char *set = diff_get_color(ecbdata->color_diff, DIFF_FILE_NEW);
 
 	if (!*ws)
-		emit_line_0(ecbdata->file, set, reset, '+', line, len);
+		emit_line_0(ecbdata->opt, set, reset, '+', line, len);
 	else if (new_blank_line_at_eof(ecbdata, line, len))
 		/* Blank line at EOF - paint '+' as well */
-		emit_line_0(ecbdata->file, ws, reset, '+', line, len);
+		emit_line_0(ecbdata->opt, ws, reset, '+', line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(ecbdata->file, set, reset, '+', "", 0);
+		emit_line_0(ecbdata->opt, set, reset, '+', "", 0);
 		ws_check_emit(line, len, ecbdata->ws_rule,
-			      ecbdata->file, set, reset, ws);
+			      ecbdata->opt->file, set, reset, ws);
 	}
 }
 
@@ -370,23 +378,23 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	if (len < 10 ||
 	    memcmp(line, atat, 2) ||
 	    !(ep = memmem(line + 2, len - 2, atat, 2))) {
-		emit_line(ecbdata->file, plain, reset, line, len);
+		emit_line(ecbdata->opt, plain, reset, line, len);
 		return;
 	}
 	ep += 2; /* skip over @@ */
 
 	/* The hunk header in fraginfo color */
-	emit_line(ecbdata->file, frag, reset, line, ep - line);
+	emit_line(ecbdata->opt, frag, reset, line, ep - line);
 
 	/* blank before the func header */
 	for (cp = ep; ep - line < len; ep++)
 		if (*ep != ' ' && *ep != '\t')
 			break;
 	if (ep != cp)
-		emit_line(ecbdata->file, plain, reset, cp, ep - cp);
+		emit_line(ecbdata->opt, plain, reset, cp, ep - cp);
 
 	if (ep < line + len)
-		emit_line(ecbdata->file, func, reset, ep, line + len - ep);
+		emit_line(ecbdata->opt, func, reset, ep, line + len - ep);
 }
 
 static struct diff_tempfile *claim_diff_tempfile(void) {
@@ -446,7 +454,7 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		len = endp ? (endp - data + 1) : size;
 		if (prefix != '+') {
 			ecb->lno_in_preimage++;
-			emit_line_0(ecb->file, old, reset, '-',
+			emit_line_0(ecb->opt, old, reset, '-',
 				    data, len);
 		} else {
 			ecb->lno_in_postimage++;
@@ -458,7 +466,7 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 	if (!endp) {
 		const char *plain = diff_get_color(ecb->color_diff,
 						   DIFF_PLAIN);
-		emit_line_0(ecb->file, plain, reset, '\\',
+		emit_line_0(ecb->opt, plain, reset, '\\',
 			    nneof, strlen(nneof));
 	}
 }
@@ -508,7 +516,7 @@ static void emit_rewrite_diff(const char *name_a,
 	ecbdata.color_diff = color_diff;
 	ecbdata.found_changesp = &o->found_changes;
 	ecbdata.ws_rule = whitespace_rule(name_b ? name_b : name_a);
-	ecbdata.file = o->file;
+	ecbdata.opt = o;
 	if (ecbdata.ws_rule & WS_BLANK_AT_EOF) {
 		mmfile_t mf1, mf2;
 		mf1.ptr = (char *)data_one;
@@ -786,7 +794,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 
 	if (ecbdata->header) {
-		fprintf(ecbdata->file, "%s", ecbdata->header->buf);
+		fprintf(ecbdata->opt->file, "%s", ecbdata->header->buf);
 		strbuf_reset(ecbdata->header);
 		ecbdata->header = NULL;
 	}
@@ -798,9 +806,9 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		name_a_tab = strchr(ecbdata->label_path[0], ' ') ? "\t" : "";
 		name_b_tab = strchr(ecbdata->label_path[1], ' ') ? "\t" : "";
 
-		fprintf(ecbdata->file, "%s--- %s%s%s\n",
+		fprintf(ecbdata->opt->file, "%s--- %s%s%s\n",
 			meta, ecbdata->label_path[0], reset, name_a_tab);
-		fprintf(ecbdata->file, "%s+++ %s%s%s\n",
+		fprintf(ecbdata->opt->file, "%s+++ %s%s%s\n",
 			meta, ecbdata->label_path[1], reset, name_b_tab);
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
@@ -818,12 +826,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		find_lno(line, ecbdata);
 		emit_hunk_header(ecbdata, line, len);
 		if (line[len-1] != '\n')
-			putc('\n', ecbdata->file);
+			putc('\n', ecbdata->opt->file);
 		return;
 	}
 
 	if (len < 1) {
-		emit_line(ecbdata->file, reset, reset, line, len);
+		emit_line(ecbdata->opt, reset, reset, line, len);
 		return;
 	}
 
@@ -840,7 +848,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		diff_words_flush(ecbdata);
 		line++;
 		len--;
-		emit_line(ecbdata->file, plain, reset, line, len);
+		emit_line(ecbdata->opt, plain, reset, line, len);
 		return;
 	}
 
@@ -851,7 +859,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		ecbdata->lno_in_preimage++;
 		if (line[0] == ' ')
 			ecbdata->lno_in_postimage++;
-		emit_line(ecbdata->file, color, reset, line, len);
+		emit_line(ecbdata->opt, color, reset, line, len);
 	} else {
 		ecbdata->lno_in_postimage++;
 		emit_add_line(reset, ecbdata, line + 1, len - 1);
@@ -1416,7 +1424,7 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 		fprintf(data->o->file, "%s:%d: %s.\n",
 			data->filename, data->lineno, err);
 		free(err);
-		emit_line(data->o->file, set, reset, line, 1);
+		emit_line(data->o, set, reset, line, 1);
 		ws_check_emit(line + 1, len - 1, data->ws_rule,
 			      data->o->file, set, reset, ws);
 	} else if (line[0] == ' ') {
@@ -1726,7 +1734,7 @@ static void builtin_diff(const char *name_a,
 		ecbdata.ws_rule = whitespace_rule(name_b ? name_b : name_a);
 		if (ecbdata.ws_rule & WS_BLANK_AT_EOF)
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
-		ecbdata.file = o->file;
+		ecbdata.opt = o;
 		ecbdata.header = header.len ? &header : NULL;
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xecfg.ctxlen = o->context;
diff --git a/diff.h b/diff.h
index 6a71013..d28c0fd 100644
--- a/diff.h
+++ b/diff.h
@@ -9,6 +9,7 @@
 struct rev_info;
 struct diff_options;
 struct diff_queue_struct;
+struct strbuf;
 
 typedef void (*change_fn_t)(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
@@ -25,6 +26,8 @@ typedef void (*add_remove_fn_t)(struct diff_options *options,
 typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 		struct diff_options *options, void *data);
 
+typedef struct strbuf *(*diff_prefix_fn_t)(FILE *file, void *data);
+
 #define DIFF_FORMAT_RAW		0x0001
 #define DIFF_FORMAT_DIFFSTAT	0x0002
 #define DIFF_FORMAT_NUMSTAT	0x0004
@@ -122,6 +125,8 @@ struct diff_options {
 	add_remove_fn_t add_remove;
 	diff_format_fn_t format_callback;
 	void *format_callback_data;
+	diff_prefix_fn_t output_prefix;
+	void *output_prefix_data;
 };
 
 enum color_diff {
-- 
1.6.0.4
