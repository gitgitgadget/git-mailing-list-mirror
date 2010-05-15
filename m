From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 4/7] diff.c: Output the text graph padding before each diff line.
Date: Sat, 15 May 2010 04:02:08 -0700
Message-ID: <1273921331-32702-5-git-send-email-struggleyb.nku@gmail.com>
References: <1273921331-32702-1-git-send-email-struggleyb.nku@gmail.com>
 <1273921331-32702-2-git-send-email-struggleyb.nku@gmail.com>
 <1273921331-32702-3-git-send-email-struggleyb.nku@gmail.com>
 <1273921331-32702-4-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 13:02:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODF8q-0007wy-Kf
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 13:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754935Ab0EOLC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 07:02:28 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:38340 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842Ab0EOLCV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 07:02:21 -0400
Received: by pxi5 with SMTP id 5so1784458pxi.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 04:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6MJ+xgZ/w/5bXAIhX5IoYFms3tZgmqcT2mkIMFvR+68=;
        b=p5jGjE5yIrAuXl4OSHE6re1SS2nkcLlOcRDlIkusU2i2y8JWKTP1Okp8Fuu+/atBki
         zC+eTAKkamNzZztJqIYNYrWYTQT86xcE+lAHe6NRK0Ma4iXPZ+R5d7mTwvk6gXjkFjBb
         yuqTpfgh+og6CVFNd9DoT8kZ9tSQ8FuZMz+GU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SvPv9Ru5o/tek66CVe55YRihazvLTP8WnbojzEt9F0kIFm+F4Jh+DfnmSHV3nizxsk
         dRIBuQBxNBMrp2mQWg4eabFRNVSrnX/pE/VrfrfzkY1OXHJ3V53btoEC67cBtL6E6EYR
         elhgxOSTfaoNdPa7/L4KVgMeX9Jz3vEmWv3l4=
Received: by 10.115.98.12 with SMTP id a12mr2153486wam.55.1273921340120;
        Sat, 15 May 2010 04:02:20 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id d16sm28703988wam.12.2010.05.15.04.02.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 04:02:19 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1273921331-32702-4-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147144>

Change -p/--dirstat/--binary/--numstat/--stat/--shortstat
to align with graph paddings.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 diff.c |  158 +++++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 116 insertions(+), 42 deletions(-)

diff --git a/diff.c b/diff.c
index 9bd9063..4a10d16 100644
--- a/diff.c
+++ b/diff.c
@@ -487,6 +487,13 @@ static void emit_rewrite_diff(const char *name_a,
 	char *data_one, *data_two;
 	size_t size_one, size_two;
 	struct emit_callback ecbdata;
+	char *line_prefix = "";
+	struct strbuf *msgbuf;
+
+	if (o && o->output_prefix) {
+		msgbuf = o->output_prefix(o->file, 0, o->output_prefix_data);
+		line_prefix = msgbuf->buf;
+	}
 
 	if (diff_mnemonic_prefix && DIFF_OPT_TST(o, REVERSE_DIFF)) {
 		a_prefix = o->b_prefix;
@@ -528,9 +535,10 @@ static void emit_rewrite_diff(const char *name_a,
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
@@ -789,9 +797,17 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	const char *meta = diff_get_color(ecbdata->color_diff, DIFF_METAINFO);
 	const char *plain = diff_get_color(ecbdata->color_diff, DIFF_PLAIN);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
+	struct diff_options *o = ecbdata->opt;
+	char *line_prefix = "";
+	struct strbuf *msgbuf;
+
+	if (o && o->output_prefix) {
+		msgbuf = o->output_prefix(o->file, 0, o->output_prefix_data);
+		line_prefix = msgbuf->buf;
+	}
 
 	if (ecbdata->header) {
-		fprintf(ecbdata->file, "%s", ecbdata->header->buf);
+		fprintf(ecbdata->opt->file, "%s", ecbdata->header->buf);
 		strbuf_reset(ecbdata->header);
 		ecbdata->header = NULL;
 	}
@@ -803,10 +819,10 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		name_a_tab = strchr(ecbdata->label_path[0], ' ') ? "\t" : "";
 		name_b_tab = strchr(ecbdata->label_path[1], ' ') ? "\t" : "";
 
-		fprintf(ecbdata->file, "%s--- %s%s%s\n",
-			meta, ecbdata->label_path[0], reset, name_a_tab);
-		fprintf(ecbdata->file, "%s+++ %s%s%s\n",
-			meta, ecbdata->label_path[1], reset, name_b_tab);
+		fprintf(ecbdata->opt->file, "%s%s--- %s%s%s\n",
+			line_prefix, meta, ecbdata->label_path[0], reset, name_a_tab);
+		fprintf(ecbdata->opt->file, "%s%s+++ %s%s%s\n",
+			line_prefix, meta, ecbdata->label_path[1], reset, name_b_tab);
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
 
@@ -823,7 +839,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		find_lno(line, ecbdata);
 		emit_hunk_header(ecbdata, line, len);
 		if (line[len-1] != '\n')
-			putc('\n', ecbdata->file);
+			putc('\n', ecbdata->opt->file);
 		return;
 	}
 
@@ -1109,6 +1125,10 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		}
 
 		if (data->files[i]->is_binary) {
+			if (options->output_prefix) {
+				options->output_prefix(options->file,
+						1, options->output_prefix_data);
+			}
 			show_name(options->file, prefix, name, len);
 			fprintf(options->file, "  Bin ");
 			fprintf(options->file, "%s%"PRIuMAX"%s",
@@ -1121,6 +1141,10 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			continue;
 		}
 		else if (data->files[i]->is_unmerged) {
+			if (options->output_prefix) {
+				options->output_prefix(options->file,
+						1, options->output_prefix_data);
+			}
 			show_name(options->file, prefix, name, len);
 			fprintf(options->file, "  Unmerged\n");
 			continue;
@@ -1143,6 +1167,10 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			add = scale_linear(add, width, max_change);
 			del = scale_linear(del, width, max_change);
 		}
+		if (options->output_prefix) {
+			options->output_prefix(options->file,
+					1, options->output_prefix_data);
+		}
 		show_name(options->file, prefix, name, len);
 		fprintf(options->file, "%5"PRIuMAX"%s", added + deleted,
 				added + deleted ? " " : "");
@@ -1150,6 +1178,10 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		show_graph(options->file, '-', del, del_c, reset);
 		fprintf(options->file, "\n");
 	}
+	if (options->output_prefix) {
+		options->output_prefix(options->file,
+				1, options->output_prefix_data);
+	}
 	fprintf(options->file,
 	       " %d files changed, %d insertions(+), %d deletions(-)\n",
 	       total_files, adds, dels);
@@ -1176,6 +1208,10 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 			}
 		}
 	}
+	if (options->output_prefix) {
+		options->output_prefix(options->file,
+				1, options->output_prefix_data);
+	}
 	fprintf(options->file, " %d files changed, %d insertions(+), %d deletions(-)\n",
 	       total_files, adds, dels);
 }
@@ -1190,6 +1226,11 @@ static void show_numstat(struct diffstat_t *data, struct diff_options *options)
 	for (i = 0; i < data->nr; i++) {
 		struct diffstat_file *file = data->files[i];
 
+		if (options->output_prefix) {
+			options->output_prefix(options->file,
+					1, options->output_prefix_data);
+		}
+
 		if (file->is_binary)
 			fprintf(options->file, "-\t-\t");
 		else
@@ -1225,10 +1266,12 @@ struct dirstat_dir {
 	int alloc, nr, percent, cumulative;
 };
 
-static long gather_dirstat(FILE *file, struct dirstat_dir *dir, unsigned long changed, const char *base, int baselen)
+static long gather_dirstat(struct diff_options *opt, struct dirstat_dir *dir, unsigned long changed, const char *base, int baselen)
 {
 	unsigned long this_dir = 0;
 	unsigned int sources = 0;
+	assert(opt);
+	FILE *file = opt->file;
 
 	while (dir->nr) {
 		struct dirstat_file *f = dir->files;
@@ -1243,7 +1286,7 @@ static long gather_dirstat(FILE *file, struct dirstat_dir *dir, unsigned long ch
 		slash = strchr(f->name + baselen, '/');
 		if (slash) {
 			int newbaselen = slash + 1 - f->name;
-			this = gather_dirstat(file, dir, changed, f->name, newbaselen);
+			this = gather_dirstat(opt, dir, changed, f->name, newbaselen);
 			sources++;
 		} else {
 			this = f->changed;
@@ -1265,6 +1308,9 @@ static long gather_dirstat(FILE *file, struct dirstat_dir *dir, unsigned long ch
 		if (permille) {
 			int percent = permille / 10;
 			if (percent >= dir->percent) {
+				if (opt->output_prefix) {
+					opt->output_prefix(file, 1, opt->output_prefix_data);
+				}
 				fprintf(file, "%4d.%01d%% %.*s\n", percent, permille % 10, baselen, base);
 				if (!dir->cumulative)
 					return 0;
@@ -1345,7 +1391,7 @@ static void show_dirstat(struct diff_options *options)
 
 	/* Show all directories with more than x% of the changes */
 	qsort(dir.files, dir.nr, sizeof(dir.files[0]), dirstat_compare);
-	gather_dirstat(options->file, &dir, changed, "", 0);
+	gather_dirstat(options, &dir, changed, "", 0);
 }
 
 static void free_diffstat_info(struct diffstat_t *diffstat)
@@ -1403,6 +1449,15 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 	const char *reset = diff_get_color(color_diff, DIFF_RESET);
 	const char *set = diff_get_color(color_diff, DIFF_FILE_NEW);
 	char *err;
+	char *line_prefix = "";
+	struct strbuf *msgbuf;
+
+	assert(data->o);
+	if (data->o->output_prefix) {
+		msgbuf = data->o->output_prefix(data->o->file, 0,
+			data->o->output_prefix_data);
+		line_prefix = msgbuf->buf;
+	}
 
 	if (line[0] == '+') {
 		unsigned bad;
@@ -1410,16 +1465,16 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
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
@@ -1459,7 +1514,7 @@ static unsigned char *deflate_it(char *data,
 	return deflated;
 }
 
-static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two)
+static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two, char *prefix)
 {
 	void *cp;
 	void *delta;
@@ -1488,13 +1543,13 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two)
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
@@ -1512,18 +1567,19 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two)
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
@@ -1612,6 +1668,13 @@ static void builtin_diff(const char *name_a,
 	struct userdiff_driver *textconv_one = NULL;
 	struct userdiff_driver *textconv_two = NULL;
 	struct strbuf header = STRBUF_INIT;
+	struct strbuf *msgbuf;
+	char *line_prefix = "";
+
+	if (o->output_prefix) {
+		msgbuf = o->output_prefix(o->file, 0, o->output_prefix_data);
+		line_prefix = msgbuf->buf;
+	}
 
 	if (DIFF_OPT_TST(o, SUBMODULE_LOG) &&
 			(!one->mode || S_ISGITLINK(one->mode)) &&
@@ -1646,22 +1709,22 @@ static void builtin_diff(const char *name_a,
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
@@ -1696,10 +1759,10 @@ static void builtin_diff(const char *name_a,
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
@@ -2309,28 +2372,36 @@ static void fill_metainfo(struct strbuf *msg,
 			  struct diff_options *o,
 			  struct diff_filepair *p)
 {
+	struct strbuf *msgbuf;
+	char *line_prefix = "";
+
+	if (o->output_prefix) {
+		msgbuf = o->output_prefix(o->file, 0, o->output_prefix_data);
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
@@ -2347,8 +2418,8 @@ static void fill_metainfo(struct strbuf *msg,
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
@@ -3027,6 +3098,9 @@ static void diff_flush_raw(struct diff_filepair *p, struct diff_options *opt)
 {
 	int line_termination = opt->line_termination;
 	int inter_name_termination = line_termination ? '\t' : '\0';
+	if (opt->output_prefix) {
+		opt->output_prefix(opt->file, 1, opt->output_prefix_data);
+	}
 
 	if (!(opt->output_format & DIFF_FORMAT_NAME_STATUS)) {
 		fprintf(opt->file, ":%06o %06o %s ", p->one->mode, p->two->mode,
-- 
1.7.1.94.gc3269
