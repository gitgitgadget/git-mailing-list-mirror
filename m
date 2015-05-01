From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/18] is_refname_available(): explain the reason for an early exit
Date: Fri,  1 May 2015 14:25:42 +0200
Message-ID: <1430483158-14349-3-git-send-email-mhagger@alum.mit.edu>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 14:26:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoA1P-0000qr-03
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 14:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753696AbbEAM0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 08:26:16 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:52302 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753623AbbEAM0N (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 08:26:13 -0400
X-AuditID: 1207440f-f792a6d000001284-10-554370e421c2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 5C.CE.04740.4E073455; Fri,  1 May 2015 08:26:12 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D7E.dip0.t-ipconnect.de [79.201.125.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t41CQ3Zf004310
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 08:26:11 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqPukwDnUYP9kaYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ5xcu4mpoI2z4u2XNawNjNfZuhg5OSQETCSaO/ugbDGJC/fWA9lcHEIClxkllj9byATh
	nGCSmH37OTtIFZuArsSinmYmEFtEQE1iYtshFpAiZoEORokLy7eBFQkLBEscPPEXzGYRUJVY
	cuUcM4jNK+Ai0bhzJTPEOjmJ88d/AtkcHJwCrhJfpiaChIWASu5//8o2gZF3ASPDKka5xJzS
	XN3cxMyc4tRk3eLkxLy81CJdE73czBK91JTSTYyQkOLfwdi1XuYQowAHoxIPL8dJp1Ah1sSy
	4srcQ4ySHExKory2Cc6hQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR476kD5XhTEiurUovyYVLS
	HCxK4rzqS9T9hATSE0tSs1NTC1KLYLIyHBxKErwM+UCNgkWp6akVaZk5JQhpJg5OkOFcUiLF
	qXkpqUWJpSUZ8aDYiC8GRgdIigdo79s8kL3FBYm5QFGI1lOMilLivI9BEgIgiYzSPLixsETx
	ilEc6Eth3i6Q7TzAJAPX/QpoMBPQ4PO3HEAGlyQipKQaGDuNbPKn7Fug/+d8UVCZ2iPPlC/y
	JROvy3AdYuBLYa+cZlzJmZ5gEpW9QXjPcp3gshSGHflnzG72cv9oO1UrvHOTYtTPcG936Qld
	W+QnMK7LnLCFY1Ps79SJcd//at/g61vBEaei/OVn1H6N7ZlLi7Yr/mq8ceqtXOPe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268116>

The reason why we can exit early if we find a reference in skip whose
name is a prefix of refname is a bit subtle, so explain it in a
comment.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 2bdd93c..ab438a5 100644
--- a/refs.c
+++ b/refs.c
@@ -907,8 +907,20 @@ static int is_refname_available(const char *refname,
 		pos = search_ref_dir(dir, refname, slash - refname);
 		if (pos >= 0) {
 			struct ref_entry *entry = dir->entries[pos];
-			if (entry_matches(entry, skip))
+			if (entry_matches(entry, skip)) {
+				/*
+				 * The fact that entry is a ref whose
+				 * name is a prefix of refname means
+				 * that there cannot be any other ref
+				 * whose name starts with that prefix
+				 * (because it would have been a D/F
+				 * conflict with entry). So, since we
+				 * don't care about entry (because it
+				 * is in skip), we can stop looking
+				 * now and return true.
+				 */
 				return 1;
+			}
 			report_refname_conflict(entry, refname);
 			return 0;
 		}
-- 
2.1.4
