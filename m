From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 18/27] refs: resolve symbolic refs first
Date: Thu, 18 Feb 2016 00:17:41 -0500
Message-ID: <1455772670-21142-19-git-send-email-dturner@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 18 06:19:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWH0F-00022q-Ll
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 06:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424946AbcBRFS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 00:18:59 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35219 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424900AbcBRFSw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 00:18:52 -0500
Received: by mail-qg0-f43.google.com with SMTP id y89so29372117qge.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 21:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=35iiLmOort4UVlJ9akQBRlku5Ad2HzTlHfpl8l7ny3M=;
        b=q7DdjsJLpHpecSe6K8sS4O37xdCW1zDqaoF6XO/xA7nOftGRpq29Q5834ByP6EMLoq
         ZYMuIc1qpVTD4G/VNpJAO1jjeHKAnhpIOtMH7bdnpvuVB5HQwO0/aX1hbIJrR3fcBFuh
         NwvfvNGOhR84ZU7rWOGAHESRADcL8o0VlQ10m0lOqQJ/bgw3rvYgDk6LO9vLbBl079WE
         6/g7g4M8DKx+F168m9pjD3pUND7OG011luSK0deVgGKwHaAK0f5oeh61GlpPO8LqZXet
         7h4vImoRQq1zNt7fqxPXPqi5qcof5PTGpPjQIiSvuVZp5PRh/aD7yjW4qmEqJ8VLI+6M
         rJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=35iiLmOort4UVlJ9akQBRlku5Ad2HzTlHfpl8l7ny3M=;
        b=lLCXi3MiP0rH4wMAdj08PsE1UwFPvMlnndxLenAyAiOKMKCF2eHVsk87hWUS5fpyIE
         LKYcqeh2Ido5D9Df/siRs0ZNND6zNuPj5PFPUX5Lj33F2nBKejeNZbD0kQk7T1n9P3b3
         Jp0Eg4QEhAKXwuzltV1t7rXFRm83fcYRrqcu9Aq7SHftZcyzQ8YedtRxT/dyqWKZuY94
         YlLwvwCz76xLBu+OpOW6gNMWMIvo2GZFWlnK3ToZpjQsBbnDNI+GWoW0huhiWwja+dAo
         4pi3NIH52d6nuIIwUukvO/xYh7WA2zTtcLgpwZnDYbN+Yb4ZB6C5keyT6yX9+CeUVK2n
         0OSA==
X-Gm-Message-State: AG10YORfoJ4ujp0Y+x34kHpO1wGU4WE5w1FkEb3xagFrboOkIgU6AiARScApWozwLKROUA==
X-Received: by 10.140.171.215 with SMTP id r206mr7175870qhr.51.1455772731845;
        Wed, 17 Feb 2016 21:18:51 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id q22sm1965322qkl.19.2016.02.17.21.18.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 21:18:51 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286590>

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
---
 refs.c               |  69 ++++++++++++++++++++++++++
 refs/files-backend.c | 137 ++++++++++++++++++++++++++-------------------------
 refs/refs-internal.h |   8 +++
 3 files changed, 148 insertions(+), 66 deletions(-)

diff --git a/refs.c b/refs.c
index c9fa34d..01cf6c3 100644
--- a/refs.c
+++ b/refs.c
@@ -1227,6 +1227,71 @@ int refs_init_db(int shared, struct strbuf *err)
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
@@ -1243,6 +1308,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
index 42f2d5b..b3cca8e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -7,7 +7,6 @@
 
 struct ref_lock {
 	char *ref_name;
-	char *orig_ref_name;
 	struct lock_file *lk;
 	struct object_id old_oid;
 };
@@ -1779,7 +1778,6 @@ static void unlock_ref(struct ref_lock *lock)
 	if (lock->lk)
 		rollback_lock_file(lock->lk);
 	free(lock->ref_name);
-	free(lock->orig_ref_name);
 	free(lock);
 }
 
@@ -1835,6 +1833,7 @@ static int remove_empty_directories(struct strbuf *path)
  */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
+					    const unsigned char *read_sha1,
 					    const struct string_list *extras,
 					    const struct string_list *skip,
 					    unsigned int flags, int *type_p,
@@ -1842,14 +1841,14 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
 
@@ -1859,65 +1858,65 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
@@ -1949,7 +1948,13 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
@@ -2484,8 +2489,8 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, REF_NODEREF,
-				   NULL, &err);
+	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, NULL,
+				   REF_NODEREF, NULL, &err);
 	if (!lock) {
 		error("unable to rename '%s' to '%s': %s", oldrefname, newrefname, err.buf);
 		strbuf_release(&err);
@@ -2503,8 +2508,9 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
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
@@ -2732,9 +2738,7 @@ static int commit_ref_update(struct ref_lock *lock,
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
@@ -2742,7 +2746,7 @@ static int commit_ref_update(struct ref_lock *lock,
 		unlock_ref(lock);
 		return -1;
 	}
-	if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
+	if (flags & REF_IS_NOT_HEAD) {
 		/*
 		 * Special hack: If a branch is updated directly and HEAD
 		 * points to it (may happen on the remote side of a push
@@ -2837,8 +2841,8 @@ static int files_create_symref(const char *refname,
 	struct ref_lock *lock;
 	int ret;
 
-	lock = lock_ref_sha1_basic(refname, NULL, NULL, NULL, REF_NODEREF, NULL,
-				   &err);
+	lock = lock_ref_sha1_basic(refname, NULL, NULL, NULL, NULL, REF_NODEREF,
+				   NULL, &err);
 	if (!lock) {
 		error("%s", err.buf);
 		strbuf_release(&err);
@@ -3106,6 +3110,7 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				update->refname,
 				((update->flags & REF_HAVE_OLD) ?
 				 update->old_sha1 : NULL),
+				update->read_sha1,
 				affected_refnames, NULL,
 				update->flags,
 				&update->type,
@@ -3352,7 +3357,7 @@ static int files_reflog_expire(const char *refname, const unsigned char *sha1,
 	struct ref_lock *lock;
 	char *log_file;
 	int status = 0;
-	int type;
+	int type = 0;
 	struct strbuf err = STRBUF_INIT;
 
 	memset(&cb, 0, sizeof(cb));
@@ -3365,7 +3370,7 @@ static int files_reflog_expire(const char *refname, const unsigned char *sha1,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_sha1_basic(refname, sha1, NULL, NULL, REF_NODEREF,
+	lock = lock_ref_sha1_basic(refname, sha1, NULL, NULL, NULL, REF_NODEREF,
 				   &type, &err);
 	if (!lock) {
 		error("cannot lock ref '%s': %s", refname, err.buf);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 283f71f..0337d2e 100644
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
