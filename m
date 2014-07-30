From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 2/5] refs.c: write updates to packed refs when a transaction has more than one ref
Date: Wed, 30 Jul 2014 14:55:38 -0700
Message-ID: <1406757341-4096-3-git-send-email-sahlberg@google.com>
References: <1406757341-4096-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 23:56:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCbqn-00087L-Db
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 23:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbaG3Vzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 17:55:44 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:39961 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbaG3Vzn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 17:55:43 -0400
Received: by mail-ob0-f202.google.com with SMTP id wp18so404432obc.1
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 14:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IJ/UoUITmuC0IEChPHWdz5ne0xcLEg4ClpVfXdD/Wig=;
        b=QijIlrJBOD8tlRL5pwQWDrmZgqIev/dXNcRRFuE299oJNaM5ItJ6Ql3xNvU3YtmnAz
         SxLEW72jsYmba7kAWBTMsbo4w99ZKQNZal7Gxxl1HTk5QuCF/4Ei+eEVDsbAoh4Rf5bq
         Cq/on7wKtIcAge2phh6/VTDoxB5dqQQYWEj8gRN9anejY8UnllMYwdsoqWQRwhf5Ubs2
         rQ3m5bhteI0NCHzPgn1XotUAOb6HSFNtLmfbNkjDZbt9f/T70EEgbN4P3g7T8f6wp6gQ
         jhPTXy2akIOrpbRmwZ/OYjL0+qxpiveGWfs8SihIpTVodAI0ME3Vp/vBBWheU/trGNF0
         fTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IJ/UoUITmuC0IEChPHWdz5ne0xcLEg4ClpVfXdD/Wig=;
        b=jPGt5ar90HAnv4SXThCEXRODJxkfDPznKwlkZAmonSDy501MKAWWNyFOy7B7aPMZJO
         kA9Py2LXWX8GKy9Ho61bXGoUpWYFueRujh/UIxZCBV6EQrCzVhrybF8ZoVdtPsHwyscY
         9eyyTgFLKEjWMJWR8qiLDzNp1InF2+9qWI80JEXUIAKQRCLKRsrjKk5UwmnWlvVk1CWP
         UzXAkzLAQ9Eas4GQ1IK4iVI5btL9AlBhVqIiwacTR+7F3j86DRcAGAyVsmzz8wZ+76Sx
         3BEUUvRrgOVeLXivVX7wpe51CGYgYvmBlehU4EjP6jQMrXwl2Leg1ja9zMaei+TDkeeD
         5S+g==
X-Gm-Message-State: ALoCoQkTLjYR4bPJQf194AD345yUQP8ZRZqNI3Cl6CrS+krqwiOO4kTHieAdBKJdbVq5fpKu0has
X-Received: by 10.182.232.164 with SMTP id tp4mr3030813obc.29.1406757343181;
        Wed, 30 Jul 2014 14:55:43 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si226418yhb.3.2014.07.30.14.55.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jul 2014 14:55:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id F2A7B5A4434;
	Wed, 30 Jul 2014 14:55:42 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9E199E0347; Wed, 30 Jul 2014 14:55:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.523.g0041e8a
In-Reply-To: <1406757341-4096-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254527>

When we are updating more than one single ref, i.e. not a commit, then
write the updated refs directly to the packed refs file instead of writing
them as loose refs.

Change clone to use a transaction instead of using the packed refs API.
This changes the behavior of clone slightly. Previously clone would always
clone all refs into a packed refs file. With this change clone will only
clone into packed refs iff there are two or more refs being cloned.
If the repository we are cloning from only contains exactly one single ref
then clone will now store this as a loose ref. The benefit here is that
we no longer need to export a bunch of API functions to clone to access
packed refs directly. Clone can now just use a normal transaction and all
the packed refs goodness will happen automatically.

Update the t5516 test to cope with the fact that clone now only uses
packed refs if there are more than one ref being cloned.

We still use loose refs for single ref transactions, such as are used
by 'git commit' and friends. The reason for this is that if you have very
many refs then having to re-write the whole packed refs file for every
common operation like commit would have a performance impact.
That said, with these changes it should now be fairly straightforward to
add support to optionally start using packed refs for ALL updates
which could solve existing issues with name clashes in case insensitive
filesystems.

This change also means that multi-ref updates will now appear as a single
atomic change to any external observers instead of a sequence of discreete
changes.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/clone.c       | 16 +++++++---
 refs.c                | 83 ++++++++++++++++++++++++++++++++++++---------------
 t/t5516-fetch-push.sh |  2 +-
 3 files changed, 72 insertions(+), 29 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f7307e6..7737e12 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -497,17 +497,25 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 static void write_remote_refs(const struct ref *local_refs)
 {
 	const struct ref *r;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
-	lock_packed_refs(LOCK_DIE_ON_ERROR);
+	transaction = transaction_begin(&err);
+	if (!transaction)
+		die("%s", err.buf);
 
 	for (r = local_refs; r; r = r->next) {
 		if (!r->peer_ref)
 			continue;
-		add_packed_ref(r->peer_ref->name, r->old_sha1);
+		if (transaction_update_sha1(transaction, r->peer_ref->name,
+					    r->old_sha1, NULL, 0, 0, NULL,
+					    &err))
+			die("%s", err.buf);
 	}
 
-	if (commit_packed_refs())
-		die_errno("unable to overwrite old ref-pack file");
+	if (transaction_commit(transaction, &err))
+		die("%s", err.buf);
+	transaction_free(transaction);
 }
 
 static void write_followtags(const struct ref *refs, const char *msg)
diff --git a/refs.c b/refs.c
index ed65f4a..bacce94 100644
--- a/refs.c
+++ b/refs.c
@@ -2543,33 +2543,18 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
 	struct string_list_item *ref_to_delete;
-	int i, ret, removed = 0;
+	int i, ret;
 
 	/* Look for a packed ref */
 	for (i = 0; i < n; i++)
 		if (get_packed_ref(refnames[i]))
 			break;
 
-	/* Avoid processing if we have nothing to do */
-	if (i == n) {
-		rollback_packed_refs();
-		return 0; /* no refname exists in packed refs */
-	}
-
 	packed = get_packed_refs(&ref_cache);
 
 	/* Remove refnames from the cache */
 	for (i = 0; i < n; i++)
-		if (remove_entry(packed, refnames[i]) != -1)
-			removed = 1;
-	if (!removed) {
-		/*
-		 * All packed entries disappeared while we were
-		 * acquiring the lock.
-		 */
-		rollback_packed_refs();
-		return 0;
-	}
+		remove_entry(packed, refnames[i]);
 
 	/* Remove any other accumulated cruft */
 	do_for_each_entry_in_dir(packed, 0, curate_packed_ref_fn, &refs_to_delete);
@@ -3624,6 +3609,7 @@ int transaction_commit(struct ref_transaction *transaction,
 		       struct strbuf *err)
 {
 	int ret = 0, delnum = 0, i, df_conflict = 0, need_repack = 0;
+	int num_updates = 0;
 	const char **delnames;
 	int n = transaction->nr;
 	struct packed_ref_cache *packed_ref_cache;
@@ -3657,14 +3643,30 @@ int transaction_commit(struct ref_transaction *transaction,
 		goto cleanup;
 	}
 
-	/* any loose refs are to be deleted are first copied to packed refs */
+	/* count how many refs we are updating (not deleting) */
+	for (i = 0; i < n; i++) {
+		struct ref_update *update = updates[i];
+
+		if (update->update_type != UPDATE_SHA1)
+			continue;
+		if (is_null_sha1(update->new_sha1))
+			continue;
+
+		num_updates++;
+	}
+
+	/*
+	 * Always copy loose refs that are to be deleted to the packed refs.
+	 * If we are updating multiple refs then copy all refs to the packed
+	 * refs file.
+	 */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 		unsigned char sha1[20];
 
 		if (update->update_type != UPDATE_SHA1)
 			continue;
-		if (!is_null_sha1(update->new_sha1))
+		if (num_updates < 2 && !is_null_sha1(update->new_sha1))
 			continue;
 		if (get_packed_ref(update->refname))
 			continue;
@@ -3676,7 +3678,7 @@ int transaction_commit(struct ref_transaction *transaction,
 		need_repack = 1;
 	}
 	if (need_repack) {
-		packed = get_packed_refs(&ref_cache);;
+		packed = get_packed_refs(&ref_cache);
 		sort_ref_dir(packed);
 		if (commit_packed_refs()){
 			strbuf_addf(err, "unable to overwrite old ref-pack "
@@ -3693,13 +3695,15 @@ int transaction_commit(struct ref_transaction *transaction,
 			goto cleanup;
 		}
 	}
+	need_repack = 0;
 
 	/*
 	 * At this stage any refs that are to be deleted have been moved to the
-	 * packed refs file anf the packed refs file is deleted. We can now
+	 * packed refs file and the packed refs file is committed. We can now
 	 * safely delete these loose refs.
+	 * If we are updating multiple refs then those will also be in the
+	 * packed refs file so we can delete those too.
 	 */
-
 	/* Unlink any loose refs scheduled for deletion */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
@@ -3735,7 +3739,10 @@ int transaction_commit(struct ref_transaction *transaction,
 		update->lock = NULL;
 	}
 
-	/* Acquire all ref locks for updates while verifying old values */
+	/*
+	 * Acquire all ref locks for updates while verifying old values.
+	 * If we are multi-updating then update them in packed refs.
+	 */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
@@ -3759,6 +3766,30 @@ int transaction_commit(struct ref_transaction *transaction,
 			ret = -1;
 			goto cleanup;
 		}
+		if (num_updates < 2)
+			continue;
+
+		if (delete_ref_loose(update->lock, update->type, err)) {
+			ret = -1;
+			goto cleanup;
+		}
+		if (write_sha1_update_reflog(update->lock, update->new_sha1,
+					     update->msg)) {
+			if (err)
+				strbuf_addf(err, "Failed to update log '%s'.",
+					    update->refname);
+			ret = -1;
+			goto cleanup;
+		}
+		unlock_ref(update->lock);
+		update->lock = NULL;
+
+		packed = get_packed_refs(&ref_cache);
+		remove_entry(packed, update->refname);
+		add_packed_ref(update->refname, update->new_sha1);
+		need_repack = 1;
+
+		try_remove_empty_parents((char *)update->refname);
 	}
 
 	/* delete reflog for all deleted refs */
@@ -3807,7 +3838,7 @@ int transaction_commit(struct ref_transaction *transaction,
 
 		if (update->update_type != UPDATE_SHA1)
 			continue;
-		if (!is_null_sha1(update->new_sha1)) {
+		if (update->lock && !is_null_sha1(update->new_sha1)) {
 			ret = write_ref_sha1(update->lock, update->new_sha1,
 					     update->msg);
 			update->lock = NULL; /* freed by write_ref_sha1 */
@@ -3872,6 +3903,10 @@ int transaction_commit(struct ref_transaction *transaction,
 		}
 	}
 
+	if (need_repack) {
+		packed = get_packed_refs(&ref_cache);
+		sort_ref_dir(packed);
+	}
 	if (repack_without_refs(delnames, delnum, err))
 		ret = -1;
 	clear_loose_ref_cache(&ref_cache);
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 67e0ab3..23978de 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -592,7 +592,7 @@ test_expect_success 'push updates up-to-date local refs' '
 
 test_expect_success 'push preserves up-to-date packed refs' '
 
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/master heads/foo heads/bar &&
 	mk_child testrepo child &&
 	(
 		cd child &&
-- 
2.0.1.523.g0041e8a
