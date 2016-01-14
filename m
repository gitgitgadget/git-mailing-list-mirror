From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 13/20] refs: resolve symbolic refs first
Date: Thu, 14 Jan 2016 11:26:10 -0500
Message-ID: <1452788777-24954-14-git-send-email-dturner@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 14 17:27:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJkjq-0002SK-Jg
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755731AbcANQ0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:26:49 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34491 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755713AbcANQ0r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:26:47 -0500
Received: by mail-qk0-f179.google.com with SMTP id x1so27647529qkc.1
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 08:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8q7QcWpVcja06CqnvowbXSB5Uie+a5VcY9UPeQ9YzJg=;
        b=RDKy4k6+ag75o5iHvv7jIVxA2ISc1Goc0vAtkejvx4em1pUsqbcgRpIZ/9yvtrK8JW
         O+TA2fW2555nTit6z7lk8wWfyaSvohZ3cdDCioiLkKpOpCSdCr0pu4kAK/1gMganVIq7
         H3KBKAD84Huq1Hsa4a9Goyf/+sgrfaBKSqdvRs9GlL5iXCYbUz01ph8UaEJjDg/fUH3c
         YsWUPBTnd4C2VjczHoOyihscFl7qDHn5A+LQ6LCrrVWgFm1b0Qiy7ACQglFDtsF7IqW/
         b2n5LcqxCVpo11e7zdDHA532N1M8abU4yAR4OjFJS/sj0yPUVREyshQxlRhW76iRZWHQ
         OZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8q7QcWpVcja06CqnvowbXSB5Uie+a5VcY9UPeQ9YzJg=;
        b=D6aZyx8F6kCFF5EQXSk9gbFx6umbgWcUXUSL0c1uafCYkClnOBN+b7JglDW4qSaR4R
         gmJCYfJeYNd6uPWbk49Whw3KKXHKki3kPb8sBQdkrUPoijroF+Wr+up5CGxP7V2yNHa7
         rNi1xve6q/ac7Mi1cbRuMk6cQIfKXcUAJIgwMhzCGtvlINyeU7Uhhi4ker/38n8ZZZMZ
         Dh4ihWMbqGsnXupKzIj94OWH8hj0HhS4oGRwE8+dkxd2pyV5vWaY5qVNv82jCyLaxY26
         dLReuWkA/pktqEHW/dR4me0vn6CLCcBtjoixiEUwIp3nFSBUUNrsz8jihcu5iLWRAZEp
         nqJQ==
X-Gm-Message-State: ALoCoQmPdjI+MfKI554zI6msjdwNbWg1aJLQcCVwM68KolrY7W64mnFXaoolwYzayAT6Q1T/if/ihT29RZSn6WH9cowPEahSkQ==
X-Received: by 10.55.78.207 with SMTP id c198mr6694707qkb.34.1452788805835;
        Thu, 14 Jan 2016 08:26:45 -0800 (PST)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b95sm2724213qge.47.2016.01.14.08.26.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 08:26:45 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284043>

Before committing ref updates, split symbolic ref updates into two
parts: an update to the underlying ref, and a log-only update to the
symbolic ref.  This ensures that both references are locked correctly
while their reflogs are updated.

It is still possible to confuse git by concurrent updates, since the
splitting of symbolic refs does not happen under lock. So a symbolic ref
could be replaced by a plain ref in the middle of this operation, which
would lead to reflog discontinuities and missed old-ref checks.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               |  69 +++++++++++++++++++++++++++
 refs/files-backend.c | 132 ++++++++++++++++++++++++++-------------------------
 refs/refs-internal.h |   8 ++++
 3 files changed, 145 insertions(+), 64 deletions(-)

diff --git a/refs.c b/refs.c
index d9cdacf..11cd5d2 100644
--- a/refs.c
+++ b/refs.c
@@ -1141,6 +1141,71 @@ int refs_init_db(struct strbuf *err, int shared)
 	return the_refs_backend->init_db(err, shared);
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
+		int mustexist = (update->old_sha1 &&
+				 !is_null_sha1(update->old_sha1));
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
@@ -1157,6 +1222,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
index 3a61d1e..3b9061e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -7,7 +7,6 @@
 
 struct ref_lock {
 	char *ref_name;
-	char *orig_ref_name;
 	struct lock_file *lk;
 	struct object_id old_oid;
 };
@@ -1839,7 +1838,6 @@ static void unlock_ref(struct ref_lock *lock)
 	if (lock->lk)
 		rollback_lock_file(lock->lk);
 	free(lock->ref_name);
-	free(lock->orig_ref_name);
 	free(lock);
 }
 
@@ -1895,6 +1893,7 @@ static int remove_empty_directories(struct strbuf *path)
  */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
+					    const unsigned char *read_sha1,
 					    const struct string_list *extras,
 					    const struct string_list *skip,
 					    unsigned int flags, int *type_p,
@@ -1902,14 +1901,14 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
 
@@ -1919,65 +1918,65 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
@@ -2009,7 +2008,13 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
@@ -2543,7 +2548,7 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, 0, NULL, &err);
+	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, NULL, 0, NULL, &err);
 	if (!lock) {
 		error("unable to rename '%s' to '%s': %s", oldrefname, newrefname, err.buf);
 		strbuf_release(&err);
@@ -2561,7 +2566,7 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, NULL, 0, NULL, &err);
+	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, NULL, NULL, 0, NULL, &err);
 	if (!lock) {
 		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -2789,9 +2794,7 @@ static int commit_ref_update(struct ref_lock *lock,
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
@@ -2799,7 +2802,7 @@ static int commit_ref_update(struct ref_lock *lock,
 		unlock_ref(lock);
 		return -1;
 	}
-	if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
+	if (flags & REF_IS_NOT_HEAD) {
 		/*
 		 * Special hack: If a branch is updated directly and HEAD
 		 * points to it (may happen on the remote side of a push
@@ -2894,8 +2897,8 @@ static int files_create_symref(const char *refname,
 	struct ref_lock *lock;
 	int ret;
 
-	lock = lock_ref_sha1_basic(refname, NULL, NULL, NULL, REF_NODEREF, NULL,
-				   &err);
+	lock = lock_ref_sha1_basic(refname, NULL, NULL, NULL, NULL, REF_NODEREF,
+				   NULL, &err);
 	if (!lock) {
 		error("%s", err.buf);
 		strbuf_release(&err);
@@ -3163,6 +3166,7 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				update->refname,
 				((update->flags & REF_HAVE_OLD) ?
 				 update->old_sha1 : NULL),
+				update->read_sha1,
 				affected_refnames, NULL,
 				update->flags,
 				&update->type,
@@ -3409,7 +3413,7 @@ static int files_reflog_expire(const char *refname, const unsigned char *sha1,
 	struct ref_lock *lock;
 	char *log_file;
 	int status = 0;
-	int type;
+	int type = 0;
 	struct strbuf err = STRBUF_INIT;
 
 	memset(&cb, 0, sizeof(cb));
@@ -3422,7 +3426,7 @@ static int files_reflog_expire(const char *refname, const unsigned char *sha1,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_sha1_basic(refname, sha1, NULL, NULL, 0, &type, &err);
+	lock = lock_ref_sha1_basic(refname, sha1, NULL, NULL, NULL, 0, &type, &err);
 	if (!lock) {
 		error("cannot lock ref '%s': %s", refname, err.buf);
 		strbuf_release(&err);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index e8b1865..ed6fb22 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -44,6 +44,8 @@
 
 #define REF_LOG_ONLY 0x80
 
+#define REF_IS_NOT_HEAD 0x100
+
 /*
  * Return true iff refname is minimally safe. "Safe" here means that
  * deleting a loose reference by this name will not do any damage, for
@@ -159,6 +161,12 @@ struct ref_update {
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
2.4.2.749.g730654d-twtrsrc
