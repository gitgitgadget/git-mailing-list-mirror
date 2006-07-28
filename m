From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC] Add the --color-words option to the diff options family
Date: Fri, 28 Jul 2006 23:56:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607282354450.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Jul 28 23:56:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6aJh-00035h-2v
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 23:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161321AbWG1V4S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 17:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161324AbWG1V4S
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 17:56:18 -0400
Received: from mail.gmx.net ([213.165.64.21]:16862 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161321AbWG1V4R (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 17:56:17 -0400
Received: (qmail invoked by alias); 28 Jul 2006 21:56:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 28 Jul 2006 23:56:16 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24403>


With this option, the changed words are shown inline. For example,
if a file containing "This is foo" is changed to "This is bar", the diff
will now show "This is " in plain text, "foo" in red, and "bar" in green.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	I am probably the only person who finds it useful, but there
	is a high coolness factor attached to it.

	And the libxdiff library actually made it very easy to do. (Yes, 
	there are two nested calls to xdiff...)

 Documentation/diff-options.txt |    3 +
 diff.c                         |  178 +++++++++++++++++++++++++++++++++++++++-
 diff.h                         |    3 -
 3 files changed, 177 insertions(+), 7 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 47ba9a4..b5d9763 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -36,6 +36,9 @@
 	Turn off colored diff, even when the configuration file
 	gives the default to color output.
 
+--color-words::
+	Show colored word diff, i.e. color words which have changed.
+
 --no-renames::
 	Turn off rename detection, even when the configuration
 	file gives the default to do so.
diff --git a/diff.c b/diff.c
index 6198a61..e910971 100644
--- a/diff.c
+++ b/diff.c
@@ -358,12 +358,152 @@ static int fill_mmfile(mmfile_t *mf, str
 	return 0;
 }
 
+struct diff_words_buffer {
+	mmfile_t text;
+	long alloc;
+	long current; /* output pointer */
+	int suppressed_newline;
+};
+
+static void diff_words_append(char *line, unsigned long len,
+		struct diff_words_buffer *buffer)
+{
+	if (buffer->text.size + len > buffer->alloc) {
+		buffer->alloc = (buffer->text.size + len) * 3 / 2;
+		buffer->text.ptr = xrealloc(buffer->text.ptr, buffer->alloc);
+	}
+	line++;
+	len--;
+	memcpy(buffer->text.ptr + buffer->text.size, line, len);
+	buffer->text.size += len;
+}
+
+struct diff_words_data {
+	struct xdiff_emit_state xm;
+	struct diff_words_buffer minus, plus;
+};
+
+static void print_word(struct diff_words_buffer *buffer, int len, int color,
+		int suppress_newline)
+{
+	const char *ptr;
+	int eol = 0;
+
+	if (len == 0)
+		return;
+
+	ptr  = buffer->text.ptr + buffer->current;
+	buffer->current += len;
+
+	if (ptr[len - 1] == '\n') {
+		eol = 1;
+		len--;
+	}
+
+	fputs(diff_get_color(1, color), stdout);
+	fwrite(ptr, len, 1, stdout);
+	fputs(diff_get_color(1, DIFF_RESET), stdout);
+
+	if (eol) {
+		if (suppress_newline)
+			buffer->suppressed_newline = 1;
+		else
+			putchar('\n');
+	}
+}
+
+static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
+{
+	struct diff_words_data *diff_words = priv;
+
+	if (diff_words->minus.suppressed_newline) {
+		if (line[0] != '+')
+			putchar('\n');
+		diff_words->minus.suppressed_newline = 0;
+	}
+
+	len--;
+	switch (line[0]) {
+		case '-':
+			print_word(&diff_words->minus, len, DIFF_FILE_OLD, 1);
+			break;
+		case '+':
+			print_word(&diff_words->plus, len, DIFF_FILE_NEW, 0);
+			break;
+		case ' ':
+			print_word(&diff_words->plus, len, DIFF_PLAIN, 0);
+			diff_words->minus.current += len;
+			break;
+	}
+}
+
+/* this executes the word diff on the accumulated buffers */
+static void diff_words_show(struct diff_words_data *diff_words)
+{
+	xpparam_t xpp;
+	xdemitconf_t xecfg;
+	xdemitcb_t ecb;
+	mmfile_t minus, plus;
+	int i;
+
+	minus.size = diff_words->minus.text.size;
+	minus.ptr = xmalloc(minus.size);
+	memcpy(minus.ptr, diff_words->minus.text.ptr, minus.size);
+	for (i = 0; i < minus.size; i++)
+		if (isspace(minus.ptr[i]))
+			minus.ptr[i] = '\n';
+	diff_words->minus.current = 0;
+
+	plus.size = diff_words->plus.text.size;
+	plus.ptr = xmalloc(plus.size);
+	memcpy(plus.ptr, diff_words->plus.text.ptr, plus.size);
+	for (i = 0; i < plus.size; i++)
+		if (isspace(plus.ptr[i]))
+			plus.ptr[i] = '\n';
+	diff_words->plus.current = 0;
+
+	xpp.flags = XDF_NEED_MINIMAL;
+	xecfg.ctxlen = diff_words->minus.alloc + diff_words->plus.alloc;
+	xecfg.flags = 0;
+	ecb.outf = xdiff_outf;
+	ecb.priv = diff_words;
+	diff_words->xm.consume = fn_out_diff_words_aux;
+	xdl_diff(&minus, &plus, &xpp, &xecfg, &ecb);
+
+	free(minus.ptr);
+	free(plus.ptr);
+	diff_words->minus.text.size = diff_words->plus.text.size = 0;
+
+	if (diff_words->minus.suppressed_newline) {
+		putchar('\n');
+		diff_words->minus.suppressed_newline = 0;
+	}
+}
+
 struct emit_callback {
 	struct xdiff_emit_state xm;
 	int nparents, color_diff;
 	const char **label_path;
+	struct diff_words_data *diff_words;
 };
 
+static void free_diff_words_data(struct emit_callback *ecbdata)
+{
+	if (ecbdata->diff_words) {
+		/* flush buffers */
+		if (ecbdata->diff_words->minus.text.size ||
+				ecbdata->diff_words->plus.text.size)
+			diff_words_show(ecbdata->diff_words);
+
+		if (ecbdata->diff_words->minus.text.ptr)
+			free (ecbdata->diff_words->minus.text.ptr);
+		if (ecbdata->diff_words->plus.text.ptr)
+			free (ecbdata->diff_words->plus.text.ptr);
+		free(ecbdata->diff_words);
+		ecbdata->diff_words = NULL;
+	}
+}
+
 const char *diff_get_color(int diff_use_color, enum color_diff ix)
 {
 	if (diff_use_color)
@@ -398,12 +538,31 @@ static void fn_out_consume(void *priv, c
 	else {
 		int nparents = ecbdata->nparents;
 		int color = DIFF_PLAIN;
-		for (i = 0; i < nparents && len; i++) {
-			if (line[i] == '-')
-				color = DIFF_FILE_OLD;
-			else if (line[i] == '+')
-				color = DIFF_FILE_NEW;
-		}
+		if (ecbdata->diff_words && nparents != 1)
+			/* fall back to normal diff */
+			free_diff_words_data(ecbdata);
+		if (ecbdata->diff_words) {
+			if (line[0] == '-') {
+				diff_words_append(line, len,
+						&ecbdata->diff_words->minus);
+				return;
+			} else if (line[0] == '+') {
+				diff_words_append(line, len,
+						&ecbdata->diff_words->plus);
+				return;
+			}
+			if (ecbdata->diff_words->minus.text.size ||
+					ecbdata->diff_words->plus.text.size)
+				diff_words_show(ecbdata->diff_words);
+			line++;
+			len--;
+		} else
+			for (i = 0; i < nparents && len; i++) {
+				if (line[i] == '-')
+					color = DIFF_FILE_OLD;
+				else if (line[i] == '+')
+					color = DIFF_FILE_NEW;
+			}
 		set = diff_get_color(ecbdata->color_diff, color);
 	}
 	if (len > 0 && line[len-1] == '\n')
@@ -836,7 +995,12 @@ static void builtin_diff(const char *nam
 		ecb.outf = xdiff_outf;
 		ecb.priv = &ecbdata;
 		ecbdata.xm.consume = fn_out_consume;
+		if (o->color_diff_words)
+			ecbdata.diff_words =
+				xcalloc(1, sizeof(struct diff_words_data));
 		xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
+		if (o->color_diff_words)
+			free_diff_words_data(&ecbdata);
 	}
 
  free_ab_and_return:
@@ -1712,6 +1876,8 @@ int diff_opt_parse(struct diff_options *
 		options->xdl_opts |= XDF_IGNORE_WHITESPACE;
 	else if (!strcmp(arg, "-b") || !strcmp(arg, "--ignore-space-change"))
 		options->xdl_opts |= XDF_IGNORE_WHITESPACE_CHANGE;
+	else if (!strcmp(arg, "--color-words"))
+		options->color_diff = options->color_diff_words = 1;
 	else if (!strcmp(arg, "--no-renames"))
 		options->detect_rename = 0;
 	else
diff --git a/diff.h b/diff.h
index 0d32830..51c163b 100644
--- a/diff.h
+++ b/diff.h
@@ -46,7 +46,8 @@ struct diff_options {
 		 full_index:1,
 		 silent_on_remove:1,
 		 find_copies_harder:1,
-		 color_diff:1;
+		 color_diff:1,
+		 color_diff_words:1;
 	int context;
 	int break_opt;
 	int detect_rename;
-- 
1.4.2.rc2.g8b063-dirty
