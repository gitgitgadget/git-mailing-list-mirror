From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v3 3/6] --color-words: Fix showing trailing deleted words at another line
Date: Sun,  4 May 2008 12:20:12 +0800
Message-ID: <1209874815-14411-4-git-send-email-pkufranky@gmail.com>
References: <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-1-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-2-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-3-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 06:21:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsVio-0004qs-95
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 06:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbYEDEUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 00:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbYEDEUU
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 00:20:20 -0400
Received: from mail.qikoo.org ([60.28.205.235]:54654 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750802AbYEDEUT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 00:20:19 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id ECE88470B0; Sun,  4 May 2008 12:20:15 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.121.g26b3
In-Reply-To: <1209874815-14411-3-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81130>

With --color-words, following example will show deleted word "bar" at
another line. (<r> represents red)

  $ git diff
  - foo bar
  + foo
  $ git diff --color-words
  foo
  <r>bar</r>

This is caused by the unsymmetrical handling of LF in the plus and minus
buffer in fn_out_diff_words_aux.

Assume "trailing minus (or plus) word" represents the last word
(with real LF following it) in a line of the minus (or plus) buffer.

Following is original unsymmetrical handling rules where LF represents
a LF will be shown there.

  - trailing minus word, [plus word, ...], LF, non plus word
  - trailing plus word, LF, any word

The second rule causes any word following the trailing plus word will
be shown in a different line.

This patch tries to implement the symmetrical handling rules:

  - trailing minus word, [plus word, ...], LF, non plus word
  - trailing plus word, [minus word, ...], LF, non minus word

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 diff.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 05f7c35..c7a0d77 100644
--- a/diff.c
+++ b/diff.c
@@ -409,6 +409,7 @@ static void print_word(FILE *file, struct diff_words_buffer *buffer, int len, in
 static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 {
 	struct diff_words_data *diff_words;
+	char lastchar_minus;
 	struct diff_words_buffer *dwb_minus, *dwb_plus;
 	FILE *outfile;
 
@@ -417,10 +418,11 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	dwb_plus = &(diff_words->plus);
 	outfile = diff_words->file;
 
-	if (dwp_minus->suppressed_newline) {
-		if (line[0] != '+')
-			putc('\n', outfile);
-		dwp_minus->suppressed_newline = 0;
+	if ((dwb_minus->suppressed_newline && line[0] != '+') ||
+			(dwb_plus->suppressed_newline && line[0] != '-')) {
+		putc('\n', outfile);
+		dwb_minus->suppressed_newline = 0;
+		dwb_plus->suppressed_newline = 0;
 	}
 
 	len--;
@@ -429,11 +431,14 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 			print_word(outfile, dwb_minus, len, DIFF_FILE_OLD, 1);
 			break;
 		case '+':
-			print_word(outfile, dwb_plus, len, DIFF_FILE_NEW, 0);
+			print_word(outfile, dwb_plus, len, DIFF_FILE_NEW, 1);
 			break;
 		case ' ':
-			print_word(outfile, dwb_plus, len, DIFF_PLAIN, 0);
+			lastchar_minus = dwb_minus->text.ptr[dwb_minus->current + len - 1];
+			print_word(outfile, dwb_plus, len, DIFF_PLAIN, 1);
 			dwb_minus->current += len;
+			if (lastchar_minus == '\n')
+				dwb_minus->suppressed_newline = 1;
 			break;
 	}
 }
@@ -474,9 +479,11 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	free(plus.ptr);
 	diff_words->minus.text.size = diff_words->plus.text.size = 0;
 
-	if (diff_words->minus.suppressed_newline) {
+	if (diff_words->minus.suppressed_newline ||
+			diff_words->plus.suppressed_newline) {
 		putc('\n', diff_words->file);
 		diff_words->minus.suppressed_newline = 0;
+		diff_words->plus.suppressed_newline = 0;
 	}
 }
 
-- 
1.5.5.1.121.g26b3
