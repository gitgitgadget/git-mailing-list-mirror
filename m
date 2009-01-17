From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 4/7] color-words: take an optional regular expression describing words
Date: Sat, 17 Jan 2009 17:29:45 +0100
Message-ID: <1232209788-10408-5-git-send-email-trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de>
 <1232209788-10408-1-git-send-email-trast@student.ethz.ch>
 <1232209788-10408-2-git-send-email-trast@student.ethz.ch>
 <1232209788-10408-3-git-send-email-trast@student.ethz.ch>
 <1232209788-10408-4-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Teemu Likonen <tlikonen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 17:32:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOE5K-00087b-AA
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 17:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763489AbZAQQ3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 11:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763427AbZAQQ3s
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 11:29:48 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:8904 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763223AbZAQQ3m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 11:29:42 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:29:40 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:29:40 +0100
X-Mailer: git-send-email 1.6.1.315.g92577
In-Reply-To: <1232209788-10408-4-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 17 Jan 2009 16:29:40.0206 (UTC) FILETIME=[CB9FA0E0:01C978C0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106082>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In some applications, words are not delimited by white space.  To
allow for that, you can specify a regular expression describing
what makes a word with

	git diff --color-words='[A-Za-z0-9]+'

Note that words cannot contain newline characters.

As suggested by Thomas Rast, the words are the exact matches of the
regular expression.

Note that a regular expression beginning with a '^' will match only
a word at the beginning of the hunk, not a word at the beginning of
a line, and is probably not what you want.

This commit contains a quoting fix by Thomas Rast.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/diff-options.txt |    6 +++-
 diff.c                         |   64 ++++++++++++++++++++++++++++++++++-----
 diff.h                         |    1 +
 t/t4034-diff-words.sh          |   57 +++++++++++++++++++++++++++++++++++
 4 files changed, 118 insertions(+), 10 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 43793d7..2c1fa4b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -91,8 +91,12 @@ endif::git-format-patch[]
 	Turn off colored diff, even when the configuration file
 	gives the default to color output.
 
---color-words::
+--color-words[=regex]::
 	Show colored word diff, i.e. color words which have changed.
++
+Optionally, you can pass a regular expression that tells Git what the
+words are that you are looking for; The default is to interpret any
+stretch of non-whitespace as a word.
 
 --no-renames::
 	Turn off rename detection, even when the configuration
diff --git a/diff.c b/diff.c
index 37c886a..9fb3d0d 100644
--- a/diff.c
+++ b/diff.c
@@ -333,12 +333,14 @@ static void diff_words_append(char *line, unsigned long len,
 	len--;
 	memcpy(buffer->text.ptr + buffer->text.size, line, len);
 	buffer->text.size += len;
+	buffer->text.ptr[buffer->text.size] = '\0';
 }
 
 struct diff_words_data {
 	struct diff_words_buffer minus, plus;
 	const char *current_plus;
 	FILE *file;
+	regex_t *word_regex;
 };
 
 static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
@@ -382,17 +384,49 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	diff_words->current_plus = plus_end;
 }
 
+/* This function starts looking at *begin, and returns 0 iff a word was found. */
+static int find_word_boundaries(mmfile_t *buffer, regex_t *word_regex,
+		int *begin, int *end)
+{
+	if (word_regex && *begin < buffer->size) {
+		regmatch_t match[1];
+		if (!regexec(word_regex, buffer->ptr + *begin, 1, match, 0)) {
+			char *p = memchr(buffer->ptr + *begin + match[0].rm_so,
+					'\n', match[0].rm_eo - match[0].rm_so);
+			*end = p ? p - buffer->ptr : match[0].rm_eo + *begin;
+			*begin += match[0].rm_so;
+			return *begin >= *end;
+		}
+		return -1;
+	}
+
+	/* find the next word */
+	while (*begin < buffer->size && isspace(buffer->ptr[*begin]))
+		(*begin)++;
+	if (*begin >= buffer->size)
+		return -1;
+
+	/* find the end of the word */
+	*end = *begin + 1;
+	while (*end < buffer->size && !isspace(buffer->ptr[*end]))
+		(*end)++;
+
+	return 0;
+}
+
 /*
  * This function splits the words in buffer->text, stores the list with
  * newline separator into out, and saves the offsets of the original words
  * in buffer->orig.
  */
-static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out)
+static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out,
+		regex_t *word_regex)
 {
 	int i, j;
+	long alloc = 0;
 
 	out->size = 0;
-	out->ptr = xmalloc(buffer->text.size);
+	out->ptr = NULL;
 
 	/* fake an empty "0th" word */
 	ALLOC_GROW(buffer->orig, 1, buffer->orig_alloc);
@@ -400,11 +434,8 @@ static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out)
 	buffer->orig_nr = 1;
 
 	for (i = 0; i < buffer->text.size; i++) {
-		if (isspace(buffer->text.ptr[i]))
-			continue;
-		for (j = i + 1; j < buffer->text.size &&
-				!isspace(buffer->text.ptr[j]); j++)
-			; /* find the end of the word */
+		if (find_word_boundaries(&buffer->text, word_regex, &i, &j))
+			return;
 
 		/* store original boundaries */
 		ALLOC_GROW(buffer->orig, buffer->orig_nr + 1,
@@ -414,6 +445,7 @@ static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out)
 		buffer->orig_nr++;
 
 		/* store one word */
+		ALLOC_GROW(out->ptr, out->size + j - i + 1, alloc);
 		memcpy(out->ptr + out->size, buffer->text.ptr + i, j - i);
 		out->ptr[out->size + j - i] = '\n';
 		out->size += j - i + 1;
@@ -443,9 +475,10 @@ static void diff_words_show(struct diff_words_data *diff_words)
 
 	memset(&xpp, 0, sizeof(xpp));
 	memset(&xecfg, 0, sizeof(xecfg));
-	diff_words_fill(&diff_words->minus, &minus);
-	diff_words_fill(&diff_words->plus, &plus);
+	diff_words_fill(&diff_words->minus, &minus, diff_words->word_regex);
+	diff_words_fill(&diff_words->plus, &plus, diff_words->word_regex);
 	xpp.flags = XDF_NEED_MINIMAL;
+	/* as only the hunk header will be parsed, we need a 0-context */
 	xecfg.ctxlen = 0;
 	xdi_diff_outf(&minus, &plus, fn_out_diff_words_aux, diff_words,
 		      &xpp, &xecfg, &ecb);
@@ -484,6 +517,7 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
 		free (ecbdata->diff_words->minus.orig);
 		free (ecbdata->diff_words->plus.text.ptr);
 		free (ecbdata->diff_words->plus.orig);
+		free(ecbdata->diff_words->word_regex);
 		free(ecbdata->diff_words);
 		ecbdata->diff_words = NULL;
 	}
@@ -1506,6 +1540,14 @@ static void builtin_diff(const char *name_a,
 			ecbdata.diff_words =
 				xcalloc(1, sizeof(struct diff_words_data));
 			ecbdata.diff_words->file = o->file;
+			if (o->word_regex) {
+				ecbdata.diff_words->word_regex = (regex_t *)
+					xmalloc(sizeof(regex_t));
+				if (regcomp(ecbdata.diff_words->word_regex,
+						o->word_regex, REG_EXTENDED))
+					die ("Invalid regular expression: %s",
+							o->word_regex);
+			}
 		}
 		xdi_diff_outf(&mf1, &mf2, fn_out_consume, &ecbdata,
 			      &xpp, &xecfg, &ecb);
@@ -2517,6 +2559,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_CLR(options, COLOR_DIFF);
 	else if (!strcmp(arg, "--color-words"))
 		options->flags |= DIFF_OPT_COLOR_DIFF | DIFF_OPT_COLOR_DIFF_WORDS;
+	else if (!prefixcmp(arg, "--color-words=")) {
+		options->flags |= DIFF_OPT_COLOR_DIFF | DIFF_OPT_COLOR_DIFF_WORDS;
+		options->word_regex = arg + 14;
+	}
 	else if (!strcmp(arg, "--exit-code"))
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
 	else if (!strcmp(arg, "--quiet"))
diff --git a/diff.h b/diff.h
index 4d5a327..23cd90c 100644
--- a/diff.h
+++ b/diff.h
@@ -98,6 +98,7 @@ struct diff_options {
 
 	int stat_width;
 	int stat_name_width;
+	const char *word_regex;
 
 	/* this is set by diffcore for DIFF_FORMAT_PATCH */
 	int found_changes;
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index b22195f..4873486 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -63,4 +63,61 @@ test_expect_success 'word diff with runs of whitespace' '
 
 '
 
+cat > expect <<\EOF
+<WHITE>diff --git a/pre b/post<RESET>
+<WHITE>index 330b04f..5ed8eff 100644<RESET>
+<WHITE>--- a/pre<RESET>
+<WHITE>+++ b/post<RESET>
+<BROWN>@@ -1,3 +1,7 @@<RESET>
+h(4),<GREEN>hh<RESET>[44]
+<RESET>
+a = b + c<RESET>
+
+<GREEN>aa = a<RESET>
+
+<GREEN>aeff = aeff * ( aaa<RESET> )
+EOF
+
+test_expect_success 'word diff with a regular expression' '
+
+	word_diff --color-words="[a-z]+"
+
+'
+
+echo 'aaa (aaa)' > pre
+echo 'aaa (aaa) aaa' > post
+
+cat > expect <<\EOF
+<WHITE>diff --git a/pre b/post<RESET>
+<WHITE>index c29453b..be22f37 100644<RESET>
+<WHITE>--- a/pre<RESET>
+<WHITE>+++ b/post<RESET>
+<BROWN>@@ -1 +1 @@<RESET>
+aaa (aaa) <GREEN>aaa<RESET>
+EOF
+
+test_expect_success 'test parsing words for newline' '
+
+	word_diff --color-words="a+"
+
+'
+
+echo '(:' > pre
+echo '(' > post
+
+cat > expect <<\EOF
+<WHITE>diff --git a/pre b/post<RESET>
+<WHITE>index 289cb9d..2d06f37 100644<RESET>
+<WHITE>--- a/pre<RESET>
+<WHITE>+++ b/post<RESET>
+<BROWN>@@ -1 +1 @@<RESET>
+(<RED>:<RESET>
+EOF
+
+test_expect_success 'test when words are only removed at the end' '
+
+	word_diff --color-words=.
+
+'
+
 test_done
-- 
1.6.1.315.g92577
