From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/4] strbuf_split_buf(): simplify iteration
Date: Sun,  4 Nov 2012 07:46:52 +0100
Message-ID: <1352011614-29334-3-git-send-email-mhagger@alum.mit.edu>
References: <1352011614-29334-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 07:47:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUtzo-0006Ts-AC
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 07:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028Ab2KDGr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 01:47:28 -0500
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:58382 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750914Ab2KDGr1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2012 01:47:27 -0500
X-AuditID: 12074414-b7f846d0000008b8-bc-50960f7f146f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 3C.EA.02232.F7F06905; Sun,  4 Nov 2012 01:47:27 -0500 (EST)
Received: from michael.fritz.box (p57A25973.dip.t-dialin.net [87.162.89.115])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qA46lFQq027771
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 4 Nov 2012 01:47:26 -0500
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352011614-29334-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqFvPPy3A4NczEYuuK91MFg29V5gt
	bq+Yz2zxo6WH2YHF4+/7D0wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3Rk/rUuaC
	W9wVMx5OY29gvMHRxcjJISFgInF2x0lmCFtM4sK99WxdjFwcQgKXGSVmtr9mhXDOMEn8v38c
	rIpNQFdiUU8zE4gtIiAr8f3wRkYQm1kgV2Lxu9vsILawgLXE67e7gSZxcLAIqEocWlAGEuYV
	cJFY8W89I8QyOYkPex6BlXMKuErcO3WABcQWAqq5eHsZywRG3gWMDKsY5RJzSnN1cxMzc4pT
	k3WLkxPz8lKLdC30cjNL9FJTSjcxQsJHZAfjkZNyhxgFOBiVeHh/r5gaIMSaWFZcmXuIUZKD
	SUmU9yvntAAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrxbPgOV86YkVlalFuXDpKQ5WJTEeb8t
	VvcTEkhPLEnNTk0tSC2CycpwcChJ8NbyAQ0VLEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUos
	LcmIB0VGfDEwNkBSPEB7XUHaeYsLEnOBohCtpxh1OY6+mfuQUYglLz8vVUqcNxOkSACkKKM0
	D24FLFm8YhQH+liYtwWkigeYaOAmvQJawgS0ZPulKSBLShIRUlINjPrvhbd9/t79pCfPIvl2
	yMR1c6MqAzn5LiVYr/Seyfj5ya1gE5saPZ6LpaHWhSpKbzfEJ27/bOLItVZ6d5d2zbJyxXu6
	lk3HFBx2c27ZK1ng7H7rcMq2xZ+OR5dx7JT7Irf1oq//ZUenvnTReE9u1VWtJqHL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209014>

While iterating, update str and slen to keep track of the part of the
string that hasn't been processed yet rather than computing things
relative to the start of the original string.  This eliminates one
local variable, reduces the scope of another, and reduces the amount
of arithmetic needed within the loop.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 strbuf.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 5256c2a..c7cd529 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -110,25 +110,22 @@ struct strbuf **strbuf_split_buf(const char *str, size_t slen, int delim, int ma
 {
 	struct strbuf **ret = NULL;
 	size_t nr = 0, alloc = 0;
-	const char *n, *p;
 	struct strbuf *t;
 
-	p = n = str;
-	while (n < str + slen) {
-		int len;
-		if (max <= 0 || nr + 1 < max)
-			n = memchr(n, delim, slen - (n - str));
-		else
-			n = NULL;
-		if (!n)
-			n = str + slen - 1;
-		len = n - p + 1;
+	while (slen) {
+		int len = slen;
+		if (max <= 0 || nr + 1 < max) {
+			const char *end = memchr(str, delim, slen);
+			if (end)
+				len = end - str + 1;
+		}
 		t = xmalloc(sizeof(struct strbuf));
 		strbuf_init(t, len);
-		strbuf_add(t, p, len);
+		strbuf_add(t, str, len);
 		ALLOC_GROW(ret, nr + 2, alloc);
 		ret[nr++] = t;
-		p = ++n;
+		str += len;
+		slen -= len;
 	}
 	ALLOC_GROW(ret, nr + 1, alloc); /* In case string was empty */
 	ret[nr] = NULL;
-- 
1.8.0
