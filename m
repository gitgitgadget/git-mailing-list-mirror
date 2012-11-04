From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/4] strbuf_split_buf(): use ALLOC_GROW()
Date: Sun,  4 Nov 2012 07:46:51 +0100
Message-ID: <1352011614-29334-2-git-send-email-mhagger@alum.mit.edu>
References: <1352011614-29334-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 07:47:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUtzn-0006Ts-R8
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 07:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557Ab2KDGr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 01:47:26 -0500
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:55856 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750914Ab2KDGrZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2012 01:47:25 -0500
X-AuditID: 12074413-b7f786d0000008bb-67-50960f7cb8d0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id BA.72.02235.C7F06905; Sun,  4 Nov 2012 01:47:24 -0500 (EST)
Received: from michael.fritz.box (p57A25973.dip.t-dialin.net [87.162.89.115])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qA46lFQp027771
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 4 Nov 2012 01:47:23 -0500
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352011614-29334-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqFvDPy3AYOM8a4uuK91MFg29V5gt
	bq+Yz2zxo6WH2YHF4+/7D0wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xoKJU1gK
	/vJULNho1MB4gbOLkYNDQsBEYuPWrC5GTiBTTOLCvfVsXYxcHEIClxklfnY0MkI4Z5gkXt5f
	zwRSxSagK7GopxnMFhGQlfh+eCMjiM0skCux+N1tdhBbWMBS4s2/+WA1LAKqEpMunmQBsXkF
	XCTam3exQmyTk/iw5xFYPaeAq8S9UwfAaoSAai7eXsYygZF3ASPDKka5xJzSXN3cxMyc4tRk
	3eLkxLy81CJdc73czBK91JTSTYyQ4BHewbjrpNwhRgEORiUe3l8rpgYIsSaWFVfmHmKU5GBS
	EuX9yjktQIgvKT+lMiOxOCO+qDQntfgQowQHs5II75bPQOW8KYmVValF+TApaQ4WJXFetSXq
	fkIC6YklqdmpqQWpRTBZGQ4OJQneWj6goYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUl
	GfGguIgvBkYGSIoHaK8rSDtvcUFiLlAUovUUoy7H0TdzHzIKseTl56VKifNmghQJgBRllObB
	rYClileM4kAfC/O2gFTxANMM3KRXQEuYgJZsvzQFZElJIkJKqoFx4vIv+xWKpp2NWBK1WNnp
	iDvvxUCtf5o3I7Zbxk6wkmH6US4/29xIt23CsYm1MzMCRFvsbJ4tZp2881lMwXbJnZbTrjod
	Xyql72T6RfHF+2RnIxmlqwE/LTZv18g3uvL0zWZp4XPffk2u3PJ0tvthASfZBYFn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209010>

Use ALLOC_GROW() rather than inline code to manage memory in
strbuf_split_buf().  Rename "pos" to "nr" because it better describes
the use of the variable and it better conforms to the "ALLOC_GROW"
idiom.

Also, instead of adding a sentinal NULL value after each entry is
added to the list, only add it once after all of the entries have been
added.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 strbuf.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 4b9e30c..5256c2a 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -108,33 +108,30 @@ void strbuf_ltrim(struct strbuf *sb)
 
 struct strbuf **strbuf_split_buf(const char *str, size_t slen, int delim, int max)
 {
-	int alloc = 2, pos = 0;
+	struct strbuf **ret = NULL;
+	size_t nr = 0, alloc = 0;
 	const char *n, *p;
-	struct strbuf **ret;
 	struct strbuf *t;
 
-	ret = xcalloc(alloc, sizeof(struct strbuf *));
 	p = n = str;
 	while (n < str + slen) {
 		int len;
-		if (max <= 0 || pos + 1 < max)
+		if (max <= 0 || nr + 1 < max)
 			n = memchr(n, delim, slen - (n - str));
 		else
 			n = NULL;
-		if (pos + 1 >= alloc) {
-			alloc = alloc * 2;
-			ret = xrealloc(ret, sizeof(struct strbuf *) * alloc);
-		}
 		if (!n)
 			n = str + slen - 1;
 		len = n - p + 1;
 		t = xmalloc(sizeof(struct strbuf));
 		strbuf_init(t, len);
 		strbuf_add(t, p, len);
-		ret[pos] = t;
-		ret[++pos] = NULL;
+		ALLOC_GROW(ret, nr + 2, alloc);
+		ret[nr++] = t;
 		p = ++n;
 	}
+	ALLOC_GROW(ret, nr + 1, alloc); /* In case string was empty */
+	ret[nr] = NULL;
 	return ret;
 }
 
-- 
1.8.0
