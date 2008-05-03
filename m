From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v2 5/5] fn_out_diff_words_aux: Handle common diff line more carefully
Date: Sat,  3 May 2008 19:57:08 +0800
Message-ID: <1209815828-6548-6-git-send-email-pkufranky@gmail.com>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
 <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-2-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-3-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-4-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-5-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 13:58:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsGNc-0004et-00
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 13:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755819AbYECL53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 07:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754236AbYECL50
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 07:57:26 -0400
Received: from mail.qikoo.org ([60.28.205.235]:41308 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755283AbYECL5S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 07:57:18 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 1F51D470B2; Sat,  3 May 2008 19:57:08 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.121.g26b3
In-Reply-To: <1209815828-6548-5-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81070>

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
index 50d7fa7..72fe804 100644
--- a/diff.c
+++ b/diff.c
@@ -414,7 +414,7 @@ static void print_word(FILE *file, struct diff_words_buffer *buffer, int len, in
 static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 {
 	struct diff_words_data *diff_words;
-	char cm;
+	char cm, cp;
 	struct diff_words_buffer *dm, *dp;
 	FILE *df;
 
@@ -440,10 +440,18 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 			break;
 		case ' ':
 			cm = dm->text.ptr[dm->current + len - 1];
-			print_word(df, dp, len, DIFF_PLAIN, 1);
-			dm->current += len;
-			if (cm == '\n')
-				dm->suppressed_newline = 1;
+			cp = dp->text.ptr[dp->current + len - 1];
+			if (cm == cp) {
+				print_word(df, dp, len, DIFF_PLAIN, 1);
+				dm->current += len;
+			}
+			else {
+				len--;
+				print_word(df, dp, len, DIFF_PLAIN, 1);
+				dm->current += len;
+				print_word(df, dm, 1, DIFF_FILE_OLD, 1);
+				print_word(df, dp, 1, DIFF_FILE_NEW, 1);
+			}
 			break;
 	}
 }
-- 
1.5.5.1.121.g26b3
