From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 5/6] diff.c: use diff_line_prefix() where applicable
Date: Thu,  7 Feb 2013 20:15:27 +0000
Message-ID: <360d40dc944e0f2d944c5ba5ae69b4b352d8d6ad.1360267849.git.john@keeping.me.uk>
References: <cover.1360267849.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 21:23:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Y0X-0001X8-7v
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 21:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759375Ab3BGUXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 15:23:07 -0500
Received: from pichi.aluminati.org ([72.9.246.58]:37237 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759334Ab3BGUXF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 15:23:05 -0500
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Feb 2013 15:23:05 EST
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 62BD5161E463;
	Thu,  7 Feb 2013 20:16:01 +0000 (GMT)
X-Quarantine-ID: <q-jMwWULTpYB>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q-jMwWULTpYB; Thu,  7 Feb 2013 20:16:00 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id DD78E161E4CF;
	Thu,  7 Feb 2013 20:15:54 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1360267849.git.john@keeping.me.uk>
In-Reply-To: <cover.1360267849.git.john@keeping.me.uk>
References: <cover.1360267849.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215726>

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 diff.c | 115 ++++++++++++-----------------------------------------------------
 1 file changed, 20 insertions(+), 95 deletions(-)

diff --git a/diff.c b/diff.c
index ed14d5d..f441f6c 100644
--- a/diff.c
+++ b/diff.c
@@ -402,12 +402,7 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 	int nofirst;
 	FILE *file = o->file;
 
-	if (o->output_prefix) {
-		struct strbuf *msg = NULL;
-		msg = o->output_prefix(o, o->output_prefix_data);
-		assert(msg);
-		fwrite(msg->buf, msg->len, 1, file);
-	}
+	fputs(diff_line_prefix(o), file);
 
 	if (len == 0) {
 		has_trailing_newline = (first == '\n');
@@ -625,13 +620,7 @@ static void emit_rewrite_diff(const char *name_a,
 	char *data_one, *data_two;
 	size_t size_one, size_two;
 	struct emit_callback ecbdata;
-	char *line_prefix = "";
-	struct strbuf *msgbuf;
-
-	if (o && o->output_prefix) {
-		msgbuf = o->output_prefix(o, o->output_prefix_data);
-		line_prefix = msgbuf->buf;
-	}
+	const char *line_prefix = diff_line_prefix(o);
 
 	if (diff_mnemonic_prefix && DIFF_OPT_TST(o, REVERSE_DIFF)) {
 		a_prefix = o->b_prefix;
@@ -827,18 +816,14 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	int minus_first, minus_len, plus_first, plus_len;
 	const char *minus_begin, *minus_end, *plus_begin, *plus_end;
 	struct diff_options *opt = diff_words->opt;
-	struct strbuf *msgbuf;
-	char *line_prefix = "";
+	const char *line_prefix;
 
 	if (line[0] != '@' || parse_hunk_header(line, len,
 			&minus_first, &minus_len, &plus_first, &plus_len))
 		return;
 
 	assert(opt);
-	if (opt->output_prefix) {
-		msgbuf = opt->output_prefix(opt, opt->output_prefix_data);
-		line_prefix = msgbuf->buf;
-	}
+	line_prefix = diff_line_prefix(opt);
 
 	/* POSIX requires that first be decremented by one if len == 0... */
 	if (minus_len) {
@@ -962,14 +947,10 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	struct diff_words_style *style = diff_words->style;
 
 	struct diff_options *opt = diff_words->opt;
-	struct strbuf *msgbuf;
-	char *line_prefix = "";
+	const char *line_prefix;
 
 	assert(opt);
-	if (opt->output_prefix) {
-		msgbuf = opt->output_prefix(opt, opt->output_prefix_data);
-		line_prefix = msgbuf->buf;
-	}
+	line_prefix = diff_line_prefix(opt);
 
 	/* special case: only removal */
 	if (!diff_words->plus.text.size) {
@@ -1155,13 +1136,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	const char *plain = diff_get_color(ecbdata->color_diff, DIFF_PLAIN);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 	struct diff_options *o = ecbdata->opt;
-	char *line_prefix = "";
-	struct strbuf *msgbuf;
-
-	if (o && o->output_prefix) {
-		msgbuf = o->output_prefix(o, o->output_prefix_data);
-		line_prefix = msgbuf->buf;
-	}
+	const char *line_prefix = diff_line_prefix(o);
 
 	if (ecbdata->header) {
 		fprintf(ecbdata->opt->file, "%s", ecbdata->header->buf);
@@ -1485,16 +1460,11 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	const char *reset, *add_c, *del_c;
 	const char *line_prefix = "";
 	int extra_shown = 0;
-	struct strbuf *msg = NULL;
 
 	if (data->nr == 0)
 		return;
 
-	if (options->output_prefix) {
-		msg = options->output_prefix(options, options->output_prefix_data);
-		line_prefix = msg->buf;
-	}
-
+	line_prefix = diff_line_prefix(options);
 	count = options->stat_count ? options->stat_count : data->nr;
 
 	reset = diff_get_color_opt(options, DIFF_RESET);
@@ -1746,12 +1716,7 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 			dels += deleted;
 		}
 	}
-	if (options->output_prefix) {
-		struct strbuf *msg = NULL;
-		msg = options->output_prefix(options,
-				options->output_prefix_data);
-		fprintf(options->file, "%s", msg->buf);
-	}
+	fprintf(options->file, "%s", diff_line_prefix(options));
 	print_stat_summary(options->file, total_files, adds, dels);
 }
 
@@ -1765,12 +1730,7 @@ static void show_numstat(struct diffstat_t *data, struct diff_options *options)
 	for (i = 0; i < data->nr; i++) {
 		struct diffstat_file *file = data->files[i];
 
-		if (options->output_prefix) {
-			struct strbuf *msg = NULL;
-			msg = options->output_prefix(options,
-					options->output_prefix_data);
-			fprintf(options->file, "%s", msg->buf);
-		}
+		fprintf(options->file, "%s", diff_line_prefix(options));
 
 		if (file->is_binary)
 			fprintf(options->file, "-\t-\t");
@@ -1812,13 +1772,7 @@ static long gather_dirstat(struct diff_options *opt, struct dirstat_dir *dir,
 {
 	unsigned long this_dir = 0;
 	unsigned int sources = 0;
-	const char *line_prefix = "";
-	struct strbuf *msg = NULL;
-
-	if (opt->output_prefix) {
-		msg = opt->output_prefix(opt, opt->output_prefix_data);
-		line_prefix = msg->buf;
-	}
+	const char *line_prefix = diff_line_prefix(opt);
 
 	while (dir->nr) {
 		struct dirstat_file *f = dir->files;
@@ -2068,15 +2022,10 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 	const char *reset = diff_get_color(data->o->use_color, DIFF_RESET);
 	const char *set = diff_get_color(data->o->use_color, DIFF_FILE_NEW);
 	char *err;
-	char *line_prefix = "";
-	struct strbuf *msgbuf;
+	const char *line_prefix;
 
 	assert(data->o);
-	if (data->o->output_prefix) {
-		msgbuf = data->o->output_prefix(data->o,
-			data->o->output_prefix_data);
-		line_prefix = msgbuf->buf;
-	}
+	line_prefix = diff_line_prefix(data->o);
 
 	if (line[0] == '+') {
 		unsigned bad;
@@ -2263,13 +2212,7 @@ static void builtin_diff(const char *name_a,
 	struct userdiff_driver *textconv_one = NULL;
 	struct userdiff_driver *textconv_two = NULL;
 	struct strbuf header = STRBUF_INIT;
-	struct strbuf *msgbuf;
-	char *line_prefix = "";
-
-	if (o->output_prefix) {
-		msgbuf = o->output_prefix(o, o->output_prefix_data);
-		line_prefix = msgbuf->buf;
-	}
+	const char *line_prefix = diff_line_prefix(o);
 
 	if (DIFF_OPT_TST(o, SUBMODULE_LOG) &&
 			(!one->mode || S_ISGITLINK(one->mode)) &&
@@ -2968,14 +2911,9 @@ static void fill_metainfo(struct strbuf *msg,
 {
 	const char *set = diff_get_color(use_color, DIFF_METAINFO);
 	const char *reset = diff_get_color(use_color, DIFF_RESET);
-	struct strbuf *msgbuf;
-	char *line_prefix = "";
+	const char *line_prefix = diff_line_prefix(o);
 
 	*must_show_header = 1;
-	if (o->output_prefix) {
-		msgbuf = o->output_prefix(o, o->output_prefix_data);
-		line_prefix = msgbuf->buf;
-	}
 	strbuf_init(msg, PATH_MAX * 2 + 300);
 	switch (p->status) {
 	case DIFF_STATUS_COPIED:
@@ -3912,12 +3850,8 @@ static void diff_flush_raw(struct diff_filepair *p, struct diff_options *opt)
 {
 	int line_termination = opt->line_termination;
 	int inter_name_termination = line_termination ? '\t' : '\0';
-	if (opt->output_prefix) {
-		struct strbuf *msg = NULL;
-		msg = opt->output_prefix(opt, opt->output_prefix_data);
-		fprintf(opt->file, "%s", msg->buf);
-	}
 
+	fprintf(opt->file, "%s", diff_line_prefix(opt));
 	if (!(opt->output_format & DIFF_FORMAT_NAME_STATUS)) {
 		fprintf(opt->file, ":%06o %06o %s ", p->one->mode, p->two->mode,
 			diff_unique_abbrev(p->one->sha1, opt->abbrev));
@@ -4187,12 +4121,7 @@ static void show_rename_copy(FILE *file, const char *renamecopy, struct diff_fil
 static void diff_summary(struct diff_options *opt, struct diff_filepair *p)
 {
 	FILE *file = opt->file;
-	char *line_prefix = "";
-
-	if (opt->output_prefix) {
-		struct strbuf *buf = opt->output_prefix(opt, opt->output_prefix_data);
-		line_prefix = buf->buf;
-	}
+	const char *line_prefix = diff_line_prefix(opt);
 
 	switch(p->status) {
 	case DIFF_STATUS_DELETED:
@@ -4493,13 +4422,9 @@ void diff_flush(struct diff_options *options)
 
 	if (output_format & DIFF_FORMAT_PATCH) {
 		if (separator) {
-			if (options->output_prefix) {
-				struct strbuf *msg = NULL;
-				msg = options->output_prefix(options,
-					options->output_prefix_data);
-				fwrite(msg->buf, msg->len, 1, options->file);
-			}
-			putc(options->line_termination, options->file);
+			fprintf(options->file, "%s%c",
+				diff_line_prefix(options),
+				options->line_termination);
 			if (options->stat_sep) {
 				/* attach patch instead of inline */
 				fputs(options->stat_sep, options->file);
-- 
1.8.1.2
