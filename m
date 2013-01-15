From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 14/14] imap-send.c: simplify logic in lf_to_crlf()
Date: Tue, 15 Jan 2013 09:06:32 +0100
Message-ID: <1358237193-8887-15-git-send-email-mhagger@alum.mit.edu>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 09:15:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv1fu-0000b5-7j
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 09:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756816Ab3AOIOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 03:14:49 -0500
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:50638 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753644Ab3AOIOs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 03:14:48 -0500
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2013 03:14:48 EST
X-AuditID: 12074414-b7f9b6d0000008b3-08-50f50e442c23
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 16.2E.02227.44E05F05; Tue, 15 Jan 2013 03:07:32 -0500 (EST)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0F86n5a029668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Jan 2013 03:07:31 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqOvC9zXAoOeajkXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGec7pvNUrBNuOJP8x7WBsbd
	fF2MnBwSAiYSix7+ZoKwxSQu3FvPBmILCVxmlJj5trSLkQvIPsMk8f7Ef7AEm4CuxKKeZrAG
	EQE1iYlth1hAbGYBB4nNnxsZQWxhAVeJY20zWUFsFgFViRunb4LFeQVcJB51HmCBWKYg8Xrn
	JbAaTqD41Z/HmCEWO0t82XCacQIj7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuhZ6uZkl
	eqkppZsYIaEisoPxyEm5Q4wCHIxKPLwmBl8ChFgTy4orcw8xSnIwKYnydnB9DRDiS8pPqcxI
	LM6ILyrNSS0+xCjBwawkwuvzDqicNyWxsiq1KB8mJc3BoiTO+22xup+QQHpiSWp2ampBahFM
	VoaDQ0mCV4EXaKhgUWp6akVaZk4JQpqJgxNEcIFs4AHa0A1SyFtckJhbnJkOUXSKUVFKnPcP
	D1BCACSRUZoHNwAW1a8YxYH+EeYVBWnnASYEuO5XQIOZgAZv2vsZZHBJIkJKqoFx0ax9DSen
	3tov9nfXxCkpaS2bWveocF+fl24Ws+Mdi0KRURHPmXl28QWGZdNyMk5lHO8RFF/lzjntYEiM
	WqHG46TNJ7SZ6467fMz+5XAviutLj5vMGt1+1318RTFTjmbe+SrXXSMeZC7onfL7UI3fl7q2
	AGuLd8aCITV1fxavCPt/cc/85/+VWIozEg21mIuKEwF+zinexQIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213619>

* The first character in the string used to be special-cased to get
  around the fact that msg->buf[i - 1] is not defined for i == 0.
  Instead, keep track of the previous character in a separate
  variable, "lastc", initialized in such a way to let the loop handle
  i == 0 correctly.

* Make the two loops over the string look as similar as possible to
  make it more obvious that the count computed in the first pass
  agrees with the true length of the new string written in the second
  pass.  As a side effect, this makes it possible to use the "j"
  counter in place of lfnum and new_len.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 52 +++++++++++++++++++++++-----------------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index f2933e9..1d40207 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1081,42 +1081,36 @@ bail:
 	return NULL;
 }
 
+/*
+ * Insert CR characters as necessary in *msg to ensure that every LF
+ * character in *msg is preceded by a CR.
+ */
 static void lf_to_crlf(struct strbuf *msg)
 {
-	size_t new_len;
 	char *new;
-	int i, j, lfnum = 0;
-
-	if (msg->buf[0] == '\n')
-		lfnum++;
-	for (i = 1; i < msg->len; i++) {
-		if (msg->buf[i - 1] != '\r' && msg->buf[i] == '\n')
-			lfnum++;
+	size_t i, j;
+	char lastc;
+
+	/* First pass: tally, in j, the size of the new string: */
+	for (i = j = 0, lastc = '\0'; i < msg->len; i++) {
+		if (msg->buf[i] == '\n' && lastc != '\r')
+			j++; /* a CR will need to be added here */
+		lastc = msg->buf[i];
+		j++;
 	}
 
-	new_len = msg->len + lfnum;
-	new = xmalloc(new_len + 1);
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
+	new = xmalloc(j + 1);
+
+	/*
+	 * Second pass: write the new string.  Note that this loop is
+	 * otherwise identical to the first pass.
+	 */
+	for (i = j = 0, lastc = '\0'; i < msg->len; i++) {
+		if (msg->buf[i] == '\n' && lastc != '\r')
 			new[j++] = '\r';
-		/* otherwise it already had CR before */
-		new[j++] = '\n';
+		lastc = new[j++] = msg->buf[i];
 	}
-	strbuf_attach(msg, new, new_len, new_len + 1);
+	strbuf_attach(msg, new, j, j + 1);
 }
 
 /*
-- 
1.8.0.3
