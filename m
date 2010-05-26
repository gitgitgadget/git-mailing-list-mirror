From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v4 1/6] Add a prefix output callback to diff output
Date: Wed, 26 May 2010 15:08:02 +0800
Message-ID: <1274857687-10514-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 09:08:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHAjH-0002fU-IC
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 09:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653Ab0EZHIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 03:08:34 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:36036 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884Ab0EZHId (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 03:08:33 -0400
Received: by pxi18 with SMTP id 18so2361611pxi.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 00:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=dSDPWz8+QFrn9yaMsvtmS6dip8sosc/ioIJWy14sUks=;
        b=GZ7Iv/q965DbEYQJlI62PtKE0FI7Hso8U9FA7lCntY7SuasP/fRgY/YAfthizcoNl4
         0IHKYwo51/5vMNIR49nqEEZft2EvVj4bTcd2s47zMYsjGgpoqFu+pXsRcziffKQoNKfs
         oL9rKWkSrG6pt7SsonXN2fVXZOYwsSMLfskng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kbGHxqwREYHFHfrnrIc6xRSsNBi5dFyp3nQAJWPE+N7HrzQKdoFbrA/otMbgVZSMlS
         0XPGE4FrKEB05iElbZolWsVSl4TfmygsWC163O6DluuNOLkx74omirqcmukTKpbDo8bh
         HIDbuOeF7xVvRvCRGj2ugTju5BkUTmWK7dsCY=
Received: by 10.114.30.6 with SMTP id d6mr7214510wad.135.1274857713027;
        Wed, 26 May 2010 00:08:33 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.99])
        by mx.google.com with ESMTPS id n29sm54704526wae.4.2010.05.26.00.08.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 May 2010 00:08:32 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147773>

The callback allow to output some prefix string for
each line of diff output.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 diff.c |   62 +++++++++++++++++++++++++++++++++++---------------------------
 diff.h |    5 +++++
 2 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/diff.c b/diff.c
index 494f560..e2f910a 100644
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
+		msg = o->output_prefix(o, o->output_prefix_data);
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
@@ -840,7 +848,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 
 	if (ecbdata->header) {
-		fprintf(ecbdata->file, "%s", ecbdata->header->buf);
+		fprintf(ecbdata->opt->file, "%s", ecbdata->header->buf);
 		strbuf_reset(ecbdata->header);
 		ecbdata->header = NULL;
 	}
@@ -852,9 +860,9 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
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
@@ -872,15 +880,15 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
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
 		if (ecbdata->diff_words
 		    && ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN)
-			fputs("~\n", ecbdata->file);
+			fputs("~\n", ecbdata->opt->file);
 		return;
 	}
 
@@ -896,11 +904,11 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		}
 		diff_words_flush(ecbdata);
 		if (ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN) {
-			emit_line(ecbdata->file, plain, reset, line, len);
-			fputs("~\n", ecbdata->file);
+			emit_line(ecbdata->opt, plain, reset, line, len);
+			fputs("~\n", ecbdata->opt->file);
 		} else {
 			/* don't print the prefix character */
-			emit_line(ecbdata->file, plain, reset, line+1, len-1);
+			emit_line(ecbdata->opt, plain, reset, line+1, len-1);
 		}
 		return;
 	}
@@ -912,7 +920,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		ecbdata->lno_in_preimage++;
 		if (line[0] == ' ')
 			ecbdata->lno_in_postimage++;
-		emit_line(ecbdata->file, color, reset, line, len);
+		emit_line(ecbdata->opt, color, reset, line, len);
 	} else {
 		ecbdata->lno_in_postimage++;
 		emit_add_line(reset, ecbdata, line + 1, len - 1);
@@ -1477,7 +1485,7 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 		fprintf(data->o->file, "%s:%d: %s.\n",
 			data->filename, data->lineno, err);
 		free(err);
-		emit_line(data->o->file, set, reset, line, 1);
+		emit_line(data->o, set, reset, line, 1);
 		ws_check_emit(line + 1, len - 1, data->ws_rule,
 			      data->o->file, set, reset, ws);
 	} else if (line[0] == ' ') {
@@ -1787,7 +1795,7 @@ static void builtin_diff(const char *name_a,
 		ecbdata.ws_rule = whitespace_rule(name_b ? name_b : name_a);
 		if (ecbdata.ws_rule & WS_BLANK_AT_EOF)
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
-		ecbdata.file = o->file;
+		ecbdata.opt = o;
 		ecbdata.header = header.len ? &header : NULL;
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xecfg.ctxlen = o->context;
diff --git a/diff.h b/diff.h
index 9ace08c..b4eefa7 100644
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
 
+typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data);
+
 #define DIFF_FORMAT_RAW		0x0001
 #define DIFF_FORMAT_DIFFSTAT	0x0002
 #define DIFF_FORMAT_NUMSTAT	0x0004
@@ -130,6 +133,8 @@ struct diff_options {
 	add_remove_fn_t add_remove;
 	diff_format_fn_t format_callback;
 	void *format_callback_data;
+	diff_prefix_fn_t output_prefix;
+	void *output_prefix_data;
 };
 
 enum color_diff {
-- 
1.6.0.4
