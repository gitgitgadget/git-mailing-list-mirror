From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 3/5] Unify whitespace checking
Date: Thu, 13 Dec 2007 14:32:29 +0100
Message-ID: <1197552751-53480-4-git-send-email-win@wincent.com>
References: <1197552751-53480-1-git-send-email-win@wincent.com>
 <1197552751-53480-2-git-send-email-win@wincent.com>
 <1197552751-53480-3-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 14:33:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2oCA-0003vl-E3
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 14:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbXLMNdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 08:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753136AbXLMNdP
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 08:33:15 -0500
Received: from wincent.com ([72.3.236.74]:47243 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918AbXLMNdO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 08:33:14 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBDDWZ4a019847;
	Thu, 13 Dec 2007 07:32:40 -0600
X-Mailer: git-send-email 1.5.4.rc0.4.g50348
In-Reply-To: <1197552751-53480-3-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68147>

This commit unifies three separate places where whitespace checking was
performed:

 - the whitespace checking previously done in builtin-apply.c is
extracted into a function in ws.c

 - the equivalent logic in "git diff" is removed

 - the emit_line_with_ws() function is also removed because that also
rechecks the shitespace, and its functionality is rolled into ws.c

The new function is called check_and_emit_line() and it does two things:
checks a line for whitespace errors and optionally emits it. The checking
is based on lines of content rather than patch lines (in other words, the
caller must strip the leading "+" or "-"); this was suggested by Junio on
the mailing list to allow for a future extension to "git show" to display
whitespace errors in blobs.

At the same time we teach it to report all classes of whitespace errors
found for a given line rather than reporting only the first found error.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 builtin-apply.c            |   54 +++--------------
 cache.h                    |    4 +
 diff.c                     |  138 ++++++--------------------------------------
 t/t4015-diff-whitespace.sh |    2 +-
 ws.c                       |  105 +++++++++++++++++++++++++++++++++
 5 files changed, 139 insertions(+), 164 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index f2e9a33..ab393f3 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -900,56 +900,22 @@ static int find_header(char *line, unsigned long size, int *hdrsize, struct patc
 
 static void check_whitespace(const char *line, int len, unsigned ws_rule)
 {
-	const char *err = "Adds trailing whitespace";
-	int seen_space = 0;
-	int i;
-
-	/*
-	 * We know len is at least two, since we have a '+' and we
-	 * checked that the last character was a '\n' before calling
-	 * this function.  That is, an addition of an empty line would
-	 * check the '+' here.  Sneaky...
-	 */
-	if ((ws_rule & WS_TRAILING_SPACE) && isspace(line[len-2]))
-		goto error;
-
-	/*
-	 * Make sure that there is no space followed by a tab in
-	 * indentation.
-	 */
-	if (ws_rule & WS_SPACE_BEFORE_TAB) {
-		err = "Space in indent is followed by a tab";
-		for (i = 1; i < len; i++) {
-			if (line[i] == '\t') {
-				if (seen_space)
-					goto error;
-			}
-			else if (line[i] == ' ')
-				seen_space = 1;
-			else
-				break;
-		}
-	}
-
-	/*
-	 * Make sure that the indentation does not contain more than
-	 * 8 spaces.
-	 */
-	if ((ws_rule & WS_INDENT_WITH_NON_TAB) &&
-	    (8 < len) && !strncmp("+        ", line, 9)) {
-		err = "Indent more than 8 places with spaces";
-		goto error;
-	}
-	return;
+	char *err;
+	unsigned result = check_and_emit_line(line + 1, len - 1, ws_rule,
+	    NULL, NULL, NULL, NULL);
+	if (!result)
+		return;
 
- error:
 	whitespace_error++;
 	if (squelch_whitespace_errors &&
 	    squelch_whitespace_errors < whitespace_error)
 		;
-	else
+	else {
+		err = whitespace_error_string(result);
 		fprintf(stderr, "%s.\n%s:%d:%.*s\n",
-			err, patch_input_file, linenr, len-2, line+1);
+		     err, patch_input_file, linenr, len - 2, line + 1);
+		free(err);
+	}
 }
 
 /*
diff --git a/cache.h b/cache.h
index 27d90fe..39331c2 100644
--- a/cache.h
+++ b/cache.h
@@ -655,6 +655,10 @@ void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, i
 extern unsigned whitespace_rule_cfg;
 extern unsigned whitespace_rule(const char *);
 extern unsigned parse_whitespace_rule(const char *);
+extern unsigned check_and_emit_line(const char *line, int len, unsigned ws_rule,
+    FILE *stream, const char *set,
+    const char *reset, const char *ws);
+extern char *whitespace_error_string(unsigned ws);
 
 /* ls-files */
 int pathspec_match(const char **spec, char *matched, const char *filename, int skiplen);
diff --git a/diff.c b/diff.c
index 39109a6..d96a4ac 100644
--- a/diff.c
+++ b/diff.c
@@ -486,88 +486,9 @@ const char *diff_get_color(int diff_use_color, enum color_diff ix)
 
 static void emit_line(const char *set, const char *reset, const char *line, int len)
 {
-	if (len > 0 && line[len-1] == '\n')
-		len--;
 	fputs(set, stdout);
 	fwrite(line, len, 1, stdout);
-	puts(reset);
-}
-
-static void emit_line_with_ws(int nparents,
-			      const char *set, const char *reset, const char *ws,
-			      const char *line, int len, unsigned ws_rule)
-{
-	int col0 = nparents;
-	int last_tab_in_indent = -1;
-	int last_space_in_indent = -1;
-	int i;
-	int tail = len;
-	int need_highlight_leading_space = 0;
-	/*
-	 * The line is a newly added line.  Does it have funny leading
-	 * whitespaces?  In indent, SP should never precede a TAB.  In
-	 * addition, under "indent with non tab" rule, there should not
-	 * be more than 8 consecutive spaces.
-	 */
-	for (i = col0; i < len; i++) {
-		if (line[i] == '\t') {
-			last_tab_in_indent = i;
-			if ((ws_rule & WS_SPACE_BEFORE_TAB) &&
-			    0 <= last_space_in_indent)
-				need_highlight_leading_space = 1;
-		}
-		else if (line[i] == ' ')
-			last_space_in_indent = i;
-		else
-			break;
-	}
-	if ((ws_rule & WS_INDENT_WITH_NON_TAB) &&
-	    0 <= last_space_in_indent &&
-	    last_tab_in_indent < 0 &&
-	    8 <= (i - col0)) {
-		last_tab_in_indent = i;
-		need_highlight_leading_space = 1;
-	}
-	fputs(set, stdout);
-	fwrite(line, col0, 1, stdout);
 	fputs(reset, stdout);
-	if (((i == len) || line[i] == '\n') && i != col0) {
-		/* The whole line was indent */
-		emit_line(ws, reset, line + col0, len - col0);
-		return;
-	}
-	i = col0;
-	if (need_highlight_leading_space) {
-		while (i < last_tab_in_indent) {
-			if (line[i] == ' ') {
-				fputs(ws, stdout);
-				putchar(' ');
-				fputs(reset, stdout);
-			}
-			else
-				putchar(line[i]);
-			i++;
-		}
-	}
-	tail = len - 1;
-	if (line[tail] == '\n' && i < tail)
-		tail--;
-	if (ws_rule & WS_TRAILING_SPACE) {
-		while (i < tail) {
-			if (!isspace(line[tail]))
-				break;
-			tail--;
-		}
-	}
-	if ((i < tail && line[tail + 1] != '\n')) {
-		/* This has whitespace between tail+1..len */
-		fputs(set, stdout);
-		fwrite(line + i, tail - i + 1, 1, stdout);
-		fputs(reset, stdout);
-		emit_line(ws, reset, line + tail + 1, len - tail - 1);
-	}
-	else
-		emit_line(set, reset, line + i, len - i);
 }
 
 static void emit_add_line(const char *reset, struct emit_callback *ecbdata, const char *line, int len)
@@ -577,9 +498,13 @@ static void emit_add_line(const char *reset, struct emit_callback *ecbdata, cons
 
 	if (!*ws)
 		emit_line(set, reset, line, len);
-	else
-		emit_line_with_ws(ecbdata->nparents, set, reset, ws,
-				  line, len, ecbdata->ws_rule);
+	else {
+		/* Emit just the prefix, then the rest. */
+		emit_line(set, reset, line, ecbdata->nparents);
+		(void)check_and_emit_line(line + ecbdata->nparents,
+		    len - ecbdata->nparents, ecbdata->ws_rule,
+		    stdout, set, reset, ws);
+	}
 }
 
 static void fn_out_consume(void *priv, char *line, unsigned long len)
@@ -1040,45 +965,20 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 	const char *ws = diff_get_color(data->color_diff, DIFF_WHITESPACE);
 	const char *reset = diff_get_color(data->color_diff, DIFF_RESET);
 	const char *set = diff_get_color(data->color_diff, DIFF_FILE_NEW);
+	char *err;
 
 	if (line[0] == '+') {
-		int i, spaces = 0, space_before_tab = 0, white_space_at_end = 0;
-
-		/* check space before tab */
-		for (i = 1; i < len; i++) {
-			if (line[i] == ' ')
-				spaces++;
-			else if (line[i] == '\t') {
-				if (spaces) {
-					space_before_tab = 1;
-					break;
-				}
-			}
-			else
-				break;
-		}
-
-		/* check whitespace at line end */
-		if (line[len - 1] == '\n')
-			len--;
-		if (isspace(line[len - 1]))
-			white_space_at_end = 1;
-
-		if (space_before_tab || white_space_at_end) {
-			data->status = 1;
-			printf("%s:%d: %s", data->filename, data->lineno, ws);
-			if (space_before_tab) {
-				printf("space before tab");
-				if (white_space_at_end)
-					putchar(',');
-			}
-			if (white_space_at_end)
-				printf("whitespace at end");
-			printf(":%s ", reset);
-			emit_line_with_ws(1, set, reset, ws, line, len,
-					  data->ws_rule);
-		}
-
+		data->status = check_and_emit_line(line + 1, len - 1,
+		    data->ws_rule, NULL, NULL, NULL, NULL);
+		if (!data->status)
+			return;
+		err = whitespace_error_string(data->status);
+		printf("%s:%d: %s%s:%s ", data->filename, data->lineno,
+		    ws, err, reset);
+		free(err);
+		emit_line(set, reset, line, 1);
+		(void)check_and_emit_line(line + 1, len - 1, data->ws_rule,
+		    stdout, set, reset, ws);
 		data->lineno++;
 	} else if (line[0] == ' ')
 		data->lineno++;
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index dc538b3..a0a47dd 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -121,7 +121,7 @@ test_expect_success 'check mixed spaces and tabs in indent' '
 
 	# This is indented with SP HT SP.
 	echo " 	 foo();" > x &&
-	git diff --check | grep "space before tab"
+	git diff --check | grep "Space in indent is followed by a tab"
 
 '
 
diff --git a/ws.c b/ws.c
index 52c10ca..a0ce860 100644
--- a/ws.c
+++ b/ws.c
@@ -94,3 +94,108 @@ unsigned whitespace_rule(const char *pathname)
 		return whitespace_rule_cfg;
 	}
 }
+
+/* The returned string should be freed by the caller. */
+char *whitespace_error_string(unsigned ws)
+{
+	struct strbuf err;
+	strbuf_init(&err, 0);
+	if (ws & WS_TRAILING_SPACE)
+		strbuf_addstr(&err, "Adds trailing whitespace");
+	if (ws & WS_SPACE_BEFORE_TAB) {
+		if (err.len)
+			strbuf_addstr(&err, ", ");
+		strbuf_addstr(&err, "Space in indent is followed by a tab");
+	}
+	if (ws & WS_INDENT_WITH_NON_TAB) {
+		if (err.len)
+			strbuf_addstr(&err, ", ");
+		strbuf_addstr(&err, "Indent more than 8 places with spaces");
+	}
+	return strbuf_detach(&err, NULL);
+}
+
+/* If stream is non-NULL, emits the line after checking. */
+unsigned check_and_emit_line(const char *line, int len, unsigned ws_rule,
+                             FILE *stream, const char *set,
+                             const char *reset, const char *ws)
+{
+	unsigned result = 0;
+	int leading_space = -1;
+	int trailing_whitespace = -1;
+	int trailing_newline = 0;
+	int i;
+
+	/* Logic is simpler if we temporarily ignore the trailing newline. */
+	if (len > 0 && line[len - 1] == '\n') {
+		trailing_newline = 1;
+		len--;
+	}
+
+	/* Check for trailing whitespace. */
+	if (ws_rule & WS_TRAILING_SPACE) {
+		for (i = len - 1; i >= 0; i--) {
+			if (isspace(line[i])) {
+				trailing_whitespace = i;
+				result |= WS_TRAILING_SPACE;
+			}
+			else
+				break;
+		}
+	}
+
+	/* Check for space before tab in initial indent. */
+	for (i = 0; i < len; i++) {
+		if (line[i] == '\t') {
+			if ((ws_rule & WS_SPACE_BEFORE_TAB) &&
+			    (leading_space != -1))
+				result |= WS_SPACE_BEFORE_TAB;
+			break;
+		}
+		else if (line[i] == ' ')
+			leading_space = i;
+		else
+			break;
+	}
+
+	/* Check for indent using non-tab. */
+	if ((ws_rule & WS_INDENT_WITH_NON_TAB) && leading_space >= 8)
+		result |= WS_INDENT_WITH_NON_TAB;
+
+	if (stream) {
+		/* Highlight errors in leading whitespace. */
+		if ((result & WS_SPACE_BEFORE_TAB) ||
+		    (result & WS_INDENT_WITH_NON_TAB)) {
+			fputs(ws, stream);
+			fwrite(line, leading_space + 1, 1, stream);
+			fputs(reset, stream);
+			leading_space++;
+		}
+		else
+			leading_space = 0;
+
+		/* Now the rest of the line starts at leading_space.
+		 * The non-highlighted part ends at trailing_whitespace. */
+		if (trailing_whitespace == -1)
+			trailing_whitespace = len;
+
+		/* Emit non-highlighted (middle) segment. */
+		if (trailing_whitespace - leading_space > 0) {
+			fputs(set, stream);
+			fwrite(line + leading_space,
+			    trailing_whitespace - leading_space, 1, stream);
+			fputs(reset, stream);
+		}
+
+		/* Highlight errors in trailing whitespace. */
+		if (trailing_whitespace != len) {
+			fputs(ws, stream);
+			fwrite(line + trailing_whitespace,
+			    len - trailing_whitespace, 1, stream);
+			fputs(reset, stream);
+		}
+		if (trailing_newline)
+			fputc('\n', stream);
+	}
+	return result;
+}
-- 
1.5.4.rc0.4.g50348
