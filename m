From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 2/3] resolve_ref_unsafe(): handle the case of an SHA-1 within loop
Date: Wed, 19 Jun 2013 08:36:27 +0200
Message-ID: <1371623788-7227-3-git-send-email-mhagger@alum.mit.edu>
References: <1371623788-7227-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 08:36:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpC0n-0005JS-E2
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 08:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756529Ab3FSGgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 02:36:50 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64806 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756509Ab3FSGgs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jun 2013 02:36:48 -0400
X-AuditID: 1207440d-b7f006d000000adf-d2-51c1517fe610
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 79.49.02783.F7151C15; Wed, 19 Jun 2013 02:36:47 -0400 (EDT)
Received: from michael.berlin.jpk.com (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5J6aXcU032032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Jun 2013 02:36:46 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371623788-7227-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqFsfeDDQ4OAFGYuuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MFncvr2J3YPP4+/4Dk8ell9/ZPG6/ns/s8ax3D6PHxUvKHp83yQWw
	RXHbJCWWlAVnpufp2yVwZ8z80s9S8Iyn4sKVt0wNjC84uxg5OSQETCRWNzxihbDFJC7cW8/W
	xcjFISRwmVFi7oOdrBDObSaJ69s3MYNUsQnoSizqaWYCsUUE1CQmth1iASliFtjIKHH86j5G
	kISwQKjEjRk3wIpYBFQl2lob2UFsXgFniebVS1gg1ilITHn4Hmwop4CLxL2/z4FWswNtc5a4
	4DGBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0jvdzMEr3UlNJNjJAw493B+H+dzCFG
	AQ5GJR7ehpUHAoVYE8uKK3MPMUpyMCmJ8oYGHAwU4kvKT6nMSCzOiC8qzUktPsQowcGsJMKr
	5wCU401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8JaBDBUsSk1PrUjL
	zClBSDNxcIIILpANPEAb0kAKeYsLEnOLM9Mhik4xKkqJ87qAJARAEhmleXADYAnhFaM40D/C
	vJYgVTzAZALX/QpoMBPQYKHv+0AGlyQipKQaGHVWltx0eD7h6/ppU3jldh8yYs88Mmlt31Pu
	rTXfjyV09svF33z8srN4soQ7c2+9lRrTSdtnr8ok97+87fJYw/+A//v1V9UdZQs61df2CZQe
	OdvcxjH16F7t94eE9Bcdnf19lV7wd4X2611HNmqd7OC1/pmWGunt/XvP5tLau6// 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228353>

There is only one "break" statement within the loop, which jumps to
the code after the loop that handles the case of a file that holds a
SHA-1.  So move that code from below the loop into the if statement
where the break was previously located.  This makes the logic flow
more local.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index ab1f99e..867cf9f 100644
--- a/refs.c
+++ b/refs.c
@@ -1300,8 +1300,19 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		/*
 		 * Is it a symbolic ref?
 		 */
-		if (prefixcmp(buffer, "ref:"))
-			break;
+		if (prefixcmp(buffer, "ref:")) {
+			/*
+			 * Please note that FETCH_HEAD has a second
+			 * line containing other data.
+			 */
+			if (get_sha1_hex(buffer, sha1) ||
+			    (buffer[40] != '\0' && !isspace(buffer[40]))) {
+				if (flag)
+					*flag |= REF_ISBROKEN;
+				return NULL;
+			}
+			return refname;
+		}
 		if (flag)
 			*flag |= REF_ISSYMREF;
 		buf = buffer + 4;
@@ -1314,13 +1325,6 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		}
 		refname = strcpy(refname_buffer, buf);
 	}
-	/* Please note that FETCH_HEAD has a second line containing other data. */
-	if (get_sha1_hex(buffer, sha1) || (buffer[40] != '\0' && !isspace(buffer[40]))) {
-		if (flag)
-			*flag |= REF_ISBROKEN;
-		return NULL;
-	}
-	return refname;
 }
 
 char *resolve_refdup(const char *ref, unsigned char *sha1, int reading, int *flag)
-- 
1.8.3.1
