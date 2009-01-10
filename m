From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] make diff --color-words customizable
Date: Sat, 10 Jan 2009 01:57:19 +0100
Message-ID: <1231549039-5236-1-git-send-email-trast@student.ethz.ch>
References: <87wsd48wam.fsf@iki.fi>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Teemu Likonen <tlikonen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 10 01:58:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLSBQ-0006bQ-4J
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 01:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251AbZAJA5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 19:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753523AbZAJA5Q
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 19:57:16 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:7274 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755356AbZAJA5O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 19:57:14 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 10 Jan 2009 01:57:12 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 10 Jan 2009 01:57:11 +0100
X-Mailer: git-send-email 1.6.1.291.g85d4d2
In-Reply-To: <87wsd48wam.fsf@iki.fi>
X-OriginalArrivalTime: 10 Jan 2009 00:57:11.0706 (UTC) FILETIME=[5ED3C7A0:01C972BE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105052>

Allows for user-configurable word splits via a regular expression when
using --color-words.  This can make the diff more readable if the
regex is configured according to the language of the file.

The regex can be specified either through an optional argument
--color-words=<regex> or through the attributes mechanism, similar to
the funcname pattern.

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
word, by "skipping" it during the translation (instead of generating a
'\n').  While this loses a tiny bit of accuracy, it runs together long
sequences of changed words into one removed and one added block,
making the diff much more readable.  As a side-effect, the splitting
regex '\S+' currently results in the exact same output as the original
code.  The existing code still stays in place in case no regex is
provided, for performance.

We also build in patterns for some of the languages that already had
funcname regexes.  They are designed to group UTF-8 sequences into a
single word to make sure they remain readable.

Thanks to Johannes Schindelin for the option handling code.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---

Thomas Rast wrote:
> I'll come up with a fixed patch, and probably make it both
> funcname-like (Jeff's idea) and command line configurable.

I think this should do.  Getting the spaces right was harder than I
thought; originally it only tracked _END and _BODY, but then a changed
sentence will look like a lot of separate word changes, making it
extremely confusing.

Teemu Likonen wrote:
> I agree with that too. A good thing about the current --color-words is
> that it automatically works with UTF-8 encoded text. This is _very_
> important as --color-words is usually the best diff tool for
> human-language texts.

Thanks for pointing this out.  I put a [\x80-\xff]+ clause in the
built-in patterns that do not already match high-bit characters, so
that they will keep them together no matter what.  Unfortunately it's
rather hard to get the same effect "by hand", as neither shell, nor
git-config, nor regex.c, seem to expand \xNN or \NNN.  You'll need $''
in bash (is this POSIX?)  or 'echo -e' or a very large keyboard, or a
pattern that can be written in terms of a negated class.

(I briefly considered forcing "|[\x80-\xff]+|\S" into the regular
expression, but the former is very encoding-specific.  Maybe at least
"|\S" would be a good addition.)



 Documentation/diff-options.txt  |   18 +++-
 Documentation/gitattributes.txt |   21 ++++
 diff.c                          |  199 +++++++++++++++++++++++++++++++++++----
 diff.h                          |    1 +
 t/t4033-diff-color-words.sh     |   90 ++++++++++++++++++
 userdiff.c                      |   27 ++++--
 userdiff.h                      |    1 +
 7 files changed, 330 insertions(+), 27 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 671f533..d22c06b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -91,8 +91,22 @@ endif::git-format-patch[]
 	Turn off colored diff, even when the configuration file
 	gives the default to color output.
 
---color-words::
-	Show colored word diff, i.e. color words which have changed.
+--color-words[=<regex>]::
+	Show colored word diff, i.e., color words which have changed.
+	By default, a new word only starts at whitespace, so that a
+	'word' is defined as a maximal sequence of non-whitespace
+	characters.  The optional argument <regex> can be used to
+	configure this.  It can also be set via a diff driver, see
+	linkgit:gitattributes[1]; if a <regex> is given explicitly, it
+	overrides any diff driver setting.
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
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 8af22ec..67f5522 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -334,6 +334,27 @@ patterns are available:
 - `tex` suitable for source code for LaTeX documents.
 
 
+Customizing word diff
+^^^^^^^^^^^^^^^^^^^^^
+
+You can customize the rules that `git diff --color-words` uses to
+split words in a line, by specifying an appropriate regular expression
+in the "diff.*.wordregex" configuration variable.  For example, in TeX
+a backslash followed by a sequence of letters forms a command, but
+several such commands can be run together without intervening
+whitespace.  To separate them, use a regular expression such as
+
+------------------------
+[diff "tex"]
+	wordregex = "\\\\[a-zA-Z]+|[{}]|\\\\.|[^\\{} \t]+"
+------------------------
+
+Similar to 'xfuncname', a built in value is provided for the drivers
+`bibtex`, `html`, `java`, `php`, `python` and `tex`.  See the
+documentation of --color-words in linkgit:git-diff[1] for the precise
+semantics.
+
+
 Performing text diffs of binary files
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/diff.c b/diff.c
index d235482..620911e 100644
--- a/diff.c
+++ b/diff.c
@@ -321,6 +321,7 @@ struct diff_words_buffer {
 	long alloc;
 	long current; /* output pointer */
 	int suppressed_newline;
+	enum diff_word_boundaries *boundaries;
 };
 
 static void diff_words_append(char *line, unsigned long len,
@@ -336,23 +337,55 @@ static void diff_words_append(char *line, unsigned long len,
 	buffer->text.size += len;
 }
 
+/*
+ * We use these to save the word boundaries.  WORD_BODY and WORD_END
+ * signal a word, meaning that after the WORD_END character an
+ * artificial newline will be inserted.
+ */
+enum diff_word_boundaries {
+	DIFF_WORD_UNDEF,
+	DIFF_WORD_BODY,
+	DIFF_WORD_END,
+	DIFF_WORD_SPACE,
+	DIFF_WORD_SKIP
+};
+
 struct diff_words_data {
 	struct diff_words_buffer minus, plus;
 	FILE *file;
+	regex_t *word_regex;
+	enum diff_word_boundaries *minus_boundaries, *plus_boundaries;
 };
 
-static void print_word(FILE *file, struct diff_words_buffer *buffer, int len, int color,
+static int print_word(FILE *file, struct diff_words_buffer *buffer, int len, int color,
 		int suppress_newline)
 {
 	const char *ptr;
 	int eol = 0;
 
 	if (len == 0)
-		return;
+		return len;
 
 	ptr  = buffer->text.ptr + buffer->current;
+
+	if (buffer->boundaries
+	    && (buffer->boundaries[buffer->current] == DIFF_WORD_BODY
+		|| buffer->boundaries[buffer->current] == DIFF_WORD_END)) {
+		/* account for the artificial newline */
+		len--;
+		/* we still have len>0 because it is a word */
+	}
+
 	buffer->current += len;
 
+	if (buffer->boundaries
+	    && buffer->boundaries[buffer->current] == DIFF_WORD_SKIP) {
+		/* we had an artificial newline, but the next whitespace
+		 * character right after was skipped because of it */
+		buffer->current++;
+		len++;
+	}
+
 	if (ptr[len - 1] == '\n') {
 		eol = 1;
 		len--;
@@ -368,6 +401,10 @@ static void print_word(FILE *file, struct diff_words_buffer *buffer, int len, in
 		else
 			putc('\n', file);
 	}
+
+	/* we need to return how many chars to skip on the other side,
+	 * so account for the (held off) \n */
+	return len+eol;
 }
 
 static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
@@ -391,13 +428,106 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 				   &diff_words->plus, len, DIFF_FILE_NEW, 0);
 			break;
 		case ' ':
-			print_word(diff_words->file,
-				   &diff_words->plus, len, DIFF_PLAIN, 0);
+			len = print_word(diff_words->file,
+					 &diff_words->plus, len, DIFF_PLAIN, 0);
 			diff_words->minus.current += len;
 			break;
 	}
 }
 
+static void scan_word_boundaries(regex_t *pattern, struct diff_words_buffer *buf,
+				 mmfile_t *mmfile)
+{
+	char *text = buf->text.ptr;
+	int len = buf->text.size;
+	int i = 0;
+	int count = 0;
+	int ret;
+	regmatch_t matches[1];
+	int offset, wordlen;
+	char *strz, *p;
+
+	/* overallocate by 1 so we can safely peek past the end for a SKIP */
+	buf->boundaries = xmalloc((len+1) * sizeof(enum diff_word_boundaries));
+	buf->boundaries[len] = DIFF_WORD_UNDEF;
+
+	if (!text) {
+		mmfile->ptr = NULL;
+		mmfile->size = 0;
+		return;
+	}
+
+	strz = xmalloc(len+1);
+	memcpy(strz, text, len);
+	strz[len] = '\0';
+
+	while (i < len) {
+		ret = regexec(pattern, strz+i, 1, matches, 0);
+		if (ret == REG_NOMATCH) {
+			/* the rest is whitespace */
+			if (i > 0 && i < len) {
+				buf->boundaries[i++] = DIFF_WORD_SKIP;
+				count--;
+			}
+			while (i < len)
+				buf->boundaries[i++] = DIFF_WORD_SPACE;
+			break;
+		}
+
+		offset = matches[0].rm_so;
+		if (offset > 0 && i > 0) {
+			buf->boundaries[i++] = DIFF_WORD_SKIP;
+			count--;
+			offset--;
+		}
+		while (offset-- > 0)
+			buf->boundaries[i++] = DIFF_WORD_SPACE;
+
+		wordlen = matches[0].rm_eo - matches[0].rm_so;
+		while (wordlen > 1) {
+			if (strz[i] == '\n')
+				die("word regex matched a newline near '%s'",
+				    strz+i);
+			buf->boundaries[i++] = DIFF_WORD_BODY;
+			wordlen--;
+		}
+		if (wordlen > 0) {
+			if (strz[i] == '\n')
+				die("word regex matched a newline near '%s'",
+				    strz+i);
+			buf->boundaries[i++] = DIFF_WORD_END;
+			count++;
+		} else {
+			die("word regex matched the empty string at '%s'",
+			    strz+i);
+		}
+	}
+
+	free(strz);
+
+	mmfile->size = len + count;
+	mmfile->ptr = xmalloc(mmfile->size);
+	p = mmfile->ptr;
+	for (i = 0; i < len; i++) {
+		switch (buf->boundaries[i]) {
+		case DIFF_WORD_BODY:
+			*p++ = text[i];
+			break;
+		case DIFF_WORD_END:
+			*p++ = text[i];
+			*p++ = '\n'; /* insert an artificial newline */
+			break;
+		case DIFF_WORD_SPACE:
+			*p++ = '\n';
+			break;
+		case DIFF_WORD_SKIP:
+			/* nothing */
+			break;
+		}
+	}
+}
+
+
 /* this executes the word diff on the accumulated buffers */
 static void diff_words_show(struct diff_words_data *diff_words)
 {
@@ -409,22 +539,31 @@ static void diff_words_show(struct diff_words_data *diff_words)
 
 	memset(&xpp, 0, sizeof(xpp));
 	memset(&xecfg, 0, sizeof(xecfg));
-	minus.size = diff_words->minus.text.size;
-	minus.ptr = xmalloc(minus.size);
-	memcpy(minus.ptr, diff_words->minus.text.ptr, minus.size);
-	for (i = 0; i < minus.size; i++)
-		if (isspace(minus.ptr[i]))
-			minus.ptr[i] = '\n';
-	diff_words->minus.current = 0;
 
-	plus.size = diff_words->plus.text.size;
-	plus.ptr = xmalloc(plus.size);
-	memcpy(plus.ptr, diff_words->plus.text.ptr, plus.size);
-	for (i = 0; i < plus.size; i++)
-		if (isspace(plus.ptr[i]))
-			plus.ptr[i] = '\n';
+	if (!diff_words->word_regex) {
+		minus.size = diff_words->minus.text.size;
+		minus.ptr = xmalloc(minus.size);
+		memcpy(minus.ptr, diff_words->minus.text.ptr, minus.size);
+		for (i = 0; i < minus.size; i++)
+			if (isspace(minus.ptr[i]))
+				minus.ptr[i] = '\n';
+
+		plus.size = diff_words->plus.text.size;
+		plus.ptr = xmalloc(plus.size);
+		memcpy(plus.ptr, diff_words->plus.text.ptr, plus.size);
+		for (i = 0; i < plus.size; i++)
+			if (isspace(plus.ptr[i]))
+				plus.ptr[i] = '\n';
+	} else {
+		scan_word_boundaries(diff_words->word_regex,
+				     &diff_words->minus, &minus);
+		scan_word_boundaries(diff_words->word_regex,
+				     &diff_words->plus, &plus);
+	}
+	diff_words->minus.current = 0;
 	diff_words->plus.current = 0;
 
+
 	xpp.flags = XDF_NEED_MINIMAL;
 	xecfg.ctxlen = diff_words->minus.alloc + diff_words->plus.alloc;
 	xdi_diff_outf(&minus, &plus, fn_out_diff_words_aux, diff_words,
@@ -432,6 +571,8 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	free(minus.ptr);
 	free(plus.ptr);
 	diff_words->minus.text.size = diff_words->plus.text.size = 0;
+	free(diff_words->minus.boundaries);
+	free(diff_words->plus.boundaries);
 
 	if (diff_words->minus.suppressed_newline) {
 		putc('\n', diff_words->file);
@@ -461,6 +602,7 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
 
 		free (ecbdata->diff_words->minus.text.ptr);
 		free (ecbdata->diff_words->plus.text.ptr);
+		free(ecbdata->diff_words->word_regex);
 		free(ecbdata->diff_words);
 		ecbdata->diff_words = NULL;
 	}
@@ -1323,6 +1465,12 @@ static const struct userdiff_funcname *diff_funcname_pattern(struct diff_filespe
 	return one->driver->funcname.pattern ? &one->driver->funcname : NULL;
 }
 
+static const char *userdiff_word_regex(struct diff_filespec *one)
+{
+	diff_filespec_load_driver(one);
+	return one->driver->word_regex;
+}
+
 void diff_set_mnemonic_prefix(struct diff_options *options, const char *a, const char *b)
 {
 	if (!options->a_prefix)
@@ -1483,6 +1631,19 @@ static void builtin_diff(const char *name_a,
 			ecbdata.diff_words =
 				xcalloc(1, sizeof(struct diff_words_data));
 			ecbdata.diff_words->file = o->file;
+			if (!o->word_regex)
+				o->word_regex = userdiff_word_regex(one);
+			if (!o->word_regex)
+				o->word_regex = userdiff_word_regex(two);
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
@@ -2494,6 +2655,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
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
diff --git a/t/t4033-diff-color-words.sh b/t/t4033-diff-color-words.sh
new file mode 100755
index 0000000..536cdac
--- /dev/null
+++ b/t/t4033-diff-color-words.sh
@@ -0,0 +1,90 @@
+#!/bin/sh
+
+
+test_description='diff --color-words'
+. ./test-lib.sh
+
+cat <<EOF > test_a
+foo_bar_baz
+a qu_ux b c
+alpha beta gamma delta
+EOF
+
+cat <<EOF > test_b
+foo_baz_baz
+a qu_new_ux b c
+alpha 4 2 delta
+EOF
+
+# t4026-diff-color.sh tests the color escapes, so we assume they do
+# not change
+
+munge () {
+    tail -n +5 | tr '\033' '!'
+}
+
+cat <<EOF > expect-plain
+![36m@@ -1,3 +1,3 @@![m
+![31mfoo_bar_baz![m![32mfoo_baz_baz![m
+a ![m![31mqu_ux ![m![32mqu_new_ux ![mb ![mc![m
+alpha ![m![31mbeta ![m![31mgamma ![m![32m4 ![m![32m2 ![mdelta![m
+EOF
+
+test_expect_success 'default settings' '
+	git diff --no-index --color-words test_a test_b |
+		munge > actual-plain &&
+	test_cmp expect-plain actual-plain
+'
+
+test_expect_success 'trivial regex yields same as default' '
+	git diff --no-index --color-words="\\S+" test_a test_b |
+		munge > actual-trivial &&
+	test_cmp expect-plain actual-trivial
+'
+
+cat <<EOF > expect-chars
+![36m@@ -1,3 +1,3 @@![m
+f![mo![mo![m_![mb![ma![m![31mr![m![32mz![m_![mb![ma![mz![m
+a ![mq![mu![m_![m![32mn![m![32me![m![32mw![m![32m_![mu![mx ![mb ![mc![m
+a![ml![mp![mh![ma ![m![31mb![m![31me![m![31mt![m![31ma ![m![31mg![m![31ma![m![31mm![m![31mm![m![31ma ![m![32m4 ![m![32m2 ![md![me![ml![mt![ma![m
+EOF
+
+test_expect_success 'character by character regex' '
+	git diff --no-index --color-words="\\S" test_a test_b |
+		munge > actual-chars &&
+	test_cmp expect-chars actual-chars
+'
+
+cat <<EOF > expect-nontrivial
+![36m@@ -1,3 +1,3 @@![m
+foo![m_![m![31mbar![m![32mbaz![m_![mbaz![m
+a ![mqu![m_![m![32mnew![m![32m_![mux ![mb ![mc![m
+alpha ![m![31mbeta ![m![31mgamma ![m![32m4![m![32m ![m![32m2![m![32m ![mdelta![m
+EOF
+
+test_expect_success 'nontrivial regex' '
+	git diff --no-index --color-words="[a-z]+|_" test_a test_b |
+		munge > actual-nontrivial &&
+	test_cmp expect-nontrivial actual-nontrivial
+'
+
+test_expect_success 'set a diff driver' '
+	git config diff.testdriver.wordregex "\\S" &&
+	cat <<EOF > .gitattributes
+test_* diff=testdriver
+EOF
+'
+
+test_expect_success 'use default supplied by driver' '
+	git diff --no-index --color-words test_a test_b |
+		munge > actual-chars-2 &&
+	test_cmp expect-chars actual-chars-2
+'
+
+test_expect_success 'option overrides default' '
+	git diff --no-index --color-words="[a-z]+|_" test_a test_b |
+		munge > actual-nontrivial-2 &&
+	test_cmp expect-nontrivial actual-nontrivial-2
+'
+
+test_done
diff --git a/userdiff.c b/userdiff.c
index 3681062..7fd9a07 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -6,13 +6,17 @@ static struct userdiff_driver *drivers;
 static int ndrivers;
 static int drivers_alloc;
 
-#define FUNCNAME(name, pattern) \
+#define FUNCNAME(name, pattern)			\
 	{ name, NULL, -1, { pattern, REG_EXTENDED } }
+#define PATTERNS(name, pattern, wordregex)			\
+	{ name, NULL, -1, { pattern, REG_EXTENDED }, NULL, wordregex }
 static struct userdiff_driver builtin_drivers[] = {
-FUNCNAME("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$"),
-FUNCNAME("java",
+PATTERNS("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$",
+	 "[^<>= \t]+|\\S"),
+PATTERNS("java",
 	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
-	 "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$"),
+	 "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$",
+	 "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[-+*/]=|\\+\\+|--|\\S|[\x80-\xff]+"),
 FUNCNAME("objc",
 	 /* Negate C statements that can look like functions */
 	 "!^[ \t]*(do|for|if|else|return|switch|while)\n"
@@ -27,14 +31,19 @@ FUNCNAME("pascal",
 		"implementation|initialization|finalization)[ \t]*.*)$"
 	 "\n"
 	 "^(.*=[ \t]*(class|record).*)$"),
-FUNCNAME("php", "^[\t ]*((function|class).*)"),
-FUNCNAME("python", "^[ \t]*((class|def)[ \t].*)$"),
+PATTERNS("php", "^[\t ]*((function|class).*)",
+	 "\\$?[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[-+*/]=|\\+\\+|--|->|\\S|[\x80-\xff]+"),
+PATTERNS("python", "^[ \t]*((class|def)[ \t].*)$",
+	 "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[-+*/]=|//|\\S|[\x80-\xff]+"),
 FUNCNAME("ruby", "^[ \t]*((class|module|def)[ \t].*)$"),
-FUNCNAME("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$"),
-FUNCNAME("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$"),
+PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
+	 "[={}\"]|[^={}\" \t]+"),
+PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
+	 "\\\\[a-zA-Z@]+|[{}]|\\\\.|[^\\{} \t]+"),
 { "default", NULL, -1, { NULL, 0 } },
 };
 #undef FUNCNAME
+#undef PATTERNS
 
 static struct userdiff_driver driver_true = {
 	"diff=true",
@@ -134,6 +143,8 @@ int userdiff_config(const char *k, const char *v)
 		return parse_string(&drv->external, k, v);
 	if ((drv = parse_driver(k, v, "textconv")))
 		return parse_string(&drv->textconv, k, v);
+	if ((drv = parse_driver(k, v, "wordregex")))
+		return parse_string(&drv->word_regex, k, v);
 
 	return 0;
 }
diff --git a/userdiff.h b/userdiff.h
index ba29457..2aab13e 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -12,6 +12,7 @@ struct userdiff_driver {
 	int binary;
 	struct userdiff_funcname funcname;
 	const char *textconv;
+	const char *word_regex;
 };
 
 int userdiff_config(const char *k, const char *v);
-- 
tg: (c123b7c..) t/word-diff-regex (depends on: origin/master)
