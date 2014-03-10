From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 22/26] commit_ref_transaction(): Introduce temporary variables
Date: Mon, 10 Mar 2014 13:46:39 +0100
Message-ID: <1394455603-2968-23-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:48:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzcg-00089o-2X
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604AbaCJMrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:47:36 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:57609 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753600AbaCJMrd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:47:33 -0400
X-AuditID: 1207440d-f79d86d0000043db-94-531db464ae3c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id AD.47.17371.464BD135; Mon, 10 Mar 2014 08:47:32 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwk025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:47:31 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqJuyRTbY4NB2bYud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd0ZD/zTWgt38Fd9W/WVtYDzK3cXIySEhYCJxY+MC
	ZghbTOLCvfVsXYxcHEIClxklZh/cyQzhnGCSuPh0E1gVm4CuxKKeZiYQW0RATWJi2yEWkCJm
	gSuMEp+//mIHSQgL+EncPLSUBcRmEVCVmHToNFgzr4CLxN6jsxkh1slJTPm9AKyeEyg+/coD
	MFtIwFni5Z5m1gmMvAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrp5WaW6KWmlG5ihAQf
	7w7G/+tkDjEKcDAq8fAeeCsTLMSaWFZcmXuIUZKDSUmUd+Ja2WAhvqT8lMqMxOKM+KLSnNTi
	Q4wSHMxKIryZi4FyvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJ3vrN
	QI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoOiILwbGB0iKB2jvNpB23uKCxFyg
	KETrKUZFKXHeOSAJAZBERmke3FhYSnnFKA70pTBvK0gVDzAdwXW/AhrMBDS4+bgUyOCSRISU
	VAOj7LbPDfY9UlZzmrhao1W2aW380JTmlfyS80fPnWTLvqVc1bwJknd+xvbN52jK2xEfcJb3
	ya7yEvMbZuevzxE3+vg75Hemk0+Xxd4XOntbxP7anrj/4GKG8IdzZrN8J+77IPDT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243746>

Use temporary variables in the for-loop blocks to simplify expressions
in the rest of the loop.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 335d0e2..ec638e9 100644
--- a/refs.c
+++ b/refs.c
@@ -3424,10 +3424,12 @@ int commit_ref_transaction(struct ref_transaction *transaction,
 
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
@@ -3436,23 +3438,28 @@ int commit_ref_transaction(struct ref_transaction *transaction,
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
-	for (i = 0; i < n; i++)
+	for (i = 0; i < n; i++) {
 		if (locks[i]) {
 			delnames[delnum++] = locks[i]->ref_name;
 			ret |= delete_ref_loose(locks[i], types[i]);
 		}
+	}
+
 	ret |= repack_without_refs(delnames, delnum);
 	for (i = 0; i < delnum; i++)
 		unlink_or_warn(git_path("logs/%s", delnames[i]));
-- 
1.9.0
