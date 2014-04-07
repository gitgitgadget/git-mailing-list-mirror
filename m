From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 25/27] struct ref_update: add a lock field
Date: Mon,  7 Apr 2014 15:48:16 +0200
Message-ID: <1396878498-19887-26-git-send-email-mhagger@alum.mit.edu>
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
	id 1WX9vr-0003Kr-Ig
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395AbaDGNtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:49:47 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48346 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755394AbaDGNtN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:49:13 -0400
X-AuditID: 1207440d-f79d86d0000043db-71-5342acd88690
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id D2.1E.17371.8DCA2435; Mon,  7 Apr 2014 09:49:12 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaW026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:49:11 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqHtjjVOwwe4JphY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7oxv/9YzF/RIVix5VNrAuES4i5GTQ0LAROLe1JdM
	ELaYxIV769m6GLk4hAQuM0ocv/mdGcI5xiRx+Nx1NpAqNgFdiUU9zWAdIgJqEhPbDrGAFDEL
	XGGUuPJxOwtIQljAVmLL7/2MIDaLgKrE3n1rwJp5BVwlJl29wgqxTk7i5LHJYDYnUHzGoVtg
	9UICLhL31xxjmcDIu4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrpFebmaJXmpK6SZGSOjx
	7mD8v07mEKMAB6MSD+/KQ47BQqyJZcWVuYcYJTmYlER5ny9zChbiS8pPqcxILM6ILyrNSS0+
	xCjBwawkwsu1GijHm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLgVQXG
	mJBgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KDbii4HRAZLiAdobDNLOW1yQmAsU
	hWg9xagoJc5bAnKQAEgiozQPbiwsobxiFAf6UphXDaSdB5iM4LpfAQ1mAhps6Ao2uCQRISXV
	wMjwcybjVdu1lzcekmLuXbmy6q0vR960/qK9TzyFN373DtKMOzXJ9spnzjYxQ56jBz7JLHt5
	M2XPmV3ufZqXV2+75GHSunzvL8aUz2FnK3uqE+y2nrfwXPEv6u2Wt2X7NgjaR3Xq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245854>

Now that we manage ref_update objects internally, we can use them to
hold some of the scratch space we need when actually carrying out the
updates.  Store the (struct ref_lock *) there.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/refs.c b/refs.c
index 33c34df..6fe4bfe8 100644
--- a/refs.c
+++ b/refs.c
@@ -3278,6 +3278,7 @@ struct ref_update {
 	unsigned char old_sha1[20];
 	int flags; /* REF_NODEREF? */
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
+	struct ref_lock *lock;
 	const char refname[FLEX_ARRAY];
 };
 
@@ -3413,7 +3414,6 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	int ret = 0, delnum = 0, i;
 	struct ref_update **updates;
 	int *types;
-	struct ref_lock **locks;
 	const char **delnames;
 	int n = transaction->nr;
 
@@ -3423,7 +3423,6 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	/* Allocate work space */
 	updates = xmalloc(sizeof(*updates) * n);
 	types = xmalloc(sizeof(*types) * n);
-	locks = xcalloc(n, sizeof(*locks));
 	delnames = xmalloc(sizeof(*delnames) * n);
 
 	/* Copy, sort, and reject duplicate refs */
@@ -3437,12 +3436,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3456,19 +3455,23 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3476,11 +3479,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
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
1.9.1
