From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH] make diff --color-words customizable
Date: Fri,  9 Jan 2009 01:05:05 +0100
Message-ID: <1231459505-14395-1-git-send-email-trast@student.ethz.ch>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 09 01:06:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL4tM-0002Eg-W0
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 01:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbZAIAFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 19:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753605AbZAIAFD
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 19:05:03 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:12005 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752525AbZAIAFA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 19:05:00 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 9 Jan 2009 01:04:58 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 9 Jan 2009 01:04:58 +0100
X-Mailer: git-send-email 1.6.1.86.g51ea5
X-OriginalArrivalTime: 09 Jan 2009 00:04:58.0115 (UTC) FILETIME=[E8A5FD30:01C971ED]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104970>

Allows for user-configurable word splits when using --color-words.
This can make the diff more readable if the regex is configured
according to the language of the file.

For now the (POSIX extended) regex must be set via the environment
GIT_DIFF_WORDS_REGEX.  Each (non-overlapping) match of the regex is
considered a word.  Anything characters not matched are considered
whitespace.  For example, for C try

  GIT_DIFF_WORDS_REGEX='[0-9]+|[a-zA-Z_][a-zA-Z0-9_]*|(\+|-|&|\|){1,2}|\S'

and for TeX try

  GIT_DIFF_WORDS_REGEX='\\[a-zA-Z@]+ *|\{|\}|\\.|[^\{} [:space:]]+'

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---

Word diff becomes much more useful especially with TeX, where it is
common to run together \sequences\of\commands\like\this that the
current --color-words treats as a single word.

Apart from possible bugs, the main issue is: where should I put the
configuration for this?


 diff.c |  142 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 127 insertions(+), 15 deletions(-)

diff --git a/diff.c b/diff.c
index d235482..c1e24de 100644
--- a/diff.c
+++ b/diff.c
@@ -321,6 +321,7 @@ struct diff_words_buffer {
 	long alloc;
 	long current; /* output pointer */
 	int suppressed_newline;
+	enum diff_word_boundaries *boundaries;
 };
 
 static void diff_words_append(char *line, unsigned long len,
@@ -336,21 +337,35 @@ static void diff_words_append(char *line, unsigned long len,
 	buffer->text.size += len;
 }
 
+enum diff_word_boundaries {
+	DIFF_WORD_CONT,
+	DIFF_WORD_START,
+	DIFF_WORD_SPACE
+};
+
+
 struct diff_words_data {
 	struct diff_words_buffer minus, plus;
 	FILE *file;
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
+	if (buffer->boundaries[buffer->current+len-1] == DIFF_WORD_START) {
+		buffer->boundaries[buffer->current+len-1] = DIFF_WORD_CONT;
+		len--;
+	}
+
 	buffer->current += len;
 
 	if (ptr[len - 1] == '\n') {
@@ -368,6 +383,8 @@ static void print_word(FILE *file, struct diff_words_buffer *buffer, int len, in
 		else
 			putc('\n', file);
 	}
+
+	return len;
 }
 
 static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
@@ -391,13 +408,79 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
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
 
+static char *worddiff_default = "\\S+";
+static regex_t worddiff_regex;
+static int worddiff_regex_compiled = 0;
+
+static int scan_word_boundaries(struct diff_words_buffer *buf)
+{
+	enum diff_word_boundaries *boundaries = buf->boundaries;
+	char *text = buf->text.ptr;
+	int len = buf->text.size;
+
+	int i = 0;
+	int count = 0;
+	int ret;
+	regmatch_t matches[1];
+	int offset, wordlen;
+	char *strz;
+
+	if (!text)
+		return 0;
+
+	if (!worddiff_regex_compiled) {
+		char *wd_pat = getenv("GIT_DIFF_WORDS_REGEX");
+		if (!wd_pat)
+			wd_pat = worddiff_default;
+		ret = regcomp(&worddiff_regex, wd_pat, REG_EXTENDED);
+		if (ret) {
+			char errbuf[1024];
+			regerror(ret, &worddiff_regex, errbuf, 1024);
+			die("word diff regex failed to compile: '%s': %s",
+			    wd_pat, errbuf);
+		}
+		worddiff_regex_compiled = 1;
+	}
+
+	strz = xmalloc(len+1);
+	memcpy(strz, text, len);
+	strz[len] = '\0';
+
+	while (i < len) {
+		ret = regexec(&worddiff_regex, strz+i, 1, matches, 0);
+		if (ret == REG_NOMATCH) {
+			/* the rest is whitespace */
+			while (i < len)
+				boundaries[i++] = DIFF_WORD_SPACE;
+			break;
+		}
+
+		offset = matches[0].rm_so;
+		while (offset-- > 0 && i < len)
+			boundaries[i++] = DIFF_WORD_SPACE;
+
+		wordlen = matches[0].rm_eo - matches[0].rm_so;
+		if (wordlen-- > 0 && i < len) {
+			boundaries[i++] = DIFF_WORD_START;
+			count++;
+		}
+		while (wordlen-- > 0 && i < len)
+			boundaries[i++] = DIFF_WORD_CONT;
+	}
+
+	free(strz);
+
+	return count;
+}
+
+
 /* this executes the word diff on the accumulated buffers */
 static void diff_words_show(struct diff_words_data *diff_words)
 {
@@ -406,23 +489,50 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	xdemitcb_t ecb;
 	mmfile_t minus, plus;
 	int i;
+	char *p;
+	int bcount;
 
 	memset(&xpp, 0, sizeof(xpp));
 	memset(&xecfg, 0, sizeof(xecfg));
-	minus.size = diff_words->minus.text.size;
-	minus.ptr = xmalloc(minus.size);
-	memcpy(minus.ptr, diff_words->minus.text.ptr, minus.size);
-	for (i = 0; i < minus.size; i++)
-		if (isspace(minus.ptr[i]))
-			minus.ptr[i] = '\n';
+
+	diff_words->minus.boundaries = xmalloc(diff_words->minus.text.size * sizeof(enum diff_word_boundaries));
+	bcount = scan_word_boundaries(&diff_words->minus);
+	minus.size = diff_words->minus.text.size + bcount;
+	minus.ptr = xmalloc(minus.size + bcount);
+	p = minus.ptr;
+	for (i = 0; i < diff_words->minus.text.size; i++) {
+		switch (diff_words->minus.boundaries[i]) {
+		case DIFF_WORD_START:
+			*p++ = '\n';
+			/* fall through */
+		case DIFF_WORD_CONT:
+			*p++ = diff_words->minus.text.ptr[i];
+			break;
+		case DIFF_WORD_SPACE:
+			*p++ = '\n';
+			break;
+		}
+	}
 	diff_words->minus.current = 0;
 
-	plus.size = diff_words->plus.text.size;
+	diff_words->plus.boundaries = xmalloc(diff_words->plus.text.size * sizeof(enum diff_word_boundaries));
+	bcount = scan_word_boundaries(&diff_words->plus);
+	plus.size = diff_words->plus.text.size + bcount;
 	plus.ptr = xmalloc(plus.size);
-	memcpy(plus.ptr, diff_words->plus.text.ptr, plus.size);
-	for (i = 0; i < plus.size; i++)
-		if (isspace(plus.ptr[i]))
-			plus.ptr[i] = '\n';
+	p = plus.ptr;
+	for (i = 0; i < diff_words->plus.text.size; i++) {
+		switch (diff_words->plus.boundaries[i]) {
+		case DIFF_WORD_START:
+			*p++ = '\n';
+			/* fall through */
+		case DIFF_WORD_CONT:
+			*p++ = diff_words->plus.text.ptr[i];
+			break;
+		case DIFF_WORD_SPACE:
+			*p++ = '\n';
+			break;
+		}
+	}
 	diff_words->plus.current = 0;
 
 	xpp.flags = XDF_NEED_MINIMAL;
@@ -432,6 +542,8 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	free(minus.ptr);
 	free(plus.ptr);
 	diff_words->minus.text.size = diff_words->plus.text.size = 0;
+	free(diff_words->minus.boundaries);
+	free(diff_words->plus.boundaries);
 
 	if (diff_words->minus.suppressed_newline) {
 		putc('\n', diff_words->file);
-- 
tg: (c123b7c..) t/word-diff-regex (depends on: origin/master)
