From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v3 5/6] fn_out_diff_words_aux: Handle common diff line more carefully
Date: Sun,  4 May 2008 12:20:14 +0800
Message-ID: <1209874815-14411-6-git-send-email-pkufranky@gmail.com>
References: <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-1-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-2-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-3-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-4-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-5-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 06:21:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsVjJ-00053b-3D
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 06:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbYEDEUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 00:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbYEDEUb
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 00:20:31 -0400
Received: from mail.qikoo.org ([60.28.205.235]:54659 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751097AbYEDEUV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 00:20:21 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 476F8470B2; Sun,  4 May 2008 12:20:15 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.121.g26b3
In-Reply-To: <1209874815-14411-5-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81133>

Before feeding minus and plus lines into xdi_diff, we replace non word
characters with '\n'. So we need recover the replaced character (always
the last character) in the callback fn_out_diff_words_aux.

Therefore, a common diff line beginning with ' ' is not always a real
common line. And we should check the last characters of the common diff
line. If they are different, we should output the first len-1 characters
as the common part and then the last characters in minus and plus
separately.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 diff.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index eb7c086..08048e4 100644
--- a/diff.c
+++ b/diff.c
@@ -414,7 +414,7 @@ static void print_word(FILE *file, struct diff_words_buffer *buffer, int len, in
 static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 {
 	struct diff_words_data *diff_words;
-	char lastchar_minus;
+	char lastchar_minus, lastchar_plus;
 	struct diff_words_buffer *dwb_minus, *dwb_plus;
 	FILE *outfile;
 
@@ -440,10 +440,18 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 			break;
 		case ' ':
 			lastchar_minus = dwb_minus->text.ptr[dwb_minus->current + len - 1];
-			print_word(outfile, dwb_plus, len, DIFF_PLAIN, 1);
-			dwb_minus->current += len;
-			if (lastchar_minus == '\n')
-				dwb_minus->suppressed_newline = 1;
+			lastchar_plus = dwb_plus->text.ptr[dwb_plus->current + len - 1];
+			if (lastchar_minus == lastchar_plus) {
+				print_word(outfile, dwb_plus, len, DIFF_PLAIN, 1);
+				dwb_minus->current += len;
+			}
+			else {
+				len--;
+				print_word(outfile, dwb_plus, len, DIFF_PLAIN, 1);
+				dwb_minus->current += len;
+				print_word(outfile, dwb_minus, 1, DIFF_FILE_OLD, 1);
+				print_word(outfile, dwb_plus, 1, DIFF_FILE_NEW, 1);
+			}
 			break;
 	}
 }
-- 
1.5.5.1.121.g26b3
