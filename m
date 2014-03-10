From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 23/26] struct ref_update: Add a lock member
Date: Mon, 10 Mar 2014 13:46:40 +0100
Message-ID: <1394455603-2968-24-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:54:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzjJ-0005XT-Be
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbaCJMyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:54:49 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:54345 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753570AbaCJMys (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:54:48 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Mar 2014 08:54:48 EDT
X-AuditID: 1207440c-f79656d000003eba-30-531db466c3de
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 71.6E.16058.664BD135; Mon, 10 Mar 2014 08:47:34 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwl025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:47:32 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqJu2RTbYYEKzjsXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4vaK+cwWP1p6mC0+di5gdmD3+Pv+A5PHzll32T0uvfzO5vHx2XJ2j2e9exg9
	Ll5S9vi8SS6APYrbJimxpCw4Mz1P3y6BO6PhZkXBFImKI/umMzUwHhfqYuTkkBAwkXjybBUr
	hC0mceHeerYuRi4OIYHLjBI9B9pYIZwTTBKrZz1hAqliE9CVWNTTDGaLCKhJTGw7xAJSxCxw
	hVHi89df7CAJYQFriZfXXzOD2CwCqhI7tu4BKuLg4BVwkehqCIPYJicx5fcCsHJOoPD0Kw/A
	bCEBZ4mXe5pZJzDyLmBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6iXm1mil5pSuokREng8
	Oxi/rZM5xCjAwajEw3vgrUywEGtiWXFl7iFGSQ4mJVHeiWtlg4X4kvJTKjMSizPii0pzUosP
	MUpwMCuJ8GYuBsrxpiRWVqUW5cOkpDlYlMR5VZeo+wkJpCeWpGanphakFsFkZTg4lCR4D28G
	ahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHRUZ8MTA2QFI8QHu3gbTzFhck5gJF
	IVpPMSpKifPOAUkIgCQySvPgxsLSyStGcaAvhXl/gFTxAFMRXPcroMFMQIObj0uBDC5JREhJ
	NTDKaFyaVq2/odpu41Xt6KkuIj94Ypsru18X5jQfzdzuHdUdqBO/5NS0DZaP2yR76/4uPbq0
	5/ruOQZvL0QWv7W6qfhhF1fmu38TdU2UHc5+ms1ctz+5Or5369vdosdEjl84le90 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243759>

Now that we manage ref_update objects internally, we can use them to
hold some of the scratch space we need when actually carrying out the
updates.  Store the (struct ref_lock *) there.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index ec638e9..73aec88 100644
--- a/refs.c
+++ b/refs.c
@@ -3278,6 +3278,7 @@ struct ref_update {
 	unsigned char old_sha1[20];
 	int flags; /* REF_NODEREF? */
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
+	struct ref_lock *lock;
 	const char refname[FLEX_ARRAY];
 };
 
@@ -3402,7 +3403,6 @@ int commit_ref_transaction(struct ref_transaction *transaction,
 	int ret = 0, delnum = 0, i;
 	struct ref_update **updates;
 	int *types;
-	struct ref_lock **locks;
 	const char **delnames;
 	int n = transaction->nr;
 
@@ -3412,7 +3412,6 @@ int commit_ref_transaction(struct ref_transaction *transaction,
 	/* Allocate work space */
 	updates = xmalloc(sizeof(*updates) * n);
 	types = xmalloc(sizeof(*types) * n);
-	locks = xcalloc(n, sizeof(*locks));
 	delnames = xmalloc(sizeof(*delnames) * n);
 
 	/* Copy, sort, and reject duplicate refs */
@@ -3426,12 +3425,12 @@ int commit_ref_transaction(struct ref_transaction *transaction,
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
@@ -3445,8 +3444,8 @@ int commit_ref_transaction(struct ref_transaction *transaction,
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
@@ -3454,9 +3453,11 @@ int commit_ref_transaction(struct ref_transaction *transaction,
 
 	/* Perform deletes now that updates are safely completed */
 	for (i = 0; i < n; i++) {
-		if (locks[i]) {
-			delnames[delnum++] = locks[i]->ref_name;
-			ret |= delete_ref_loose(locks[i], types[i]);
+		struct ref_update *update = updates[i];
+
+		if (update->lock) {
+			delnames[delnum++] = update->lock->ref_name;
+			ret |= delete_ref_loose(update->lock, types[i]);
 		}
 	}
 
@@ -3467,11 +3468,10 @@ int commit_ref_transaction(struct ref_transaction *transaction,
 
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
 	return ret;
 }
-- 
1.9.0
