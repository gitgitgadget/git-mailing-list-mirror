From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 08/15] refs.c: write updates to packed refs when a transaction has more than one ref
Date: Tue, 21 Oct 2014 13:36:53 -0700
Message-ID: <1413923820-14457-9-git-send-email-sahlberg@google.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:37:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XggBp-000100-Hm
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 22:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933259AbaJUUh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 16:37:29 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:34458 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933170AbaJUUhF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 16:37:05 -0400
Received: by mail-qa0-f73.google.com with SMTP id cm18so201706qab.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 13:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wsa3QKa1VyErbIvVP041WAPKTRXnkFo7KHJm4XDqpuQ=;
        b=S6Zc+6uPiQ+oKEwxXqljDwfLCDp7Qa8JFBr1MZBYIuAYiOhnBb5n98jR/vldenSCjw
         1YuF2q0m6RlBdq38J5CUGfIxgxtHbViAOnTCPemGP8wiUoNyMafrMxlpwsNAW4b51vZw
         Tgwu+NHvNr8IsM6cu1/PIYf62SRlch3R5Q5+GK+PgGr/yz/TvJFMaSmg/9hJhEt3h7Ib
         ZjpB9FLP+71u34G03tN4kr6d1NXIU7HTT0XgLY4+B+4wNGi2EIw7E049W02rRhMDfFb3
         pHPovHSwB/JwMQXOoLMbnLPxITggI9SKh7HFtNtaD13KDcTm1Wl4rHEpaG9UwpAdgG7O
         Mtzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wsa3QKa1VyErbIvVP041WAPKTRXnkFo7KHJm4XDqpuQ=;
        b=GlKNuPI+f+DQa4wTQ54+tIOT+fIPuhJgW50X6BB5mcT5AumE0/pTfjqjU+Dcyl0ABl
         17FpDLR+0CjGHOk6iZ+Fsw5NOGbGANSnqtH3wGwvPnAZstf9vTfPssIsPoq5vdXjj7Bf
         Q3pujTBNRyFoDoWXrcN412opX69f/8Y95DXQkAK0cf+ZouYC1TlfsQrstK2M0Ovbwmmo
         3gPL9DrVfLPC1jv29CR3eV80XkBiYwB7dMxDJWsQn0HerHs7GLfDYypQkGvYYtegyPP7
         ewWUBPo94EoiQdmg0OCMKXm3JzwHjP9oNk8/JiiNQCoPSElIVrTSxoyuntAFaAODUFN+
         jRpw==
X-Gm-Message-State: ALoCoQlOOAGrIwkmCJEzq7tUH8Ne7SuuBEXyKbF+SopAoEEaqNMWAU9kmJ5GFIl1MfnfTPuzDlnV
X-Received: by 10.52.188.67 with SMTP id fy3mr2795824vdc.5.1413923824125;
        Tue, 21 Oct 2014 13:37:04 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id k66si593302yho.7.2014.10.21.13.37.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 13:37:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id JX2XGAEZ.1; Tue, 21 Oct 2014 13:37:03 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0BD95E1109; Tue, 21 Oct 2014 13:37:02 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.738.gd04b95a
In-Reply-To: <1413923820-14457-1-git-send-email-sahlberg@google.com>
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

Change-Id: I70cdcdb4341048386133e5b56b08c0b580b24c1b
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/clone.c       | 16 ++++++---
 refs.c                | 89 ++++++++++++++++++++++++++++++++++-----------------
 t/t5516-fetch-push.sh |  2 +-
 3 files changed, 72 insertions(+), 35 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 7f509d0..5052fac 100644
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
index 4eec7e4..b64d0c7 100644
--- a/refs.c
+++ b/refs.c
@@ -2668,36 +2668,15 @@ int repack_without_refs(struct string_list *without, struct strbuf *err)
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
@@ -3759,6 +3738,7 @@ int transaction_commit(struct transaction *transaction,
 		       struct strbuf *err)
 {
 	int ret = 0, i, need_repack = 0;
+	int num_updates = 0;
 	int n = transaction->nr;
 	struct packed_ref_cache *packed_ref_cache;
 	struct ref_update **updates = transaction->updates;
@@ -3792,14 +3772,30 @@ int transaction_commit(struct transaction *transaction,
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
@@ -3811,7 +3807,7 @@ int transaction_commit(struct transaction *transaction,
 		need_repack = 1;
 	}
 	if (need_repack) {
-		packed = get_packed_refs(&ref_cache);;
+		packed = get_packed_refs(&ref_cache);
 		sort_ref_dir(packed);
 		if (commit_packed_refs()){
 			strbuf_addf(err, "unable to overwrite old ref-pack "
@@ -3828,13 +3824,15 @@ int transaction_commit(struct transaction *transaction,
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
@@ -3873,7 +3871,10 @@ int transaction_commit(struct transaction *transaction,
 		update->lock = NULL;
 	}
 
-	/* Acquire all ref locks for updates while verifying old values */
+	/*
+	 * Acquire all ref locks for updates while verifying old values.
+	 * If we are multi-updating then update them in packed refs.
+	 */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
@@ -3896,6 +3897,30 @@ int transaction_commit(struct transaction *transaction,
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
@@ -3944,7 +3969,7 @@ int transaction_commit(struct transaction *transaction,
 
 		if (update->update_type != UPDATE_SHA1)
 			continue;
-		if (!is_null_sha1(update->new_sha1)) {
+		if (update->lock && !is_null_sha1(update->new_sha1)) {
 			if (write_ref_sha1(update->lock, update->new_sha1,
 					   update->msg)) {
 				update->lock = NULL; /* freed by write_ref_sha1 */
@@ -4007,6 +4032,10 @@ int transaction_commit(struct transaction *transaction,
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
