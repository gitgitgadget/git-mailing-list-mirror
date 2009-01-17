From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 3/7] color-words: change algorithm to allow for 0-character word boundaries
Date: Sat, 17 Jan 2009 17:29:44 +0100
Message-ID: <1232209788-10408-4-git-send-email-trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de>
 <1232209788-10408-1-git-send-email-trast@student.ethz.ch>
 <1232209788-10408-2-git-send-email-trast@student.ethz.ch>
 <1232209788-10408-3-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Teemu Likonen <tlikonen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 17:32:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOE5L-00087b-O9
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 17:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763617AbZAQQ3z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jan 2009 11:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763512AbZAQQ3x
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 11:29:53 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:41359 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763337AbZAQQ3n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 11:29:43 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:29:40 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:29:39 +0100
X-Mailer: git-send-email 1.6.1.315.g92577
In-Reply-To: <1232209788-10408-3-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 17 Jan 2009 16:29:39.0972 (UTC) FILETIME=[CB7BEC40:01C978C0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106086>

=46rom: Johannes Schindelin <johannes.schindelin@gmx.de>

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

- the code needed extra special handling of newlines in the removed par=
t.

=46ix all of these issues by processing the text such that

- we build word lists, separated by newlines,

- we remember the original offsets for every word, and

- after calling libxdiff on the wordlists, we parse the hunk headers, a=
nd
  find the corresponding offsets, and then

- we print the removed/added parts in one go.

The pre and post samples in the test were provided by Santi B=C3=A9jar.

Note that there is some strange special handling of hunk headers where
one line range is 0 due to POSIX: in this case, the start is one too
low.  In other words a hunk header '@@ -1,0 +2 @@' actually means that
the line must be added after the _second_ line of the pre text, _not_
the first.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c                |  161 ++++++++++++++++++++++++++++-------------=
--------
 t/t4034-diff-words.sh |   66 ++++++++++++++++++++
 2 files changed, 159 insertions(+), 68 deletions(-)
 create mode 100755 t/t4034-diff-words.sh

diff --git a/diff.c b/diff.c
index c111eef..37c886a 100644
--- a/diff.c
+++ b/diff.c
@@ -319,8 +319,10 @@ static int fill_mmfile(mmfile_t *mf, struct diff_f=
ilespec *one)
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
=20
 static void diff_words_append(char *line, unsigned long len,
@@ -335,80 +337,89 @@ static void diff_words_append(char *line, unsigne=
d long len,
=20
 struct diff_words_data {
 	struct diff_words_buffer minus, plus;
+	const char *current_plus;
 	FILE *file;
 };
=20
-static void print_word(FILE *file, struct diff_words_buffer *buffer, i=
nt len, int color,
-		int suppress_newline)
+static void fn_out_diff_words_aux(void *priv, char *line, unsigned lon=
g len)
 {
-	const char *ptr;
-	int eol =3D 0;
+	struct diff_words_data *diff_words =3D priv;
+	int minus_first, minus_len, plus_first, plus_len;
+	const char *minus_begin, *minus_end, *plus_begin, *plus_end;
=20
-	if (len =3D=3D 0)
+	if (line[0] !=3D '@' || parse_hunk_header(line, len,
+			&minus_first, &minus_len, &plus_first, &plus_len))
 		return;
=20
-	ptr  =3D buffer->text.ptr + buffer->current;
-	buffer->current +=3D len;
+	/* POSIX requires that first be decremented by one if len =3D=3D 0...=
 */
+	if (minus_len) {
+		minus_begin =3D diff_words->minus.orig[minus_first].begin;
+		minus_end =3D
+			diff_words->minus.orig[minus_first + minus_len - 1].end;
+	} else
+		minus_begin =3D minus_end =3D
+			diff_words->minus.orig[minus_first].end;
=20
-	if (ptr[len - 1] =3D=3D '\n') {
-		eol =3D 1;
-		len--;
-	}
+	if (plus_len) {
+		plus_begin =3D diff_words->plus.orig[plus_first].begin;
+		plus_end =3D diff_words->plus.orig[plus_first + plus_len - 1].end;
+	} else
+		plus_begin =3D plus_end =3D diff_words->plus.orig[plus_first].end;
=20
-	fputs(diff_get_color(1, color), file);
-	fwrite(ptr, len, 1, file);
-	fputs(diff_get_color(1, DIFF_RESET), file);
+	if (diff_words->current_plus !=3D plus_begin)
+		fwrite(diff_words->current_plus,
+				plus_begin - diff_words->current_plus, 1,
+				diff_words->file);
+	if (minus_begin !=3D minus_end)
+		color_fwrite_lines(diff_words->file,
+				diff_get_color(1, DIFF_FILE_OLD),
+				minus_end - minus_begin, minus_begin);
+	if (plus_begin !=3D plus_end)
+		color_fwrite_lines(diff_words->file,
+				diff_get_color(1, DIFF_FILE_NEW),
+				plus_end - plus_begin, plus_begin);
=20
-	if (eol) {
-		if (suppress_newline)
-			buffer->suppressed_newline =3D 1;
-		else
-			putc('\n', file);
-	}
-}
-
-static void fn_out_diff_words_aux(void *priv, char *line, unsigned lon=
g len)
-{
-	struct diff_words_data *diff_words =3D priv;
-
-	if (diff_words->minus.suppressed_newline) {
-		if (line[0] !=3D '+')
-			putc('\n', diff_words->file);
-		diff_words->minus.suppressed_newline =3D 0;
-	}
-
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
-			diff_words->minus.current +=3D len;
-			break;
-	}
+	diff_words->current_plus =3D plus_end;
 }
=20
 /*
- * This function splits the words in buffer->text, and stores the list=
 with
- * newline separator into out.
+ * This function splits the words in buffer->text, stores the list wit=
h
+ * newline separator into out, and saves the offsets of the original w=
ords
+ * in buffer->orig.
  */
 static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t=
 *out)
 {
-	int i;
-	out->size =3D buffer->text.size;
-	out->ptr =3D xmalloc(out->size);
-	memcpy(out->ptr, buffer->text.ptr, out->size);
-	for (i =3D 0; i < out->size; i++)
-		if (isspace(out->ptr[i]))
-			out->ptr[i] =3D '\n';
-	buffer->current =3D 0;
+	int i, j;
+
+	out->size =3D 0;
+	out->ptr =3D xmalloc(buffer->text.size);
+
+	/* fake an empty "0th" word */
+	ALLOC_GROW(buffer->orig, 1, buffer->orig_alloc);
+	buffer->orig[0].begin =3D buffer->orig[0].end =3D buffer->text.ptr;
+	buffer->orig_nr =3D 1;
+
+	for (i =3D 0; i < buffer->text.size; i++) {
+		if (isspace(buffer->text.ptr[i]))
+			continue;
+		for (j =3D i + 1; j < buffer->text.size &&
+				!isspace(buffer->text.ptr[j]); j++)
+			; /* find the end of the word */
+
+		/* store original boundaries */
+		ALLOC_GROW(buffer->orig, buffer->orig_nr + 1,
+				buffer->orig_alloc);
+		buffer->orig[buffer->orig_nr].begin =3D buffer->text.ptr + i;
+		buffer->orig[buffer->orig_nr].end =3D buffer->text.ptr + j;
+		buffer->orig_nr++;
+
+		/* store one word */
+		memcpy(out->ptr + out->size, buffer->text.ptr + i, j - i);
+		out->ptr[out->size + j - i] =3D '\n';
+		out->size +=3D j - i + 1;
+
+		i =3D j - 1;
+	}
 }
=20
 /* this executes the word diff on the accumulated buffers */
@@ -419,22 +430,34 @@ static void diff_words_show(struct diff_words_dat=
a *diff_words)
 	xdemitcb_t ecb;
 	mmfile_t minus, plus;
=20
+	/* special case: only removal */
+	if (!diff_words->plus.text.size) {
+		color_fwrite_lines(diff_words->file,
+			diff_get_color(1, DIFF_FILE_OLD),
+			diff_words->minus.text.size, diff_words->minus.text.ptr);
+		diff_words->minus.text.size =3D 0;
+		return;
+	}
+
+	diff_words->current_plus =3D diff_words->plus.text.ptr;
+
 	memset(&xpp, 0, sizeof(xpp));
 	memset(&xecfg, 0, sizeof(xecfg));
 	diff_words_fill(&diff_words->minus, &minus);
 	diff_words_fill(&diff_words->plus, &plus);
 	xpp.flags =3D XDF_NEED_MINIMAL;
-	xecfg.ctxlen =3D diff_words->minus.alloc + diff_words->plus.alloc;
+	xecfg.ctxlen =3D 0;
 	xdi_diff_outf(&minus, &plus, fn_out_diff_words_aux, diff_words,
 		      &xpp, &xecfg, &ecb);
 	free(minus.ptr);
 	free(plus.ptr);
+	if (diff_words->current_plus !=3D diff_words->plus.text.ptr +
+			diff_words->plus.text.size)
+		fwrite(diff_words->current_plus,
+			diff_words->plus.text.ptr + diff_words->plus.text.size
+			- diff_words->current_plus, 1,
+			diff_words->file);
 	diff_words->minus.text.size =3D diff_words->plus.text.size =3D 0;
-
-	if (diff_words->minus.suppressed_newline) {
-		putc('\n', diff_words->file);
-		diff_words->minus.suppressed_newline =3D 0;
-	}
 }
=20
 typedef unsigned long (*sane_truncate_fn)(char *line, unsigned long le=
n);
@@ -458,7 +481,9 @@ static void free_diff_words_data(struct emit_callba=
ck *ecbdata)
 			diff_words_show(ecbdata->diff_words);
=20
 		free (ecbdata->diff_words->minus.text.ptr);
+		free (ecbdata->diff_words->minus.orig);
 		free (ecbdata->diff_words->plus.text.ptr);
+		free (ecbdata->diff_words->plus.orig);
 		free(ecbdata->diff_words);
 		ecbdata->diff_words =3D NULL;
 	}
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
new file mode 100755
index 0000000..b22195f
--- /dev/null
+++ b/t/t4034-diff-words.sh
@@ -0,0 +1,66 @@
+#!/bin/sh
+
+test_description=3D'word diff colors'
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
+word_diff () {
+	test_must_fail git diff --no-index "$@" pre post > output &&
+	decrypt_color < output > output.decrypted &&
+	test_cmp expect output.decrypted
+}
+
+cat > pre <<\EOF
+h(4)
+
+a =3D b + c
+EOF
+
+cat > post <<\EOF
+h(4),hh[44]
+
+a =3D b + c
+
+aa =3D a
+
+aeff =3D aeff * ( aaa )
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
+a =3D b + c<RESET>
+
+<GREEN>aa =3D a<RESET>
+
+<GREEN>aeff =3D aeff * ( aaa )<RESET>
+EOF
+
+test_expect_success 'word diff with runs of whitespace' '
+
+	word_diff --color-words
+
+'
+
+test_done
--=20
1.6.1.315.g92577
