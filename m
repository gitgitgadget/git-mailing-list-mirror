From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 24/27] ref_transaction_commit(): simplify code using temporary variables
Date: Mon,  7 Apr 2014 15:48:15 +0200
Message-ID: <1396878498-19887-25-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:49:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9vc-0003AS-Em
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402AbaDGNt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:49:27 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57541 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755347AbaDGNtM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:49:12 -0400
X-AuditID: 12074411-f79ab6d000002f0e-20-5342acd65c22
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id FD.AF.12046.6DCA2435; Mon,  7 Apr 2014 09:49:10 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaV026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:49:09 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqHttjVOwwYw1phY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7oyu3z8YCybyVvyY/Ym1gfE+ZxcjJ4eEgInE2i3L
	2CFsMYkL99azdTFycQgJXGaU+PTsFSOEc4xJYvbiGSwgVWwCuhKLepqZQGwRATWJiW2HWECK
	mAWuMEpc+bgdrEhYIFqie9oksCIWAVWJW6/ugq3gFXCV2P7rOzPEOjmJk8cms4LYnEDxGYdu
	MYLYQgIuEvfXHGOZwMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuqV5uZoleakrpJkZI
	8AnuYJxxUu4QowAHoxIP74pDjsFCrIllxZW5hxglOZiURHmfL3MKFuJLyk+pzEgszogvKs1J
	LT7EKMHBrCTCy7UaKMebklhZlVqUD5OS5mBREuflW6LuJySQnliSmp2aWpBaBJOV4eBQkuBd
	D9IoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qO+GJgfICkeID2zgXbW1yQmAsU
	hWg9xagoJc5bApIQAElklObBjYWllFeM4kBfCvNuAKniAaYjuO5XQIOZgAYbuoINLklESEk1
	MPJk9TplX7vBk84tZ8i6dU9GQnvFGcZnx8/fyJMsrk7quNhbcCrcMDfUo6lt/8afZzr3cSo5
	F3A8nD5dyzf97wzzrxUup18HvcioSvomqrZIrnzbvLXv2FuDjnYzT7PS0EssOTkj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245850>

Use temporary variables in the for-loop blocks to simplify expressions
in the rest of the loop.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 2ff195f..33c34df 100644
--- a/refs.c
+++ b/refs.c
@@ -3435,10 +3435,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
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
@@ -3447,16 +3449,19 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
1.9.1
