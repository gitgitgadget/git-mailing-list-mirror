From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 1/2] Add diff --porcelain option for --color-words
Date: Sat, 3 Apr 2010 20:06:19 +0200
Message-ID: <f5741e49b2c09ec76def2d21a84a7da6ff7b8368.1270317502.git.trast@student.ethz.ch>
References: <cover.1270317502.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 03 20:06:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ny7k4-0005W5-QO
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 20:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845Ab0DCSG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 14:06:28 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:23839 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755775Ab0DCSGY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 14:06:24 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 3 Apr
 2010 20:06:21 +0200
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 3 Apr
 2010 20:06:22 +0200
X-Mailer: git-send-email 1.7.0.4.504.g4d2c
In-Reply-To: <cover.1270317502.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143893>

This teaches the --color-words mode a new option --porcelain that
disables color mode again and instead uses an ad-hoc format for the
word diff designed for machine reading:

* Newlines in the output are no longer significant

* Each diff unit is prefixed by [-+ ] and terminated by newline as
  before

* Newlines in the input are output as a line consisting only of a
  tilde '~'

Note that for backwards compatibility --color-words still implies
--color, so the order matters: if you say --porcelain --color-words,
the hunk headers will be colored; if you say --color-words
--porcelain, they won't.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/diff-options.txt |   11 ++++
 color.c                        |   28 -----------
 color.h                        |    1 -
 diff.c                         |  105 +++++++++++++++++++++++++++++++++-------
 diff.h                         |    1 +
 t/t4034-diff-words.sh          |   27 ++++++++++
 6 files changed, 127 insertions(+), 46 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 60e922e..ca9c7ad 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -142,6 +142,17 @@ The regex can also be set via a diff driver or configuration option, see
 linkgit:gitattributes[1] or linkgit:git-config[1].  Giving it explicitly
 overrides any diff driver or configuration setting.  Diff drivers
 override configuration settings.
++
+With `--porcelain`, use a variant of the unified diff format:
+Added/removed/unchanged runs of words are printed as a line starting
+with `+`/`-`/` ` (respectively) and terminated by a newline.  Newlines
+in the input are shown as a tilde `~` on a line of its own.
+
+--porcelain::
+	Switch to plumbing mode, designed for consumption by a
+	porcelain script.  Currently, this only affects
+	`--color-words`, which see.
+
 endif::git-format-patch[]
 
 --no-renames::
diff --git a/color.c b/color.c
index bcf4e2c..1b00554 100644
--- a/color.c
+++ b/color.c
@@ -211,31 +211,3 @@ int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...)
 	va_end(args);
 	return r;
 }
-
-/*
- * This function splits the buffer by newlines and colors the lines individually.
- *
- * Returns 0 on success.
- */
-int color_fwrite_lines(FILE *fp, const char *color,
-		size_t count, const char *buf)
-{
-	if (!*color)
-		return fwrite(buf, count, 1, fp) != 1;
-	while (count) {
-		char *p = memchr(buf, '\n', count);
-		if (p != buf && (fputs(color, fp) < 0 ||
-				fwrite(buf, p ? p - buf : count, 1, fp) != 1 ||
-				fputs(GIT_COLOR_RESET, fp) < 0))
-			return -1;
-		if (!p)
-			return 0;
-		if (fputc('\n', fp) < 0)
-			return -1;
-		count -= p + 1 - buf;
-		buf = p + 1;
-	}
-	return 0;
-}
-
-
diff --git a/color.h b/color.h
index 5c264b0..03ca064 100644
--- a/color.h
+++ b/color.h
@@ -61,6 +61,5 @@
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
 __attribute__((format (printf, 3, 4)))
 int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
-int color_fwrite_lines(FILE *fp, const char *color, size_t count, const char *buf);
 
 #endif /* COLOR_H */
diff --git a/diff.c b/diff.c
index f5d93e9..1b4d620 100644
--- a/diff.c
+++ b/diff.c
@@ -577,8 +577,62 @@ struct diff_words_data {
 	const char *current_plus;
 	FILE *file;
 	regex_t *word_regex;
+	int porcelain;
 };
 
+int color_fwrite_lines(FILE *fp, const char *color,
+		size_t count, const char *buf)
+{
+	if (!*color)
+		return fwrite(buf, count, 1, fp) != 1;
+	while (count) {
+		char *p = memchr(buf, '\n', count);
+		if (p != buf && (fputs(color, fp) < 0 ||
+				fwrite(buf, p ? p - buf : count, 1, fp) != 1 ||
+				fputs(GIT_COLOR_RESET, fp) < 0))
+			return -1;
+		if (!p)
+			return 0;
+		if (fputc('\n', fp) < 0)
+			return -1;
+		count -= p + 1 - buf;
+		buf = p + 1;
+	}
+	return 0;
+}
+
+static int fn_out_diff_words_write_helper(FILE *fp,
+					   const char *color, const char *prefix,
+					   size_t count, const char *buf,
+					   int porcelain)
+{
+	const char *suffix = "\n";
+	const char *newline = "~\n";
+
+	if (!porcelain) {
+		if (!color)
+			return fwrite(buf, count, 1, fp);
+		prefix = color;
+		suffix = GIT_COLOR_RESET;
+		newline = "\n";
+	}
+
+	while (count) {
+		char *p = memchr(buf, '\n', count);
+		if (p != buf && (fputs(prefix, fp) < 0 ||
+				 fwrite(buf, p ? p - buf : count, 1, fp) != 1 ||
+				 fputs(suffix, fp) < 0))
+			return -1;
+		if (!p)
+			return 0;
+		if (fputs(newline, fp) < 0)
+			return -1;
+		count -= p + 1 - buf;
+		buf = p + 1;
+	}
+	return 0;
+}
+
 static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 {
 	struct diff_words_data *diff_words = priv;
@@ -605,17 +659,21 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 		plus_begin = plus_end = diff_words->plus.orig[plus_first].end;
 
 	if (diff_words->current_plus != plus_begin)
-		fwrite(diff_words->current_plus,
-				plus_begin - diff_words->current_plus, 1,
-				diff_words->file);
+		fn_out_diff_words_write_helper(diff_words->file,
+				NULL, " ",
+				plus_begin - diff_words->current_plus,
+				diff_words->current_plus,
+				diff_words->porcelain);
 	if (minus_begin != minus_end)
-		color_fwrite_lines(diff_words->file,
-				diff_get_color(1, DIFF_FILE_OLD),
-				minus_end - minus_begin, minus_begin);
+		fn_out_diff_words_write_helper(diff_words->file,
+				diff_get_color(1, DIFF_FILE_OLD), "-",
+				minus_end - minus_begin, minus_begin,
+				diff_words->porcelain);
 	if (plus_begin != plus_end)
-		color_fwrite_lines(diff_words->file,
-				diff_get_color(1, DIFF_FILE_NEW),
-				plus_end - plus_begin, plus_begin);
+		fn_out_diff_words_write_helper(diff_words->file,
+				diff_get_color(1, DIFF_FILE_NEW), "+",
+				plus_end - plus_begin, plus_begin,
+				diff_words->porcelain);
 
 	diff_words->current_plus = plus_end;
 }
@@ -700,9 +758,10 @@ static void diff_words_show(struct diff_words_data *diff_words)
 
 	/* special case: only removal */
 	if (!diff_words->plus.text.size) {
-		color_fwrite_lines(diff_words->file,
-			diff_get_color(1, DIFF_FILE_OLD),
-			diff_words->minus.text.size, diff_words->minus.text.ptr);
+		fn_out_diff_words_write_helper(diff_words->file,
+			diff_get_color(1, DIFF_FILE_OLD), "-",
+			diff_words->minus.text.size, diff_words->minus.text.ptr,
+			diff_words->porcelain);
 		diff_words->minus.text.size = 0;
 		return;
 	}
@@ -722,10 +781,11 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	free(plus.ptr);
 	if (diff_words->current_plus != diff_words->plus.text.ptr +
 			diff_words->plus.text.size)
-		fwrite(diff_words->current_plus,
+		fn_out_diff_words_write_helper(diff_words->file,
+			NULL, " ",
 			diff_words->plus.text.ptr + diff_words->plus.text.size
-			- diff_words->current_plus, 1,
-			diff_words->file);
+			- diff_words->current_plus, diff_words->current_plus,
+			diff_words->porcelain);
 	diff_words->minus.text.size = diff_words->plus.text.size = 0;
 }
 
@@ -837,6 +897,8 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 
 	if (len < 1) {
 		emit_line(ecbdata->file, reset, reset, line, len);
+		if (ecbdata->diff_words && ecbdata->diff_words->porcelain)
+			fputs("~\n", ecbdata->file);
 		return;
 	}
 
@@ -851,9 +913,13 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			return;
 		}
 		diff_words_flush(ecbdata);
-		line++;
-		len--;
+		if (!ecbdata->diff_words->porcelain) {
+			line++;
+			len--;
+		}
 		emit_line(ecbdata->file, plain, reset, line, len);
+		if (ecbdata->diff_words->porcelain)
+			fputs("~\n", ecbdata->file);
 		return;
 	}
 
@@ -1765,6 +1831,7 @@ static void builtin_diff(const char *name_a,
 				o->word_regex = userdiff_word_regex(two);
 			if (!o->word_regex)
 				o->word_regex = diff_word_regex_cfg;
+			ecbdata.diff_words->porcelain = DIFF_OPT_TST(o, PORCELAIN);
 			if (o->word_regex) {
 				ecbdata.diff_words->word_regex = (regex_t *)
 					xmalloc(sizeof(regex_t));
@@ -2852,6 +2919,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_SET(options, COLOR_DIFF_WORDS);
 		options->word_regex = arg + 14;
 	}
+	else if (!strcmp(arg, "--porcelain")) {
+		DIFF_OPT_SET(options, PORCELAIN);
+		DIFF_OPT_CLR(options, COLOR_DIFF);
+	}
 	else if (!strcmp(arg, "--exit-code"))
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
 	else if (!strcmp(arg, "--quiet"))
diff --git a/diff.h b/diff.h
index 6a71013..7fdd251 100644
--- a/diff.h
+++ b/diff.h
@@ -71,6 +71,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_SUBMODULE_LOG       (1 << 23)
 #define DIFF_OPT_DIRTY_SUBMODULES    (1 << 24)
 #define DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES (1 << 25)
+#define DIFF_OPT_PORCELAIN           (1 <<  26)
 
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 2e2e103..26637d3 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -55,6 +55,33 @@ test_expect_success 'word diff with runs of whitespace' '
 
 '
 
+sed 's/#.*$//' > expect <<EOF
+diff --git a/pre b/post
+index 330b04f..5ed8eff 100644
+--- a/pre
++++ b/post
+@@ -1,3 +1,7 @@
+-h(4)
++h(4),hh[44]
+~
+ # significant space
+~
+ a = b + c
+~
+~
++aa = a
+~
+~
++aeff = aeff * ( aaa )
+~
+EOF
+
+test_expect_success '--porcelain' '
+
+	word_diff --color-words --porcelain
+
+'
+
 cat > expect <<\EOF
 <WHITE>diff --git a/pre b/post<RESET>
 <WHITE>index 330b04f..5ed8eff 100644<RESET>
-- 
1.7.0.4.504.g4d2c
