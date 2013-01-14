From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/14] imap-send.c: simplify logic in lf_to_crlf()
Date: Mon, 14 Jan 2013 06:32:43 +0100
Message-ID: <1358141566-26081-12-git-send-email-mhagger@alum.mit.edu>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 06:41:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tucnv-0005p0-Br
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 06:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916Ab3ANFlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 00:41:31 -0500
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:55724 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751161Ab3ANFl3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 00:41:29 -0500
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jan 2013 00:41:29 EST
X-AuditID: 12074414-b7f9b6d0000008b3-03-50f398c6ac16
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 69.31.02227.6C893F05; Mon, 14 Jan 2013 00:33:58 -0500 (EST)
Received: from michael.fritz.box (p57A25AA5.dip.t-dialin.net [87.162.90.165])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0E5Wt2s026427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Jan 2013 00:33:57 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsUixO6iqHtsxucAg+OzOSy6rnQzWTT0XmG2
	uL1iPrPFj5YeZgcWj7/vPzB5POvdw+hx8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGW+vTGMt
	eM5V8XLHTvYGxr/sXYycHBICJhIPDrxhgrDFJC7cW8/WxcjFISRwmVFi0vqTUM5ZJolDzZ/B
	qtgEdCUW9TSD2SICahIT2w6xgNjMAikSHc+7GUFsYQEnictzm5lBbBYBVYnuuevAbF4BV4nz
	nadYILYpSLzeeYkVxOYEin//eAqsRkjAReLhqWa2CYy8CxgZVjHKJeaU5urmJmbmFKcm6xYn
	J+blpRbpWujlZpbopaaUbmKEBJDIDsYjJ+UOMQpwMCrx8G4u+RwgxJpYVlyZe4hRkoNJSZQ3
	vB8oxJeUn1KZkVicEV9UmpNafIhRgoNZSYQ3tA4ox5uSWFmVWpQPk5LmYFES5/22WN1PSCA9
	sSQ1OzW1ILUIJivDwaEkwRs6HahRsCg1PbUiLTOnBCHNxMEJIrhANvAAbagBKeQtLkjMLc5M
	hyg6xagoJc6bCpIQAElklObBDYDF+itGcaB/hHmbQKp4gGkCrvsV0GAmoMFnL7wHGVySiJCS
	amBc0vUswHiv9aT4zALXJ/P//DzWJTWjKWjb7c9i8+KkTcK5loWmaHuUi39WlLGfrhITZNQ3
	n/lvrs+kf2/3WN2s7PjGsrzrwt63O4sqW6RP8txb1F9Yl5mZ2PDlyNG6IDnlzACnF65GR5cq
	Hdp09nlfvJX3mwPJvh4XH8WuYHUy8GJM36B97IMSS3FGoqEWc1FxIgCUqxt00AIA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213447>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 70abe9b..3167dcc 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1089,36 +1089,21 @@ static void lf_to_crlf(struct strbuf *msg)
 {
 	size_t new_len;
 	char *new;
-	int i, j, lfnum = 0;
+	int i, j = 0, lfnum = 0;
+	char lastc;
 
-	if (msg->buf[0] == '\n')
-		lfnum++;
-	for (i = 1; i < msg->len; i++) {
-		if (msg->buf[i - 1] != '\r' && msg->buf[i] == '\n')
+	for (i = 0, lastc = '\0'; i < msg->len; i++) {
+		if (msg->buf[i] == '\n' && lastc != '\r')
 			lfnum++;
+		lastc = msg->buf[i];
 	}
 
 	new_len = msg->len + lfnum;
 	new = xmalloc(new_len + 1);
-	if (msg->buf[0] == '\n') {
-		new[0] = '\r';
-		new[1] = '\n';
-		i = 1;
-		j = 2;
-	} else {
-		new[0] = msg->buf[0];
-		i = 1;
-		j = 1;
-	}
-	for ( ; i < msg->len; i++) {
-		if (msg->buf[i] != '\n') {
-			new[j++] = msg->buf[i];
-			continue;
-		}
-		if (msg->buf[i - 1] != '\r')
+	for (i = 0, lastc = '\0'; i < msg->len; i++) {
+		if (msg->buf[i] == '\n' && lastc != '\r')
 			new[j++] = '\r';
-		/* otherwise it already had CR before */
-		new[j++] = '\n';
+		lastc = new[j++] = msg->buf[i];
 	}
 	strbuf_attach(msg, new, new_len, new_len + 1);
 }
-- 
1.8.0.3
