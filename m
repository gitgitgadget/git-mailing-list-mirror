From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/4] color-words: refactor word splitting and use
 ALLOC_GROW()
Date: Wed, 14 Jan 2009 18:50:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901141850260.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901112059340.3586@pacific.mpi-cbg.de> <200901120947.13566.trast@student.ethz.ch> <7vprisj26i.fsf@gitster.siamese.dyndns.org> <adf1fd3d0901140500j10556a1as6370d40d766f1899@mail.gmail.com>
 <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 18:52:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN9u7-0002Mw-L8
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 18:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbZANRuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 12:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752234AbZANRuM
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 12:50:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:50446 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751993AbZANRuK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 12:50:10 -0500
Received: (qmail invoked by alias); 14 Jan 2009 17:50:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp030) with SMTP; 14 Jan 2009 18:50:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18+j/RrhSo+67NNhvW4FM54/iqpemAWcjIIh6Ivlo
	3h22h5+CifwEfH
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105672>


Word splitting is now performed by the function diff_words_fill(),
avoiding having the same code twice.

In the same spirit, avoid duplicating the code of ALLOC_GROW().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This has not changed, actually.  Just for your convenience.

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
1.6.1.243.g4c9c5a
