From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words
 configurable
Date: Wed, 07 May 2008 12:13:39 -0700
Message-ID: <7viqxqc4gs.fsf@gitster.siamese.dyndns.org>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
 <46dff0320805031732x25286707r991358162046c07c@mail.gmail.com>
 <alpine.DEB.1.00.0805041040560.30431@racer>
 <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com>
 <7v63ttq0y8.fsf@gitster.siamese.dyndns.org>
 <46dff0320805041840g1b9362d3u138b9d40cde160f2@mail.gmail.com>
 <7vprs1ny5e.fsf@gitster.siamese.dyndns.org>
 <46dff0320805050510t3bc5fd0eq44e0d58d1bb57629@mail.gmail.com>
 <46dff0320805051740o65eee07eqc7073e4fa7996277@mail.gmail.com>
 <alpine.DEB.1.00.0805060954470.30431@racer>
 <46dff0320805061815k6aca9020g285b09da2bcf29c3@mail.gmail.com>
 <alpine.DEB.1.00.0805071223450.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 07 21:14:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtp6H-0001AI-Mn
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 21:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765739AbYEGTN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 15:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765480AbYEGTN6
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 15:13:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49907 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758371AbYEGTNy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 15:13:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 15147301C;
	Wed,  7 May 2008 15:13:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 166543017; Wed,  7 May 2008 15:13:45 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0805071223450.30431@racer> (Johannes
 Schindelin's message of "Wed, 7 May 2008 12:24:19 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BB507CC2-1C69-11DD-BDE9-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81472>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I am rather interested in the semantics, i.e. if you can punch holes into 
> this 3-class approach.

This is not the 3-class thing, but was done as a lunchtime hack.  It
removes more lines than it adds, with real comments ;-).

 * It removes the custom allocator used for minus/plus buffers and
   replaces it with the bog-standard strbuf;

 * The tokenization is done when diff_words_append() is called, i.e. when
   we read the original "added or deleted _lines_";

 * The tokenization function is separated out, and gets the emit_callback,
   so anybody can enhance it with customization using gitattributes and
   other heuristics.  More importantly, it is not byte oriented and would
   be easier to extend it to UTF-8 contents;

 * It does not have to play "suppressed_newline" games anymore.  A LF is
   just a token.

I haven't tested this at all (this is a lunchtime hack) and have a mild
suspicion that it may have corner case miscounting (e.g. I blindly
subtracts 3 from len when dealing with a line that represents a single
token from the internal diff output --- do I always have 3 there even when
the original file ends with an incomplete line?  I didn't check), but
other than that I think this is a lot easier to read and follow.

---

 diff.c |  216 +++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 106 insertions(+), 110 deletions(-)

diff --git a/diff.c b/diff.c
index e35384b..344aaa6 100644
--- a/diff.c
+++ b/diff.c
@@ -351,87 +351,119 @@ static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
 	return 0;
 }
 
-struct diff_words_buffer {
-	mmfile_t text;
-	long alloc;
-	long current; /* output pointer */
-	int suppressed_newline;
+typedef unsigned long (*sane_truncate_fn)(char *line, unsigned long len);
+
+struct emit_callback {
+	struct xdiff_emit_state xm;
+	int nparents, color_diff;
+	unsigned ws_rule;
+	sane_truncate_fn truncate;
+	const char **label_path;
+	struct diff_words_data *diff_words;
+	int *found_changesp;
+	FILE *file;
 };
 
-static void diff_words_append(char *line, unsigned long len,
-		struct diff_words_buffer *buffer)
+static size_t diff_words_tokenize(struct emit_callback *ecbdata,
+				  char *line, unsigned long len)
 {
-	if (buffer->text.size + len > buffer->alloc) {
-		buffer->alloc = (buffer->text.size + len) * 3 / 2;
-		buffer->text.ptr = xrealloc(buffer->text.ptr, buffer->alloc);
+	/*
+	 * This function currently is deliberately done very stupid,
+	 * but passing ecbdata here means that you can potentially
+	 * implement different tokenization rules depending on
+	 * the content (e.g. "gitattributes(5)").
+	 */
+	int is_space;
+	char *line0 = line;
+
+	if (!len)
+		return 0;
+
+	is_space = isspace(*line);
+	while (len && (isspace(*line) == is_space)) {
+		line++;
+		len--;
 	}
+	return line - line0;
+}
+
+static void diff_words_append(struct emit_callback *ecbdata,
+			      char *line, unsigned long len,
+			      struct strbuf *text)
+{
+	/* Skip leading +/- first. */
 	line++;
 	len--;
-	memcpy(buffer->text.ptr + buffer->text.size, line, len);
-	buffer->text.size += len;
+
+	/*
+	 * Tokenize and stuff the words in.
+	 */
+	while (len) {
+		size_t token_len = diff_words_tokenize(ecbdata, line, len);
+
+		if (line[0] != '\n') {
+			/*
+			 * A nonempty token has ' ' stuffed in front,
+			 * so that we can recover the original
+			 * end-of-line easily.  Stupid, but works.
+			 */
+			strbuf_add(text, " ", 1);
+			strbuf_add(text, line, token_len);
+			strbuf_add(text, "\n", 1);
+			len -= token_len;
+			line += token_len;
+		} else {
+			/* A real LF */
+			strbuf_add(text, "\n", 1);
+			break;
+		}
+	}
 }
 
 struct diff_words_data {
 	struct xdiff_emit_state xm;
-	struct diff_words_buffer minus, plus;
+	struct strbuf minus;
+	struct strbuf plus;
 	FILE *file;
 };
 
-static void print_word(FILE *file, struct diff_words_buffer *buffer, int len, int color,
-		int suppress_newline)
+static void emit_line(FILE *file, const char *set, const char *reset, const char *line, int len)
 {
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
+	fputs(set, file);
+	fwrite(line, len, 1, file);
+	fputs(reset, file);
 }
 
 static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 {
 	struct diff_words_data *diff_words = priv;
+	const char *set;
+	const char *reset = diff_colors[DIFF_RESET];
 
-	if (diff_words->minus.suppressed_newline) {
-		if (line[0] != '+')
-			putc('\n', diff_words->file);
-		diff_words->minus.suppressed_newline = 0;
+	switch (line[0]) {
+	case '-':
+		set = diff_colors[DIFF_FILE_OLD];
+		break;
+	case '+':
+		set = diff_colors[DIFF_FILE_NEW];
+		break;
+	case ' ':
+		set = diff_colors[DIFF_PLAIN];
+		break;
+	default:
+		return; /* omit @@ -j,k +l,m @@ header */
 	}
 
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
+	if (line[1] == ' ') {
+		/* A token */
+		line += 2;
+		len -= 3; /* drop the trailing LF */
+	} else {
+		/* A real LF */
+		line++;
+		len--;
 	}
+	emit_line(diff_words->file, set, reset, line, len);
 }
 
 /* this executes the word diff on the accumulated buffers */
@@ -441,27 +473,18 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	xdemitconf_t xecfg;
 	xdemitcb_t ecb;
 	mmfile_t minus, plus;
-	int i;
+	unsigned long sz;
 
 	memset(&xecfg, 0, sizeof(xecfg));
-	minus.size = diff_words->minus.text.size;
-	minus.ptr = xmalloc(minus.size);
-	memcpy(minus.ptr, diff_words->minus.text.ptr, minus.size);
-	for (i = 0; i < minus.size; i++)
-		if (isspace(minus.ptr[i]))
-			minus.ptr[i] = '\n';
-	diff_words->minus.current = 0;
-
-	plus.size = diff_words->plus.text.size;
-	plus.ptr = xmalloc(plus.size);
-	memcpy(plus.ptr, diff_words->plus.text.ptr, plus.size);
-	for (i = 0; i < plus.size; i++)
-		if (isspace(plus.ptr[i]))
-			plus.ptr[i] = '\n';
-	diff_words->plus.current = 0;
+
+	minus.ptr = strbuf_detach(&diff_words->minus, &sz);
+	minus.size = sz;
+	plus.ptr = strbuf_detach(&diff_words->plus, &sz);
+	plus.size = sz;
 
 	xpp.flags = XDF_NEED_MINIMAL;
-	xecfg.ctxlen = diff_words->minus.alloc + diff_words->plus.alloc;
+	/* hack to make it a single hunk to show all */
+	xecfg.ctxlen = minus.size + plus.size;
 	ecb.outf = xdiff_outf;
 	ecb.priv = diff_words;
 	diff_words->xm.consume = fn_out_diff_words_aux;
@@ -469,37 +492,15 @@ static void diff_words_show(struct diff_words_data *diff_words)
 
 	free(minus.ptr);
 	free(plus.ptr);
-	diff_words->minus.text.size = diff_words->plus.text.size = 0;
-
-	if (diff_words->minus.suppressed_newline) {
-		putc('\n', diff_words->file);
-		diff_words->minus.suppressed_newline = 0;
-	}
 }
 
-typedef unsigned long (*sane_truncate_fn)(char *line, unsigned long len);
-
-struct emit_callback {
-	struct xdiff_emit_state xm;
-	int nparents, color_diff;
-	unsigned ws_rule;
-	sane_truncate_fn truncate;
-	const char **label_path;
-	struct diff_words_data *diff_words;
-	int *found_changesp;
-	FILE *file;
-};
-
 static void free_diff_words_data(struct emit_callback *ecbdata)
 {
 	if (ecbdata->diff_words) {
 		/* flush buffers */
-		if (ecbdata->diff_words->minus.text.size ||
-				ecbdata->diff_words->plus.text.size)
+		if (ecbdata->diff_words->minus.len ||
+		    ecbdata->diff_words->plus.len)
 			diff_words_show(ecbdata->diff_words);
-
-		free (ecbdata->diff_words->minus.text.ptr);
-		free (ecbdata->diff_words->plus.text.ptr);
 		free(ecbdata->diff_words);
 		ecbdata->diff_words = NULL;
 	}
@@ -512,13 +513,6 @@ const char *diff_get_color(int diff_use_color, enum color_diff ix)
 	return "";
 }
 
-static void emit_line(FILE *file, const char *set, const char *reset, const char *line, int len)
-{
-	fputs(set, file);
-	fwrite(line, len, 1, file);
-	fputs(reset, file);
-}
-
 static void emit_add_line(const char *reset, struct emit_callback *ecbdata, const char *line, int len)
 {
 	const char *ws = diff_get_color(ecbdata->color_diff, DIFF_WHITESPACE);
@@ -604,16 +598,16 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		free_diff_words_data(ecbdata);
 	if (ecbdata->diff_words) {
 		if (line[0] == '-') {
-			diff_words_append(line, len,
+			diff_words_append(ecbdata, line, len,
 					  &ecbdata->diff_words->minus);
 			return;
 		} else if (line[0] == '+') {
-			diff_words_append(line, len,
+			diff_words_append(ecbdata, line, len,
 					  &ecbdata->diff_words->plus);
 			return;
 		}
-		if (ecbdata->diff_words->minus.text.size ||
-		    ecbdata->diff_words->plus.text.size)
+		if (ecbdata->diff_words->minus.len ||
+		    ecbdata->diff_words->plus.len)
 			diff_words_show(ecbdata->diff_words);
 		line++;
 		len--;
@@ -1470,6 +1464,8 @@ static void builtin_diff(const char *name_a,
 		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS)) {
 			ecbdata.diff_words =
 				xcalloc(1, sizeof(struct diff_words_data));
+			strbuf_init(&ecbdata.diff_words->minus, 0);
+			strbuf_init(&ecbdata.diff_words->plus, 0);
 			ecbdata.diff_words->file = o->file;
 		}
 		xdi_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
