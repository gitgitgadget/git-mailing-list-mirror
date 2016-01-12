From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 13/21] refs: resolve symbolic refs first
Date: Mon, 11 Jan 2016 20:22:12 -0500
Message-ID: <1452561740-8668-14-git-send-email-dturner@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jan 12 02:23:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIngE-0003dS-KT
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 02:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761706AbcALBXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 20:23:23 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33956 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761133AbcALBWq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 20:22:46 -0500
Received: by mail-qk0-f174.google.com with SMTP id t64so492900qke.1
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 17:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uH1uQDGAukuEBz0f6gP1ldV+sn9u1KAdIVYrpO/Tv80=;
        b=mPoKfZYE1aYTlVwpbdoqHjiVjblY4MSO9rKXlcq7UKpHc+yqBtdKe4G+Kg0E1nO//c
         h8eUFw7Bj2P6kflbgtTMz8jX0JXrG/lLYCJhHiG73w2QEs5RZqFLGS6JVdsaDYGMhgI8
         zVYBQOPVLAQXgg/RXeWNSGD+xzeeeOvZg/Ah+C8gfVdHxFHs7f9X29CUyae9JsYUMTaf
         wtNoXNOGF67q1FXLOein/Ky19niDj2bXURUEzOf6MsipdEzFcQYpW23T0LByZ6D80q24
         p/RtscTJctJTTjRlnABdw3ZussynJJSLMbm+vbkPtwYll05IPyLjs1kCU7wq4NsbOqzU
         jgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uH1uQDGAukuEBz0f6gP1ldV+sn9u1KAdIVYrpO/Tv80=;
        b=CAALSM/8LJ8lxCH457jqngUV5P3ul6XOSUfcZmyIlB+ygDXiG7acOBi5p9YGew1gsJ
         T4F4DaGlARdbEh45o7sZhVVU2FlFeSSAnNUGeEAjmPLu6boAxR7EGjARUEu9YkPCu51K
         3wEwMAA8pJA/8sIH5KG17SJF2mdqRZ5x8WbVki3m+MVug2GpB2M7pyPNR9t8iTFXSBZu
         EoGWAItFR+N7378DQY2Vk5zqrFXUKP2DWXb2+bKT4eyyVlBuXKUKqfziItofD/05+bDr
         D3t8r/SSGT0B5BMwh9Y8TAHWGFy1gLU6W40XdTZmksTFusumjf4R0xJGll7EeSFBDFDd
         xEnQ==
X-Gm-Message-State: ALoCoQnVrv+vNxX9xi7RRDGee6S5/RJtIhuPjJSs4LRXTDFORiWWhOg0NLa8anVI6JBq1S42z/tm3l8DzeK2t9USkps6ustTyw==
X-Received: by 10.55.26.215 with SMTP id l84mr20163127qkh.101.1452561766086;
        Mon, 11 Jan 2016 17:22:46 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id d64sm55362053qgd.48.2016.01.11.17.22.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jan 2016 17:22:45 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283755>

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
 refs.c               |  71 +++++++++++++++++++++++++++++
 refs/files-backend.c | 123 +++++++++++++++++++++++++--------------------------
 refs/refs-internal.h |   8 ++++
 3 files changed, 140 insertions(+), 62 deletions(-)

diff --git a/refs.c b/refs.c
index 87bb1bb..1b17c15 100644
--- a/refs.c
+++ b/refs.c
@@ -1125,6 +1125,73 @@ int refs_init_db(struct strbuf *err, int shared)
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
+		struct ref_update *new_update;
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
+			 * We'll try again to resolve this during
+			 * commit and give a better error message
+			 * then, but we know it's not a symbolic ref
+			 * (or, indeed, any sort of ref).
+			 */
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
@@ -1141,6 +1208,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
index 37c26d9..1886a3f 100644
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
 
@@ -1890,6 +1888,7 @@ static int remove_empty_directories(struct strbuf *path)
  */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
+					    const unsigned char *read_sha1,
 					    const struct string_list *extras,
 					    const struct string_list *skip,
 					    unsigned int flags, int *type_p,
@@ -1897,13 +1896,13 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 {
 	struct strbuf ref_file = STRBUF_INIT;
 	struct strbuf orig_ref_file = STRBUF_INIT;
-	const char *orig_refname = refname;
 	struct ref_lock *lock;
 	int last_errno = 0;
 	int type, lflags;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
-	int resolve_flags = 0;
+	int resolve_flags = RESOLVE_REF_NO_RECURSE;
 	int attempts_remaining = 3;
+	int resolved;
 
 	assert(err);
 
@@ -1911,67 +1910,68 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
 	if (mustexist)
 		resolve_flags |= RESOLVE_REF_READING;
-	if (flags & REF_DELETING) {
-		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
-		if (flags & REF_NODEREF)
-			resolve_flags |= RESOLVE_REF_NO_RECURSE;
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
+
+		if (flags & REF_DELETING)
+			resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
+
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
+				last_errno = errno;
+				if (!verify_refname_available_dir(refname, extras, skip,
+								  get_loose_refs(&ref_cache), err))
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
 
 	lflags = 0;
-	if (flags & REF_NODEREF) {
-		refname = orig_refname;
+	if (flags & REF_NODEREF)
 		lflags |= LOCK_NO_DEREF;
-	}
 	lock->ref_name = xstrdup(refname);
-	lock->orig_ref_name = xstrdup(orig_refname);
 	strbuf_git_path(&ref_file, "%s", refname);
 
  retry:
@@ -2537,7 +2537,7 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, 0, NULL, &err);
+	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, NULL, 0, NULL, &err);
 	if (!lock) {
 		error("unable to rename '%s' to '%s': %s", oldrefname, newrefname, err.buf);
 		strbuf_release(&err);
@@ -2555,7 +2555,7 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, NULL, 0, NULL, &err);
+	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, NULL, NULL, 0, NULL, &err);
 	if (!lock) {
 		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -2783,9 +2783,7 @@ static int commit_ref_update(struct ref_lock *lock,
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
@@ -2793,7 +2791,7 @@ static int commit_ref_update(struct ref_lock *lock,
 		unlock_ref(lock);
 		return -1;
 	}
-	if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
+	if (flags & REF_IS_NOT_HEAD) {
 		/*
 		 * Special hack: If a branch is updated directly and HEAD
 		 * points to it (may happen on the remote side of a push
@@ -3157,6 +3155,7 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				update->refname,
 				((update->flags & REF_HAVE_OLD) ?
 				 update->old_sha1 : NULL),
+				update->read_sha1,
 				affected_refnames, NULL,
 				update->flags,
 				&update->type,
@@ -3403,7 +3402,7 @@ static int files_reflog_expire(const char *refname, const unsigned char *sha1,
 	struct ref_lock *lock;
 	char *log_file;
 	int status = 0;
-	int type;
+	int type = 0;
 	struct strbuf err = STRBUF_INIT;
 
 	memset(&cb, 0, sizeof(cb));
@@ -3416,7 +3415,7 @@ static int files_reflog_expire(const char *refname, const unsigned char *sha1,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_sha1_basic(refname, sha1, NULL, NULL, 0, &type, &err);
+	lock = lock_ref_sha1_basic(refname, sha1, NULL, NULL, NULL, 0, &type, &err);
 	if (!lock) {
 		error("cannot lock ref '%s': %s", refname, err.buf);
 		strbuf_release(&err);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 82e44ef..75d4dae 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -44,6 +44,8 @@
 
 #define REF_LOG_ONLY 0x80
 
+#define REF_IS_NOT_HEAD 0x100
+
 /* Include broken references in a do_for_each_ref*() iteration */
 #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
 
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
