From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v3 0/6] --color-words improvement
Date: Sun,  4 May 2008 12:20:09 +0800
Message-ID: <1209874815-14411-1-git-send-email-pkufranky@gmail.com>
References: <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 06:21:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsVjH-00053b-Pv
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 06:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbYEDEU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 00:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbYEDEU0
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 00:20:26 -0400
Received: from mail.qikoo.org ([60.28.205.235]:54655 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750940AbYEDEUT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 00:20:19 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 53001470AE; Sun,  4 May 2008 12:20:15 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.121.g26b3
In-Reply-To: <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81132>

Ping Yin (6):
      diff.c: Remove code redundancy in diff_words_show
      fn_out_diff_words_aux: Use short variable name
      --color-words: Fix showing trailing deleted words at another line
      --color-words: Make non-word characters configurable
      fn_out_diff_words_aux: Handle common diff line more carefully
      --color-words: Add test t4030

Related to last series
 
 - add a test patch (the last one)
 - refine commit message
 - use more meaningful varaible name (dm -> dwb_minus etc.)
 - refine some words (boundary -> non-word etc.)
 - some compiling warning given by junio (add void, remove int i)

The diff between previous patch series and current series
except the last patch

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 60dd5e6..70acc14 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -95,7 +95,7 @@ endif::git-format-patch[]
 
 --color-words::
 	Show colored word diff, i.e. color words which have changed.
-	The boundary characters can be configured with diff.nonwordchars.
+	The non-word characters can be configured with diff.nonwordchars.
 
 --no-renames::
 	Turn off rename detection, even when the configuration
diff --git a/diff.c b/diff.c
index 72fe804..08048e4 100644
--- a/diff.c
+++ b/diff.c
@@ -414,43 +414,43 @@ static void print_word(FILE *file, struct diff_words_buffer *buffer, int len, in
 static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 {
 	struct diff_words_data *diff_words;
-	char cm, cp;
-	struct diff_words_buffer *dm, *dp;
-	FILE *df;
+	char lastchar_minus, lastchar_plus;
+	struct diff_words_buffer *dwb_minus, *dwb_plus;
+	FILE *outfile;
 
 	diff_words = priv;
-	dm = &(diff_words->minus);
-	dp = &(diff_words->plus);
-	df = diff_words->file;
+	dwb_minus = &(diff_words->minus);
+	dwb_plus = &(diff_words->plus);
+	outfile = diff_words->file;
 
-	if ((dm->suppressed_newline && line[0] != '+') ||
-			(dp->suppressed_newline && line[0] != '-')) {
-		putc('\n', df);
-		dm->suppressed_newline = 0;
-		dp->suppressed_newline = 0;
+	if ((dwb_minus->suppressed_newline && line[0] != '+') ||
+			(dwb_plus->suppressed_newline && line[0] != '-')) {
+		putc('\n', outfile);
+		dwb_minus->suppressed_newline = 0;
+		dwb_plus->suppressed_newline = 0;
 	}
 
 	len--;
 	switch (line[0]) {
 		case '-':
-			print_word(df, dm, len, DIFF_FILE_OLD, 1);
+			print_word(outfile, dwb_minus, len, DIFF_FILE_OLD, 1);
 			break;
 		case '+':
-			print_word(df, dp, len, DIFF_FILE_NEW, 1);
+			print_word(outfile, dwb_plus, len, DIFF_FILE_NEW, 1);
 			break;
 		case ' ':
-			cm = dm->text.ptr[dm->current + len - 1];
-			cp = dp->text.ptr[dp->current + len - 1];
-			if (cm == cp) {
-				print_word(df, dp, len, DIFF_PLAIN, 1);
-				dm->current += len;
+			lastchar_minus = dwb_minus->text.ptr[dwb_minus->current + len - 1];
+			lastchar_plus = dwb_plus->text.ptr[dwb_plus->current + len - 1];
+			if (lastchar_minus == lastchar_plus) {
+				print_word(outfile, dwb_plus, len, DIFF_PLAIN, 1);
+				dwb_minus->current += len;
 			}
 			else {
 				len--;
-				print_word(df, dp, len, DIFF_PLAIN, 1);
-				dm->current += len;
-				print_word(df, dm, 1, DIFF_FILE_OLD, 1);
-				print_word(df, dp, 1, DIFF_FILE_NEW, 1);
+				print_word(outfile, dwb_plus, len, DIFF_PLAIN, 1);
+				dwb_minus->current += len;
+				print_word(outfile, dwb_minus, 1, DIFF_FILE_OLD, 1);
+				print_word(outfile, dwb_plus, 1, DIFF_FILE_NEW, 1);
 			}
 			break;
 	}
@@ -461,7 +461,7 @@ static int is_non_word_char(char c)
 	return isspace(c) || !!strchr(diff_non_word_chars, c);
 }
 
-static mmfile_copy_set_boundary(mmfile_t *dest, mmfile_t *src) {
+static void mmfile_copy_set_boundary(mmfile_t *dest, mmfile_t *src) {
 	int i;
 
 	dest->size = src->size;
@@ -479,7 +479,6 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	xdemitconf_t xecfg;
 	xdemitcb_t ecb;
 	mmfile_t minus, plus;
-	int i;
 
 	memset(&xecfg, 0, sizeof(xecfg));
 	mmfile_copy_set_boundary(&minus, &(diff_words->minus.text));


 Documentation/config.txt       |    4 ++
 Documentation/diff-options.txt |    1 +
 diff.c                         |   84 ++++++++++++++++++++++++++-------------
 t/t4030-diff-color-words.sh    |   42 ++++++++++++++++++++
 t/t4030/expect1                |    1 +
 t/t4030/expect10               |    1 +
 t/t4030/expect2                |    1 +
 t/t4030/expect3                |    1 +
 t/t4030/expect4                |    1 +
 t/t4030/expect5                |    1 +
 t/t4030/expect6                |    1 +
 t/t4030/expect7                |    1 +
 t/t4030/expect8                |    1 +
 t/t4030/expect9                |    1 +
 t/t4030/gen-expect.sh          |   35 ++++++++++++++++
 15 files changed, 148 insertions(+), 28 deletions(-)
