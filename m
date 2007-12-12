From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 2/4] Extract and improve whitespace check from "git apply"
Date: Wed, 12 Dec 2007 17:23:00 +0100
Message-ID: <1197476582-18956-3-git-send-email-win@wincent.com>
References: <1197476582-18956-1-git-send-email-win@wincent.com>
 <1197476582-18956-2-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 17:23:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2UNE-0002Qk-Ie
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 17:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149AbXLLQXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 11:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754937AbXLLQXb
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 11:23:31 -0500
Received: from wincent.com ([72.3.236.74]:44669 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753071AbXLLQXa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 11:23:30 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBCGN3CI026521;
	Wed, 12 Dec 2007 10:23:07 -0600
X-Mailer: git-send-email 1.5.3.7.1159.g2f071-dirty
In-Reply-To: <1197476582-18956-2-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68065>

This refactoring extracts the whitespace checking formerly done in
builtin-apply.c into a function in ws.c so that the exact same
whitespace logic can be used by "git diff" as well, thus reducing
code duplication and the likelihood of errors.

At the same time we teach "git apply" to report all classes of
whitespace errors found in a given line rather than reporting only
the first found error.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 builtin-apply.c |   60 +++++++++++-------------------------------------------
 cache.h         |    2 +
 ws.c            |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 47 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index f2e9a33..cf349db 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -898,58 +898,24 @@ static int find_header(char *line, unsigned long size, int *hdrsize, struct patc
 	return -1;
 }
 
-static void check_whitespace(const char *line, int len, unsigned ws_rule)
+static void check_patch_whitespace(const char *line, int len,
+                                   unsigned ws_rule)
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
+	unsigned result = check_whitespace(line, len, ws_rule);
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
@@ -1001,7 +967,7 @@ static int parse_fragment(char *line, unsigned long size,
 		case '-':
 			if (apply_in_reverse &&
 			    ws_error_action != nowarn_ws_error)
-				check_whitespace(line, len, patch->ws_rule);
+				check_patch_whitespace(line, len, patch->ws_rule);
 			deleted++;
 			oldlines--;
 			trailing = 0;
@@ -1009,7 +975,7 @@ static int parse_fragment(char *line, unsigned long size,
 		case '+':
 			if (!apply_in_reverse &&
 			    ws_error_action != nowarn_ws_error)
-				check_whitespace(line, len, patch->ws_rule);
+				check_patch_whitespace(line, len, patch->ws_rule);
 			added++;
 			newlines--;
 			trailing = 0;
diff --git a/cache.h b/cache.h
index 1bcb3df..6c17f27 100644
--- a/cache.h
+++ b/cache.h
@@ -655,6 +655,8 @@ void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, i
 extern unsigned whitespace_rule_cfg;
 extern unsigned whitespace_rule(const char *);
 extern unsigned parse_whitespace_rule(const char *);
+extern unsigned check_whitespace(const char *line, int len, unsigned ws_rule);
+extern char *whitespace_error_string(unsigned ws);
 
 /* ls-files */
 int pathspec_match(const char **spec, char *matched, const char *filename, int skiplen);
diff --git a/ws.c b/ws.c
index 52c10ca..884d373 100644
--- a/ws.c
+++ b/ws.c
@@ -94,3 +94,61 @@ unsigned whitespace_rule(const char *pathname)
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
+unsigned check_whitespace(const char *line, int len, unsigned ws_rule)
+{
+	unsigned result = 0;
+	int seen_space = 0;
+	int i;
+
+	if (ws_rule & WS_TRAILING_SPACE) {
+		/* Lines start with "+" or "-" so length is at least 1 */
+		if (line[len - 1] == '\n') {
+			if (isspace(line[len - 2]))
+				result |= WS_TRAILING_SPACE;
+		}
+		else if (isspace(line[len - 1]))
+			result |= WS_TRAILING_SPACE;
+	}
+
+	if (ws_rule & WS_SPACE_BEFORE_TAB) {
+		for (i = 1; i < len; i++) {
+			if (line[i] == '\t') {
+				if (seen_space) {
+					result |= WS_SPACE_BEFORE_TAB;
+					break;
+				}
+			}
+			else if (line[i] == ' ')
+				seen_space = 1;
+			else
+				break;
+		}
+	}
+
+	if ((ws_rule & WS_INDENT_WITH_NON_TAB) &&
+	    (8 < len) && !strncmp("+        ", line, 9)) {
+		result |= WS_INDENT_WITH_NON_TAB;
+	}
+	return result;
+}
-- 
1.5.3.7.1159.g2f071-dirty
