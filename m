From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 03/17] refs.c: use packed refs when deleting refs during a transaction
Date: Mon,  3 Nov 2014 11:02:05 -0800
Message-ID: <1415041339-18450-4-git-send-email-sahlberg@google.com>
References: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:02:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlMtp-0001Xv-VE
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393AbaKCTCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:02:30 -0500
Received: from mail-qg0-f74.google.com ([209.85.192.74]:37525 "EHLO
	mail-qg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbaKCTCY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:02:24 -0500
Received: by mail-qg0-f74.google.com with SMTP id q107so851699qgd.3
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1L6tahwld1ogmM3pR528AD7M8p9J1TkVLkWFE4HllM0=;
        b=PE+mhxIifCLM3wS4CeEgHhsDO81DXR/lAvLmX2Yc0IGKKY6eclYDdekYGXc3Ji5jsX
         qy/4cxqJbu/egTD/mtpNE+R4rouTuw8T1YeZo1d8N+5g4hM8MXfCY2nlAOGl33KbtVUm
         j42FdjUsi+dstbTXBo7l3SgQYT2nyRgb4wdh/CtpGJ9aX70b1JZDgOKU/L/uHG1XWIx4
         F+Av6rn2Q3YgUujAhFQcZn7l5rG4cKPASSZ7d3WhOkegiK47fuN3b+9mOI6c2uX4hsRv
         YZ8m1ZDptUs2P/jK3pNH9rOnwb+7Olmm8Kiv3Tne/uXTpAht/iAIus/dBZkmCqxF9Oev
         y+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1L6tahwld1ogmM3pR528AD7M8p9J1TkVLkWFE4HllM0=;
        b=hbWAatLPFA2TXAr3pBg7GJgFKMJw7KnITN8YDtJUAFSLd84UgEVg5ID1s5Xr+wH6xN
         FJmxf7pSoJJGbTQO2t7NFD/tPJn2Fn7t4iTkN99t6m61iq9Ymx7W8RZUVDJrNUzj+wwS
         b1CfCzvxnKap8pVaRRpFghPKuTmlA7CZsFrpF+cFAoxT+nHscfhEA+iYhKJ9iEWZLQVs
         gnrvAGy2xsSWkMSBQw59dEMOSeAcbNEoOSM8P3/Vpm3Zjs/cwvT42cCmYvzfFpgmz0zu
         umkE8BWjehSNJMvjLxijYG7to4bgCevoN1ZHwVXarNl7hUado+HpUyvb0+xWPi64lsBt
         1yxw==
X-Gm-Message-State: ALoCoQmKhHV9vSnl0dc0ObFO9fpUwGBiJ+4Yms67tb7/yYbTwTxyO4Er+OcUIvndZ4B2TwbLL31H
X-Received: by 10.236.13.105 with SMTP id a69mr27179759yha.16.1415041343491;
        Mon, 03 Nov 2014 11:02:23 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id k66si973041yho.7.2014.11.03.11.02.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:02:23 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id KSAhiK9b.1; Mon, 03 Nov 2014 11:02:23 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9AB6BE0642; Mon,  3 Nov 2014 11:02:22 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/remote.c |  20 ++++++-
 refs.c           | 155 ++++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 138 insertions(+), 37 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 7f28f92..c25420f 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "lockfile.h"
 #include "parse-options.h"
 #include "transport.h"
 #include "remote.h"
@@ -753,6 +754,15 @@ static int remove_branches(struct string_list *branches)
 	const char **branch_names;
 	int i, result = 0;
 
+	if (lock_packed_refs(0)) {
+		struct strbuf err = STRBUF_INIT;
+
+		unable_to_lock_message(git_path("packed-refs"), errno, &err);
+		error("%s", err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
+
 	branch_names = xmalloc(branches->nr * sizeof(*branch_names));
 	for (i = 0; i < branches->nr; i++)
 		branch_names[i] = branches->items[i].string;
@@ -1337,9 +1347,15 @@ static int prune_remote(const char *remote, int dry_run)
 			delete_refs[i] = states.stale.items[i].util;
 		if (!dry_run) {
 			struct strbuf err = STRBUF_INIT;
-			if (repack_without_refs(delete_refs, states.stale.nr,
-						&err))
+
+			if (lock_packed_refs(0)) {
+				unable_to_lock_message(git_path("packed-refs"),
+						       errno, &err);
 				result |= error("%s", err.buf);
+			} else
+				if (repack_without_refs(delete_refs,
+							states.stale.nr, &err))
+					result |= error("%s", err.buf);
 			strbuf_release(&err);
 		}
 		free(delete_refs);
diff --git a/refs.c b/refs.c
index d4ab65c..809bd3f 100644
--- a/refs.c
+++ b/refs.c
@@ -2660,6 +2660,9 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
+/*
+ * Must be called with packed refs already locked (and sorted)
+ */
 int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 {
 	struct ref_dir *packed;
@@ -2674,14 +2677,12 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
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
-		unable_to_lock_message(git_path("packed-refs"), errno, err);
-		return -1;
 	}
+
 	packed = get_packed_refs(&ref_cache);
 
 	/* Remove refnames from the cache */
@@ -3798,10 +3799,12 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 int transaction_commit(struct transaction *transaction,
 		       struct strbuf *err)
 {
-	int ret = 0, delnum = 0, i;
+	int ret = 0, delnum = 0, i, need_repack = 0;
 	const char **delnames;
 	int n = transaction->nr;
+	struct packed_ref_cache *packed_ref_cache;
 	struct ref_update **updates = transaction->updates;
+	struct ref_dir *packed;
 
 	assert(err);
 
@@ -3823,23 +3826,109 @@ int transaction_commit(struct transaction *transaction,
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
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
-		int flags = update->flags;
+		unsigned char sha1[20];
 
 		if (update->update_type != UPDATE_SHA1)
 			continue;
+		if (!is_null_sha1(update->new_sha1))
+			continue;
+		if (get_packed_ref(update->refname))
+			continue;
+		if (!resolve_ref_unsafe(update->refname, RESOLVE_REF_READING,
+					sha1, NULL))
+			continue;
 
-		if (is_null_sha1(update->new_sha1))
-			flags |= REF_DELETING;
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
+		update->flags |= REF_DELETING;
+		update->lock = lock_ref_sha1_basic(update->refname,
+						   (update->have_old ?
+						    update->old_sha1 :
+						    NULL),
+						   NULL,
+						   update->flags,
+						   &update->type);
+		if (!update->lock) {
+			int df_conflict = (errno == ENOTDIR);
+
+			strbuf_addf(err, "Cannot lock the ref '%s'.",
+				    update->refname);
+			ret = df_conflict ?
+			  TRANSACTION_NAME_CONFLICT : 
+			  TRANSACTION_GENERIC_ERROR;
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
+	for (i = 0; i < n; i++) {
+		struct ref_update *update = updates[i];
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
+		if (is_null_sha1(update->new_sha1))
+			continue;
 		update->lock = lock_ref_sha1_basic(update->refname,
 						   (update->have_old ?
 						    update->old_sha1 :
 						    NULL),
 						   NULL,
-						   flags,
+						   update->flags,
 						   &update->type);
 		if (!update->lock) {
 			ret = (errno == ENOTDIR)
@@ -3851,6 +3940,10 @@ int transaction_commit(struct transaction *transaction,
 		}
 	}
 
+	/* delete reflog for all deleted refs */
+	for (i = 0; i < delnum; i++)
+		unlink_or_warn(git_path("logs/%s", delnames[i]));
+
 	/* Lock all reflog files */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
@@ -3862,6 +3955,16 @@ int transaction_commit(struct transaction *transaction,
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
@@ -3877,7 +3980,7 @@ int transaction_commit(struct transaction *transaction,
 		}
 	}
 
-	/* Perform ref updates first so live commits remain referenced */
+	/* Perform ref updates */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
@@ -3896,23 +3999,6 @@ int transaction_commit(struct transaction *transaction,
 		}
 	}
 
-	/* Perform deletes now that updates are safely completed */
-	for (i = 0; i < n; i++) {
-		struct ref_update *update = updates[i];
-
-		if (update->update_type != UPDATE_SHA1)
-			continue;
-		if (update->lock) {
-			if (delete_ref_loose(update->lock, update->type, err)) {
-				ret = TRANSACTION_GENERIC_ERROR;
-				goto cleanup;
-			}
-
-			if (!(update->flags & REF_ISPRUNING))
-				delnames[delnum++] = update->lock->ref_name;
-		}
-	}
-
 	/*
 	 * Update all reflog files
 	 * We have already committed all ref updates and deletes.
@@ -3963,15 +4049,14 @@ int transaction_commit(struct transaction *transaction,
 		}
 	}
 
-	if (repack_without_refs(delnames, delnum, err)) {
+	if (repack_without_refs(delnames, delnum, err))
 		ret = TRANSACTION_GENERIC_ERROR;
-		goto cleanup;
-	}
-	for (i = 0; i < delnum; i++)
-		unlink_or_warn(git_path("logs/%s", delnames[i]));
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
+	packed_ref_cache = get_packed_ref_cache(&ref_cache);
+	if (packed_ref_cache->lock)
+		rollback_packed_refs();
 	transaction->state = TRANSACTION_CLOSED;
 
 	for (i = 0; i < n; i++)
-- 
2.1.0.rc2.206.gedb03e5
