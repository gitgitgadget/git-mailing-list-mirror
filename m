From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v2 3/5] diff.c: Fix --color-words showing trailing deleted words at another line
Date: Sat,  3 May 2008 19:57:06 +0800
Message-ID: <1209815828-6548-4-git-send-email-pkufranky@gmail.com>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
 <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-2-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-3-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 13:58:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsGNa-0004et-MX
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 13:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbYECL5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 07:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757347AbYECL5V
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 07:57:21 -0400
Received: from mail.qikoo.org ([60.28.205.235]:41300 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754629AbYECL5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 07:57:16 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id C2BB8470B0; Sat,  3 May 2008 19:57:08 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.121.g26b3
In-Reply-To: <1209815828-6548-3-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81072>

With --color-words, following example will show deleted word "bar" at
another line. (<r> represents red)
------------------
$ git diff
- foo bar
+ foo
$ git diff --color-words
foo
<r>bar</r>
------------------

This wrong behaviour is a bug in fn_out_diff_words_aux which always
outputs a newline after handling the diff line beginning with "+" and
ending with a newline.

Instead, we always supress the newline when using print_word, and in
fn_out_diff_words_aux, a newline is shown only in following cases:

  - true minus.suppressed_newline followd by a line beginning with
    '-', ' ' or '@' (i.e. not '+')
  - true plus.suppressed_newline followd by a line beginning with
    '+', ' ' or '@' (i.e. not '-')

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 diff.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index b5f7141..11316fe 100644
--- a/diff.c
+++ b/diff.c
@@ -409,6 +409,7 @@ static void print_word(FILE *file, struct diff_words_buffer *buffer, int len, in
 static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 {
 	struct diff_words_data *diff_words;
+	char cm;
 	struct diff_words_buffer *dm, *dp;
 	FILE *df;
 
@@ -417,10 +418,11 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	dp = &(diff_words->plus);
 	df = diff_words->file;
 
-	if (dm->suppressed_newline) {
-		if (line[0] != '+')
-			putc('\n', df);
+	if ((dm->suppressed_newline && line[0] != '+') ||
+			(dp->suppressed_newline && line[0] != '-')) {
+		putc('\n', df);
 		dm->suppressed_newline = 0;
+		dp->suppressed_newline = 0;
 	}
 
 	len--;
@@ -429,11 +431,14 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 			print_word(df, dm, len, DIFF_FILE_OLD, 1);
 			break;
 		case '+':
-			print_word(df, dp, len, DIFF_FILE_NEW, 0);
+			print_word(df, dp, len, DIFF_FILE_NEW, 1);
 			break;
 		case ' ':
-			print_word(df, dp, len, DIFF_PLAIN, 0);
+			cm = dm->text.ptr[dm->current + len - 1];
+			print_word(df, dp, len, DIFF_PLAIN, 1);
 			dm->current += len;
+			if (cm == '\n')
+				dm->suppressed_newline = 1;
 			break;
 	}
 }
@@ -475,9 +480,11 @@ static void diff_words_show(struct diff_words_data *diff_words)
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
