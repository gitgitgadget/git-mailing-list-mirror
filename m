From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 26/27] struct ref_update: add a type field
Date: Mon,  7 Apr 2014 15:48:17 +0200
Message-ID: <1396878498-19887-27-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:49:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9vr-0003Kr-0f
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246AbaDGNto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:49:44 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:56696 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755395AbaDGNtP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:49:15 -0400
X-AuditID: 1207440e-f79c76d000003e2c-9e-5342acdad05d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 74.49.15916.ADCA2435; Mon,  7 Apr 2014 09:49:14 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaX026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:49:13 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqHtrjVOwwdQOXYud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd8a+X+0sBff4K6a2LmdsYFzC08XIySEhYCJxee8N
	FghbTOLCvfVsXYxcHEIClxkljlx4zg6SEBI4xiTR0eEOYrMJ6Eos6mlmArFFBNQkJrYdYgFp
	YBa4wihx5eN2sEnCArYSh5pmgTWzCKhKrFrynhnE5hVwlfjSP5UdYpucxMljk1lBbE6g+IxD
	txghlrlI3F9zjGUCI+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbrGermZJXqpKaWbGCGh
	x7eDsX29zCFGAQ5GJR7eFYccg4VYE8uKK3MPMUpyMCmJ8j5f5hQsxJeUn1KZkVicEV9UmpNa
	fIhRgoNZSYSXazVQjjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwasK
	jDEhwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFBsxBcDowMkxQO0dy7Y3uKCxFyg
	KETrKUZFKXHeEpCEAEgiozQPbiwsobxiFAf6UphXDWQ7DzAZwXW/AhrMBDTY0BVscEkiQkqq
	gVHK/KOJVeEPR/GCmJvPGVTytLtOWK6QvTP34V92/tiDbDKHGqoq5CU2JlQm/FG5f5HF7pWt
	xlRZzzw7btayLrcHK6+HzE+stLzMfzpqPq/x8jnV6r/Tr0u1LJl4R0Nn8bM3Ofda 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245853>

It used to be that ref_transaction_commit() allocated a temporary
array to hold the types of references while it is working.  Instead,
add a type field to ref_update that ref_transaction_commit() can use
as its scratch space.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 6fe4bfe8..c058f30 100644
--- a/refs.c
+++ b/refs.c
@@ -3279,6 +3279,7 @@ struct ref_update {
 	int flags; /* REF_NODEREF? */
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
 	struct ref_lock *lock;
+	int type;
 	const char refname[FLEX_ARRAY];
 };
 
@@ -3413,7 +3414,6 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 {
 	int ret = 0, delnum = 0, i;
 	struct ref_update **updates;
-	int *types;
 	const char **delnames;
 	int n = transaction->nr;
 
@@ -3422,7 +3422,6 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Allocate work space */
 	updates = xmalloc(sizeof(*updates) * n);
-	types = xmalloc(sizeof(*types) * n);
 	delnames = xmalloc(sizeof(*delnames) * n);
 
 	/* Copy, sort, and reject duplicate refs */
@@ -3440,7 +3439,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       (update->have_old ?
 						update->old_sha1 : NULL),
 					       update->flags,
-					       &types[i], onerr);
+					       &update->type, onerr);
 		if (!update->lock) {
 			ret = 1;
 			goto cleanup;
@@ -3468,7 +3467,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (update->lock) {
 			delnames[delnum++] = update->lock->ref_name;
-			ret |= delete_ref_loose(update->lock, types[i]);
+			ret |= delete_ref_loose(update->lock, update->type);
 		}
 	}
 
@@ -3482,7 +3481,6 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(updates);
-	free(types);
 	free(delnames);
 	ref_transaction_free(transaction);
 	return ret;
-- 
1.9.1
