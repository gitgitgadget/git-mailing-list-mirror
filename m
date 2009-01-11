From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/4] color-words: refactor to allow for 0-character word
 boundaries
Date: Sun, 11 Jan 2009 20:59:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901112059340.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 11 21:01:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM6UT-0004Tw-M4
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 21:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbZAKT7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 14:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752423AbZAKT7V
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 14:59:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:43349 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751738AbZAKT7U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 14:59:20 -0500
Received: (qmail invoked by alias); 11 Jan 2009 19:59:15 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp003) with SMTP; 11 Jan 2009 20:59:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lbEVTzl5l/PCOwSsSDMKhJkZ1GLKkN02iqazTdw
	DUqLfRlWJvHcR9
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105208>


Up until now, the color-words code assumed that word boundaries are
identical to white space characters.

Therefore, it could get away with a very simple scheme: it copied the
hunks, substituted newlines for each white space character, called
libxdiff with the processed text, but then identified the text to
print out by the offsets (which agreed since the original text had the
same length).

This code was ugly, for a number of reasons:

- it was impossible to introduce 0-character word boundaries,

- we had to print everything word by word, and

- the code needed extra special handling of newlines in the removed part.

Fix all of these issues by processing the text such that

- we build word lists, separated by newlines,

- we remember the original offsets for every word, and

- after calling libxdiff on the wordlists, we parse the hunk headers, and
  find the corresponding offsets, and then

- we print the removed/added parts in one go.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c |  150 +++++++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 82 insertions(+), 68 deletions(-)

diff --git a/diff.c b/diff.c
index 6d87ea5..2a3d301 100644
--- a/diff.c
+++ b/diff.c
@@ -319,8 +319,10 @@ static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
 struct diff_words_buffer {
 	mmfile_t text;
 	long alloc;
-	long current; /* output pointer */
-	int suppressed_newline;
+	struct diff_words_orig {
+		const char *begin, *end;
+	} *orig;
+	int orig_nr, orig_alloc;
 };
 
 static void diff_words_append(char *line, unsigned long len,
@@ -335,80 +337,79 @@ static void diff_words_append(char *line, unsigned long len,
 
 struct diff_words_data {
 	struct diff_words_buffer minus, plus;
+	const char *current_plus;
 	FILE *file;
 };
 
-static void print_word(FILE *file, struct diff_words_buffer *buffer, int len, int color,
-		int suppress_newline)
+static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 {
-	const char *ptr;
-	int eol = 0;
+	struct diff_words_data *diff_words = priv;
+	int minus_first, minus_len, plus_first, plus_len;
+	const char *minus_begin, *minus_end, *plus_begin, *plus_end;
 
-	if (len == 0)
+	if (line[0] != '@' || parse_hunk_header(line, len,
+			&minus_first, &minus_len, &plus_first, &plus_len))
 		return;
 
-	ptr  = buffer->text.ptr + buffer->current;
-	buffer->current += len;
-
-	if (ptr[len - 1] == '\n') {
-		eol = 1;
-		len--;
-	}
-
-	fputs(diff_get_color(1, color), file);
-	fwrite(ptr, len, 1, file);
-	fputs(diff_get_color(1, DIFF_RESET), file);
-
-	if (eol) {
-		if (suppress_newline)
-			buffer->suppressed_newline = 1;
-		else
-			putc('\n', file);
-	}
-}
-
-static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
-{
-	struct diff_words_data *diff_words = priv;
+	minus_begin = diff_words->minus.orig[minus_first].begin;
+	minus_end = minus_len == 0 ? minus_begin :
+		diff_words->minus.orig[minus_first + minus_len - 1].end;
+	plus_begin = diff_words->plus.orig[plus_first].begin;
+	plus_end = plus_len == 0 ? plus_begin :
+		diff_words->plus.orig[plus_first + plus_len - 1].end;
 
-	if (diff_words->minus.suppressed_newline) {
-		if (line[0] != '+')
-			putc('\n', diff_words->file);
-		diff_words->minus.suppressed_newline = 0;
-	}
+	if (diff_words->current_plus != plus_begin)
+		fwrite(diff_words->current_plus,
+				plus_begin - diff_words->current_plus, 1,
+				diff_words->file);
+	if (minus_begin != minus_end)
+		color_fwrite(diff_words->file, diff_get_color(1, DIFF_FILE_OLD),
+				minus_end - minus_begin, minus_begin);
+	if (plus_begin != plus_end)
+		color_fwrite(diff_words->file, diff_get_color(1, DIFF_FILE_NEW),
+				plus_end - plus_begin, plus_begin);
 
-	len--;
-	switch (line[0]) {
-		case '-':
-			print_word(diff_words->file,
-				   &diff_words->minus, len, DIFF_FILE_OLD, 1);
-			break;
-		case '+':
-			print_word(diff_words->file,
-				   &diff_words->plus, len, DIFF_FILE_NEW, 0);
-			break;
-		case ' ':
-			print_word(diff_words->file,
-				   &diff_words->plus, len, DIFF_PLAIN, 0);
-			diff_words->minus.current += len;
-			break;
-	}
+	diff_words->current_plus = plus_end;
 }
 
 /*
- * This function splits the words in buffer->text, and stores the list with
- * newline separator into out.
+ * This function splits the words in buffer->text, stores the list with
+ * newline separator into out, and saves the offsets of the original words
+ * in buffer->orig.
  */
 static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out)
 {
-	int i;
-	out->size = buffer->text.size;
-	out->ptr = xmalloc(out->size);
-	memcpy(out->ptr, buffer->text.ptr, out->size);
-	for (i = 0; i < out->size; i++)
-		if (isspace(out->ptr[i]))
-			out->ptr[i] = '\n';
-	buffer->current = 0;
+	int i, j;
+
+	out->size = 0;
+	out->ptr = xmalloc(buffer->text.size);
+
+	/* fake an empty "0th" word */
+	ALLOC_GROW(buffer->orig, 1, buffer->orig_alloc);
+	buffer->orig[0].begin = buffer->orig[0].end = buffer->text.ptr;
+	buffer->orig_nr = 1;
+
+	for (i = 0; i < buffer->text.size; i++) {
+		if (isspace(buffer->text.ptr[i]))
+			continue;
+		for (j = i + 1; j < buffer->text.size &&
+				!isspace(buffer->text.ptr[j]); j++)
+			; /* find the end of the word */
+
+		/* store original boundaries */
+		ALLOC_GROW(buffer->orig, buffer->orig_nr + 1,
+				buffer->orig_alloc);
+		buffer->orig[buffer->orig_nr].begin = buffer->text.ptr + i;
+		buffer->orig[buffer->orig_nr].end = buffer->text.ptr + j;
+		buffer->orig_nr++;
+
+		/* store one word */
+		memcpy(out->ptr + out->size, buffer->text.ptr + i, j - i);
+		out->ptr[out->size + j - i] = '\n';
+		out->size += j - i + 1;
+
+		i = j - 1;
+	}
 }
 
 /* this executes the word diff on the accumulated buffers */
@@ -419,22 +420,33 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	xdemitcb_t ecb;
 	mmfile_t minus, plus;
 
+	/* special case: only removal */
+	if (!diff_words->plus.text.size) {
+		color_fwrite(diff_words->file, diff_get_color(1, DIFF_FILE_OLD),
+			diff_words->minus.text.size, diff_words->minus.text.ptr);
+		diff_words->minus.text.size = 0;
+		return;
+	}
+
+	diff_words->current_plus = diff_words->plus.text.ptr;
+
 	memset(&xpp, 0, sizeof(xpp));
 	memset(&xecfg, 0, sizeof(xecfg));
 	diff_words_fill(&diff_words->minus, &minus);
 	diff_words_fill(&diff_words->plus, &plus);
 	xpp.flags = XDF_NEED_MINIMAL;
-	xecfg.ctxlen = diff_words->minus.alloc + diff_words->plus.alloc;
+	xecfg.ctxlen = 0;
 	xdi_diff_outf(&minus, &plus, fn_out_diff_words_aux, diff_words,
 		      &xpp, &xecfg, &ecb);
 	free(minus.ptr);
 	free(plus.ptr);
+	if (diff_words->current_plus != diff_words->plus.text.ptr +
+			diff_words->plus.text.size)
+		fwrite(diff_words->current_plus,
+			diff_words->plus.text.ptr + diff_words->plus.text.size
+			- diff_words->current_plus, 1,
+			diff_words->file);
 	diff_words->minus.text.size = diff_words->plus.text.size = 0;
-
-	if (diff_words->minus.suppressed_newline) {
-		putc('\n', diff_words->file);
-		diff_words->minus.suppressed_newline = 0;
-	}
 }
 
 typedef unsigned long (*sane_truncate_fn)(char *line, unsigned long len);
@@ -458,7 +470,9 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
 			diff_words_show(ecbdata->diff_words);
 
 		free (ecbdata->diff_words->minus.text.ptr);
+		free (ecbdata->diff_words->minus.orig);
 		free (ecbdata->diff_words->plus.text.ptr);
+		free (ecbdata->diff_words->plus.orig);
 		free(ecbdata->diff_words);
 		ecbdata->diff_words = NULL;
 	}
-- 
1.6.1.186.g48f3bc4
