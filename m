From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 25/27] struct ref_update: Add a lock member
Date: Mon, 24 Mar 2014 18:56:58 +0100
Message-ID: <1395683820-17304-26-git-send-email-mhagger@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:58:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS99C-0002Oo-NX
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862AbaCXR6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:58:07 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:51442 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753829AbaCXR6B (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:58:01 -0400
X-AuditID: 1207440f-f79326d000003c9f-9b-533072289c0f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id EA.93.15519.82270335; Mon, 24 Mar 2014 13:58:00 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xv028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:57:58 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqKtRZBBs0HFHymLnOgmLrivdTBYN
	vVeYLebd3cVkcXvFfGaLHy09zBYfOxcwO7B7/H3/gclj56y77B6XXn5n8/j4bDm7x7PePYwe
	Fy8pe3zeJBfAHsVtk5RYUhacmZ6nb5fAnXFj/iP2gm7Jiv0nXzM1MC4W7mLk5JAQMJHo//eZ
	CcIWk7hwbz1bFyMXh5DAZUaJzqfn2SGcE0wSV3bfZAOpYhPQlVjU0wzWISKgJjGx7RALSBGz
	wBVGiSsft7OAJIQF7CQe/7/DCmKzCKhK7Gg8B9bAK+Aqse30FUaIdXISU34vYAexOYHiW9sP
	M4PYQgIuEjs+9jJNYORdwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXRC83s0QvNaV0EyMk
	+Ph3MHatlznEKMDBqMTDG2FsECzEmlhWXJl7iFGSg0lJlJctFyjEl5SfUpmRWJwRX1Sak1p8
	iFGCg1lJhNcyHCjHm5JYWZValA+TkuZgURLnVV+i7ickkJ5YkpqdmlqQWgSTleHgUJLglS4E
	ahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHRUd8MTA+QFI8QHsdQNp5iwsSc4Gi
	EK2nGBWlxHmvFQAlBEASGaV5cGNhKeUVozjQl8K8aiDtPMB0BNf9CmgwE9Dg8CY9kMEliQgp
	qQbGvmJWUbXZ6acDW67K717y/kdtvj3bE4V75Ye3vftnHHPr0nq/8uRtpn5PXWSVlq3Yo283
	nbNb2aHbsFnFcYKRI+N8p5/bTrz5/Hz2nrBvNYsjAi9OZ+ja8tG1acGKPLlyHn0B 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244849>

Now that we manage ref_update objects internally, we can use them to
hold some of the scratch space we need when actually carrying out the
updates.  Store the (struct ref_lock *) there.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/refs.c b/refs.c
index d51566c..d1edd57 100644
--- a/refs.c
+++ b/refs.c
@@ -3278,6 +3278,7 @@ struct ref_update {
 	unsigned char old_sha1[20];
 	int flags; /* REF_NODEREF? */
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
+	struct ref_lock *lock;
 	const char refname[FLEX_ARRAY];
 };
 
@@ -3410,7 +3411,6 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	int ret = 0, delnum = 0, i;
 	struct ref_update **updates;
 	int *types;
-	struct ref_lock **locks;
 	const char **delnames;
 	int n = transaction->nr;
 
@@ -3420,7 +3420,6 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	/* Allocate work space */
 	updates = xmalloc(sizeof(*updates) * n);
 	types = xmalloc(sizeof(*types) * n);
-	locks = xcalloc(n, sizeof(*locks));
 	delnames = xmalloc(sizeof(*delnames) * n);
 
 	/* Copy, sort, and reject duplicate refs */
@@ -3434,12 +3433,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		locks[i] = update_ref_lock(update->refname,
-					   (update->have_old ?
-					    update->old_sha1 : NULL),
-					   update->flags,
-					   &types[i], onerr);
-		if (!locks[i]) {
+		update->lock = update_ref_lock(update->refname,
+					       (update->have_old ?
+						update->old_sha1 : NULL),
+					       update->flags,
+					       &types[i], onerr);
+		if (!update->lock) {
 			ret = 1;
 			goto cleanup;
 		}
@@ -3453,19 +3452,23 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			ret = update_ref_write(msg,
 					       update->refname,
 					       update->new_sha1,
-					       locks[i], onerr);
-			locks[i] = NULL; /* freed by update_ref_write */
+					       update->lock, onerr);
+			update->lock = NULL; /* freed by update_ref_write */
 			if (ret)
 				goto cleanup;
 		}
 	}
 
 	/* Perform deletes now that updates are safely completed */
-	for (i = 0; i < n; i++)
-		if (locks[i]) {
-			delnames[delnum++] = locks[i]->ref_name;
-			ret |= delete_ref_loose(locks[i], types[i]);
+	for (i = 0; i < n; i++) {
+		struct ref_update *update = updates[i];
+
+		if (update->lock) {
+			delnames[delnum++] = update->lock->ref_name;
+			ret |= delete_ref_loose(update->lock, types[i]);
 		}
+	}
+
 	ret |= repack_without_refs(delnames, delnum);
 	for (i = 0; i < delnum; i++)
 		unlink_or_warn(git_path("logs/%s", delnames[i]));
@@ -3473,11 +3476,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 cleanup:
 	for (i = 0; i < n; i++)
-		if (locks[i])
-			unlock_ref(locks[i]);
+		if (updates[i]->lock)
+			unlock_ref(updates[i]->lock);
 	free(updates);
 	free(types);
-	free(locks);
 	free(delnames);
 	ref_transaction_free(transaction);
 	return ret;
-- 
1.9.0
