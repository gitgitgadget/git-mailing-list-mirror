From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] diff.c: second war on whitespace.
Date: Sat, 23 Sep 2006 00:47:39 -0700
Message-ID: <7vbqp7vxb8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Sep 23 09:47:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR2Ei-0002p9-RZ
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 09:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWIWHrl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 03:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWIWHrl
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 03:47:41 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:50169 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751040AbWIWHrk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 03:47:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923074740.GQJJ26416.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Sat, 23 Sep 2006 03:47:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Rjnh1V0101kojtg0000000
	Sat, 23 Sep 2006 03:47:42 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27566>

This adds DIFF_WHITESPACE color class (default = reverse red) to
colored diff output to let you catch common whitespace errors.

 - trailing whitespaces at the end of line
 - a space followed by a tab in the indent

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 diff.c |  172 +++++++++++++++++++++++++++++++++++++++++++++++++---------------
 diff.h |    1 
 2 files changed, 132 insertions(+), 41 deletions(-)

diff --git a/diff.c b/diff.c
index 443e248..2464238 100644
--- a/diff.c
+++ b/diff.c
@@ -20,12 +20,13 @@ static int diff_use_color_default;
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	"\033[m",	/* reset */
-	"",		/* normal */
-	"\033[1m",	/* bold */
-	"\033[36m",	/* cyan */
-	"\033[31m",	/* red */
-	"\033[32m",	/* green */
-	"\033[33m"	/* yellow */
+	"",		/* PLAIN (normal) */
+	"\033[1m",	/* METAINFO (bold) */
+	"\033[36m",	/* FRAGINFO (cyan) */
+	"\033[31m",	/* OLD (red) */
+	"\033[32m",	/* NEW (green) */
+	"\033[33m",	/* COMMIT (yellow) */
+	"\033[41m",	/* WHITESPACE (red background) */
 };
 
 static int parse_diff_color_slot(const char *var, int ofs)
@@ -42,6 +43,8 @@ static int parse_diff_color_slot(const c
 		return DIFF_FILE_NEW;
 	if (!strcasecmp(var+ofs, "commit"))
 		return DIFF_COMMIT;
+	if (!strcasecmp(var+ofs, "whitespace"))
+		return DIFF_WHITESPACE;
 	die("bad config variable '%s'", var);
 }
 
@@ -383,9 +386,89 @@ const char *diff_get_color(int diff_use_
 	return "";
 }
 
+static void emit_line(const char *set, const char *reset, const char *line, int len)
+{
+	if (len > 0 && line[len-1] == '\n')
+		len--;
+	fputs(set, stdout);
+	fwrite(line, len, 1, stdout);
+	puts(reset);
+}
+
+static void emit_add_line(const char *reset, struct emit_callback *ecbdata, const char *line, int len)
+{
+	int col0 = ecbdata->nparents;
+	int last_tab_in_indent = -1;
+	int last_space_in_indent = -1;
+	int i;
+	int tail = len;
+	int need_highlight_leading_space = 0;
+	const char *ws = diff_get_color(ecbdata->color_diff, DIFF_WHITESPACE);
+	const char *set = diff_get_color(ecbdata->color_diff, DIFF_FILE_NEW);
+
+	if (!*ws) {
+		emit_line(set, reset, line, len);
+		return;
+	}
+
+	/* The line is a newly added line.  Does it have funny leading
+	 * whitespaces?  In indent, SP should never precede a TAB.
+	 */
+	for (i = col0; i < len; i++) {
+		if (line[i] == '\t') {
+			last_tab_in_indent = i;
+			if (0 <= last_space_in_indent)
+				need_highlight_leading_space = 1;
+		}
+		else if (line[i] == ' ')
+			last_space_in_indent = i;
+		else
+			break;
+	}
+	fputs(set, stdout);
+	fwrite(line, col0, 1, stdout);
+	fputs(reset, stdout);
+	if (((i == len) || line[i] == '\n') && i != col0) {
+		/* The whole line was indent */
+		emit_line(ws, reset, line + col0, len - col0);
+		return;
+	}
+	i = col0;
+	if (need_highlight_leading_space) {
+		while (i < last_tab_in_indent) {
+			if (line[i] == ' ') {
+				fputs(ws, stdout);
+				putchar(' ');
+				fputs(reset, stdout);
+			}
+			else
+				putchar(line[i]);
+			i++;
+		}
+	}
+	tail = len - 1;
+	if (line[tail] == '\n' && i < tail)
+		tail--;
+	while (i < tail) {
+		if (!isspace(line[tail]))
+			break;
+		tail--;
+	}
+	if ((i < tail && line[tail + 1] != '\n')) {
+		/* This has whitespace between tail+1..len */
+		fputs(set, stdout);
+		fwrite(line + i, tail - i + 1, 1, stdout);
+		fputs(reset, stdout);
+		emit_line(ws, reset, line + tail + 1, len - tail - 1);
+	}
+	else
+		emit_line(set, reset, line + i, len - i);
+}
+
 static void fn_out_consume(void *priv, char *line, unsigned long len)
 {
 	int i;
+	int color;
 	struct emit_callback *ecbdata = priv;
 	const char *set = diff_get_color(ecbdata->color_diff, DIFF_METAINFO);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
@@ -403,45 +486,52 @@ static void fn_out_consume(void *priv, c
 		;
 	if (2 <= i && i < len && line[i] == ' ') {
 		ecbdata->nparents = i - 1;
-		set = diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO);
+		emit_line(diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO),
+			  reset, line, len);
+		return;
 	}
-	else if (len < ecbdata->nparents)
+
+	if (len < ecbdata->nparents) {
 		set = reset;
-	else {
-		int nparents = ecbdata->nparents;
-		int color = DIFF_PLAIN;
-		if (ecbdata->diff_words && nparents != 1)
-			/* fall back to normal diff */
-			free_diff_words_data(ecbdata);
-		if (ecbdata->diff_words) {
-			if (line[0] == '-') {
-				diff_words_append(line, len,
-						&ecbdata->diff_words->minus);
-				return;
-			} else if (line[0] == '+') {
-				diff_words_append(line, len,
-						&ecbdata->diff_words->plus);
-				return;
-			}
-			if (ecbdata->diff_words->minus.text.size ||
-					ecbdata->diff_words->plus.text.size)
-				diff_words_show(ecbdata->diff_words);
-			line++;
-			len--;
-		} else
-			for (i = 0; i < nparents && len; i++) {
-				if (line[i] == '-')
-					color = DIFF_FILE_OLD;
-				else if (line[i] == '+')
-					color = DIFF_FILE_NEW;
-			}
-		set = diff_get_color(ecbdata->color_diff, color);
+		emit_line(reset, reset, line, len);
+		return;
 	}
-	if (len > 0 && line[len-1] == '\n')
+
+	color = DIFF_PLAIN;
+	if (ecbdata->diff_words && ecbdata->nparents != 1)
+		/* fall back to normal diff */
+		free_diff_words_data(ecbdata);
+	if (ecbdata->diff_words) {
+		if (line[0] == '-') {
+			diff_words_append(line, len,
+					  &ecbdata->diff_words->minus);
+			return;
+		} else if (line[0] == '+') {
+			diff_words_append(line, len,
+					  &ecbdata->diff_words->plus);
+			return;
+		}
+		if (ecbdata->diff_words->minus.text.size ||
+		    ecbdata->diff_words->plus.text.size)
+			diff_words_show(ecbdata->diff_words);
+		line++;
 		len--;
-	fputs (set, stdout);
-	fwrite (line, len, 1, stdout);
-	puts (reset);
+		emit_line(set, reset, line, len);
+		return;
+	}
+	for (i = 0; i < ecbdata->nparents && len; i++) {
+		if (line[i] == '-')
+			color = DIFF_FILE_OLD;
+		else if (line[i] == '+')
+			color = DIFF_FILE_NEW;
+	}
+
+	if (color != DIFF_FILE_NEW) {
+		emit_line(diff_get_color(ecbdata->color_diff, color),
+			  reset, line, len);
+		return;
+	}
+	emit_add_line(reset, ecbdata, line, len);
 }
 
 static char *pprint_rename(const char *a, const char *b)
diff --git a/diff.h b/diff.h
index b60a02e..3435fe7 100644
--- a/diff.h
+++ b/diff.h
@@ -86,6 +86,7 @@ enum color_diff {
 	DIFF_FILE_OLD = 4,
 	DIFF_FILE_NEW = 5,
 	DIFF_COMMIT = 6,
+	DIFF_WHITESPACE = 7,
 };
 const char *diff_get_color(int diff_use_color, enum color_diff ix);
 
-- 
1.4.2.1.gf2bba
