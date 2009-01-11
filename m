From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 2/4] word diff: customizable word splits
Date: Sun, 11 Jan 2009 11:27:12 +0100
Message-ID: <529cd830908f018f796dbc46d3b055c1f8ba9c1b.1231669012.git.trast@student.ethz.ch>
References: <cover.1231669012.git.trast@student.ethz.ch>
 <4aea85caafd38a058145c5769fe8a30ffdbd4d13.1231669012.git.trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Teemu Likonen <tlikonen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 11 11:28:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLxYg-0002rW-5r
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 11:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbZAKK1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 05:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbZAKK1S
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 05:27:18 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:42017 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150AbZAKK1O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 05:27:14 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 11 Jan 2009 11:27:05 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 11 Jan 2009 11:27:05 +0100
X-Mailer: git-send-email 1.6.1.279.g41f0
In-Reply-To: <4aea85caafd38a058145c5769fe8a30ffdbd4d13.1231669012.git.trast@student.ethz.ch>
In-Reply-To: <7vr63atykr.fsf@gitster.siamese.dyndns.org>
References: <7vr63atykr.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 11 Jan 2009 10:27:05.0166 (UTC) FILETIME=[262176E0:01C973D7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105162>

Allows for user-configurable word splits when using --color-words.
This can make the diff more readable if the regex is configured
according to the language of the file.

Each non-overlapping match of the regex is a word; everything in
between is whitespace.  We disallow matching the empty string (because
it results in an endless loop) or a newline (breaks color escapes and
interacts badly with the input coming from the usual line diff).  To
help the user, we set REG_NEWLINE so that [^...] and . do not match
newlines.

--color-words works (and always worked) by splitting words onto one
line each, and using the normal line-diff machinery to get a word
diff.  Since we cannot reuse the current approach of simply
overwriting uninteresting characters with '\n', we insert an
artificial '\n' at the end of each detected word.  Its presence must
be tracked so that we can distinguish artificial from source newlines.

Insertion of spaces is somewhat subtle.  We echo a "context" space
twice (once on each side of the diff) if it follows directly after a
word.  While this loses a tiny bit of accuracy, it runs together long
sequences of changed word into one removed and one added block, making
the diff much more readable.  This feature also means that the
splitting regex '\S+' results in the same output as the original code.
The existing code still stays in place in case no regex is provided,
for performance.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/diff-options.txt |   16 +++-
 diff.c                         |  196 +++++++++++++++++++++++++++++++++++++++-
 diff.h                         |    1 +
 3 files changed, 206 insertions(+), 7 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 671f533..6152d5b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -91,8 +91,20 @@ endif::git-format-patch[]
 	Turn off colored diff, even when the configuration file
 	gives the default to color output.
 
---color-words::
-	Show colored word diff, i.e. color words which have changed.
+--color-words[=<regex>]::
+	Show colored word diff, i.e., color words which have changed.
+	By default, a new word only starts at whitespace, so that a
+	'word' is defined as a maximal sequence of non-whitespace
+	characters.  The optional argument <regex> can be used to
+	configure this.
++
+The <regex> must be an (extended) regular expression.  When set, every
+non-overlapping match of the <regex> is considered a word.  (Regular
+expression semantics ensure that quantifiers grab a maximal sequence
+of characters.)  Anything between these matches is considered
+whitespace and ignored for the purposes of finding differences.  You
+may want to append `|\S` to your regular expression to make sure that
+it matches all non-whitespace characters.
 
 --no-renames::
 	Turn off rename detection, even when the configuration
diff --git a/diff.c b/diff.c
index f274bf5..badaea6 100644
--- a/diff.c
+++ b/diff.c
@@ -316,7 +316,21 @@ static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
 	return 0;
 }
 
-/* unused right now */
+/*
+ * We use these to save the word boundaries:
+ *
+ * - BODY and END track the extent of a word; after END, an artificial
+ *   newline will be inserted.
+ *
+ * - SPACE means the character is a space, and will be replaced by a
+ *   newline.  If a space follows immediately after END, it is flagged
+ *   SKIP instead, so that two words with exactly one space in between
+ *   end up with only one newline between them.
+ *
+ * - The boundary array is overallocated by one, and the spare element
+ *   is flagged UNDEF to allow peeking over the end of a word to see
+ *   if the next element is a SKIP.
+ */
 enum diff_word_boundaries {
 	DIFF_WORD_UNDEF,
 	DIFF_WORD_BODY,
@@ -349,12 +363,12 @@ static void diff_words_append(char *line, unsigned long len,
 struct diff_words_data {
 	struct diff_words_buffer minus, plus;
 	FILE *file;
-	regex_t *word_regex; /* currently unused */
+	regex_t *word_regex;
 };
 
 /*
  * Print 'len' characters from the "real" diff data in 'buffer'.  Also
- * returns how many characters were printed (currently always 'len').
+ * returns how many characters were printed.
  * With 'suppress_newline', we remember a final newline instead of
  * printing it.
  */
@@ -368,8 +382,27 @@ static int print_word(FILE *file, struct diff_words_buffer *buffer, int len, int
 		return len;
 
 	ptr  = buffer->text.ptr + buffer->current;
+
+	if (buffer->boundaries
+	    && (buffer->boundaries[buffer->current] == DIFF_WORD_BODY
+		|| buffer->boundaries[buffer->current] == DIFF_WORD_END)) {
+		/* drop the artificial newline */
+		len--;
+		/* we still have len>0 because it is a word, and
+		 * scan_word_boundaries() disallows words of length 0. */
+	}
+
 	buffer->current += len;
 
+	/* Peek past the end (this is safe because we overallocated)
+	 * to check if the next character was a skipped space. If so,
+	 * we put it together with the word. */
+	if (buffer->boundaries
+	    && buffer->boundaries[buffer->current] == DIFF_WORD_SKIP) {
+		buffer->current++;
+		len++;
+	}
+
 	if (ptr[len - 1] == '\n') {
 		eol = 1;
 		len--;
@@ -429,6 +462,141 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	}
 }
 
+/*
+ * Fancy word splitting by regex
+ *
+ * We search for all non-overlapping matches of 'pattern' in the
+ * 'buf', and define every match as a (separate) word and all
+ * unmatched characters as whitespace.
+ *
+ * Then we build a new mmfile where each word is on a line of its own.
+ * Two of these can then be line-diffed to find the word differences
+ * between the original buffers.  Unlike the normal word diff (see
+ * diff_words_show() below), the transformation does not preserve
+ * character counts, so we need to keep tracking information in
+ * buf->boundaries for later use by print_word().
+ */
+static void scan_word_boundaries(regex_t *pattern, struct diff_words_buffer *buf,
+				 mmfile_t *mmfile)
+{
+	char *text = buf->text.ptr;
+	int len = buf->text.size;
+	int i = 0;
+	/* counts how many extra characters will be inserted into the
+	 * mmfile */
+	int count = 0;
+	int ret;
+	regmatch_t matches[1];
+	int offset, wordlen;
+	char *strz, *p;
+
+	/* overallocate by 1 so we can safely peek past the end for a
+	 * SKIP, see print_word() */
+	buf->boundaries = xmalloc((len+1) * sizeof(enum diff_word_boundaries));
+	buf->boundaries[len] = DIFF_WORD_UNDEF;
+
+	if (!text) {
+		mmfile->ptr = NULL;
+		mmfile->size = 0;
+		return;
+	}
+
+	/* we unfortunately need a null-terminated copy for regexec */
+	strz = xmalloc(len+1);
+	memcpy(strz, text, len);
+	strz[len] = '\0';
+
+	while (i < len) {
+		/* iteratively match the regex against the rest of the
+		 * input string to find the next word */
+		ret = regexec(pattern, strz+i, 1, matches, 0);
+		if (ret == REG_NOMATCH) {
+			/* The rest is whitespace.  The first space
+			 * character is flagged SKIP unless there was
+			 * no preceding text at all */
+			if (i > 0 && i < len) {
+				buf->boundaries[i++] = DIFF_WORD_SKIP;
+				count--; /* SKIP characters have no output */
+			}
+			while (i < len)
+				buf->boundaries[i++] = DIFF_WORD_SPACE;
+			break;
+		}
+
+		offset = matches[0].rm_so;
+
+		/* everything up to the next word is whitespace, using
+		 * the same SKIP rule as above */
+		if (offset > 0 && i > 0) {
+			buf->boundaries[i++] = DIFF_WORD_SKIP;
+			count--;
+			offset--;
+		}
+		while (offset-- > 0)
+			buf->boundaries[i++] = DIFF_WORD_SPACE;
+
+		/* rm_eo is the first character after the match, so
+		 * this is indeed the number of characters matched */
+		wordlen = matches[0].rm_eo - matches[0].rm_so;
+
+		/* all but the last character are BODY */
+		while (wordlen > 1) {
+			if (strz[i] == '\n')
+				die("word regex matched a newline before '%s'",
+				    strz+i+1);
+			buf->boundaries[i++] = DIFF_WORD_BODY;
+			wordlen--;
+		}
+		/* the last character is END, we will insert an extra
+		 * '\n' after it */
+		if (wordlen > 0) {
+			if (strz[i] == '\n')
+				die("word regex matched a newline before '%s'",
+				    strz+i+1);
+			buf->boundaries[i++] = DIFF_WORD_END;
+			count++;
+		} else {
+			/* this would cause an endless loop, so panic */
+			die("word regex matched the empty string at '%s'",
+			    strz+i);
+		}
+	}
+
+	free(strz);
+
+	/* now build the mmfile. there will be 'count' more characters
+	 * than in the original */
+	mmfile->size = len + count;
+	mmfile->ptr = xmalloc(mmfile->size);
+	p = mmfile->ptr;
+	for (i = 0; i < len; i++) {
+		switch (buf->boundaries[i]) {
+		case DIFF_WORD_BODY: /* copy over */
+			*p++ = text[i];
+			break;
+		case DIFF_WORD_END: /* copy and insert an artificial newline */
+			*p++ = text[i];
+			*p++ = '\n';
+			break;
+		case DIFF_WORD_SPACE: /* replace by '\n' */
+			*p++ = '\n';
+			break;
+		case DIFF_WORD_SKIP:
+			/* Ignore. Since the character right before
+			 * this one is always an END, another way to
+			 * look at it is that we avoid duplicate END
+			 * newlines that are already provided by
+			 * SPACE */
+			break;
+		case DIFF_WORD_UNDEF:
+			/* can't happen, but silences a warning */
+			die("can't happen, send test case to git@vger.kernel.org");
+			break;
+		}
+	}
+}
+
+
 /* this executes the word diff on the accumulated buffers */
 static void diff_words_show(struct diff_words_data *diff_words)
 {
@@ -441,7 +609,6 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	memset(&xpp, 0, sizeof(xpp));
 	memset(&xecfg, 0, sizeof(xecfg));
 
-	/* currently always true */
 	if (!diff_words->word_regex) {
 		/*
 		 * "Simple" word diff: replace all space characters
@@ -465,6 +632,13 @@ static void diff_words_show(struct diff_words_data *diff_words)
 		for (i = 0; i < plus.size; i++)
 			if (isspace(plus.ptr[i]))
 				plus.ptr[i] = '\n';
+	} else {
+		/* Configurable word diff with a regex.  See
+		 * scan_word_boundaries() above. */
+		scan_word_boundaries(diff_words->word_regex,
+				     &diff_words->minus, &minus);
+		scan_word_boundaries(diff_words->word_regex,
+				     &diff_words->plus, &plus);
 	}
 	diff_words->minus.current = 0;
 	diff_words->plus.current = 0;
@@ -478,7 +652,6 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	free(minus.ptr);
 	free(plus.ptr);
 	diff_words->minus.text.size = diff_words->plus.text.size = 0;
-	/* these two are currently free(NULL) */
 	free(diff_words->minus.boundaries);
 	free(diff_words->plus.boundaries);
 
@@ -1535,6 +1708,15 @@ static void builtin_diff(const char *name_a,
 			ecbdata.diff_words =
 				xcalloc(1, sizeof(struct diff_words_data));
 			ecbdata.diff_words->file = o->file;
+			if (o->word_regex) {
+				ecbdata.diff_words->word_regex = (regex_t *)
+					xmalloc(sizeof(regex_t));
+				if (regcomp(ecbdata.diff_words->word_regex,
+					    o->word_regex,
+					    REG_EXTENDED|REG_NEWLINE))
+					die ("Invalid regular expression: %s",
+					     o->word_regex);
+			}
 		}
 		xdi_diff_outf(&mf1, &mf2, fn_out_consume, &ecbdata,
 			      &xpp, &xecfg, &ecb);
@@ -2546,6 +2728,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
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
-- 
1.6.1.269.g0769
