From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Write diff output to a file in struct diff_options
Date: Sun, 9 Mar 2008 22:43:39 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803092235150.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 03:44:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYXzy-0004Nx-Ex
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 03:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbYCJCnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 22:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754539AbYCJCnp
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 22:43:45 -0400
Received: from iabervon.org ([66.92.72.58]:48611 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754481AbYCJCnm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 22:43:42 -0400
Received: (qmail 30091 invoked by uid 1000); 10 Mar 2008 02:43:39 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Mar 2008 02:43:39 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76692>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
I remember there being some expectation that this would be difficult, but 
it was a pretty straightforward conversion, so I'm wondering if I've 
missed something. In any case, this is missing tests and documentation for 
--output=, but I really want it to use directly for rebase-interactive, 
and I only did the command line option so I could do informal testing.

 diff.c |  306 +++++++++++++++++++++++++++++++++++-----------------------------
 diff.h |    3 +
 2 files changed, 169 insertions(+), 140 deletions(-)

diff --git a/diff.c b/diff.c
index 00e1590..3a0b077 100644
--- a/diff.c
+++ b/diff.c
@@ -256,40 +256,41 @@ static int count_lines(const char *data, int size)
 	return count;
 }
 
-static void print_line_count(int count)
+static void print_line_count(FILE *file, int count)
 {
 	switch (count) {
 	case 0:
-		printf("0,0");
+		fprintf(file, "0,0");
 		break;
 	case 1:
-		printf("1");
+		fprintf(file, "1");
 		break;
 	default:
-		printf("1,%d", count);
+		fprintf(file, "1,%d", count);
 		break;
 	}
 }
 
-static void copy_file_with_prefix(int prefix, const char *data, int size,
+static void copy_file_with_prefix(FILE *file,
+				  int prefix, const char *data, int size,
 				  const char *set, const char *reset)
 {
 	int ch, nl_just_seen = 1;
 	while (0 < size--) {
 		ch = *data++;
 		if (nl_just_seen) {
-			fputs(set, stdout);
-			putchar(prefix);
+			fputs(set, file);
+			putc(prefix, file);
 		}
 		if (ch == '\n') {
 			nl_just_seen = 1;
-			fputs(reset, stdout);
+			fputs(reset, file);
 		} else
 			nl_just_seen = 0;
-		putchar(ch);
+		putc(ch, file);
 	}
 	if (!nl_just_seen)
-		printf("%s\n\\ No newline at end of file\n", reset);
+		fprintf(file, "%s\n\\ No newline at end of file\n", reset);
 }
 
 static void emit_rewrite_diff(const char *name_a,
@@ -322,17 +323,18 @@ static void emit_rewrite_diff(const char *name_a,
 	diff_populate_filespec(two, 0);
 	lc_a = count_lines(one->data, one->size);
 	lc_b = count_lines(two->data, two->size);
-	printf("%s--- %s%s%s\n%s+++ %s%s%s\n%s@@ -",
-	       metainfo, a_name.buf, name_a_tab, reset,
-	       metainfo, b_name.buf, name_b_tab, reset, fraginfo);
-	print_line_count(lc_a);
-	printf(" +");
-	print_line_count(lc_b);
-	printf(" @@%s\n", reset);
+	fprintf(o->file,
+		"%s--- %s%s%s\n%s+++ %s%s%s\n%s@@ -",
+		metainfo, a_name.buf, name_a_tab, reset,
+		metainfo, b_name.buf, name_b_tab, reset, fraginfo);
+	print_line_count(o->file, lc_a);
+	fprintf(o->file, " +");
+	print_line_count(o->file, lc_b);
+	fprintf(o->file, " @@%s\n", reset);
 	if (lc_a)
-		copy_file_with_prefix('-', one->data, one->size, old, reset);
+		copy_file_with_prefix(o->file, '-', one->data, one->size, old, reset);
 	if (lc_b)
-		copy_file_with_prefix('+', two->data, two->size, new, reset);
+		copy_file_with_prefix(o->file, '+', two->data, two->size, new, reset);
 }
 
 static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
@@ -372,9 +374,10 @@ static void diff_words_append(char *line, unsigned long len,
 struct diff_words_data {
 	struct xdiff_emit_state xm;
 	struct diff_words_buffer minus, plus;
+	FILE *file;
 };
 
-static void print_word(struct diff_words_buffer *buffer, int len, int color,
+static void print_word(FILE *file, struct diff_words_buffer *buffer, int len, int color,
 		int suppress_newline)
 {
 	const char *ptr;
@@ -391,15 +394,15 @@ static void print_word(struct diff_words_buffer *buffer, int len, int color,
 		len--;
 	}
 
-	fputs(diff_get_color(1, color), stdout);
-	fwrite(ptr, len, 1, stdout);
-	fputs(diff_get_color(1, DIFF_RESET), stdout);
+	fputs(diff_get_color(1, color), file);
+	fwrite(ptr, len, 1, file);
+	fputs(diff_get_color(1, DIFF_RESET), file);
 
 	if (eol) {
 		if (suppress_newline)
 			buffer->suppressed_newline = 1;
 		else
-			putchar('\n');
+			putc('\n', file);
 	}
 }
 
@@ -409,20 +412,23 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 
 	if (diff_words->minus.suppressed_newline) {
 		if (line[0] != '+')
-			putchar('\n');
+			putc('\n', diff_words->file);
 		diff_words->minus.suppressed_newline = 0;
 	}
 
 	len--;
 	switch (line[0]) {
 		case '-':
-			print_word(&diff_words->minus, len, DIFF_FILE_OLD, 1);
+			print_word(diff_words->file,
+				   &diff_words->minus, len, DIFF_FILE_OLD, 1);
 			break;
 		case '+':
-			print_word(&diff_words->plus, len, DIFF_FILE_NEW, 0);
+			print_word(diff_words->file,
+				   &diff_words->plus, len, DIFF_FILE_NEW, 0);
 			break;
 		case ' ':
-			print_word(&diff_words->plus, len, DIFF_PLAIN, 0);
+			print_word(diff_words->file,
+				   &diff_words->plus, len, DIFF_PLAIN, 0);
 			diff_words->minus.current += len;
 			break;
 	}
@@ -466,7 +472,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	diff_words->minus.text.size = diff_words->plus.text.size = 0;
 
 	if (diff_words->minus.suppressed_newline) {
-		putchar('\n');
+		putc('\n', diff_words->file);
 		diff_words->minus.suppressed_newline = 0;
 	}
 }
@@ -481,6 +487,7 @@ struct emit_callback {
 	const char **label_path;
 	struct diff_words_data *diff_words;
 	int *found_changesp;
+	FILE *file;
 };
 
 static void free_diff_words_data(struct emit_callback *ecbdata)
@@ -505,11 +512,11 @@ const char *diff_get_color(int diff_use_color, enum color_diff ix)
 	return "";
 }
 
-static void emit_line(const char *set, const char *reset, const char *line, int len)
+static void emit_line(FILE *file, const char *set, const char *reset, const char *line, int len)
 {
-	fputs(set, stdout);
-	fwrite(line, len, 1, stdout);
-	fputs(reset, stdout);
+	fputs(set, file);
+	fwrite(line, len, 1, file);
+	fputs(reset, file);
 }
 
 static void emit_add_line(const char *reset, struct emit_callback *ecbdata, const char *line, int len)
@@ -518,13 +525,13 @@ static void emit_add_line(const char *reset, struct emit_callback *ecbdata, cons
 	const char *set = diff_get_color(ecbdata->color_diff, DIFF_FILE_NEW);
 
 	if (!*ws)
-		emit_line(set, reset, line, len);
+		emit_line(ecbdata->file, set, reset, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line(set, reset, line, ecbdata->nparents);
+		emit_line(ecbdata->file, set, reset, line, ecbdata->nparents);
 		(void)check_and_emit_line(line + ecbdata->nparents,
 		    len - ecbdata->nparents, ecbdata->ws_rule,
-		    stdout, set, reset, ws);
+		    ecbdata->file, set, reset, ws);
 	}
 }
 
@@ -563,10 +570,10 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		name_a_tab = strchr(ecbdata->label_path[0], ' ') ? "\t" : "";
 		name_b_tab = strchr(ecbdata->label_path[1], ' ') ? "\t" : "";
 
-		printf("%s--- %s%s%s\n",
-		       meta, ecbdata->label_path[0], reset, name_a_tab);
-		printf("%s+++ %s%s%s\n",
-		       meta, ecbdata->label_path[1], reset, name_b_tab);
+		fprintf(ecbdata->file, "%s--- %s%s%s\n",
+			meta, ecbdata->label_path[0], reset, name_a_tab);
+		fprintf(ecbdata->file, "%s+++ %s%s%s\n",
+			meta, ecbdata->label_path[1], reset, name_b_tab);
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
 
@@ -578,15 +585,16 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	if (2 <= i && i < len && line[i] == ' ') {
 		ecbdata->nparents = i - 1;
 		len = sane_truncate_line(ecbdata, line, len);
-		emit_line(diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO),
+		emit_line(ecbdata->file, 
+			  diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO),
 			  reset, line, len);
 		if (line[len-1] != '\n')
-			putchar('\n');
+			putc('\n', ecbdata->file);
 		return;
 	}
 
 	if (len < ecbdata->nparents) {
-		emit_line(reset, reset, line, len);
+		emit_line(ecbdata->file, reset, reset, line, len);
 		return;
 	}
 
@@ -609,7 +617,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			diff_words_show(ecbdata->diff_words);
 		line++;
 		len--;
-		emit_line(plain, reset, line, len);
+		emit_line(ecbdata->file, plain, reset, line, len);
 		return;
 	}
 	for (i = 0; i < ecbdata->nparents && len; i++) {
@@ -620,7 +628,8 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	}
 
 	if (color != DIFF_FILE_NEW) {
-		emit_line(diff_get_color(ecbdata->color_diff, color),
+		emit_line(ecbdata->file,
+			  diff_get_color(ecbdata->color_diff, color),
 			  reset, line, len);
 		return;
 	}
@@ -759,20 +768,21 @@ static int scale_linear(int it, int width, int max_change)
 	return ((it - 1) * (width - 1) + max_change - 1) / (max_change - 1);
 }
 
-static void show_name(const char *prefix, const char *name, int len,
+static void show_name(FILE *file,
+		      const char *prefix, const char *name, int len,
 		      const char *reset, const char *set)
 {
-	printf(" %s%s%-*s%s |", set, prefix, len, name, reset);
+	fprintf(file, " %s%s%-*s%s |", set, prefix, len, name, reset);
 }
 
-static void show_graph(char ch, int cnt, const char *set, const char *reset)
+static void show_graph(FILE *file, char ch, int cnt, const char *set, const char *reset)
 {
 	if (cnt <= 0)
 		return;
-	printf("%s", set);
+	fprintf(file, "%s", set);
 	while (cnt--)
-		putchar(ch);
-	printf("%s", reset);
+		putc(ch, file);
+	fprintf(file, "%s", reset);
 }
 
 static void fill_print_name(struct diffstat_file *file)
@@ -877,18 +887,18 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 		}
 
 		if (data->files[i]->is_binary) {
-			show_name(prefix, name, len, reset, set);
-			printf("  Bin ");
-			printf("%s%d%s", del_c, deleted, reset);
-			printf(" -> ");
-			printf("%s%d%s", add_c, added, reset);
-			printf(" bytes");
-			printf("\n");
+			show_name(options->file, prefix, name, len, reset, set);
+			fprintf(options->file, "  Bin ");
+			fprintf(options->file, "%s%d%s", del_c, deleted, reset);
+			fprintf(options->file, " -> ");
+			fprintf(options->file, "%s%d%s", add_c, added, reset);
+			fprintf(options->file, " bytes");
+			fprintf(options->file, "\n");
 			continue;
 		}
 		else if (data->files[i]->is_unmerged) {
-			show_name(prefix, name, len, reset, set);
-			printf("  Unmerged\n");
+			show_name(options->file, prefix, name, len, reset, set);
+			fprintf(options->file, "  Unmerged\n");
 			continue;
 		}
 		else if (!data->files[i]->is_renamed &&
@@ -911,17 +921,18 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 			del = scale_linear(del, width, max_change);
 			total = add + del;
 		}
-		show_name(prefix, name, len, reset, set);
-		printf("%5d ", added + deleted);
-		show_graph('+', add, add_c, reset);
-		show_graph('-', del, del_c, reset);
-		putchar('\n');
-	}
-	printf("%s %d files changed, %d insertions(+), %d deletions(-)%s\n",
+		show_name(options->file, prefix, name, len, reset, set);
+		fprintf(options->file, "%5d ", added + deleted);
+		show_graph(options->file, '+', add, add_c, reset);
+		show_graph(options->file, '-', del, del_c, reset);
+		fprintf(options->file, "\n");
+	}
+	fprintf(options->file,
+	       "%s %d files changed, %d insertions(+), %d deletions(-)%s\n",
 	       set, total_files, adds, dels, reset);
 }
 
-static void show_shortstats(struct diffstat_t* data)
+static void show_shortstats(struct diffstat_t* data, struct diff_options *options)
 {
 	int i, adds = 0, dels = 0, total_files = data->nr;
 
@@ -942,7 +953,7 @@ static void show_shortstats(struct diffstat_t* data)
 			}
 		}
 	}
-	printf(" %d files changed, %d insertions(+), %d deletions(-)\n",
+	fprintf(options->file, " %d files changed, %d insertions(+), %d deletions(-)\n",
 	       total_files, adds, dels);
 }
 
@@ -957,24 +968,25 @@ static void show_numstat(struct diffstat_t* data, struct diff_options *options)
 		struct diffstat_file *file = data->files[i];
 
 		if (file->is_binary)
-			printf("-\t-\t");
+			fprintf(options->file, "-\t-\t");
 		else
-			printf("%d\t%d\t", file->added, file->deleted);
+			fprintf(options->file,
+				"%d\t%d\t", file->added, file->deleted);
 		if (options->line_termination) {
 			fill_print_name(file);
 			if (!file->is_renamed)
-				write_name_quoted(file->name, stdout,
+				write_name_quoted(file->name, options->file,
 						  options->line_termination);
 			else {
-				fputs(file->print_name, stdout);
-				putchar(options->line_termination);
+				fputs(file->print_name, options->file);
+				putc(options->line_termination, options->file);
 			}
 		} else {
 			if (file->is_renamed) {
-				putchar('\0');
-				write_name_quoted(file->from_name, stdout, '\0');
+				putc('\0', options->file);
+				write_name_quoted(file->from_name, options->file, '\0');
 			}
-			write_name_quoted(file->name, stdout, '\0');
+			write_name_quoted(file->name, options->file, '\0');
 		}
 	}
 }
@@ -984,7 +996,7 @@ struct diffstat_dir {
 	int nr, percent, cumulative;
 };
 
-static long gather_dirstat(struct diffstat_dir *dir, unsigned long changed, const char *base, int baselen)
+static long gather_dirstat(FILE *file, struct diffstat_dir *dir, unsigned long changed, const char *base, int baselen)
 {
 	unsigned long this_dir = 0;
 	unsigned int sources = 0;
@@ -1002,7 +1014,7 @@ static long gather_dirstat(struct diffstat_dir *dir, unsigned long changed, cons
 		slash = strchr(f->name + baselen, '/');
 		if (slash) {
 			int newbaselen = slash + 1 - f->name;
-			this = gather_dirstat(dir, changed, f->name, newbaselen);
+			this = gather_dirstat(file, dir, changed, f->name, newbaselen);
 			sources++;
 		} else {
 			if (f->is_unmerged || f->is_binary)
@@ -1027,7 +1039,7 @@ static long gather_dirstat(struct diffstat_dir *dir, unsigned long changed, cons
 		if (permille) {
 			int percent = permille / 10;
 			if (percent >= dir->percent) {
-				printf("%4d.%01d%% %.*s\n", percent, permille % 10, baselen, base);
+				fprintf(file, "%4d.%01d%% %.*s\n", percent, permille % 10, baselen, base);
 				if (!dir->cumulative)
 					return 0;
 			}
@@ -1060,7 +1072,7 @@ static void show_dirstat(struct diffstat_t *data, struct diff_options *options)
 	dir.nr = data->nr;
 	dir.percent = options->dirstat_percent;
 	dir.cumulative = options->output_format & DIFF_FORMAT_CUMULATIVE;
-	gather_dirstat(&dir, changed, "", 0);
+	gather_dirstat(options->file, &dir, changed, "", 0);
 }
 
 static void free_diffstat_info(struct diffstat_t *diffstat)
@@ -1083,6 +1095,7 @@ struct checkdiff_t {
 	int lineno, color_diff;
 	unsigned ws_rule;
 	unsigned status;
+	FILE *file;
 };
 
 static void checkdiff_consume(void *priv, char *line, unsigned long len)
@@ -1100,11 +1113,11 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 		if (!data->status)
 			return;
 		err = whitespace_error_string(data->status);
-		printf("%s:%d: %s.\n", data->filename, data->lineno, err);
+		fprintf(data->file, "%s:%d: %s.\n", data->filename, data->lineno, err);
 		free(err);
-		emit_line(set, reset, line, 1);
+		emit_line(data->file, set, reset, line, 1);
 		(void)check_and_emit_line(line + 1, len - 1, data->ws_rule,
-		    stdout, set, reset, ws);
+		    data->file, set, reset, ws);
 	} else if (line[0] == ' ')
 		data->lineno++;
 	else if (line[0] == '@') {
@@ -1140,7 +1153,7 @@ static unsigned char *deflate_it(char *data,
 	return deflated;
 }
 
-static void emit_binary_diff_body(mmfile_t *one, mmfile_t *two)
+static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two)
 {
 	void *cp;
 	void *delta;
@@ -1169,13 +1182,13 @@ static void emit_binary_diff_body(mmfile_t *one, mmfile_t *two)
 	}
 
 	if (delta && delta_size < deflate_size) {
-		printf("delta %lu\n", orig_size);
+		fprintf(file, "delta %lu\n", orig_size);
 		free(deflated);
 		data = delta;
 		data_size = delta_size;
 	}
 	else {
-		printf("literal %lu\n", two->size);
+		fprintf(file, "literal %lu\n", two->size);
 		free(delta);
 		data = deflated;
 		data_size = deflate_size;
@@ -1193,17 +1206,18 @@ static void emit_binary_diff_body(mmfile_t *one, mmfile_t *two)
 			line[0] = bytes - 26 + 'a' - 1;
 		encode_85(line + 1, cp, bytes);
 		cp = (char *) cp + bytes;
-		puts(line);
+		fputs(line, file);
+		fputc('\n', file);
 	}
-	printf("\n");
+	fprintf(file, "\n");
 	free(data);
 }
 
-static void emit_binary_diff(mmfile_t *one, mmfile_t *two)
+static void emit_binary_diff(FILE *file, mmfile_t *one, mmfile_t *two)
 {
-	printf("GIT binary patch\n");
-	emit_binary_diff_body(one, two);
-	emit_binary_diff_body(two, one);
+	fprintf(file, "GIT binary patch\n");
+	emit_binary_diff_body(file, one, two);
+	emit_binary_diff_body(file, two, one);
 }
 
 static void setup_diff_attr_check(struct git_attr_check *check)
@@ -1334,25 +1348,25 @@ static void builtin_diff(const char *name_a,
 	b_two = quote_two(o->b_prefix, name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
-	printf("%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
+	fprintf(o->file, "%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
 	if (lbl[0][0] == '/') {
 		/* /dev/null */
-		printf("%snew file mode %06o%s\n", set, two->mode, reset);
+		fprintf(o->file, "%snew file mode %06o%s\n", set, two->mode, reset);
 		if (xfrm_msg && xfrm_msg[0])
-			printf("%s%s%s\n", set, xfrm_msg, reset);
+			fprintf(o->file, "%s%s%s\n", set, xfrm_msg, reset);
 	}
 	else if (lbl[1][0] == '/') {
-		printf("%sdeleted file mode %06o%s\n", set, one->mode, reset);
+		fprintf(o->file, "%sdeleted file mode %06o%s\n", set, one->mode, reset);
 		if (xfrm_msg && xfrm_msg[0])
-			printf("%s%s%s\n", set, xfrm_msg, reset);
+			fprintf(o->file, "%s%s%s\n", set, xfrm_msg, reset);
 	}
 	else {
 		if (one->mode != two->mode) {
-			printf("%sold mode %06o%s\n", set, one->mode, reset);
-			printf("%snew mode %06o%s\n", set, two->mode, reset);
+			fprintf(o->file, "%sold mode %06o%s\n", set, one->mode, reset);
+			fprintf(o->file, "%snew mode %06o%s\n", set, two->mode, reset);
 		}
 		if (xfrm_msg && xfrm_msg[0])
-			printf("%s%s%s\n", set, xfrm_msg, reset);
+			fprintf(o->file, "%s%s%s\n", set, xfrm_msg, reset);
 		/*
 		 * we do not run diff between different kind
 		 * of objects.
@@ -1376,10 +1390,10 @@ static void builtin_diff(const char *name_a,
 		    !memcmp(mf1.ptr, mf2.ptr, mf1.size))
 			goto free_ab_and_return;
 		if (DIFF_OPT_TST(o, BINARY))
-			emit_binary_diff(&mf1, &mf2);
+			emit_binary_diff(o->file, &mf1, &mf2);
 		else
-			printf("Binary files %s and %s differ\n",
-			       lbl[0], lbl[1]);
+			fprintf(o->file, "Binary files %s and %s differ\n",
+				lbl[0], lbl[1]);
 		o->found_changes = 1;
 	}
 	else {
@@ -1401,6 +1415,7 @@ static void builtin_diff(const char *name_a,
 		ecbdata.color_diff = DIFF_OPT_TST(o, COLOR_DIFF);
 		ecbdata.found_changesp = &o->found_changes;
 		ecbdata.ws_rule = whitespace_rule(name_b ? name_b : name_a);
+		ecbdata.file = o->file;
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xecfg.ctxlen = o->context;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
@@ -1415,9 +1430,11 @@ static void builtin_diff(const char *name_a,
 		ecb.outf = xdiff_outf;
 		ecb.priv = &ecbdata;
 		ecbdata.xm.consume = fn_out_consume;
-		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS))
+		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS)) {
 			ecbdata.diff_words =
 				xcalloc(1, sizeof(struct diff_words_data));
+			ecbdata.diff_words->file = o->file;
+		}
 		xdi_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
 		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS))
 			free_diff_words_data(&ecbdata);
@@ -1496,6 +1513,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	data.lineno = 0;
 	data.color_diff = DIFF_OPT_TST(o, COLOR_DIFF);
 	data.ws_rule = whitespace_rule(attr_path);
+	data.file = o->file;
 
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
@@ -1966,7 +1984,7 @@ static void run_diff_cmd(const char *pgm,
 		builtin_diff(name, other ? other : name,
 			     one, two, xfrm_msg, o, complete_rewrite);
 	else
-		printf("* Unmerged path %s\n", name);
+		fprintf(o->file, "* Unmerged path %s\n", name);
 }
 
 static void diff_fill_sha1_info(struct diff_filespec *one)
@@ -2157,6 +2175,9 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 void diff_setup(struct diff_options *options)
 {
 	memset(options, 0, sizeof(*options));
+
+	options->file = stdout;
+
 	options->line_termination = '\n';
 	options->break_opt = -1;
 	options->rename_limit = -1;
@@ -2470,7 +2491,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->b_prefix = arg + 13;
 	else if (!strcmp(arg, "--no-prefix"))
 		options->a_prefix = options->b_prefix = "";
-	else
+	else if (!prefixcmp(arg, "--output=")) {
+		options->file = fopen(arg + strlen("--output="), "w");
+		options->close_file = 1;
+	} else
 		return 0;
 	return 1;
 }
@@ -2599,15 +2623,15 @@ static void diff_flush_raw(struct diff_filepair *p, struct diff_options *opt)
 	int inter_name_termination = line_termination ? '\t' : '\0';
 
 	if (!(opt->output_format & DIFF_FORMAT_NAME_STATUS)) {
-		printf(":%06o %06o %s ", p->one->mode, p->two->mode,
-		       diff_unique_abbrev(p->one->sha1, opt->abbrev));
-		printf("%s ", diff_unique_abbrev(p->two->sha1, opt->abbrev));
+		fprintf(opt->file, ":%06o %06o %s ", p->one->mode, p->two->mode,
+			diff_unique_abbrev(p->one->sha1, opt->abbrev));
+		fprintf(opt->file, "%s ", diff_unique_abbrev(p->two->sha1, opt->abbrev));
 	}
 	if (p->score) {
-		printf("%c%03d%c", p->status, similarity_index(p),
-			   inter_name_termination);
+		fprintf(opt->file, "%c%03d%c", p->status, similarity_index(p),
+			inter_name_termination);
 	} else {
-		printf("%c%c", p->status, inter_name_termination);
+		fprintf(opt->file, "%c%c", p->status, inter_name_termination);
 	}
 
 	if (p->status == DIFF_STATUS_COPIED ||
@@ -2616,14 +2640,14 @@ static void diff_flush_raw(struct diff_filepair *p, struct diff_options *opt)
 		name_a = p->one->path;
 		name_b = p->two->path;
 		strip_prefix(opt->prefix_length, &name_a, &name_b);
-		write_name_quoted(name_a, stdout, inter_name_termination);
-		write_name_quoted(name_b, stdout, line_termination);
+		write_name_quoted(name_a, opt->file, inter_name_termination);
+		write_name_quoted(name_b, opt->file, line_termination);
 	} else {
 		const char *name_a, *name_b;
 		name_a = p->one->mode ? p->one->path : p->two->path;
 		name_b = NULL;
 		strip_prefix(opt->prefix_length, &name_a, &name_b);
-		write_name_quoted(name_a, stdout, line_termination);
+		write_name_quoted(name_a, opt->file, line_termination);
 	}
 }
 
@@ -2825,62 +2849,62 @@ static void flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
 		name_a = p->two->path;
 		name_b = NULL;
 		strip_prefix(opt->prefix_length, &name_a, &name_b);
-		write_name_quoted(name_a, stdout, opt->line_termination);
+		write_name_quoted(name_a, opt->file, opt->line_termination);
 	}
 }
 
-static void show_file_mode_name(const char *newdelete, struct diff_filespec *fs)
+static void show_file_mode_name(FILE *file, const char *newdelete, struct diff_filespec *fs)
 {
 	if (fs->mode)
-		printf(" %s mode %06o ", newdelete, fs->mode);
+		fprintf(file, " %s mode %06o ", newdelete, fs->mode);
 	else
-		printf(" %s ", newdelete);
-	write_name_quoted(fs->path, stdout, '\n');
+		fprintf(file, " %s ", newdelete);
+	write_name_quoted(fs->path, file, '\n');
 }
 
 
-static void show_mode_change(struct diff_filepair *p, int show_name)
+static void show_mode_change(FILE *file, struct diff_filepair *p, int show_name)
 {
 	if (p->one->mode && p->two->mode && p->one->mode != p->two->mode) {
-		printf(" mode change %06o => %06o%c", p->one->mode, p->two->mode,
+		fprintf(file, " mode change %06o => %06o%c", p->one->mode, p->two->mode,
 			show_name ? ' ' : '\n');
 		if (show_name) {
-			write_name_quoted(p->two->path, stdout, '\n');
+			write_name_quoted(p->two->path, file, '\n');
 		}
 	}
 }
 
-static void show_rename_copy(const char *renamecopy, struct diff_filepair *p)
+static void show_rename_copy(FILE *file, const char *renamecopy, struct diff_filepair *p)
 {
 	char *names = pprint_rename(p->one->path, p->two->path);
 
-	printf(" %s %s (%d%%)\n", renamecopy, names, similarity_index(p));
+	fprintf(file, " %s %s (%d%%)\n", renamecopy, names, similarity_index(p));
 	free(names);
-	show_mode_change(p, 0);
+	show_mode_change(file, p, 0);
 }
 
-static void diff_summary(struct diff_filepair *p)
+static void diff_summary(FILE *file, struct diff_filepair *p)
 {
 	switch(p->status) {
 	case DIFF_STATUS_DELETED:
-		show_file_mode_name("delete", p->one);
+		show_file_mode_name(file, "delete", p->one);
 		break;
 	case DIFF_STATUS_ADDED:
-		show_file_mode_name("create", p->two);
+		show_file_mode_name(file, "create", p->two);
 		break;
 	case DIFF_STATUS_COPIED:
-		show_rename_copy("copy", p);
+		show_rename_copy(file, "copy", p);
 		break;
 	case DIFF_STATUS_RENAMED:
-		show_rename_copy("rename", p);
+		show_rename_copy(file, "rename", p);
 		break;
 	default:
 		if (p->score) {
-			fputs(" rewrite ", stdout);
-			write_name_quoted(p->two->path, stdout, ' ');
-			printf("(%d%%)\n", similarity_index(p));
+			fputs(" rewrite ", file);
+			write_name_quoted(p->two->path, file, ' ');
+			fprintf(file, "(%d%%)\n", similarity_index(p));
 		}
-		show_mode_change(p, !p->score);
+		show_mode_change(file, p, !p->score);
 		break;
 	}
 }
@@ -3088,14 +3112,14 @@ void diff_flush(struct diff_options *options)
 		if (output_format & DIFF_FORMAT_DIFFSTAT)
 			show_stats(&diffstat, options);
 		if (output_format & DIFF_FORMAT_SHORTSTAT)
-			show_shortstats(&diffstat);
+			show_shortstats(&diffstat, options);
 		free_diffstat_info(&diffstat);
 		separator++;
 	}
 
 	if (output_format & DIFF_FORMAT_SUMMARY && !is_summary_empty(q)) {
 		for (i = 0; i < q->nr; i++)
-			diff_summary(q->queue[i]);
+			diff_summary(options->file, q->queue[i]);
 		separator++;
 	}
 
@@ -3103,9 +3127,9 @@ void diff_flush(struct diff_options *options)
 		if (separator) {
 			if (options->stat_sep) {
 				/* attach patch instead of inline */
-				fputs(options->stat_sep, stdout);
+				fputs(options->stat_sep, options->file);
 			} else {
-				putchar(options->line_termination);
+				putc(options->line_termination, options->file);
 			}
 		}
 
@@ -3125,6 +3149,8 @@ free_queue:
 	free(q->queue);
 	q->queue = NULL;
 	q->nr = q->alloc = 0;
+	if (options->close_file)
+		fclose(options->file);
 }
 
 static void diffcore_apply_filter(const char *filter)
diff --git a/diff.h b/diff.h
index 9a652e7..f2c7739 100644
--- a/diff.h
+++ b/diff.h
@@ -98,6 +98,9 @@ struct diff_options {
 	/* this is set by diffcore for DIFF_FORMAT_PATCH */
 	int found_changes;
 
+	FILE *file;
+	int close_file;
+
 	int nr_paths;
 	const char **paths;
 	int *pathlens;
-- 
1.5.4.3.610.gea6cd
