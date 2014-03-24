From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 24/27] ref_transaction_commit(): Introduce temporary variables
Date: Mon, 24 Mar 2014 18:56:57 +0100
Message-ID: <1395683820-17304-25-git-send-email-mhagger@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:58:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS99B-0002Oo-Fz
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbaCXR6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:58:00 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:51442 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753829AbaCXR57 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:57:59 -0400
X-AuditID: 1207440f-f79326d000003c9f-95-53307226787f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 6A.93.15519.62270335; Mon, 24 Mar 2014 13:57:58 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xu028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:57:56 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqKtWZBBssGCTpMXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4vaK+cwWP1p6mC0+di5gdmD3+Pv+A5PHzll32T0uvfzO5vHx2XJ2j2e9exg9
	Ll5S9vi8SS6APYrbJimxpCw4Mz1P3y6BO+PVg1esBRN5K3bsOsfWwHifs4uRk0NCwETi/pI5
	zBC2mMSFe+vZuhi5OIQELjNKHPjZxwLhnGCSuDrpPRNIFZuArsSinmYwW0RATWJi2yGwImaB
	K4wSVz5uZwFJCAsESmxe+AbMZhFQlVjU284IYvMKuErsnngAap2cxJTfC9hBbE6g+Nb2w2Bx
	IQEXiR0fe5kmMPIuYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRropebWaKXmlK6iRESfPw7
	GLvWyxxiFOBgVOLhjTA2CBZiTSwrrsw9xCjJwaQkysuWCxTiS8pPqcxILM6ILyrNSS0+xCjB
	wawkwmsZDpTjTUmsrEotyodJSXOwKInzqi9R9xMSSE8sSc1OTS1ILYLJynBwKEnwShcCNQoW
	paanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDoiO+GBgfICkeoL0OIO28xQWJuUBRiNZT
	jIpS4rzXCoASAiCJjNI8uLGwlPKKURzoS2FeNZB2HmA6gut+BTSYCWhweJMeyOCSRISUVAPj
	lvZJ5Y3ZP1McV3Opqs6W/W5UMPfE7QuXaxfv75kvsrjjr4GL/lzmmZPE+pieVz7k+tZm3PBw
	7tlv/07efe/b1a1g2M2ieiLpt2PquhtKcrMdd8wT994k6LowZ61CyS9J+csTVhT8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244845>

Use temporary variables in the for-loop blocks to simplify expressions
in the rest of the loop.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 2b80f6d..d51566c 100644
--- a/refs.c
+++ b/refs.c
@@ -3432,10 +3432,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Acquire all locks while verifying old values */
 	for (i = 0; i < n; i++) {
-		locks[i] = update_ref_lock(updates[i]->refname,
-					   (updates[i]->have_old ?
-					    updates[i]->old_sha1 : NULL),
-					   updates[i]->flags,
+		struct ref_update *update = updates[i];
+
+		locks[i] = update_ref_lock(update->refname,
+					   (update->have_old ?
+					    update->old_sha1 : NULL),
+					   update->flags,
 					   &types[i], onerr);
 		if (!locks[i]) {
 			ret = 1;
@@ -3444,16 +3446,19 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	}
 
 	/* Perform updates first so live commits remain referenced */
-	for (i = 0; i < n; i++)
-		if (!is_null_sha1(updates[i]->new_sha1)) {
+	for (i = 0; i < n; i++) {
+		struct ref_update *update = updates[i];
+
+		if (!is_null_sha1(update->new_sha1)) {
 			ret = update_ref_write(msg,
-					       updates[i]->refname,
-					       updates[i]->new_sha1,
+					       update->refname,
+					       update->new_sha1,
 					       locks[i], onerr);
 			locks[i] = NULL; /* freed by update_ref_write */
 			if (ret)
 				goto cleanup;
 		}
+	}
 
 	/* Perform deletes now that updates are safely completed */
 	for (i = 0; i < n; i++)
-- 
1.9.0
