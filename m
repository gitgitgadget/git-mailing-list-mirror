From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 7/8] wrap_in_html(): use strbuf_addstr_xml_quoted()
Date: Sun, 25 Nov 2012 12:08:40 +0100
Message-ID: <1353841721-16269-8-git-send-email-mhagger@alum.mit.edu>
References: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 12:09:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tca5v-0004Na-3s
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 12:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193Ab2KYLJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 06:09:36 -0500
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:46349 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753096Ab2KYLJf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Nov 2012 06:09:35 -0500
X-AuditID: 1207440f-b7fde6d00000095c-18-50b1fc6fa658
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 41.D9.02396.F6CF1B05; Sun, 25 Nov 2012 06:09:35 -0500 (EST)
Received: from michael.fritz.box (p57A25314.dip.t-dialin.net [87.162.83.20])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qAPB90UJ002898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 25 Nov 2012 06:09:34 -0500
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsUixO6iqJv/Z2OAwcZpchZdV7qZLBp6rzBb
	9C/vYrO4fHIuo8XtFfOZHVg9/r7/wOTx5Wojk8eHj3EeFy8pe3zeJBfAGsVtk5RYUhacmZ6n
	b5fAnfHkzG3mgh6eih8XLjI1MO7k7GLk5JAQMJF4fXwGM4QtJnHh3nq2LkYuDiGBy4wSn6Y8
	YYdwzjBJHN39iAWkik1AV2JRTzMTiC0ioCYxse0QC0gRs8BqRonJW86zgySEBZwl9rzuBSti
	EVCV2PngJlicV8BF4un+jYwQ6+QkPux5BBbnFHCV+LHvARuILQRUs/nCfsYJjLwLGBlWMcol
	5pTm6uYmZuYUpybrFicn5uWlFuma6OVmluilppRuYoQEFf8Oxq71MocYBTgYlXh4DVI2Bgix
	JpYVV+YeYpTkYFIS5Z37FSjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhDf0GVCONyWxsiq1KB8m
	Jc3BoiTOq75E3U9IID2xJDU7NbUgtQgmK8PBoSTBy/8bqFGwKDU9tSItM6cEIc3EwQkynEtK
	pDg1LyW1KLG0JCMeFB3xxcD4AEnxAO3VAGnnLS5IzAWKQrSeYtTlmDOz/QmjEEtefl6qlDgv
	C0iRAEhRRmke3ApYCnnFKA70sTDvz19AVTzA9AM36RXQEiagJcnXwZaUJCKkpBoYO5uTl+3M
	PPshS3DfxoY1xmuWz/gXl8f0ns9+poLtrE2r2VYcs43JC7dfu8OiIsVu+u07Ci2V012n9P8I
	UP723PiViq1N56eQ8G2c035MfqZeWv1acp+yjdeVdzL5Dxcdl833Z14mK7hyRqfn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210362>

Use the new function to quote characters as they are being added to
buf, rather than quoting them in *p and then copying them into buf.
This increases code sharing, and changes the algorithm from O(N^2) to
O(N) in the number of characters in a line.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index a5e0e33..b73c913 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1339,21 +1339,6 @@ static int imap_store_msg(struct store *gctx, struct msg_data *msg)
 	return DRV_OK;
 }
 
-static void encode_html_chars(struct strbuf *p)
-{
-	int i;
-	for (i = 0; i < p->len; i++) {
-		if (p->buf[i] == '&')
-			strbuf_splice(p, i, 1, "&amp;", 5);
-		if (p->buf[i] == '<')
-			strbuf_splice(p, i, 1, "&lt;", 4);
-		if (p->buf[i] == '>')
-			strbuf_splice(p, i, 1, "&gt;", 4);
-		if (p->buf[i] == '"')
-			strbuf_splice(p, i, 1, "&quot;", 6);
-	}
-}
-
 static void wrap_in_html(struct strbuf *msg)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -1372,12 +1357,12 @@ static void wrap_in_html(struct strbuf *msg)
 				strbuf_addbuf(&buf, *p);
 				strbuf_addstr(&buf, pre_open);
 				added_header = 1;
-				continue;
+			} else {
+				strbuf_addbuf(&buf, *p);
 			}
+		} else {
+			strbuf_addstr_xml_quoted(&buf, (*p)->buf);
 		}
-		else
-			encode_html_chars(*p);
-		strbuf_addbuf(&buf, *p);
 	}
 	strbuf_addstr(&buf, pre_close);
 	strbuf_list_free(lines);
-- 
1.8.0
