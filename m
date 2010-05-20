From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 3/6 v2] diff.c: Output the text graph padding before each diff line.
Date: Thu, 20 May 2010 03:25:35 -0700
Message-ID: <1274351138-11813-4-git-send-email-struggleyb.nku@gmail.com>
References: <1274351138-11813-1-git-send-email-struggleyb.nku@gmail.com>
 <1274351138-11813-2-git-send-email-struggleyb.nku@gmail.com>
 <1274351138-11813-3-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 20 12:26:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF2x9-0006qW-R4
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 12:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375Ab0ETKZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 06:25:57 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:40491 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab0ETKZy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 06:25:54 -0400
Received: by mail-pv0-f174.google.com with SMTP id 18so1448192pva.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 03:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=yrJpv1IHyyTL0U/6lphZRv32aDo92zcwh9qkxl3dXqo=;
        b=jASHptuDnMRivVJsRVMhz5AklakUv+G/0ln6sSEvy83TO8im2WlHVvUnLTHLOWz5eD
         pom8bMxETyX5O8Ef7HjJmPGXBEoqNWes0Yp2omMZMuqf8+F4Fb1aeWUcM8jEL+OnVg/7
         UCdx6n5WVBlDt/A4hUtOkOsa4tIubKetLNeqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DeSd/WTWfB/mW5WU4TMQpOcMG8fg7DtvpDBXyvgFFqjFVymzwSbsLs4NTHRdHrUkch
         GzkMxMUxbxNy8kUv7e/GKUPq5Cg+VFwbcQkXxFJgjDDtHdnhY/3a9T8ER5EkExiwk0bh
         Dbq/Glnbow2Jey6SyxGGp9eah9zJBOW3SK7WE=
Received: by 10.114.249.6 with SMTP id w6mr8577866wah.0.1274351153955;
        Thu, 20 May 2010 03:25:53 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id n32sm76160636wae.22.2010.05.20.03.25.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 May 2010 03:25:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1274351138-11813-3-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147377>

Change -p/--dirstat/--binary/--numstat/--stat/--shortstat/--check
to align with graph paddings.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 diff.c |  161 +++++++++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 120 insertions(+), 41 deletions(-)

diff --git a/diff.c b/diff.c
index b2df2d5..5d1b7b5 100644
--- a/diff.c
+++ b/diff.c
@@ -490,6 +490,13 @@ static void emit_rewrite_diff(const char *name_a,
 	char *data_one, *data_two;
 	size_t size_one, size_two;
 	struct emit_callback ecbdata;
+	char *line_prefix = "";
+	struct strbuf *msgbuf;
+
+	if (o && o->output_prefix) {
+		msgbuf = o->output_prefix(o->file, o->output_prefix_data);
+		line_prefix = msgbuf->buf;
+	}
 
 	if (diff_mnemonic_prefix && DIFF_OPT_TST(o, REVERSE_DIFF)) {
 		a_prefix = o->b_prefix;
@@ -531,9 +538,10 @@ static void emit_rewrite_diff(const char *name_a,
 	lc_a = count_lines(data_one, size_one);
 	lc_b = count_lines(data_two, size_two);
 	fprintf(o->file,
-		"%s--- %s%s%s\n%s+++ %s%s%s\n%s@@ -",
-		metainfo, a_name.buf, name_a_tab, reset,
-		metainfo, b_name.buf, name_b_tab, reset, fraginfo);
+		"%s%s--- %s%s%s\n%s%s+++ %s%s%s\n%s%s@@ -",
+		line_prefix, metainfo, a_name.buf, name_a_tab, reset,
+		line_prefix, metainfo, b_name.buf, name_b_tab, reset,
+		line_prefix, fraginfo);
 	print_line_count(o->file, lc_a);
 	fprintf(o->file, " +");
 	print_line_count(o->file, lc_b);
@@ -792,6 +800,14 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	const char *meta = diff_get_color(ecbdata->color_diff, DIFF_METAINFO);
 	const char *plain = diff_get_color(ecbdata->color_diff, DIFF_PLAIN);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
+	struct diff_options *o = ecbdata->opt;
+	char *line_prefix = "";
+	struct strbuf *msgbuf;
+
+	if (o && o->output_prefix) {
+		msgbuf = o->output_prefix(o->file, o->output_prefix_data);
+		line_prefix = msgbuf->buf;
+	}
 
 	if (ecbdata->header) {
 		fprintf(ecbdata->opt->file, "%s", ecbdata->header->buf);
@@ -806,10 +822,10 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		name_a_tab = strchr(ecbdata->label_path[0], ' ') ? "\t" : "";
 		name_b_tab = strchr(ecbdata->label_path[1], ' ') ? "\t" : "";
 
-		fprintf(ecbdata->opt->file, "%s--- %s%s%s\n",
-			meta, ecbdata->label_path[0], reset, name_a_tab);
-		fprintf(ecbdata->opt->file, "%s+++ %s%s%s\n",
-			meta, ecbdata->label_path[1], reset, name_b_tab);
+		fprintf(ecbdata->opt->file, "%s%s--- %s%s%s\n",
+			line_prefix, meta, ecbdata->label_path[0], reset, name_a_tab);
+		fprintf(ecbdata->opt->file, "%s%s+++ %s%s%s\n",
+			line_prefix, meta, ecbdata->label_path[1], reset, name_b_tab);
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
 
@@ -1039,10 +1055,17 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	int total_files = data->nr;
 	int width, name_width;
 	const char *reset, *set, *add_c, *del_c;
+	const char *line_prefix = "";
+	struct strbuf *msg = NULL;
 
 	if (data->nr == 0)
 		return;
 
+	if (options->output_prefix) {
+		msg = options->output_prefix(options->file, options->output_prefix_data);
+		line_prefix = msg->buf;
+	}
+
 	width = options->stat_width ? options->stat_width : 80;
 	name_width = options->stat_name_width ? options->stat_name_width : 50;
 
@@ -1112,6 +1135,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		}
 
 		if (data->files[i]->is_binary) {
+			fprintf(options->file, "%s", line_prefix);
 			show_name(options->file, prefix, name, len);
 			fprintf(options->file, "  Bin ");
 			fprintf(options->file, "%s%"PRIuMAX"%s",
@@ -1124,6 +1148,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			continue;
 		}
 		else if (data->files[i]->is_unmerged) {
+			fprintf(options->file, "%s", line_prefix);
 			show_name(options->file, prefix, name, len);
 			fprintf(options->file, "  Unmerged\n");
 			continue;
@@ -1146,6 +1171,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			add = scale_linear(add, width, max_change);
 			del = scale_linear(del, width, max_change);
 		}
+		fprintf(options->file, "%s", line_prefix);
 		show_name(options->file, prefix, name, len);
 		fprintf(options->file, "%5"PRIuMAX"%s", added + deleted,
 				added + deleted ? " " : "");
@@ -1153,6 +1179,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		show_graph(options->file, '-', del, del_c, reset);
 		fprintf(options->file, "\n");
 	}
+	fprintf(options->file, "%s", line_prefix);
 	fprintf(options->file,
 	       " %d files changed, %d insertions(+), %d deletions(-)\n",
 	       total_files, adds, dels);
@@ -1179,6 +1206,12 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 			}
 		}
 	}
+	if (options->output_prefix) {
+		struct strbuf *msg = NULL;
+		msg = options->output_prefix(options->file,
+				options->output_prefix_data);
+		fprintf(options->file, "%s", msg->buf);
+	}
 	fprintf(options->file, " %d files changed, %d insertions(+), %d deletions(-)\n",
 	       total_files, adds, dels);
 }
@@ -1193,6 +1226,13 @@ static void show_numstat(struct diffstat_t *data, struct diff_options *options)
 	for (i = 0; i < data->nr; i++) {
 		struct diffstat_file *file = data->files[i];
 
+		if (options->output_prefix) {
+			struct strbuf *msg = NULL;
+			msg = options->output_prefix(options->file,
+					options->output_prefix_data);
+			fprintf(options->file, "%s", msg->buf);
+		}
+
 		if (file->is_binary)
 			fprintf(options->file, "-\t-\t");
 		else
@@ -1228,10 +1268,19 @@ struct dirstat_dir {
 	int alloc, nr, percent, cumulative;
 };
 
-static long gather_dirstat(FILE *file, struct dirstat_dir *dir, unsigned long changed, const char *base, int baselen)
+static long gather_dirstat(struct diff_options *opt, struct dirstat_dir *dir, unsigned long changed, const char *base, int baselen)
 {
 	unsigned long this_dir = 0;
 	unsigned int sources = 0;
+	assert(opt);
+	FILE *file = opt->file;
+	const char *line_prefix = "";
+	struct strbuf *msg = NULL;
+
+	if (opt->output_prefix) {
+		msg = opt->output_prefix(opt->file, opt->output_prefix_data);
+		line_prefix = msg->buf;
+	}
 
 	while (dir->nr) {
 		struct dirstat_file *f = dir->files;
@@ -1246,7 +1295,7 @@ static long gather_dirstat(FILE *file, struct dirstat_dir *dir, unsigned long ch
 		slash = strchr(f->name + baselen, '/');
 		if (slash) {
 			int newbaselen = slash + 1 - f->name;
-			this = gather_dirstat(file, dir, changed, f->name, newbaselen);
+			this = gather_dirstat(opt, dir, changed, f->name, newbaselen);
 			sources++;
 		} else {
 			this = f->changed;
@@ -1268,7 +1317,7 @@ static long gather_dirstat(FILE *file, struct dirstat_dir *dir, unsigned long ch
 		if (permille) {
 			int percent = permille / 10;
 			if (percent >= dir->percent) {
-				fprintf(file, "%4d.%01d%% %.*s\n", percent, permille % 10, baselen, base);
+				fprintf(file, "%s%4d.%01d%% %.*s\n", line_prefix, percent, permille % 10, baselen, base);
 				if (!dir->cumulative)
 					return 0;
 			}
@@ -1348,7 +1397,7 @@ static void show_dirstat(struct diff_options *options)
 
 	/* Show all directories with more than x% of the changes */
 	qsort(dir.files, dir.nr, sizeof(dir.files[0]), dirstat_compare);
-	gather_dirstat(options->file, &dir, changed, "", 0);
+	gather_dirstat(options, &dir, changed, "", 0);
 }
 
 static void free_diffstat_info(struct diffstat_t *diffstat)
@@ -1406,6 +1455,15 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 	const char *reset = diff_get_color(color_diff, DIFF_RESET);
 	const char *set = diff_get_color(color_diff, DIFF_FILE_NEW);
 	char *err;
+	char *line_prefix = "";
+	struct strbuf *msgbuf;
+
+	assert(data->o);
+	if (data->o->output_prefix) {
+		msgbuf = data->o->output_prefix(data->o->file,
+			data->o->output_prefix_data);
+		line_prefix = msgbuf->buf;
+	}
 
 	if (line[0] == '+') {
 		unsigned bad;
@@ -1413,16 +1471,16 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 		if (is_conflict_marker(line + 1, marker_size, len - 1)) {
 			data->status |= 1;
 			fprintf(data->o->file,
-				"%s:%d: leftover conflict marker\n",
-				data->filename, data->lineno);
+				"%s%s:%d: leftover conflict marker\n",
+				line_prefix, data->filename, data->lineno);
 		}
 		bad = ws_check(line + 1, len - 1, data->ws_rule);
 		if (!bad)
 			return;
 		data->status |= bad;
 		err = whitespace_error_string(bad);
-		fprintf(data->o->file, "%s:%d: %s.\n",
-			data->filename, data->lineno, err);
+		fprintf(data->o->file, "%s%s:%d: %s.\n",
+			line_prefix, data->filename, data->lineno, err);
 		free(err);
 		emit_line(data->o, set, reset, line, 1);
 		ws_check_emit(line + 1, len - 1, data->ws_rule,
@@ -1462,7 +1520,7 @@ static unsigned char *deflate_it(char *data,
 	return deflated;
 }
 
-static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two)
+static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two, char *prefix)
 {
 	void *cp;
 	void *delta;
@@ -1491,13 +1549,13 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two)
 	}
 
 	if (delta && delta_size < deflate_size) {
-		fprintf(file, "delta %lu\n", orig_size);
+		fprintf(file, "%sdelta %lu\n", prefix, orig_size);
 		free(deflated);
 		data = delta;
 		data_size = delta_size;
 	}
 	else {
-		fprintf(file, "literal %lu\n", two->size);
+		fprintf(file, "%sliteral %lu\n", prefix, two->size);
 		free(delta);
 		data = deflated;
 		data_size = deflate_size;
@@ -1515,18 +1573,19 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two)
 			line[0] = bytes - 26 + 'a' - 1;
 		encode_85(line + 1, cp, bytes);
 		cp = (char *) cp + bytes;
+		fprintf(file, "%s", prefix);
 		fputs(line, file);
 		fputc('\n', file);
 	}
-	fprintf(file, "\n");
+	fprintf(file, "%s\n", prefix);
 	free(data);
 }
 
-static void emit_binary_diff(FILE *file, mmfile_t *one, mmfile_t *two)
+static void emit_binary_diff(FILE *file, mmfile_t *one, mmfile_t *two, char *prefix)
 {
-	fprintf(file, "GIT binary patch\n");
-	emit_binary_diff_body(file, one, two);
-	emit_binary_diff_body(file, two, one);
+	fprintf(file, "%sGIT binary patch\n", prefix);
+	emit_binary_diff_body(file, one, two, prefix);
+	emit_binary_diff_body(file, two, one, prefix);
 }
 
 static void diff_filespec_load_driver(struct diff_filespec *one)
@@ -1615,6 +1674,13 @@ static void builtin_diff(const char *name_a,
 	struct userdiff_driver *textconv_one = NULL;
 	struct userdiff_driver *textconv_two = NULL;
 	struct strbuf header = STRBUF_INIT;
+	struct strbuf *msgbuf;
+	char *line_prefix = "";
+
+	if (o->output_prefix) {
+		msgbuf = o->output_prefix(o->file, o->output_prefix_data);
+		line_prefix = msgbuf->buf;
+	}
 
 	if (DIFF_OPT_TST(o, SUBMODULE_LOG) &&
 			(!one->mode || S_ISGITLINK(one->mode)) &&
@@ -1649,22 +1715,22 @@ static void builtin_diff(const char *name_a,
 	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
-	strbuf_addf(&header, "%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
+	strbuf_addf(&header, "%s%sdiff --git %s %s%s\n", line_prefix, set, a_one, b_two, reset);
 	if (lbl[0][0] == '/') {
 		/* /dev/null */
-		strbuf_addf(&header, "%snew file mode %06o%s\n", set, two->mode, reset);
+		strbuf_addf(&header, "%s%snew file mode %06o%s\n", line_prefix, set, two->mode, reset);
 		if (xfrm_msg && xfrm_msg[0])
 			strbuf_addf(&header, "%s%s%s\n", set, xfrm_msg, reset);
 	}
 	else if (lbl[1][0] == '/') {
-		strbuf_addf(&header, "%sdeleted file mode %06o%s\n", set, one->mode, reset);
+		strbuf_addf(&header, "%s%sdeleted file mode %06o%s\n", line_prefix, set, one->mode, reset);
 		if (xfrm_msg && xfrm_msg[0])
 			strbuf_addf(&header, "%s%s%s\n", set, xfrm_msg, reset);
 	}
 	else {
 		if (one->mode != two->mode) {
-			strbuf_addf(&header, "%sold mode %06o%s\n", set, one->mode, reset);
-			strbuf_addf(&header, "%snew mode %06o%s\n", set, two->mode, reset);
+			strbuf_addf(&header, "%s%sold mode %06o%s\n", line_prefix, set, one->mode, reset);
+			strbuf_addf(&header, "%s%snew mode %06o%s\n", line_prefix, set, two->mode, reset);
 		}
 		if (xfrm_msg && xfrm_msg[0])
 			strbuf_addf(&header, "%s%s%s\n", set, xfrm_msg, reset);
@@ -1699,10 +1765,10 @@ static void builtin_diff(const char *name_a,
 		fprintf(o->file, "%s", header.buf);
 		strbuf_reset(&header);
 		if (DIFF_OPT_TST(o, BINARY))
-			emit_binary_diff(o->file, &mf1, &mf2);
+			emit_binary_diff(o->file, &mf1, &mf2, line_prefix);
 		else
-			fprintf(o->file, "Binary files %s and %s differ\n",
-				lbl[0], lbl[1]);
+			fprintf(o->file, "%sBinary files %s and %s differ\n",
+				line_prefix, lbl[0], lbl[1]);
 		o->found_changes = 1;
 	}
 	else {
@@ -2312,28 +2378,36 @@ static void fill_metainfo(struct strbuf *msg,
 			  struct diff_options *o,
 			  struct diff_filepair *p)
 {
+	struct strbuf *msgbuf;
+	char *line_prefix = "";
+
+	if (o->output_prefix) {
+		msgbuf = o->output_prefix(o->file, o->output_prefix_data);
+		line_prefix = msgbuf->buf;
+	}
+
 	strbuf_init(msg, PATH_MAX * 2 + 300);
 	switch (p->status) {
 	case DIFF_STATUS_COPIED:
-		strbuf_addf(msg, "similarity index %d%%", similarity_index(p));
-		strbuf_addstr(msg, "\ncopy from ");
+		strbuf_addf(msg, "%ssimilarity index %d%%", line_prefix, similarity_index(p));
+		strbuf_addf(msg, "\n%scopy from ", line_prefix);
 		quote_c_style(name, msg, NULL, 0);
-		strbuf_addstr(msg, "\ncopy to ");
+		strbuf_addf(msg, "\n%scopy to ", line_prefix);
 		quote_c_style(other, msg, NULL, 0);
 		strbuf_addch(msg, '\n');
 		break;
 	case DIFF_STATUS_RENAMED:
-		strbuf_addf(msg, "similarity index %d%%", similarity_index(p));
-		strbuf_addstr(msg, "\nrename from ");
+		strbuf_addf(msg, "%ssimilarity index %d%%", line_prefix, similarity_index(p));
+		strbuf_addf(msg, "\n%srename from ", line_prefix);
 		quote_c_style(name, msg, NULL, 0);
-		strbuf_addstr(msg, "\nrename to ");
+		strbuf_addf(msg, "\n%srename to ", line_prefix);
 		quote_c_style(other, msg, NULL, 0);
 		strbuf_addch(msg, '\n');
 		break;
 	case DIFF_STATUS_MODIFIED:
 		if (p->score) {
-			strbuf_addf(msg, "dissimilarity index %d%%\n",
-				    similarity_index(p));
+			strbuf_addf(msg, "%sdissimilarity index %d%%\n",
+				    line_prefix, similarity_index(p));
 			break;
 		}
 		/* fallthru */
@@ -2350,8 +2424,8 @@ static void fill_metainfo(struct strbuf *msg,
 			    (!fill_mmfile(&mf, two) && diff_filespec_is_binary(two)))
 				abbrev = 40;
 		}
-		strbuf_addf(msg, "index %.*s..%.*s",
-			    abbrev, sha1_to_hex(one->sha1),
+		strbuf_addf(msg, "%sindex %.*s..%.*s",
+			    line_prefix, abbrev, sha1_to_hex(one->sha1),
 			    abbrev, sha1_to_hex(two->sha1));
 		if (one->mode == two->mode)
 			strbuf_addf(msg, " %06o", one->mode);
@@ -3030,6 +3104,11 @@ static void diff_flush_raw(struct diff_filepair *p, struct diff_options *opt)
 {
 	int line_termination = opt->line_termination;
 	int inter_name_termination = line_termination ? '\t' : '\0';
+	if (opt->output_prefix) {
+		struct strbuf *msg = NULL;
+		msg = opt->output_prefix(opt->file, opt->output_prefix_data);
+		fprintf(opt->file, "%s", msg->buf);
+	}
 
 	if (!(opt->output_format & DIFF_FORMAT_NAME_STATUS)) {
 		fprintf(opt->file, ":%06o %06o %s ", p->one->mode, p->two->mode,
-- 
1.6.0.4
