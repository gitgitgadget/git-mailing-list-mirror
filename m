From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 3/4] refs.c: use packed refs when deleting refs during a transaction
Date: Thu,  5 Jun 2014 16:17:13 -0700
Message-ID: <1402010234-7628-4-git-send-email-sahlberg@google.com>
References: <1402010234-7628-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 01:17:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsguW-0003jr-KX
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 01:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbaFEXR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 19:17:26 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:46630 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095AbaFEXRT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 19:17:19 -0400
Received: by mail-qa0-f73.google.com with SMTP id hw13so411742qab.2
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 16:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pJNnMckbqDt+udZJZmkFXvPyTeGOdUp9zj71IcMbe+w=;
        b=Tm92srVrrt0Okbyh5/tudMkIS93y9g+TVj4Oevsj9XaWKY8CJ5SzackK+VqGKYK5EU
         jWN5RXU1kL+/iA3QJLk1tzelAGqxKAK+glBpmlgz2eLSEK9Nx2Zzl893QAB2/ZKBBx4d
         7tEhir8I0Fwwc6H7khuyp3KEoSqOAxj8gec6AMT32YLaumUm90AHO+r4hEQCGujC1tJV
         vHuoxywJzGB0UqaNaI3O501GAco/Tq3CbHXwNOsoKp4FoAK7uqW2rFp5HDPa52TBrnp4
         T5TE3kC7y1+RdTcbJc71KRwmKrQc9JG7lIw0irT0rc8JDkipOHOhujtRB3sFz5DBBAJ9
         Y8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pJNnMckbqDt+udZJZmkFXvPyTeGOdUp9zj71IcMbe+w=;
        b=PtmQlQpyVlLsS6XLvk3DUMR0Fnyz10EDAdpHo0OBd1ySENl+XToE4tditLvVss5JFb
         LRFbdftJvK+4K4Sgpt4DXFIvZWatO242iGYsETTgJOZK+YUwgidsUV/KhXOz+JwubxWN
         8Job5C7TqPjopJnBasFi2mAmWXDw5DvPG+BDiQ1i/oHQYZ8T7X6cFI6nE8EADahMax98
         9T3GIMfObxqgGVnyWM4EJnXvr9jBour5PnEdm8CviKBVL+5zzqPoic2rPe7gV7HDCizU
         7rsQe4JVIE9DxpfRh3VPfeY+EBUmN/t16YF3+wctO2cj4Hz5Zs6qSbsCi41e+tXsAVnh
         KXtA==
X-Gm-Message-State: ALoCoQnAUjhkgmvcWbYpMS3Hnw91VEuuaRPFkjz1xoPU6pBRwTI4NH0qVO2AD9LvJkRgk5/tP3f4
X-Received: by 10.58.218.232 with SMTP id pj8mr681567vec.3.1402010238410;
        Thu, 05 Jun 2014 16:17:18 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id t4si648433yhm.0.2014.06.05.16.17.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jun 2014 16:17:18 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 32BE85A4755;
	Thu,  5 Jun 2014 16:17:18 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C610BE0941; Thu,  5 Jun 2014 16:17:17 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.583.g402232d
In-Reply-To: <1402010234-7628-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250877>

Make the deletion of refs during a transaction more atomic.
Start by first copying all loose refs we will be deleting to the packed
refs file and then commit the packed refs file. Then re-lock the packed refs
file to avoid anyone else from modifying the refs we are to delete during this
transaction and keep it locked until we are finished.
Since all refs we are about to delete are now safely held in the packed refs
file we can proceed to immediately unlink any loose refs for those refs
and still be fully rollback-able.

The exception is for refs that can not be resolved. Those refs are never
added to the packed refs and will just be un-rollback-ably deleted during
commit.

By deleting all the loose refs at the start of the transaction we make make it
possible to both delete one ref and then re-create a different ref in the
same transaction, even if both the old-to-be-deleted and the new-to-be-created
refs would otherwise conflict in the file-system.

Example: rename m->m/m

In that example we want to delete the file 'm' so that we make room so
that we can create a directory with the same name in order to lock and
write to the ref m/m and its lock-file m/m.lock.

If there is a failure during the commit phase we can rollback without losing
any refs since we have so far only deleted the loose refs but we still have
the refs stored in the packed refs file.
Once we have finished all updates for refs and their reflogs we can repack
the packed refs file and remove the to-be-deleted refs from the packed refs,
at which point all the deleted refs will disappear in one atomic rename
operation.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 114 insertions(+), 32 deletions(-)

diff --git a/refs.c b/refs.c
index ab0b629..3692a4d 100644
--- a/refs.c
+++ b/refs.c
@@ -1311,7 +1311,7 @@ static struct ref_entry *get_packed_ref(const char *refname)
 
 /*
  * A loose ref file doesn't exist; check for a packed ref.  The
- * options are forwarded from resolve_safe_unsafe().
+ * options are forwarded from resolve_ref_unsafe().
  */
 static const char *handle_missing_loose_ref(const char *refname,
 					    unsigned char *sha1,
@@ -1367,7 +1367,6 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		}
 
 		git_snpath(path, sizeof(path), "%s", refname);
-
 		/*
 		 * We might have to loop back here to avoid a race
 		 * condition: first we lstat() the file, then we try
@@ -2474,6 +2473,9 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
+/*
+ * Must be called with packed refs already locked (and sorted)
+ */
 static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 {
 	struct ref_dir *packed;
@@ -2486,19 +2488,10 @@ static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 		if (get_packed_ref(refnames[i]))
 			break;
 
-	/* Avoid locking if we have nothing to do */
+	/* Avoid processing if we have nothing to do */
 	if (i == n)
 		return 0; /* no refname exists in packed refs */
 
-	if (lock_packed_refs(0)) {
-		if (err) {
-			unable_to_lock_message(git_path("packed-refs"), errno,
-					       err);
-			return -1;
-		}
-		unable_to_lock_error(git_path("packed-refs"), errno);
-		return error("cannot delete '%s' from packed refs", refnames[i]);
-	}
 	packed = get_packed_refs(&ref_cache);
 
 	/* Remove refnames from the cache */
@@ -3632,10 +3625,12 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
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
@@ -3655,12 +3650,100 @@ int transaction_commit(struct ref_transaction *transaction,
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
@@ -3679,9 +3762,14 @@ int transaction_commit(struct ref_transaction *transaction,
 		}
 	}
 
+	/* delete reflog for all deleted refs */
+	for (i = 0; i < delnum; i++)
+		unlink_or_warn(git_path("logs/%s", delnames[i]));
+
 	/* Lock all reflog files */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
+		char log_file[PATH_MAX];
 
 		if (update->update_type != UPDATE_LOG)
 			continue;
@@ -3690,6 +3778,14 @@ int transaction_commit(struct ref_transaction *transaction,
 			update->reflog_lock = update->orig_update->reflog_lock;
 			continue;
 		}
+		if (log_ref_setup(update->refname, log_file,
+				  sizeof(log_file))) {
+			ret = -1;
+			if (err)
+				strbuf_addf(err, "Failed to setup reflog for "
+					    "%s", update->refname);
+			goto cleanup;
+		}
 		update->reflog_fd = hold_lock_file_for_append(
 					update->reflog_lock,
 					git_path("logs/%s", update->refname),
@@ -3705,7 +3801,7 @@ int transaction_commit(struct ref_transaction *transaction,
 		}
 	}
 
-	/* Perform ref updates first so live commits remain referenced */
+	/* Perform ref updates */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
@@ -3726,21 +3822,6 @@ int transaction_commit(struct ref_transaction *transaction,
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
@@ -3793,11 +3874,12 @@ int transaction_commit(struct ref_transaction *transaction,
 
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
2.0.0.583.g402232d
