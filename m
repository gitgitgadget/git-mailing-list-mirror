From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 2/7] color-words: refactor word splitting and use ALLOC_GROW()
Date: Sat, 17 Jan 2009 17:29:43 +0100
Message-ID: <1232209788-10408-3-git-send-email-trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de>
 <1232209788-10408-1-git-send-email-trast@student.ethz.ch>
 <1232209788-10408-2-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Teemu Likonen <tlikonen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 17:31:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOE4h-0007ql-5L
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 17:31:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763417AbZAQQ3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 11:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763305AbZAQQ3n
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 11:29:43 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:8904 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761757AbZAQQ3k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 11:29:40 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:29:39 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:29:39 +0100
X-Mailer: git-send-email 1.6.1.315.g92577
In-Reply-To: <1232209788-10408-2-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 17 Jan 2009 16:29:39.0581 (UTC) FILETIME=[CB4042D0:01C978C0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106080>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Word splitting is now performed by the function diff_words_fill(),
avoiding having the same code twice.

In the same spirit, avoid duplicating the code of ALLOC_GROW().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c |   40 +++++++++++++++++++---------------------
 1 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/diff.c b/diff.c
index d235482..c111eef 100644
--- a/diff.c
+++ b/diff.c
@@ -326,10 +326,7 @@ struct diff_words_buffer {
 static void diff_words_append(char *line, unsigned long len,
 		struct diff_words_buffer *buffer)
 {
-	if (buffer->text.size + len > buffer->alloc) {
-		buffer->alloc = (buffer->text.size + len) * 3 / 2;
-		buffer->text.ptr = xrealloc(buffer->text.ptr, buffer->alloc);
-	}
+	ALLOC_GROW(buffer->text.ptr, buffer->text.size + len, buffer->alloc);
 	line++;
 	len--;
 	memcpy(buffer->text.ptr + buffer->text.size, line, len);
@@ -398,6 +395,22 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	}
 }
 
+/*
+ * This function splits the words in buffer->text, and stores the list with
+ * newline separator into out.
+ */
+static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out)
+{
+	int i;
+	out->size = buffer->text.size;
+	out->ptr = xmalloc(out->size);
+	memcpy(out->ptr, buffer->text.ptr, out->size);
+	for (i = 0; i < out->size; i++)
+		if (isspace(out->ptr[i]))
+			out->ptr[i] = '\n';
+	buffer->current = 0;
+}
+
 /* this executes the word diff on the accumulated buffers */
 static void diff_words_show(struct diff_words_data *diff_words)
 {
@@ -405,26 +418,11 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	xdemitconf_t xecfg;
 	xdemitcb_t ecb;
 	mmfile_t minus, plus;
-	int i;
 
 	memset(&xpp, 0, sizeof(xpp));
 	memset(&xecfg, 0, sizeof(xecfg));
-	minus.size = diff_words->minus.text.size;
-	minus.ptr = xmalloc(minus.size);
-	memcpy(minus.ptr, diff_words->minus.text.ptr, minus.size);
-	for (i = 0; i < minus.size; i++)
-		if (isspace(minus.ptr[i]))
-			minus.ptr[i] = '\n';
-	diff_words->minus.current = 0;
-
-	plus.size = diff_words->plus.text.size;
-	plus.ptr = xmalloc(plus.size);
-	memcpy(plus.ptr, diff_words->plus.text.ptr, plus.size);
-	for (i = 0; i < plus.size; i++)
-		if (isspace(plus.ptr[i]))
-			plus.ptr[i] = '\n';
-	diff_words->plus.current = 0;
-
+	diff_words_fill(&diff_words->minus, &minus);
+	diff_words_fill(&diff_words->plus, &plus);
 	xpp.flags = XDF_NEED_MINIMAL;
 	xecfg.ctxlen = diff_words->minus.alloc + diff_words->plus.alloc;
 	xdi_diff_outf(&minus, &plus, fn_out_diff_words_aux, diff_words,
-- 
1.6.1.315.g92577
