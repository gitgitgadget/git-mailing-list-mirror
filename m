From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/4] color-words: change algorithm to allow for 0-character
 word boundaries
Date: Wed, 14 Jan 2009 18:51:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901141851030.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901112059340.3586@pacific.mpi-cbg.de> <200901120947.13566.trast@student.ethz.ch> <7vprisj26i.fsf@gitster.siamese.dyndns.org> <adf1fd3d0901140500j10556a1as6370d40d766f1899@mail.gmail.com>
 <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-619604115-1231955491=:3586"
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 18:52:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN9uc-0002eo-2z
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 18:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbZANRup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 12:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752250AbZANRup
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 12:50:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:40711 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751538AbZANRun (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 12:50:43 -0500
Received: (qmail invoked by alias); 14 Jan 2009 17:50:38 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 14 Jan 2009 18:50:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/12oV4JcH1+t+E3qrKBVNFDfVvoP7x8WMctzST71
	i7u2APzLczC53H
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105671>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-619604115-1231955491=:3586
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT


Up until now, the color-words code assumed that word boundaries are
identical to white space characters.

Therefore, it could get away with a very simple scheme: it copied the
hunks, substituted newlines for each white space character, called
libxdiff with the processed text, and then identified the text to
output by the offsets (which agreed since the original text had the
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

The pre and post samples in the test were provided by Santi Béjar.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c                |  153 +++++++++++++++++++++++++++----------------------
 t/t4034-diff-words.sh |   62 ++++++++++++++++++++
 2 files changed, 147 insertions(+), 68 deletions(-)
 create mode 100755 t/t4034-diff-words.sh

diff --git a/diff.c b/diff.c
index 6d87ea5..fe8b1f0 100644
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
@@ -335,80 +337,81 @@ static void diff_words_append(char *line, unsigned long len,
 
 struct diff_words_data {
 	struct diff_words_buffer minus, plus;
+	const char *current_plus;
 	FILE *file;
 };
 
-static void print_word(FILE *file, struct diff_words_buffer *buffer, int len, int color,
-		int suppress_newline)
-{
-	const char *ptr;
-	int eol = 0;
-
-	if (len == 0)
-		return;
-
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
 static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 {
 	struct diff_words_data *diff_words = priv;
+	int minus_first, minus_len, plus_first, plus_len;
+	const char *minus_begin, *minus_end, *plus_begin, *plus_end;
 
-	if (diff_words->minus.suppressed_newline) {
-		if (line[0] != '+')
-			putc('\n', diff_words->file);
-		diff_words->minus.suppressed_newline = 0;
-	}
+	if (line[0] != '@' || parse_hunk_header(line, len,
+			&minus_first, &minus_len, &plus_first, &plus_len))
+		return;
 
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
+	minus_begin = diff_words->minus.orig[minus_first].begin;
+	minus_end = minus_len == 0 ? minus_begin :
+		diff_words->minus.orig[minus_first + minus_len - 1].end;
+	plus_begin = diff_words->plus.orig[plus_first].begin;
+	plus_end = plus_len == 0 ? plus_begin :
+		diff_words->plus.orig[plus_first + plus_len - 1].end;
+
+	if (diff_words->current_plus != plus_begin)
+		fwrite(diff_words->current_plus,
+				plus_begin - diff_words->current_plus, 1,
+				diff_words->file);
+	if (minus_begin != minus_end)
+		color_fwrite_lines(diff_words->file,
+				diff_get_color(1, DIFF_FILE_OLD),
+				minus_end - minus_begin, minus_begin);
+	if (plus_begin != plus_end)
+		color_fwrite_lines(diff_words->file,
+				diff_get_color(1, DIFF_FILE_NEW),
+				plus_end - plus_begin, plus_begin);
+
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
@@ -419,22 +422,34 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	xdemitcb_t ecb;
 	mmfile_t minus, plus;
 
+	/* special case: only removal */
+	if (!diff_words->plus.text.size) {
+		color_fwrite_lines(diff_words->file,
+			diff_get_color(1, DIFF_FILE_OLD),
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
@@ -458,7 +473,9 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
 			diff_words_show(ecbdata->diff_words);
 
 		free (ecbdata->diff_words->minus.text.ptr);
+		free (ecbdata->diff_words->minus.orig);
 		free (ecbdata->diff_words->plus.text.ptr);
+		free (ecbdata->diff_words->plus.orig);
 		free(ecbdata->diff_words);
 		ecbdata->diff_words = NULL;
 	}
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
new file mode 100755
index 0000000..b032bd3
--- /dev/null
+++ b/t/t4034-diff-words.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+
+test_description='word diff colors'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	git config diff.color.old red
+	git config diff.color.new green
+
+'
+
+decrypt_color () {
+	sed \
+		-e 's/.\[1m/<WHITE>/g' \
+		-e 's/.\[31m/<RED>/g' \
+		-e 's/.\[32m/<GREEN>/g' \
+		-e 's/.\[36m/<BROWN>/g' \
+		-e 's/.\[m/<RESET>/g'
+}
+
+cat > pre <<\EOF
+h(4)
+
+a = b + c
+EOF
+
+cat > post <<\EOF
+h(4),hh[44]
+
+a = b + c
+
+aa = a
+
+aeff = aeff * ( aaa )
+EOF
+
+cat > expect <<\EOF
+<WHITE>diff --git a/pre b/post<RESET>
+<WHITE>index 330b04f..5ed8eff 100644<RESET>
+<WHITE>--- a/pre<RESET>
+<WHITE>+++ b/post<RESET>
+<BROWN>@@ -1,3 +1,7 @@<RESET>
+<RED>h(4)<RESET><GREEN>h(4),hh[44]<RESET>
+<RESET>
+a = b + c<RESET>
+
+<GREEN>aa = a<RESET>
+
+<GREEN>aeff = aeff * ( aaa )<RESET>
+EOF
+
+test_expect_success 'word diff with runs of whitespace' '
+
+	test_must_fail git diff --no-index --color-words pre post > output &&
+	decrypt_color < output > output.decrypted &&
+	test_cmp expect output.decrypted
+
+'
+
+test_done
-- 
1.6.1.243.g4c9c5a


--8323328-619604115-1231955491=:3586--
