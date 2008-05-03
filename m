From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v2 1/5] diff.c: Remove code redundancy in diff_words_show
Date: Sat,  3 May 2008 19:57:04 +0800
Message-ID: <1209815828-6548-2-git-send-email-pkufranky@gmail.com>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
 <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 13:58:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsGNZ-0004et-Bg
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 13:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638AbYECL5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 07:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754717AbYECL5R
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 07:57:17 -0400
Received: from mail.qikoo.org ([60.28.205.235]:41305 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753757AbYECL5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 07:57:16 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 6A4A1470AB; Sat,  3 May 2008 19:57:08 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.121.g26b3
In-Reply-To: <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81071>

Introduce mmfile_copy_set_boundary to do the repeated work.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 diff.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index 3632b55..acef138 100644
--- a/diff.c
+++ b/diff.c
@@ -434,6 +434,17 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	}
 }
 
+static mmfile_copy_set_boundary(mmfile_t *dest, mmfile_t *src) {
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
@@ -444,20 +455,9 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	int i;
 
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
