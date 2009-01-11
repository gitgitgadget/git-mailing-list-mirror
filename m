From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/4] color-words: refactor word splitting and use
 ALLOC_GROW()
Date: Sun, 11 Jan 2009 20:59:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901112059160.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 11 21:00:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM6UT-0004Tw-0P
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 21:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbZAKT7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 14:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752669AbZAKT7A
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 14:59:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:55088 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752659AbZAKT67 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 14:58:59 -0500
Received: (qmail invoked by alias); 11 Jan 2009 19:58:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp052) with SMTP; 11 Jan 2009 20:58:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18rqR5j44Qrbfu++emcUCnvmXTjcyOcDi7OYcQFhb
	GWozVOV5gqfLwO
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105207>


Word splitting is now performed by the function diff_words_fill(),
avoiding having the same code twice.

In the same spirit, avoid duplicating the code of ALLOC_GROW().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c |   40 +++++++++++++++++++---------------------
 1 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/diff.c b/diff.c
index f67e0b2..6d87ea5 100644
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
1.6.1.186.g48f3bc4
