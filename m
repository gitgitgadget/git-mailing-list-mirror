From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 3/5] refs.c: use packed refs when deleting refs during a transaction
Date: Wed, 30 Jul 2014 14:52:46 -0700
Message-ID: <1406757168-3729-4-git-send-email-sahlberg@google.com>
References: <1406757168-3729-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 23:53:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCboC-0005qk-LL
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 23:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbaG3VxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 17:53:09 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:42383 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbaG3Vwz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 17:52:55 -0400
Received: by mail-pa0-f73.google.com with SMTP id kx10so347369pab.2
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 14:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WrxPCM1Dztte3HBJNzX0QcORHajNwqEGvgEU70Bp+Wg=;
        b=AN6E0KtCyZrcxK2GMgTObXCPH3rywcLfEwu8rbu+P72Itb0CzM6d1u8QIuEVJZtd5m
         vNp1/pTOOUxGhQ4ly7mnKfVaugyTDmymWSJi/30I3kvtF++mWFrLCypyJqga7jq7yRyb
         hSjaDliOSS5wydqlI+5PfJzY207hAxKx91IahImn0qchToaENx14bCHIyRgyXTuYKmPC
         l6JRiTKr/NxrXoOUM9o41Q8fpzeuSzRIQbkcvtnScqeSOHxy1fLsScdaEyHYHLXAFQVJ
         ferC233dl/zWlvwbeSCooHhE7pt9yKQ6AD6woRX0jzzgtcUgm3AOx391CIQpDdHE81sp
         9row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WrxPCM1Dztte3HBJNzX0QcORHajNwqEGvgEU70Bp+Wg=;
        b=G7H2eHjLXEpV+4wvC+tK0quV1WH7wMU+AoPAVqYWzPcaG783WiijQmygpKiAKdcACK
         GR7w/pHwdPyuN5MGAyqoNIAeACCX1gXIITR5i1kQWsjbwm6gmm651GGOjX6MMQGH0B8j
         K12vZ+JVJhwFL7BEtpzcjYkHE0J7ScNb5ExcbS5Vn7cm83x7rIqlmRa+dZGG+7sH9uG7
         E5GhhF/XlsStSSJeiz3rQN69CGxFprL463VxXBxx+uo1TAEnIA1Updg/ViVj8EvmTcMa
         4nyXu0BtS+Dl7N1mpAnWlMyN5DUbOYHlJF1RcFTIhaYqDs8Q3y36qy/p+ElDlHlWw6kD
         hVvA==
X-Gm-Message-State: ALoCoQl44+kXw1r39HXZ2tOjDadeSBg/v529K8SZW7h1UMeXOqA9HM0TAN6Ep0nRgQ8K8v9K795+
X-Received: by 10.66.163.41 with SMTP id yf9mr2933941pab.36.1406757175182;
        Wed, 30 Jul 2014 14:52:55 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si225305yhk.4.2014.07.30.14.52.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jul 2014 14:52:55 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 64AB631C542;
	Wed, 30 Jul 2014 14:52:54 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E9FBEE0959; Wed, 30 Jul 2014 14:52:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.523.g0041e8a
In-Reply-To: <1406757168-3729-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254522>

Make the deletion of refs during a transaction more atomic.
Start by first copying all loose refs we will be deleting to the packed
refs file and then commit the packed refs file. Then re-lock the packed refs
file to stop anyone else from modifying these refs and keep it locked until
we are finished.
Since all refs we are about to delete are now safely held in the packed refs
file we can proceed to immediately unlink any corresponding loose refs
and still be fully rollback-able.

The exception is for refs that can not be resolved. Those refs are never
added to the packed refs and will just be un-rollback-ably deleted during
commit.

By deleting all the loose refs at the start of the transaction we make make
it possible to both delete one ref and then re-create a different ref in
the same transaction even if the two refs would normally conflict.

Example: rename m->m/m

In that example we want to delete the file 'm' so that we make room so
that we can create a directory with the same name in order to lock and
write to the ref m/m and its lock-file m/m.lock.

If there is a failure during the commit phase we can rollback without losing
any refs since we have so far only deleted loose refs that that are
guaranteed to also have a corresponding entry in the packed refs file.
Once we have finished all updates for refs and their reflogs we can repack
the packed refs file and remove the to-be-deleted refs from the packed refs,
at which point all the deleted refs will disappear in one atomic rename
operation.

This also means that for an outside observer, deletion of multiple refs
in a single transaction will look atomic instead of one ref being deleted
at a time.

In order to do all this we need to change the semantics for the
repack_without_refs function so that we can lock the packed refs file,
do other stuff, and later be able to call repack_without_refs with the
lock already taken.
This means we need some additional changes in remote.c to reflect the
changes to the repack_without_refs semantics.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/remote.c |  14 ++++--
 refs.c           | 148 +++++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 128 insertions(+), 34 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index be8ebac..bfcc823 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -753,6 +753,9 @@ static int remove_branches(struct string_list *branches)
 	const char **branch_names;
 	int i, result = 0;
 
+	if (lock_packed_refs(0))
+		return unable_to_lock_error(git_path("packed-refs"), errno);
+
 	branch_names = xmalloc(branches->nr * sizeof(*branch_names));
 	for (i = 0; i < branches->nr; i++)
 		branch_names[i] = branches->items[i].string;
@@ -1333,9 +1336,14 @@ static int prune_remote(const char *remote, int dry_run)
 		delete_refs = xmalloc(states.stale.nr * sizeof(*delete_refs));
 		for (i = 0; i < states.stale.nr; i++)
 			delete_refs[i] = states.stale.items[i].util;
-		if (!dry_run)
-			result |= repack_without_refs(delete_refs,
-						      states.stale.nr, NULL);
+		if (!dry_run) {
+			if (lock_packed_refs(0))
+				result |= unable_to_lock_error(
+					git_path("packed-refs"), errno);
+			else
+				result |= repack_without_refs(delete_refs,
+							states.stale.nr, NULL);
+		}
 		free(delete_refs);
 	}
 
diff --git a/refs.c b/refs.c
index 35f6db1..32f48ea 100644
--- a/refs.c
+++ b/refs.c
@@ -2535,6 +2535,9 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
+/*
+ * Must be called with packed refs already locked (and sorted)
+ */
 int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 {
 	struct ref_dir *packed;
@@ -2547,19 +2550,12 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 		if (get_packed_ref(refnames[i]))
 			break;
 
-	/* Avoid locking if we have nothing to do */
-	if (i == n)
+	/* Avoid processing if we have nothing to do */
+	if (i == n) {
+		rollback_packed_refs();
 		return 0; /* no refname exists in packed refs */
-
-	if (lock_packed_refs(0)) {
-		if (err) {
-			unable_to_lock_message(git_path("packed-refs"), errno,
-					       err);
-			return -1;
-		}
-		unable_to_lock_error(git_path("packed-refs"), errno);
-		return error("cannot delete '%s' from packed refs", refnames[i]);
 	}
+
 	packed = get_packed_refs(&ref_cache);
 
 	/* Remove refnames from the cache */
@@ -3671,10 +3667,12 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 int transaction_commit(struct ref_transaction *transaction,
 		       struct strbuf *err)
 {
-	int ret = 0, delnum = 0, i, df_conflict = 0;
+	int ret = 0, delnum = 0, i, df_conflict = 0, need_repack = 0;
 	const char **delnames;
 	int n = transaction->nr;
+	struct packed_ref_cache *packed_ref_cache;
 	struct ref_update **updates = transaction->updates;
+	struct ref_dir *packed;
 
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: commit called for transaction that is not open");
@@ -3694,12 +3692,100 @@ int transaction_commit(struct ref_transaction *transaction,
 		goto cleanup;
 	}
 
-	/* Acquire all ref locks while verifying old values */
+	/* Lock packed refs during commit */
+	if (lock_packed_refs(0)) {
+		if (err)
+			unable_to_lock_message(git_path("packed-refs"),
+					       errno, err);
+		ret = -1;
+		goto cleanup;
+	}
+
+	/* any loose refs are to be deleted are first copied to packed refs */
+	for (i = 0; i < n; i++) {
+		struct ref_update *update = updates[i];
+		unsigned char sha1[20];
+
+		if (update->update_type != UPDATE_SHA1)
+			continue;
+		if (!is_null_sha1(update->new_sha1))
+			continue;
+		if (get_packed_ref(update->refname))
+			continue;
+		if (!resolve_ref_unsafe(update->refname, sha1, 1, NULL))
+			continue;
+
+		add_packed_ref(update->refname, sha1);
+		need_repack = 1;
+	}
+	if (need_repack) {
+		packed = get_packed_refs(&ref_cache);;
+		sort_ref_dir(packed);
+		if (commit_packed_refs()){
+			strbuf_addf(err, "unable to overwrite old ref-pack "
+				    "file");
+			ret = -1;
+			goto cleanup;
+		}
+		/* lock the packed refs again so no one can change it */
+		if (lock_packed_refs(0)) {
+			if (err)
+				unable_to_lock_message(git_path("packed-refs"),
+						       errno, err);
+			ret = -1;
+			goto cleanup;
+		}
+	}
+
+	/*
+	 * At this stage any refs that are to be deleted have been moved to the
+	 * packed refs file anf the packed refs file is deleted. We can now
+	 * safely delete these loose refs.
+	 */
+
+	/* Unlink any loose refs scheduled for deletion */
+	for (i = 0; i < n; i++) {
+		struct ref_update *update = updates[i];
+
+		if (update->update_type != UPDATE_SHA1)
+			continue;
+		if (!is_null_sha1(update->new_sha1))
+			continue;
+		update->lock = lock_ref_sha1_basic(update->refname,
+						   (update->have_old ?
+						    update->old_sha1 :
+						    NULL),
+						   update->flags,
+						   &update->type,
+						   delnames, delnum);
+		if (!update->lock) {
+			if (errno == ENOTDIR)
+				df_conflict = 1;
+			if (err)
+				strbuf_addf(err, "Cannot lock the ref '%s'.",
+					    update->refname);
+			ret = -1;
+			goto cleanup;
+		}
+		if (delete_ref_loose(update->lock, update->type, err)) {
+			ret = -1;
+			goto cleanup;
+		}
+		try_remove_empty_parents((char *)update->refname);
+		if (!(update->flags & REF_ISPRUNING))
+			  delnames[delnum++] = xstrdup(update->lock->ref_name);
+		unlock_ref(update->lock);
+		update->lock = NULL;
+	}
+
+	/* Acquire all ref locks for updates while verifying old values */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
 		if (update->update_type != UPDATE_SHA1)
 			continue;
+		if (is_null_sha1(update->new_sha1))
+			continue;
 		update->lock = lock_ref_sha1_basic(update->refname,
 						   (update->have_old ?
 						    update->old_sha1 :
@@ -3718,6 +3804,10 @@ int transaction_commit(struct ref_transaction *transaction,
 		}
 	}
 
+	/* delete reflog for all deleted refs */
+	for (i = 0; i < delnum; i++)
+		unlink_or_warn(git_path("logs/%s", delnames[i]));
+
 	/* Lock all reflog files */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
@@ -3729,6 +3819,16 @@ int transaction_commit(struct ref_transaction *transaction,
 			update->reflog_lock = update->orig_update->reflog_lock;
 			continue;
 		}
+		if (log_all_ref_updates && !reflog_exists(update->refname) &&
+		    create_reflog(update->refname)) {
+			ret = -1;
+			if (err)
+				strbuf_addf(err, "Failed to setup reflog for "
+					    "%s", update->refname);
+			goto cleanup;
+		}
+		if (!reflog_exists(update->refname))
+			continue;
 		update->reflog_fd = hold_lock_file_for_append(
 					update->reflog_lock,
 					git_path("logs/%s", update->refname),
@@ -3744,7 +3844,7 @@ int transaction_commit(struct ref_transaction *transaction,
 		}
 	}
 
-	/* Perform ref updates first so live commits remain referenced */
+	/* Perform ref updates */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
@@ -3765,21 +3865,6 @@ int transaction_commit(struct ref_transaction *transaction,
 		}
 	}
 
-	/* Perform deletes now that updates are safely completed */
-	for (i = 0; i < n; i++) {
-		struct ref_update *update = updates[i];
-
-		if (update->update_type != UPDATE_SHA1)
-			continue;
-		if (update->lock) {
-			if (delete_ref_loose(update->lock, update->type, err))
-				ret = -1;
-
-			if (!(update->flags & REF_ISPRUNING))
-				delnames[delnum++] = update->lock->ref_name;
-		}
-	}
-
 	/*
 	 * Update all reflog files
 	 * We have already committed all ref updates and deletes.
@@ -3832,11 +3917,12 @@ int transaction_commit(struct ref_transaction *transaction,
 
 	if (repack_without_refs(delnames, delnum, err))
 		ret = -1;
-	for (i = 0; i < delnum; i++)
-		unlink_or_warn(git_path("logs/%s", delnames[i]));
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
+	packed_ref_cache = get_packed_ref_cache(&ref_cache);
+	if (packed_ref_cache->lock)
+		rollback_packed_refs();
 	transaction->state = ret ? REF_TRANSACTION_ERROR
 		: REF_TRANSACTION_CLOSED;
 
-- 
2.0.1.523.g0041e8a
