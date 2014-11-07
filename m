From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 09/16] refs.c: write updates to packed refs when a transaction has more than one ref
Date: Fri,  7 Nov 2014 11:38:58 -0800
Message-ID: <1415389145-6391-10-git-send-email-sahlberg@google.com>
References: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 20:39:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpNl-0004FM-Ho
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbaKGTj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:39:28 -0500
Received: from mail-pd0-f202.google.com ([209.85.192.202]:58604 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbaKGTjM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:39:12 -0500
Received: by mail-pd0-f202.google.com with SMTP id ft15so638702pdb.1
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 11:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B96GnBGDMHIW2YftrH7h9/53uIXD00rEvx/nj1sEOGA=;
        b=on91Cr73If4wgJQl3sCyd7bPNpeN/S4Joh/g0p2qq7EW0t5QOu8Bv3OaDX8bc/9pSf
         ip1DYPyMcHepp1dlgfvmlYB8YTePvckhR43AhRVh9xN2zzVAGSJgsRlvyoc4PPaKsy3F
         m7zOBvLoiNztsuWSBaMNbDq00T0t6T3KoYDyf/S3dM8q6HHzEGqMj87myYjyHZuBjyjO
         yvflW5Ia5E+zjTUyM9rGX9znbjC7eco6v8uGO43mID6M28wwS1ET6Yadov6VxqjHf+q7
         4mn5OL65P7/TwzsDd4ni7Ce5W4wiapmMHhbvvUa+gEH1/cg8YIpUx21eZXOtkKpZnUy/
         MRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B96GnBGDMHIW2YftrH7h9/53uIXD00rEvx/nj1sEOGA=;
        b=j5tk7oaef58lJPvtvjP1W7JYODJOT5ibTOlY+pVtxYMrgnj09Ky8QcuooR8PmyrGK1
         TxNEsQ2O19CyKSIqYiFASP0iTQqbiEnMl7MXufRdm+Oghhg6vh+CK5Up2kyt7I4FYmcH
         3B3ZMMShQ9Y72Xws+TK1DpRVs3G84ptzk2DuoW7aYEjO2BGvYifL2MAOBEpEjZcywhiU
         bRGKlIjHgEBgBC0sB+6hXNyPMcChED87Yz00OowZOVq2ZPiVURMdDYtEVJg4Ct2ONz82
         EdQH8byhqErjl0Mi0mKzo9xlM+9dHRKMmNWKSxN6Ad8hdDdltNIO77k86BfFqFOaWUoE
         A25Q==
X-Gm-Message-State: ALoCoQnLIJEatXQsZQuN29+dN+ZYrYgMxtPIYUsGW3uQkqCCpAiOpV0UGgWjs8dFNV3WVAb8NQWc
X-Received: by 10.70.119.71 with SMTP id ks7mr10299921pdb.9.1415389151125;
        Fri, 07 Nov 2014 11:39:11 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id 5si402131yhd.6.2014.11.07.11.39.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 11:39:11 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id CY4GDXNY.1; Fri, 07 Nov 2014 11:39:10 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BD350E0B37; Fri,  7 Nov 2014 11:39:09 -0800 (PST)
X-Mailer: git-send-email 2.1.2.810.gfbd2bf7.dirty
In-Reply-To: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
 builtin/clone.c       | 16 ++++++---
 refs.c                | 89 ++++++++++++++++++++++++++++++++++-----------------
 t/t5516-fetch-push.sh |  2 +-
 3 files changed, 72 insertions(+), 35 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 316c75d..bb2c058 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -498,17 +498,25 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 static void write_remote_refs(const struct ref *local_refs)
 {
 	const struct ref *r;
+	struct transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
-	lock_packed_refs(LOCK_DIE_ON_ERROR);
+	transaction = transaction_begin(&err);
+	if (!transaction)
+		die("%s", err.buf);
 
 	for (r = local_refs; r; r = r->next) {
 		if (!r->peer_ref)
 			continue;
-		add_packed_ref(r->peer_ref->name, r->old_sha1);
+		if (transaction_update_ref(transaction, r->peer_ref->name,
+					   r->old_sha1, NULL, 0, 0, NULL,
+					   &err))
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
index 7f4b4cb..c1db86f 100644
--- a/refs.c
+++ b/refs.c
@@ -2673,36 +2673,15 @@ int repack_without_refs(struct string_list *without, struct strbuf *err)
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
 	struct string_list_item *ref_to_delete;
-	int count, ret, removed = 0;
+	int ret;
 
 	assert(err);
 
-	/* Look for a packed ref */
-	count = 0;
-	for_each_string_list_item(ref_to_delete, without)
-		if (get_packed_ref(ref_to_delete->string))
-			count++;
-
-	/* No refname exists in packed refs */
-	if (!count) {
-		rollback_packed_refs();
-		return 0;
-	}
-
 	packed = get_packed_refs(&ref_cache);
 
 	/* Remove refnames from the cache */
 	for_each_string_list_item(ref_to_delete, without)
-		if (remove_entry(packed, ref_to_delete->string) != -1)
-			removed = 1;
-	if (!removed) {
-		/*
-		 * All packed entries disappeared while we were
-		 * acquiring the lock.
-		 */
-		rollback_packed_refs();
-		return 0;
-	}
+		remove_entry(packed, ref_to_delete->string);
 
 	/* Remove any other accumulated cruft */
 	do_for_each_entry_in_dir(packed, 0, curate_packed_ref_fn, &refs_to_delete);
@@ -3791,6 +3770,7 @@ int transaction_commit(struct transaction *transaction,
 		       struct strbuf *err)
 {
 	int ret = 0, i, need_repack = 0;
+	int num_updates = 0;
 	int n = transaction->nr;
 	struct packed_ref_cache *packed_ref_cache;
 	struct ref_update **updates = transaction->updates;
@@ -3824,14 +3804,30 @@ int transaction_commit(struct transaction *transaction,
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
@@ -3843,7 +3839,7 @@ int transaction_commit(struct transaction *transaction,
 		need_repack = 1;
 	}
 	if (need_repack) {
-		packed = get_packed_refs(&ref_cache);;
+		packed = get_packed_refs(&ref_cache);
 		sort_ref_dir(packed);
 		if (commit_packed_refs()){
 			strbuf_addf(err, "unable to overwrite old ref-pack "
@@ -3860,13 +3856,15 @@ int transaction_commit(struct transaction *transaction,
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
@@ -3905,7 +3903,10 @@ int transaction_commit(struct transaction *transaction,
 		update->lock = NULL;
 	}
 
-	/* Acquire all ref locks for updates while verifying old values */
+	/*
+	 * Acquire all ref locks for updates while verifying old values.
+	 * If we are multi-updating then update them in packed refs.
+	 */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
@@ -3928,6 +3929,30 @@ int transaction_commit(struct transaction *transaction,
 				    update->refname);
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
@@ -3976,7 +4001,7 @@ int transaction_commit(struct transaction *transaction,
 
 		if (update->update_type != UPDATE_SHA1)
 			continue;
-		if (!is_null_sha1(update->new_sha1)) {
+		if (update->lock && !is_null_sha1(update->new_sha1)) {
 			if (write_ref_sha1(update->lock, update->new_sha1,
 					   update->msg)) {
 				update->lock = NULL; /* freed by write_ref_sha1 */
@@ -4049,6 +4074,10 @@ int transaction_commit(struct transaction *transaction,
 		}
 	}
 
+	if (need_repack) {
+		packed = get_packed_refs(&ref_cache);
+		sort_ref_dir(packed);
+	}
 	if (repack_without_refs(&refs_to_delete, err))
 		ret = TRANSACTION_GENERIC_ERROR;
 	clear_loose_ref_cache(&ref_cache);
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 7c8a769..03375a9 100755
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
2.1.0.rc2.206.gedb03e5
