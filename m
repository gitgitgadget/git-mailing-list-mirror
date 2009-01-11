From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 1/4] word diff: comments, preparations for regex customization
Date: Sun, 11 Jan 2009 11:27:11 +0100
Message-ID: <4aea85caafd38a058145c5769fe8a30ffdbd4d13.1231669012.git.trast@student.ethz.ch>
References: <cover.1231669012.git.trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Teemu Likonen <tlikonen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 11 11:28:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLxYf-0002rW-GQ
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 11:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbZAKK1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 05:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbZAKK1O
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 05:27:14 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:42017 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016AbZAKK1K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 05:27:10 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 11 Jan 2009 11:27:05 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 11 Jan 2009 11:27:04 +0100
X-Mailer: git-send-email 1.6.1.279.g41f0
In-Reply-To: <cover.1231669012.git.trast@student.ethz.ch>
In-Reply-To: <7vr63atykr.fsf@gitster.siamese.dyndns.org>
References: <7vr63atykr.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 11 Jan 2009 10:27:04.0650 (UTC) FILETIME=[25D2BAA0:01C973D7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105161>

This reorganizes the code for diff --color-words in a way that will be
convenient for the next patch, without changing any of the semantics.
The new variables are not used yet except for their default state.

We also add some comments on the workings of diff_words_show() and
associated helper routines.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 diff.c |   86 +++++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 69 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index d235482..f274bf5 100644
--- a/diff.c
+++ b/diff.c
@@ -316,11 +316,21 @@ static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
 	return 0;
 }
 
+/* unused right now */
+enum diff_word_boundaries {
+	DIFF_WORD_UNDEF,
+	DIFF_WORD_BODY,
+	DIFF_WORD_END,
+	DIFF_WORD_SPACE,
+	DIFF_WORD_SKIP
+};
+
 struct diff_words_buffer {
 	mmfile_t text;
 	long alloc;
 	long current; /* output pointer */
 	int suppressed_newline;
+	enum diff_word_boundaries *boundaries;
 };
 
 static void diff_words_append(char *line, unsigned long len,
@@ -339,16 +349,23 @@ static void diff_words_append(char *line, unsigned long len,
 struct diff_words_data {
 	struct diff_words_buffer minus, plus;
 	FILE *file;
+	regex_t *word_regex; /* currently unused */
 };
 
-static void print_word(FILE *file, struct diff_words_buffer *buffer, int len, int color,
+/*
+ * Print 'len' characters from the "real" diff data in 'buffer'.  Also
+ * returns how many characters were printed (currently always 'len').
+ * With 'suppress_newline', we remember a final newline instead of
+ * printing it.
+ */
+static int print_word(FILE *file, struct diff_words_buffer *buffer, int len, int color,
 		int suppress_newline)
 {
 	const char *ptr;
 	int eol = 0;
 
 	if (len == 0)
-		return;
+		return len;
 
 	ptr  = buffer->text.ptr + buffer->current;
 	buffer->current += len;
@@ -368,18 +385,30 @@ static void print_word(FILE *file, struct diff_words_buffer *buffer, int len, in
 		else
 			putc('\n', file);
 	}
+
+	/* we need to return how many chars to skip on the other side,
+	 * so account for the (held off) \n */
+	return len+eol;
 }
 
+/*
+ * Callback for word diff output
+ */
 static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 {
 	struct diff_words_data *diff_words = priv;
 
 	if (diff_words->minus.suppressed_newline) {
+		/* We completely drop a suppressed newline on the
+		 * minus side, if it is immediately followed by a plus
+		 * side output. This formats a word change right
+		 * before the end of line correctly */
 		if (line[0] != '+')
 			putc('\n', diff_words->file);
 		diff_words->minus.suppressed_newline = 0;
 	}
 
+	/* account for the [+- ] inserted by the line diff */
 	len--;
 	switch (line[0]) {
 		case '-':
@@ -391,8 +420,10 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 				   &diff_words->plus, len, DIFF_FILE_NEW, 0);
 			break;
 		case ' ':
-			print_word(diff_words->file,
-				   &diff_words->plus, len, DIFF_PLAIN, 0);
+			len = print_word(diff_words->file,
+					 &diff_words->plus, len, DIFF_PLAIN, 0);
+			/* skip the characters that were printed on
+			 * the other side, too */
 			diff_words->minus.current += len;
 			break;
 	}
@@ -409,22 +440,37 @@ static void diff_words_show(struct diff_words_data *diff_words)
 
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
+	/* currently always true */
+	if (!diff_words->word_regex) {
+		/*
+		 * "Simple" word diff: replace all space characters
+		 * with a newline.
+		 *
+		 * This groups together "words" of nonspaces on a line
+		 * each, which we then diff using the normal line-diff
+		 * mechanism.  It also has the nice property that
+		 * character counts/offsets stay the same.
+		 */
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
+	}
+	diff_words->minus.current = 0;
 	diff_words->plus.current = 0;
 
+	/* we want a minimal diff with enough context to run
+	 * everything into a single hunk */
 	xpp.flags = XDF_NEED_MINIMAL;
 	xecfg.ctxlen = diff_words->minus.alloc + diff_words->plus.alloc;
 	xdi_diff_outf(&minus, &plus, fn_out_diff_words_aux, diff_words,
@@ -432,7 +478,12 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	free(minus.ptr);
 	free(plus.ptr);
 	diff_words->minus.text.size = diff_words->plus.text.size = 0;
+	/* these two are currently free(NULL) */
+	free(diff_words->minus.boundaries);
+	free(diff_words->plus.boundaries);
 
+	/* do not forget about a possible final newline that was held
+	 * back */
 	if (diff_words->minus.suppressed_newline) {
 		putc('\n', diff_words->file);
 		diff_words->minus.suppressed_newline = 0;
@@ -461,6 +512,7 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
 
 		free (ecbdata->diff_words->minus.text.ptr);
 		free (ecbdata->diff_words->plus.text.ptr);
+		free(ecbdata->diff_words->word_regex);
 		free(ecbdata->diff_words);
 		ecbdata->diff_words = NULL;
 	}
-- 
1.6.1.269.g0769
