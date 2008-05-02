From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH] Make words boundary for --color-words configurable
Date: Fri,  2 May 2008 11:39:24 +0800
Message-ID: <1209699564-2800-1-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 05:40:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrm8Y-00057q-IL
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 05:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbYEBDjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 23:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754644AbYEBDjo
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 23:39:44 -0400
Received: from mail.qikoo.org ([60.28.205.235]:34878 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753062AbYEBDjn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 23:39:43 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id C3E88470AE; Fri,  2 May 2008 11:39:24 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.116.ge4b9c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80954>

Previously --color-words only allow spaces as words boundary. However,
just space is not enough. For example, when i rename a function from
foo to bar, following example doesn't show as expected when using
--color-words.

------------------
- if (foo(arg))
+ if (bar(arg))
------------------

It shows as "if <r>(foo(arg))</r><g>(foo(arg))</g>". Actually, it's the
best to show as "if (<r>foo</r><g>bar</g>(arg))". Here "r" and "g"
represent "red" and "green" separately.

This patch introduces a configuration diff.wordsboundary to make
--color-words treat both spaces and characters in diff.wordsboundary as
boundary characters.

If we set diff.wordsboundary to "()", the example above will show as
"if (<r>foo(</r><g>bar(</g>arg))". It's much better, athough not the best,

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 diff.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 3632b55..2c37bb6 100644
--- a/diff.c
+++ b/diff.c
@@ -23,6 +23,7 @@ static int diff_rename_limit_default = 100;
 int diff_use_color_default = -1;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
+static const char *diff_words_boundary = "";
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	"\033[m",	/* reset */
@@ -159,6 +160,10 @@ int git_diff_ui_config(const char *var, const char *value)
 		external_diff_cmd_cfg = xstrdup(value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.wordsboundary")) {
+		diff_words_boundary = value ? xstrdup(value) : "";
+		return 0;
+	}
 	if (!prefixcmp(var, "diff.")) {
 		const char *ep = strrchr(var, '.');
 
@@ -434,6 +439,11 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	}
 }
 
+static int iswordsboundary(char c)
+{
+	return isspace(c) || !!strchr(diff_words_boundary, c);
+}
+
 /* this executes the word diff on the accumulated buffers */
 static void diff_words_show(struct diff_words_data *diff_words)
 {
@@ -448,7 +458,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	minus.ptr = xmalloc(minus.size);
 	memcpy(minus.ptr, diff_words->minus.text.ptr, minus.size);
 	for (i = 0; i < minus.size; i++)
-		if (isspace(minus.ptr[i]))
+		if (iswordsboundary(minus.ptr[i]))
 			minus.ptr[i] = '\n';
 	diff_words->minus.current = 0;
 
@@ -456,7 +466,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	plus.ptr = xmalloc(plus.size);
 	memcpy(plus.ptr, diff_words->plus.text.ptr, plus.size);
 	for (i = 0; i < plus.size; i++)
-		if (isspace(plus.ptr[i]))
+		if (iswordsboundary(plus.ptr[i]))
 			plus.ptr[i] = '\n';
 	diff_words->plus.current = 0;
 
-- 
1.5.5.1.116.ge4b9c.dirty
