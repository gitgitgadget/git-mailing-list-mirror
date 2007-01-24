From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] diff --check: use colour
Date: Wed, 24 Jan 2007 15:05:48 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701241505260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Jan 24 15:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9il8-000201-Vd
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 15:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbXAXOFv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 09:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbXAXOFv
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 09:05:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:57226 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751482AbXAXOFu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 09:05:50 -0500
Received: (qmail invoked by alias); 24 Jan 2007 14:05:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 24 Jan 2007 15:05:49 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37640>


Reuse the colour handling of the regular diff.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	Is it possible that diff_get_color() _never_ returns NULL?
	Then diff.c can be further cleaned up...

 diff.c |   58 ++++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/diff.c b/diff.c
index f11a633..1b31c4f 100644
--- a/diff.c
+++ b/diff.c
@@ -405,22 +405,16 @@ static void emit_line(const char *set, const char *reset, const char *line, int
 	puts(reset);
 }
 
-static void emit_add_line(const char *reset, struct emit_callback *ecbdata, const char *line, int len)
+static void emit_line_with_ws(int nparents,
+		const char *set, const char *reset, const char *ws,
+		const char *line, int len)
 {
-	int col0 = ecbdata->nparents;
+	int col0 = nparents;
 	int last_tab_in_indent = -1;
 	int last_space_in_indent = -1;
 	int i;
 	int tail = len;
 	int need_highlight_leading_space = 0;
-	const char *ws = diff_get_color(ecbdata->color_diff, DIFF_WHITESPACE);
-	const char *set = diff_get_color(ecbdata->color_diff, DIFF_FILE_NEW);
-
-	if (!*ws) {
-		emit_line(set, reset, line, len);
-		return;
-	}
-
 	/* The line is a newly added line.  Does it have funny leading
 	 * whitespaces?  In indent, SP should never precede a TAB.
 	 */
@@ -475,6 +469,18 @@ static void emit_add_line(const char *reset, struct emit_callback *ecbdata, cons
 		emit_line(set, reset, line + i, len - i);
 }
 
+static void emit_add_line(const char *reset, struct emit_callback *ecbdata, const char *line, int len)
+{
+	const char *ws = diff_get_color(ecbdata->color_diff, DIFF_WHITESPACE);
+	const char *set = diff_get_color(ecbdata->color_diff, DIFF_FILE_NEW);
+
+	if (!*ws)
+		emit_line(set, reset, line, len);
+	else
+		emit_line_with_ws(ecbdata->nparents, set, reset, reset,
+				line, len);
+}
+
 static void fn_out_consume(void *priv, char *line, unsigned long len)
 {
 	int i;
@@ -864,30 +870,45 @@ static void show_numstat(struct diffstat_t* data, struct diff_options *options)
 struct checkdiff_t {
 	struct xdiff_emit_state xm;
 	const char *filename;
-	int lineno;
+	int lineno, color_diff;
 };
 
 static void checkdiff_consume(void *priv, char *line, unsigned long len)
 {
 	struct checkdiff_t *data = priv;
+	const char *ws = diff_get_color(data->color_diff, DIFF_WHITESPACE);
+	const char *reset = diff_get_color(data->color_diff, DIFF_RESET);
+	const char *set = diff_get_color(data->color_diff, DIFF_FILE_NEW);
 
 	if (line[0] == '+') {
-		int i, spaces = 0;
+		int i, spaces = 0, space_before_tab = 0, white_space_at_end = 0;
+		const char *message = NULL;
 
 		/* check space before tab */
 		for (i = 1; i < len && (line[i] == ' ' || line[i] == '\t'); i++)
 			if (line[i] == ' ')
 				spaces++;
 		if (line[i - 1] == '\t' && spaces)
-			printf("%s:%d: space before tab:%.*s\n",
-				data->filename, data->lineno, (int)len, line);
+			space_before_tab = 1;
 
 		/* check white space at line end */
 		if (line[len - 1] == '\n')
 			len--;
 		if (isspace(line[len - 1]))
-			printf("%s:%d: white space at end: %.*s\n",
-				data->filename, data->lineno, (int)len, line);
+			white_space_at_end = 1;
+
+		if (space_before_tab || white_space_at_end) {
+			printf("%s:%d: %s", data->filename, data->lineno, ws);
+			if (space_before_tab) {
+				printf("space before tab");
+				if (white_space_at_end)
+					putchar(',');
+			}
+			if (white_space_at_end)
+				printf("white space at end");
+			printf(":%s ", reset);
+			emit_line_with_ws(2, set, reset, ws, line, len);
+		}
 
 		data->lineno++;
 	} else if (line[0] == ' ')
@@ -1145,7 +1166,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 
 static void builtin_checkdiff(const char *name_a, const char *name_b,
 			     struct diff_filespec *one,
-			     struct diff_filespec *two)
+			     struct diff_filespec *two, struct diff_options *o)
 {
 	mmfile_t mf1, mf2;
 	struct checkdiff_t data;
@@ -1157,6 +1178,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	data.xm.consume = checkdiff_consume;
 	data.filename = name_b ? name_b : name_a;
 	data.lineno = 0;
+	data.color_diff = o->color_diff;
 
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
@@ -1766,7 +1788,7 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 	diff_fill_sha1_info(p->one);
 	diff_fill_sha1_info(p->two);
 
-	builtin_checkdiff(name, other, p->one, p->two);
+	builtin_checkdiff(name, other, p->one, p->two, o);
 }
 
 void diff_setup(struct diff_options *options)
-- 
1.5.0.rc2.g8b13f-dirty
