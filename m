From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 22/33] refs: resolve symbolic refs first
Date: Mon, 29 Feb 2016 19:52:55 -0500
Message-ID: <1456793586-22082-23-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:54:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYZb-00078C-Pw
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463AbcCAAxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:53:54 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33734 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbcCAAxx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:53 -0500
Received: by mail-qg0-f48.google.com with SMTP id d32so74639391qgd.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r5FNiocjPzINFCoIlexzSGHiDcj38l0LWNmCFCQtHSU=;
        b=w4fHtUBG0198dGccBYOpzlocSLjsLF+7a9jqPDkgQKM3P5jB+GfNrQ2i1d53MhVUSJ
         L6HrCV4C84fsj0RN4BX6vsgeiLsJ1Y/gXmx/PcVUd5Fhkvapg+qdRH0nn5kfzikpweyq
         Ye8ycJh0GlsmzyRDa33rezfCAs3dlhhRzawHKCfRZhCtnfr90tVum37JcWuZuI2dTXtv
         I2a+rb1NSzKrO5aea45WaBOK+7PHFGkjQu8/ZOIkvoAQQIMKJBz93Y9Utj4BD7keVP0M
         p3ku1mIhLSwRspmQC5aWKTWmmQG6VsicztkDr6UcNo6vbnvUZkfIcz/Oo2LNzq1Z3MAz
         VGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r5FNiocjPzINFCoIlexzSGHiDcj38l0LWNmCFCQtHSU=;
        b=Mxojl8YjmBLeTKAjNJG2E3tiaM3wrf5diowFquPy+luX/FYYP2uspFumJAquO9XlWI
         VvpgViRAP8hC3gYTBzhNNYHtaC5P++9AtTSRP27n2t9FDat72E67Ytu8ovlqxs92jE/r
         tYJNvb2vfycq0O1HnxiWreFG3yEgX9TQVdHupyPebzS/b5O5txZPtBG+2EU8ACasUwIk
         RUFZeDuNMOWmAxZeBMnp1AqkJIoEyLWThgBiGZpxT6fCoh6KIak2EiWJdkVH8YHP3fxz
         p5kc0sEtMd/pn3pxLs8RZC17Do9+fNUeARvIrJfDZJv1g9qpGe76JE65vWRzszpXyOFt
         7yAA==
X-Gm-Message-State: AD7BkJJ0LIwfpQkkQ5ngP0QgsNb0f6u2Ibf5yH7xJiP2sEkc2nh9EiddYym4jRaWKnhKug==
X-Received: by 10.140.96.84 with SMTP id j78mr22408390qge.93.1456793632180;
        Mon, 29 Feb 2016 16:53:52 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:51 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287958>

Before committing ref updates, split symbolic ref updates into two
parts: an update to the underlying ref, and a log-only update to the
symbolic ref.  This ensures that both references are locked correctly
while their reflogs are updated.

It is still possible to confuse git by concurrent updates, since the
splitting of symbolic refs does not happen under lock. So a symbolic ref
could be replaced by a plain ref in the middle of this operation, which
would lead to reflog discontinuities and missed old-ref checks.

All callers to lock_ref_sha1_basic outside of ref_transaction_commit
now set REF_NODEREF.  And ref_transaction_commit only happens on
already-derefernced refs.  So we can assume REF_NODEREF when resolving
inside this function.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               |  69 ++++++++++++++++++++++++++
 refs/files-backend.c | 137 ++++++++++++++++++++++++++-------------------------
 refs/refs-internal.h |   8 +++
 3 files changed, 148 insertions(+), 66 deletions(-)

diff --git a/refs.c b/refs.c
index 9f695cd..eee8c37 100644
--- a/refs.c
+++ b/refs.c
@@ -1354,6 +1354,71 @@ int refs_init_db(int shared, struct strbuf *err)
 	return the_refs_backend->init_db(shared, err);
 }
 
+/*
+ * Special case for symbolic refs when REF_NODEREF is not turned on.
+ * Dereference them here, mark them REF_LOG_ONLY, and add an update
+ * for the underlying ref.
+ */
+static int dereference_symrefs(struct ref_transaction *transaction,
+			       struct strbuf *err)
+{
+	int i;
+	int nr = transaction->nr;
+
+	for (i = 0; i < nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+		const char *resolved;
+		unsigned char sha1[20];
+		int resolve_flags = 0;
+		int mustexist = update->flags & REF_HAVE_OLD &&
+			!is_null_sha1(update->old_sha1);
+		int deleting = (update->flags & REF_HAVE_NEW) &&
+			is_null_sha1(update->new_sha1);
+
+		if (mustexist)
+			resolve_flags |= RESOLVE_REF_READING;
+		if (deleting)
+			resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME |
+				RESOLVE_REF_NO_RECURSE;
+
+		if (strcmp(update->refname, "HEAD"))
+			update->flags |= REF_IS_NOT_HEAD;
+
+		resolved = resolve_ref_unsafe(update->refname, resolve_flags,
+					      sha1, &update->type);
+		if (!resolved) {
+			/*
+			 * We may notice this breakage later and die
+			 * with a sensible error message
+			 */
+			update->type |= REF_ISBROKEN;
+			continue;
+		}
+
+		hashcpy(update->read_sha1, sha1);
+
+		if (update->flags & REF_NODEREF ||
+		    !(update->type & REF_ISSYMREF))
+			continue;
+
+		/* Create a new transaction for the underlying ref */
+		if (ref_transaction_update(transaction,
+					   resolved,
+					   update->new_sha1,
+					   (update->flags & REF_HAVE_OLD) ?
+					   update->old_sha1 : NULL,
+					   update->flags & ~REF_IS_NOT_HEAD,
+					   update->msg, err))
+			return -1;
+
+		/* Make the symbolic ref update non-recursive */
+		update->flags |= REF_LOG_ONLY | REF_NODEREF;
+		update->flags &= ~REF_HAVE_OLD;
+	}
+
+	return 0;
+}
+
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
@@ -1370,6 +1435,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		return 0;
 	}
 
+	ret = dereference_symrefs(transaction, err);
+	if (ret)
+		goto done;
+
 	if (get_affected_refnames(transaction, &affected_refnames, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto done;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1f36dde..7ccaf88 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -7,7 +7,6 @@
 
 struct ref_lock {
 	char *ref_name;
-	char *orig_ref_name;
 	struct lock_file *lk;
 	struct object_id old_oid;
 };
@@ -1715,7 +1714,6 @@ static void unlock_ref(struct ref_lock *lock)
 	if (lock->lk)
 		rollback_lock_file(lock->lk);
 	free(lock->ref_name);
-	free(lock->orig_ref_name);
 	free(lock);
 }
 
@@ -1771,6 +1769,7 @@ static int remove_empty_directories(struct strbuf *path)
  */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
+					    const unsigned char *read_sha1,
 					    const struct string_list *extras,
 					    const struct string_list *skip,
 					    unsigned int flags, int *type_p,
@@ -1778,14 +1777,14 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 {
 	struct strbuf ref_file = STRBUF_INIT;
 	struct strbuf orig_ref_file = STRBUF_INIT;
-	const char *orig_refname = refname;
 	struct ref_lock *lock;
 	int last_errno = 0;
 	int type;
 	int lflags = 0;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
-	int resolve_flags = 0;
+	int resolve_flags = RESOLVE_REF_NO_RECURSE;
 	int attempts_remaining = 3;
+	int resolved;
 
 	assert(err);
 
@@ -1795,65 +1794,65 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		resolve_flags |= RESOLVE_REF_READING;
 	if (flags & REF_DELETING)
 		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
-	if (flags & REF_NODEREF) {
-		resolve_flags |= RESOLVE_REF_NO_RECURSE;
+	if (flags & REF_NODEREF)
 		lflags |= LOCK_NO_DEREF;
-	}
 
-	refname = resolve_ref_unsafe(refname, resolve_flags,
-				     lock->old_oid.hash, &type);
-	if (!refname && errno == EISDIR) {
-		/*
-		 * we are trying to lock foo but we used to
-		 * have foo/bar which now does not exist;
-		 * it is normal for the empty directory 'foo'
-		 * to remain.
-		 */
-		strbuf_git_path(&orig_ref_file, "%s", orig_refname);
-		if (remove_empty_directories(&orig_ref_file)) {
+	if (type_p && *type_p & REF_ISSYMREF) {
+		hashcpy(lock->old_oid.hash, read_sha1);
+	} else {
+		resolved = !!resolve_ref_unsafe(refname, resolve_flags,
+						lock->old_oid.hash, &type);
+		if (!resolved && errno == EISDIR) {
+			/*
+			 * we are trying to lock foo but we used to
+			 * have foo/bar which now does not exist;
+			 * it is normal for the empty directory 'foo'
+			 * to remain.
+			 */
+			strbuf_git_path(&orig_ref_file, "%s", refname);
+			if (remove_empty_directories(&orig_ref_file)) {
+				struct ref_dir *loose_refs;
+				loose_refs = get_loose_refs(&ref_cache);
+				last_errno = errno;
+				if (!verify_refname_available_dir(refname, extras, skip,
+								  loose_refs, err))
+					strbuf_addf(err, "there are still refs under '%s'",
+						    refname);
+				goto error_return;
+			}
+			resolved = !!resolve_ref_unsafe(refname, resolve_flags,
+							lock->old_oid.hash, &type);
+		}
+
+		if (type_p)
+			*type_p = type;
+		if (!resolved) {
 			last_errno = errno;
-			if (!verify_refname_available_dir(orig_refname, extras, skip,
+			if (last_errno != ENOTDIR ||
+			    !verify_refname_available_dir(refname, extras, skip,
 							  get_loose_refs(&ref_cache), err))
-				strbuf_addf(err, "there are still refs under '%s'",
-					    orig_refname);
+				strbuf_addf(err,
+					    "unable to resolve reference %s: %s",
+					    refname, strerror(last_errno));
+
+			goto error_return;
+		}
+		/*
+		 * If the ref did not exist and we are creating it, make sure
+		 * there is no existing packed ref whose name begins with our
+		 * refname, nor a packed ref whose name is a proper prefix of
+		 * our refname.
+		 */
+		if (is_null_oid(&lock->old_oid) &&
+		    verify_refname_available_dir(refname, extras, skip,
+						 get_packed_refs(&ref_cache), err)) {
+			last_errno = ENOTDIR;
 			goto error_return;
 		}
-		refname = resolve_ref_unsafe(orig_refname, resolve_flags,
-					     lock->old_oid.hash, &type);
-	}
-	if (type_p)
-	    *type_p = type;
-	if (!refname) {
-		last_errno = errno;
-		if (last_errno != ENOTDIR ||
-		    !verify_refname_available_dir(orig_refname, extras, skip,
-						  get_loose_refs(&ref_cache), err))
-			strbuf_addf(err, "unable to resolve reference %s: %s",
-				    orig_refname, strerror(last_errno));
-
-		goto error_return;
-	}
-
-	if (flags & REF_NODEREF)
-		refname = orig_refname;
-
-	/*
-	 * If the ref did not exist and we are creating it, make sure
-	 * there is no existing packed ref whose name begins with our
-	 * refname, nor a packed ref whose name is a proper prefix of
-	 * our refname.
-	 */
-	if (is_null_oid(&lock->old_oid) &&
-	    verify_refname_available_dir(refname, extras, skip,
-					 get_packed_refs(&ref_cache), err)) {
-		last_errno = ENOTDIR;
-		goto error_return;
 	}
-
 	lock->lk = xcalloc(1, sizeof(struct lock_file));
 
 	lock->ref_name = xstrdup(refname);
-	lock->orig_ref_name = xstrdup(orig_refname);
 	strbuf_git_path(&ref_file, "%s", refname);
 
  retry:
@@ -1885,7 +1884,13 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			goto error_return;
 		}
 	}
-	if (verify_lock(lock, old_sha1, mustexist, err)) {
+
+	if (type_p && *type_p & REF_ISSYMREF && !(*type_p & REF_ISBROKEN)) {
+		/*
+		 * Old hash verification for symrefs happens on their
+		 * base ref.
+		 */
+	} else if (verify_lock(lock, old_sha1, mustexist, err)) {
 		last_errno = errno;
 		goto error_return;
 	}
@@ -2419,8 +2424,8 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, REF_NODEREF,
-				   NULL, &err);
+	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, NULL,
+				   REF_NODEREF, NULL, &err);
 	if (!lock) {
 		error("unable to rename '%s' to '%s': %s", oldrefname, newrefname, err.buf);
 		strbuf_release(&err);
@@ -2438,8 +2443,9 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, NULL, REF_NODEREF,
-				   NULL, &err);
+	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, NULL, NULL,
+				   REF_NODEREF, NULL, &err);
+
 	if (!lock) {
 		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -2667,9 +2673,7 @@ static int commit_ref_update(struct ref_lock *lock,
 			     int flags, struct strbuf *err)
 {
 	clear_loose_ref_cache(&ref_cache);
-	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, flags, err) < 0 ||
-	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
-	     log_ref_write(lock->orig_ref_name, lock->old_oid.hash, sha1, logmsg, flags, err) < 0)) {
+	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, flags, err) < 0) {
 		char *old_msg = strbuf_detach(err, NULL);
 		strbuf_addf(err, "Cannot update the ref '%s': %s",
 			    lock->ref_name, old_msg);
@@ -2677,7 +2681,7 @@ static int commit_ref_update(struct ref_lock *lock,
 		unlock_ref(lock);
 		return -1;
 	}
-	if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
+	if (flags & REF_IS_NOT_HEAD) {
 		/*
 		 * Special hack: If a branch is updated directly and HEAD
 		 * points to it (may happen on the remote side of a push
@@ -2772,8 +2776,8 @@ static int files_create_symref(const char *refname,
 	struct ref_lock *lock;
 	int ret;
 
-	lock = lock_ref_sha1_basic(refname, NULL, NULL, NULL, REF_NODEREF, NULL,
-				   &err);
+	lock = lock_ref_sha1_basic(refname, NULL, NULL, NULL, NULL, REF_NODEREF,
+				   NULL, &err);
 	if (!lock) {
 		error("%s", err.buf);
 		strbuf_release(&err);
@@ -3041,6 +3045,7 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				update->refname,
 				((update->flags & REF_HAVE_OLD) ?
 				 update->old_sha1 : NULL),
+				update->read_sha1,
 				affected_refnames, NULL,
 				update->flags,
 				&update->type,
@@ -3287,7 +3292,7 @@ static int files_reflog_expire(const char *refname, const unsigned char *sha1,
 	struct ref_lock *lock;
 	char *log_file;
 	int status = 0;
-	int type;
+	int type = 0;
 	struct strbuf err = STRBUF_INIT;
 
 	memset(&cb, 0, sizeof(cb));
@@ -3300,7 +3305,7 @@ static int files_reflog_expire(const char *refname, const unsigned char *sha1,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_sha1_basic(refname, sha1, NULL, NULL, REF_NODEREF,
+	lock = lock_ref_sha1_basic(refname, sha1, NULL, NULL, NULL, REF_NODEREF,
 				   &type, &err);
 	if (!lock) {
 		error("cannot lock ref '%s': %s", refname, err.buf);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index dd76246..0d3f9e7 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -49,6 +49,8 @@
  */
 #define REF_LOG_ONLY 0x80
 
+#define REF_IS_NOT_HEAD 0x100
+
 /*
  * Return true iff refname is minimally safe. "Safe" here means that
  * deleting a loose reference by this name will not do any damage, for
@@ -147,6 +149,12 @@ struct ref_update {
 	 */
 	unsigned char old_sha1[20];
 	/*
+	 * During the symbolic ref split stage, we resolve refs.
+	 * We'll re-resolve non-symbolic refs once they are locked,
+	 * but we store this to avoid re-resolving symbolic refs.
+	 */
+	unsigned char read_sha1[20];
+	/*
 	 * One or more of REF_HAVE_NEW, REF_HAVE_OLD, REF_NODEREF,
 	 * REF_DELETING, and REF_ISPRUNING:
 	 */
-- 
2.4.2.767.g62658d5-twtrsrc
