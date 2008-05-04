From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v3 1/6] diff.c: Remove code redundancy in diff_words_show
Date: Sun,  4 May 2008 12:20:10 +0800
Message-ID: <1209874815-14411-2-git-send-email-pkufranky@gmail.com>
References: <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-1-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 06:21:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsVin-0004qs-KO
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 06:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbYEDEUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 00:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbYEDEUU
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 00:20:20 -0400
Received: from mail.qikoo.org ([60.28.205.235]:54650 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750847AbYEDEUT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 00:20:19 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 84C8C470AD; Sun,  4 May 2008 12:20:15 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.121.g26b3
In-Reply-To: <1209874815-14411-1-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81128>

Introduce mmfile_copy_set_boundary to do the repeated work.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 diff.c |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/diff.c b/diff.c
index 3632b55..6633c9c 100644
--- a/diff.c
+++ b/diff.c
@@ -434,6 +434,17 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	}
 }
 
+static void mmfile_copy_set_boundary(mmfile_t *dest, mmfile_t *src) {
+	int i;
+
+	dest->size = src->size;
+	dest->ptr = xmalloc(dest->size);
+	memcpy(dest->ptr, src->ptr, dest->size);
+	for (i = 0; i < dest->size; i++)
+		if (isspace(dest->ptr[i]))
+			dest->ptr[i] = '\n';
+}
+
 /* this executes the word diff on the accumulated buffers */
 static void diff_words_show(struct diff_words_data *diff_words)
 {
@@ -441,23 +452,11 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	xdemitconf_t xecfg;
 	xdemitcb_t ecb;
 	mmfile_t minus, plus;
-	int i;
 
 	memset(&xecfg, 0, sizeof(xecfg));
-	minus.size = diff_words->minus.text.size;
-	minus.ptr = xmalloc(minus.size);
-	memcpy(minus.ptr, diff_words->minus.text.ptr, minus.size);
-	for (i = 0; i < minus.size; i++)
-		if (isspace(minus.ptr[i]))
-			minus.ptr[i] = '\n';
+	mmfile_copy_set_boundary(&minus, &(diff_words->minus.text));
 	diff_words->minus.current = 0;
-
-	plus.size = diff_words->plus.text.size;
-	plus.ptr = xmalloc(plus.size);
-	memcpy(plus.ptr, diff_words->plus.text.ptr, plus.size);
-	for (i = 0; i < plus.size; i++)
-		if (isspace(plus.ptr[i]))
-			plus.ptr[i] = '\n';
+	mmfile_copy_set_boundary(&plus, &(diff_words->plus.text));
 	diff_words->plus.current = 0;
 
 	xpp.flags = XDF_NEED_MINIMAL;
-- 
1.5.5.1.121.g26b3
