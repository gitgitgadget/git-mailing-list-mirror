From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/2] diff: add --word-diff option that generalizes --color-words
Date: Sun, 4 Apr 2010 15:46:38 +0200
Message-ID: <a1e9ef6a4eb1d7930f69e9ac4b63dc3152ebc98c.1270388195.git.trast@student.ethz.ch>
References: <cover.1270388195.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>, Miles Bader <miles@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 04 15:47:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyQAw-00013g-Ka
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 15:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237Ab0DDNr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 09:47:27 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:55444 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754185Ab0DDNrG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 09:47:06 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 4 Apr
 2010 15:47:01 +0200
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 4 Apr
 2010 15:46:40 +0200
X-Mailer: git-send-email 1.7.0.3.521.ga1e9e
In-Reply-To: <cover.1270388195.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143928>

This teaches the --color-words engine a more general interface that
supports two new modes:

* --word-diff=plain, inspired by the 'wdiff' utility (most similar to
  'wdiff -n <old> <new>'): uses delimiters [-removed-] and {+added+}

* --word-diff=porcelain, which generates an ad-hoc machine readable
  format:
  - each diff unit is prefixed by [-+ ] and terminated by newline as
    in unified diff
  - newlines in the input are output as a line consisting only of a
    tilde '~'

--color-words becomes a synonym for --word-diff=color.  Also adds some
compatibility/convenience options.

Thanks to Junio C Hamano and Miles Bader for good ideas.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/diff-options.txt  |   39 +++++++++-
 Documentation/gitattributes.txt |    2 +-
 color.c                         |   28 -------
 color.h                         |    1 -
 diff.c                          |  148 ++++++++++++++++++++++++++++++++++-----
 diff.h                          |   11 +++-
 t/t4034-diff-words.sh           |   70 ++++++++++++++++++
 7 files changed, 245 insertions(+), 54 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 60e922e..e51fc9a 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -126,11 +126,38 @@ any of those replacements occurred.
 	gives the default to color output.
 	Same as `--color=never`.
 
---color-words[=<regex>]::
-	Show colored word diff, i.e., color words which have changed.
-	By default, words are separated by whitespace.
+--word-diff[=<mode>]::
+	Show a word diff, using the <mode> to delimit changed words.
+	By default, words are delimited by whitespace; see
+	`--word-diff-regex` below.  The <mode> defaults to 'auto', and
+	must be one of:
++
+--
+color::
+	Highlight changed words with colors.  Implies `--color`.
+plain::
+	Show words as `[-removed-]` and `{+added+}`.  Makes no
+	attempts to escape the delimiters if they appear in the input,
+	so the output may be ambiguous.
+porcelain::
+	Use a special line-based format intended for script
+	consumption.  Added/removed/unchanged runs are printed in the
+	usual unified diff format, starting with a `+`/`-`/` `
+	character at the beginning of the line and extending to the
+	end of the line.  Newlines in the input are represented by a
+	tilde `~` on a line of its own.
+auto::
+	'color' if color is enabled, 'plain' otherwise.
+none::
+	Disable word diff again.
+--
+
+--word-diff-regex=<regex>::
+	Use <regex> to decide what a word is, instead of considering
+	runs of non-whitespace to be a word.  Also implies
+	`--word-diff=auto` unless it was already enabled.
 +
-When a <regex> is specified, every non-overlapping match of the
+Every non-overlapping match of the
 <regex> is considered a word.  Anything between these matches is
 considered whitespace and ignored(!) for the purposes of finding
 differences.  You may want to append `|[^[:space:]]` to your regular
@@ -142,6 +169,10 @@ The regex can also be set via a diff driver or configuration option, see
 linkgit:gitattributes[1] or linkgit:git-config[1].  Giving it explicitly
 overrides any diff driver or configuration setting.  Diff drivers
 override configuration settings.
+
+--color-words[=<regex>]::
+	Equivalent to `--word-diff=color` plus (if a regex was
+	specified) `--word-diff-regex=<regex>`.
 endif::git-format-patch[]
 
 --no-renames::
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index d892e64..7554fcd 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -360,7 +360,7 @@ patterns are available:
 Customizing word diff
 ^^^^^^^^^^^^^^^^^^^^^
 
-You can customize the rules that `git diff --color-words` uses to
+You can customize the rules that `git diff --word-diff` uses to
 split words in a line, by specifying an appropriate regular expression
 in the "diff.*.wordRegex" configuration variable.  For example, in TeX
 a backslash followed by a sequence of letters forms a command, but
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
index f5d93e9..dca310e 100644
--- a/diff.c
+++ b/diff.c
@@ -572,16 +572,60 @@ static void diff_words_append(char *line, unsigned long len,
 	buffer->text.ptr[buffer->text.size] = '\0';
 }
 
+struct diff_words_style
+{
+	enum diff_words_type type;
+	int is_color;
+	const char *new_prefix;
+	const char *new_suffix;
+	const char *old_prefix;
+	const char *old_suffix;
+	const char *ctx_prefix;
+	const char *ctx_suffix;
+	const char *newline;
+};
+
+struct diff_words_style diff_words_styles[] = {
+	{ DIFF_WORDS_PORCELAIN, 0, "+", "\n", "-", "\n", " ", "\n", "~\n" },
+	{ DIFF_WORDS_PLAIN, 0, "{+", "+}", "[-", "-]", "", "", "\n" },
+	{ DIFF_WORDS_COLOR, 1, NULL, NULL, NULL, NULL, NULL, NULL, "\n" }
+};
+
 struct diff_words_data {
 	struct diff_words_buffer minus, plus;
 	const char *current_plus;
 	FILE *file;
 	regex_t *word_regex;
+	enum diff_words_type type;
+	struct diff_words_style *style;
 };
 
+static int fn_out_diff_words_write_helper(FILE *fp,
+					  const char *prefix,
+					  const char *suffix,
+					  const char *newline,
+					  size_t count, const char *buf)
+{
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
+	struct diff_words_style *style = diff_words->style;
 	int minus_first, minus_len, plus_first, plus_len;
 	const char *minus_begin, *minus_end, *plus_begin, *plus_end;
 
@@ -605,16 +649,20 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 		plus_begin = plus_end = diff_words->plus.orig[plus_first].end;
 
 	if (diff_words->current_plus != plus_begin)
-		fwrite(diff_words->current_plus,
-				plus_begin - diff_words->current_plus, 1,
-				diff_words->file);
+		fn_out_diff_words_write_helper(diff_words->file,
+				style->ctx_prefix, style->ctx_suffix,
+				style->newline,
+				plus_begin - diff_words->current_plus,
+				diff_words->current_plus);
 	if (minus_begin != minus_end)
-		color_fwrite_lines(diff_words->file,
-				diff_get_color(1, DIFF_FILE_OLD),
+		fn_out_diff_words_write_helper(diff_words->file,
+				style->old_prefix, style->old_suffix,
+				style->newline,
 				minus_end - minus_begin, minus_begin);
 	if (plus_begin != plus_end)
-		color_fwrite_lines(diff_words->file,
-				diff_get_color(1, DIFF_FILE_NEW),
+		fn_out_diff_words_write_helper(diff_words->file,
+				style->new_prefix, style->new_suffix,
+				style->newline,
 				plus_end - plus_begin, plus_begin);
 
 	diff_words->current_plus = plus_end;
@@ -697,11 +745,13 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	xdemitconf_t xecfg;
 	xdemitcb_t ecb;
 	mmfile_t minus, plus;
+	struct diff_words_style *style = diff_words->style;
 
 	/* special case: only removal */
 	if (!diff_words->plus.text.size) {
-		color_fwrite_lines(diff_words->file,
-			diff_get_color(1, DIFF_FILE_OLD),
+		fn_out_diff_words_write_helper(diff_words->file,
+			style->old_prefix, style->old_suffix,
+			style->newline,
 			diff_words->minus.text.size, diff_words->minus.text.ptr);
 		diff_words->minus.text.size = 0;
 		return;
@@ -722,10 +772,11 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	free(plus.ptr);
 	if (diff_words->current_plus != diff_words->plus.text.ptr +
 			diff_words->plus.text.size)
-		fwrite(diff_words->current_plus,
+		fn_out_diff_words_write_helper(diff_words->file,
+			style->ctx_prefix, style->ctx_suffix,
+			style->newline,
 			diff_words->plus.text.ptr + diff_words->plus.text.size
-			- diff_words->current_plus, 1,
-			diff_words->file);
+			- diff_words->current_plus, diff_words->current_plus);
 	diff_words->minus.text.size = diff_words->plus.text.size = 0;
 }
 
@@ -837,6 +888,9 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 
 	if (len < 1) {
 		emit_line(ecbdata->file, reset, reset, line, len);
+		if (ecbdata->diff_words
+		    && ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN)
+			fputs("~\n", ecbdata->file);
 		return;
 	}
 
@@ -851,9 +905,13 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			return;
 		}
 		diff_words_flush(ecbdata);
-		line++;
-		len--;
-		emit_line(ecbdata->file, plain, reset, line, len);
+		if (ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN) {
+			emit_line(ecbdata->file, plain, reset, line, len);
+			fputs("~\n", ecbdata->file);
+		} else {
+			/* don't print the prefix character */
+			emit_line(ecbdata->file, plain, reset, line+1, len-1);
+		}
 		return;
 	}
 
@@ -1755,10 +1813,19 @@ static void builtin_diff(const char *name_a,
 			xecfg.ctxlen = strtoul(diffopts + 10, NULL, 10);
 		else if (!prefixcmp(diffopts, "-u"))
 			xecfg.ctxlen = strtoul(diffopts + 2, NULL, 10);
-		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS)) {
+		if (o->word_diff) {
+			int i;
+
+			if (o->word_diff == DIFF_WORDS_AUTO) {
+				if (DIFF_OPT_TST(o, COLOR_DIFF))
+					o->word_diff = DIFF_WORDS_COLOR;
+				else
+					o->word_diff = DIFF_WORDS_PLAIN;
+			}
 			ecbdata.diff_words =
 				xcalloc(1, sizeof(struct diff_words_data));
 			ecbdata.diff_words->file = o->file;
+			ecbdata.diff_words->type = o->word_diff;
 			if (!o->word_regex)
 				o->word_regex = userdiff_word_regex(one);
 			if (!o->word_regex)
@@ -1774,10 +1841,27 @@ static void builtin_diff(const char *name_a,
 					die ("Invalid regular expression: %s",
 							o->word_regex);
 			}
+			for (i = 0; i < ARRAY_SIZE(diff_words_styles); i++) {
+				if (o->word_diff == diff_words_styles[i].type) {
+					ecbdata.diff_words->style =
+						&diff_words_styles[i];
+					break;
+				}
+			}
+			if (ecbdata.diff_words->style->is_color) {
+				struct diff_words_style *s
+					= ecbdata.diff_words->style;
+				s->new_prefix = diff_get_color_opt(o, DIFF_FILE_NEW);
+				s->old_prefix = diff_get_color_opt(o, DIFF_FILE_OLD);
+				s->ctx_prefix = diff_get_color_opt(o, DIFF_PLAIN);
+				s->new_suffix = s->old_suffix
+					= diff_get_color_opt(o, DIFF_RESET);
+				s->ctx_suffix = "";
+			}
 		}
 		xdi_diff_outf(&mf1, &mf2, fn_out_consume, &ecbdata,
 			      &xpp, &xecfg, &ecb);
-		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS))
+		if (o->word_diff)
 			free_diff_words_data(&ecbdata);
 		if (textconv_one)
 			free(mf1.ptr);
@@ -2845,13 +2929,39 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_CLR(options, COLOR_DIFF);
 	else if (!strcmp(arg, "--color-words")) {
 		DIFF_OPT_SET(options, COLOR_DIFF);
-		DIFF_OPT_SET(options, COLOR_DIFF_WORDS);
+		options->word_diff = DIFF_WORDS_COLOR;
 	}
 	else if (!prefixcmp(arg, "--color-words=")) {
 		DIFF_OPT_SET(options, COLOR_DIFF);
-		DIFF_OPT_SET(options, COLOR_DIFF_WORDS);
+		options->word_diff = DIFF_WORDS_COLOR;
 		options->word_regex = arg + 14;
 	}
+	else if (!strcmp(arg, "--word-diff")) {
+		if (options->word_diff == DIFF_WORDS_NONE)
+			options->word_diff = DIFF_WORDS_AUTO;
+	}
+	else if (!prefixcmp(arg, "--word-diff=")) {
+		const char *type = arg + 12;
+		if (!strcmp(type, "auto"))
+			options->word_diff = DIFF_WORDS_AUTO;
+		else if (!strcmp(type, "plain"))
+			options->word_diff = DIFF_WORDS_PLAIN;
+		else if (!strcmp(type, "color")) {
+			DIFF_OPT_SET(options, COLOR_DIFF);
+			options->word_diff = DIFF_WORDS_COLOR;
+		}
+		else if (!strcmp(type, "porcelain"))
+			options->word_diff = DIFF_WORDS_PORCELAIN;
+		else if (!strcmp(type, "none"))
+			options->word_diff = DIFF_WORDS_NONE;
+		else
+			die("bad --word-diff argument: %s", type);
+	}
+	else if (!prefixcmp(arg, "--word-diff-regex=")) {
+		if (options->word_diff == DIFF_WORDS_NONE)
+			options->word_diff = DIFF_WORDS_AUTO;
+		options->word_regex = arg + 18;
+	}
 	else if (!strcmp(arg, "--exit-code"))
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
 	else if (!strcmp(arg, "--quiet"))
diff --git a/diff.h b/diff.h
index 6a71013..7c8e3ff 100644
--- a/diff.h
+++ b/diff.h
@@ -54,7 +54,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_FIND_COPIES_HARDER  (1 <<  6)
 #define DIFF_OPT_FOLLOW_RENAMES      (1 <<  7)
 #define DIFF_OPT_COLOR_DIFF          (1 <<  8)
-#define DIFF_OPT_COLOR_DIFF_WORDS    (1 <<  9)
+/* (1 <<  9) unused */
 #define DIFF_OPT_HAS_CHANGES         (1 << 10)
 #define DIFF_OPT_QUICK               (1 << 11)
 #define DIFF_OPT_NO_INDEX            (1 << 12)
@@ -79,6 +79,14 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_XDL_SET(opts, flag)    ((opts)->xdl_opts |= XDF_##flag)
 #define DIFF_XDL_CLR(opts, flag)    ((opts)->xdl_opts &= ~XDF_##flag)
 
+enum diff_words_type {
+	DIFF_WORDS_NONE = 0,
+	DIFF_WORDS_AUTO,
+	DIFF_WORDS_PORCELAIN,
+	DIFF_WORDS_PLAIN,
+	DIFF_WORDS_COLOR
+};
+
 struct diff_options {
 	const char *filter;
 	const char *orderfile;
@@ -108,6 +116,7 @@ struct diff_options {
 	int stat_width;
 	int stat_name_width;
 	const char *word_regex;
+	enum diff_words_type word_diff;
 
 	/* this is set by diffcore for DIFF_FORMAT_PATCH */
 	int found_changes;
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 2e2e103..764368d 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -55,6 +55,72 @@ test_expect_success 'word diff with runs of whitespace' '
 
 '
 
+test_expect_success '--word-diff=color' '
+
+	word_diff --word-diff=color
+
+'
+
+test_expect_success '--color --word-diff=color' '
+
+	word_diff --color --word-diff=auto
+
+'
+
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
+test_expect_success '--word-diff=porcelain' '
+
+	word_diff --word-diff=porcelain
+
+'
+
+cat > expect <<EOF
+diff --git a/pre b/post
+index 330b04f..5ed8eff 100644
+--- a/pre
++++ b/post
+@@ -1,3 +1,7 @@
+[-h(4)-]{+h(4),hh[44]+}
+
+a = b + c
+
+{+aa = a+}
+
+{+aeff = aeff * ( aaa )+}
+EOF
+
+test_expect_success '--word-diff=plain' '
+
+	word_diff --word-diff=plain
+
+'
+
+test_expect_success '--no-color --word-diff=color' '
+
+	word_diff --no-color --word-diff=auto
+
+'
+
 cat > expect <<\EOF
 <WHITE>diff --git a/pre b/post<RESET>
 <WHITE>index 330b04f..5ed8eff 100644<RESET>
@@ -143,6 +209,10 @@ test_expect_success 'command-line overrides config' '
 	word_diff --color-words="[a-z]+"
 '
 
+test_expect_success 'command-line overrides config: --word-diff-regex' '
+	word_diff --color --word-diff-regex="[a-z]+"
+'
+
 cp expect.non-whitespace-is-word expect
 
 test_expect_success '.gitattributes override config' '
-- 
1.7.0.3.521.ga1e9e
