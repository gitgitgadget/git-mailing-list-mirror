From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 29/33] refs: resolve symbolic refs first
Date: Fri, 13 May 2016 14:35:40 +0200
Message-ID: <e87d7f0f441a9094d75cae7a39aac1e8760426e9.1463140520.git.mhagger@alum.mit.edu>
References: <5735C990.8080502@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 13 14:36:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1CK6-0006VM-RK
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 14:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbcEMMgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 08:36:01 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:53106 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751407AbcEMMgA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2016 08:36:00 -0400
X-AuditID: 12074412-52fff700000009f7-c4-5735ca273ac5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 16.49.02551.72AC5375; Fri, 13 May 2016 08:35:51 -0400 (EDT)
Received: from michael.fritz.box (p508EABB6.dip0.t-ipconnect.de [80.142.171.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u4DCZlmB022426
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 13 May 2016 08:35:49 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <5735C990.8080502@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsUixO6iqKt+yjTcoO+pgsX8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgtZl61tujs+MrowOHx9/0HJo+ds+6yezzr3cPocfGSssf+
	pdvYPBY8v8/u8XmTnMftZ9tYAjiiuG2SEkvKgjPT8/TtErgzlt45y17wdz9jxfylq1gaGF9N
	Zuxi5OSQEDCRuHZhP3sXIxeHkMBWRon5n66xQjgnmSR+tC5mA6liE9CVWNTTzARiiwhESDS8
	amEEKWIW2Mok8eBJPztIQljAWuLP/26wsSwCqhJ7D5wFa+YViJL4+K+XGWKdnMTl6Q+A4hwc
	nAI6Eht2J4KEhQS0JT4cnMk6gZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdM73czBK9
	1JTSTYyQ0BPawbj+pNwhRgEORiUe3gQl03Ah1sSy4srcQ4ySHExKorwT9wOF+JLyUyozEosz
	4otKc1KLDzFKcDArifCuOg6U401JrKxKLcqHSUlzsCiJ8/5crO4nJJCeWJKanZpakFoEk5Xh
	4FCS4L18AqhRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQH8cXASABJ8QDtlTsJ
	sre4IDEXKArReopRl+PI/ntrmYRY8vLzUqXEefVAigRAijJK8+BWwBLNK0ZxoI+FeSNBqniA
	SQpu0iugJUxAS6qvG4EsKUlESEk1MLI2fPpxQ8Txer3Pommmjot0G6f13DiX91sk6M6nx9lW
	FhO4grXZYis3nD2ht4BdS9ZKrcxZ78LpkJLbgQ9r4mfPZF5r+vJGzAL39Jlmp9ie 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294528>

Before committing ref updates, split symbolic ref updates into two
parts: an update to the underlying ref, and a log-only update to the
symbolic ref. This ensures that both references are locked correctly
during the transaction, including while their reflogs are updated.

Similarly, if the reference pointed to by HEAD is modified directly, add
a separate log-only update to HEAD, rather than leaving the job of
updating HEAD's reflog to commit_ref_update(). This change ensures that
HEAD is locked correctly while its reflog is being modified, as well as
being cheaper (HEAD only needs to be resolved once).

This makes use of a new function, lock_raw_ref(), which is analogous to
read_raw_ref(), but acquires a lock on the reference before reading it.

This change still has two problems:

* There are redundant read_ref_full() reference lookups.

* It is still possible to get incorrect reflogs for symbolic references
  if there is a concurrent update by another process, since the old_oid
  of a symref is determined before the lock on the pointed-to ref is
  held.

Both problems will soon be fixed.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
The rest of this patch series is unchanged from v2 so I won't bother
resending it.

Thanks to Torsten for reporting a problem in v2, and Peff for the
bisection and diagnosis.

The changes to this patch since v2:

* Correct s/read_ref_raw/read_raw_ref/ in the log message.

* If read_raw_ref() fails with ENOENT, instead of calling
  verify_refname_available_dir(), insert a comment explaining why such
  a call is unnecessary.

 refs/files-backend.c  | 518 +++++++++++++++++++++++++++++++++++++++++++++-----
 refs/refs-internal.h  |  11 +-
 t/t1400-update-ref.sh |  35 ++++
 3 files changed, 519 insertions(+), 45 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8ff76ed..3af0d35 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1527,6 +1527,233 @@ static void unlock_ref(struct ref_lock *lock)
 }
 
 /*
+ * Lock refname, without following symrefs, and set *lock_p to point
+ * at a newly-allocated lock object. Fill in lock->old_oid, referent,
+ * and type similarly to read_raw_ref().
+ *
+ * The caller must verify that refname is a "safe" reference name (in
+ * the sense of refname_is_safe()) before calling this function.
+ *
+ * If the reference doesn't already exist, verify that refname doesn't
+ * have a D/F conflict with any existing references. extras and skip
+ * are passed to verify_refname_available_dir() for this check.
+ *
+ * If mustexist is not set and the reference is not found or is
+ * broken, lock the reference anyway but clear sha1.
+ *
+ * Return 0 on success. On failure, write an error message to err and
+ * return TRANSACTION_NAME_CONFLICT or TRANSACTION_GENERIC_ERROR.
+ *
+ * Implementation note: This function is basically
+ *
+ *     lock reference
+ *     read_raw_ref()
+ *
+ * but it includes a lot more code to
+ * - Deal with possible races with other processes
+ * - Avoid calling verify_refname_available_dir() when it can be
+ *   avoided, namely if we were successfully able to read the ref
+ * - Generate informative error messages in the case of failure
+ */
+static int lock_raw_ref(const char *refname, int mustexist,
+			const struct string_list *extras,
+			const struct string_list *skip,
+			struct ref_lock **lock_p,
+			struct strbuf *referent,
+			unsigned int *type,
+			struct strbuf *err)
+{
+	struct ref_lock *lock;
+	struct strbuf ref_file = STRBUF_INIT;
+	int attempts_remaining = 3;
+	int ret = TRANSACTION_GENERIC_ERROR;
+
+	assert(err);
+	*type = 0;
+
+	/* First lock the file so it can't change out from under us. */
+
+	*lock_p = lock = xcalloc(1, sizeof(*lock));
+
+	lock->ref_name = xstrdup(refname);
+	lock->orig_ref_name = xstrdup(refname);
+	strbuf_git_path(&ref_file, "%s", refname);
+
+retry:
+	switch (safe_create_leading_directories(ref_file.buf)) {
+	case SCLD_OK:
+		break; /* success */
+	case SCLD_EXISTS:
+		/*
+		 * Suppose refname is "refs/foo/bar". We just failed
+		 * to create the containing directory, "refs/foo",
+		 * because there was a non-directory in the way. This
+		 * indicates a D/F conflict, probably because of
+		 * another reference such as "refs/foo". There is no
+		 * reason to expect this error to be transitory.
+		 */
+		if (verify_refname_available(refname, extras, skip, err)) {
+			if (mustexist) {
+				/*
+				 * To the user the relevant error is
+				 * that the "mustexist" reference is
+				 * missing:
+				 */
+				strbuf_reset(err);
+				strbuf_addf(err, "unable to resolve reference '%s'",
+					    refname);
+			} else {
+				/*
+				 * The error message set by
+				 * verify_refname_available_dir() is OK.
+				 */
+				ret = TRANSACTION_NAME_CONFLICT;
+			}
+		} else {
+			/*
+			 * The file that is in the way isn't a loose
+			 * reference. Report it as a low-level
+			 * failure.
+			 */
+			strbuf_addf(err, "unable to create lock file %s.lock; "
+				    "non-directory in the way",
+				    ref_file.buf);
+		}
+		goto error_return;
+	case SCLD_VANISHED:
+		/* Maybe another process was tidying up. Try again. */
+		if (--attempts_remaining > 0)
+			goto retry;
+		/* fall through */
+	default:
+		strbuf_addf(err, "unable to create directory for %s",
+			    ref_file.buf);
+		goto error_return;
+	}
+
+	if (!lock->lk)
+		lock->lk = xcalloc(1, sizeof(struct lock_file));
+
+	if (hold_lock_file_for_update(lock->lk, ref_file.buf, LOCK_NO_DEREF) < 0) {
+		if (errno == ENOENT && --attempts_remaining > 0) {
+			/*
+			 * Maybe somebody just deleted one of the
+			 * directories leading to ref_file.  Try
+			 * again:
+			 */
+			goto retry;
+		} else {
+			unable_to_lock_message(ref_file.buf, errno, err);
+			goto error_return;
+		}
+	}
+
+	/*
+	 * Now we hold the lock and can read the reference without
+	 * fear that its value will change.
+	 */
+
+	if (read_raw_ref(refname, lock->old_oid.hash, referent, type)) {
+		if (errno == ENOENT) {
+			if (mustexist) {
+				/* Garden variety missing reference. */
+				strbuf_addf(err, "unable to resolve reference '%s'",
+					    refname);
+				goto error_return;
+			} else {
+				/*
+				 * Reference is missing, but that's OK. We
+				 * know that there is not a conflict with
+				 * another loose reference because
+				 * (supposing that we are trying to lock
+				 * reference "refs/foo/bar"):
+				 *
+				 * - We were successfully able to create
+				 *   the lockfile refs/foo/bar.lock, so we
+				 *   know there cannot be a loose reference
+				 *   named "refs/foo".
+				 *
+				 * - We got ENOENT and not EISDIR, so we
+				 *   know that there cannot be a loose
+				 *   reference named "refs/foo/bar/baz".
+				 */
+			}
+		} else if (errno == EISDIR) {
+			/*
+			 * There is a directory in the way. It might have
+			 * contained references that have been deleted. If
+			 * we don't require that the reference already
+			 * exists, try to remove the directory so that it
+			 * doesn't cause trouble when we want to rename the
+			 * lockfile into place later.
+			 */
+			if (mustexist) {
+				/* Garden variety missing reference. */
+				strbuf_addf(err, "unable to resolve reference '%s'",
+					    refname);
+				goto error_return;
+			} else if (remove_dir_recursively(&ref_file,
+							  REMOVE_DIR_EMPTY_ONLY)) {
+				if (verify_refname_available_dir(
+						    refname, extras, skip,
+						    get_loose_refs(&ref_cache),
+						    err)) {
+					/*
+					 * The error message set by
+					 * verify_refname_available() is OK.
+					 */
+					ret = TRANSACTION_NAME_CONFLICT;
+					goto error_return;
+				} else {
+					/*
+					 * We can't delete the directory,
+					 * but we also don't know of any
+					 * references that it should
+					 * contain.
+					 */
+					strbuf_addf(err, "there is a non-empty directory '%s' "
+						    "blocking reference '%s'",
+						    ref_file.buf, refname);
+					goto error_return;
+				}
+			}
+		} else if (errno == EINVAL && (*type & REF_ISBROKEN)) {
+			strbuf_addf(err, "unable to resolve reference '%s': "
+				    "reference broken", refname);
+			goto error_return;
+		} else {
+			strbuf_addf(err, "unable to resolve reference '%s': %s",
+				    refname, strerror(errno));
+			goto error_return;
+		}
+
+		/*
+		 * If the ref did not exist and we are creating it,
+		 * make sure there is no existing packed ref whose
+		 * name begins with our refname, nor a packed ref
+		 * whose name is a proper prefix of our refname.
+		 */
+		if (verify_refname_available_dir(
+				    refname, extras, skip,
+				    get_packed_refs(&ref_cache),
+				    err)) {
+			goto error_return;
+		}
+	}
+
+	ret = 0;
+	goto out;
+
+error_return:
+	unlock_ref(lock);
+	*lock_p = NULL;
+
+out:
+	strbuf_release(&ref_file);
+	return ret;
+}
+
+/*
  * Peel the entry (if possible) and return its new peel_status.  If
  * repeel is true, re-peel the entry even if there is an old peeled
  * value that is already stored in it.
@@ -3052,55 +3279,201 @@ static int ref_update_reject_duplicates(struct string_list *refnames,
 }
 
 /*
- * Acquire all locks, verify old values if provided, check
- * that new values are valid, and write new values to the
- * lockfiles, ready to be activated. Only keep one lockfile
- * open at a time to avoid running out of file descriptors.
+ * If update is a direct update of head_ref (the reference pointed to
+ * by HEAD), then add an extra REF_LOG_ONLY update for HEAD.
+ */
+static int split_head_update(struct ref_update *update,
+			     struct ref_transaction *transaction,
+			     const char *head_ref,
+			     struct string_list *affected_refnames,
+			     struct strbuf *err)
+{
+	struct string_list_item *item;
+	struct ref_update *new_update;
+
+	if ((update->flags & REF_LOG_ONLY) ||
+	    (update->flags & REF_ISPRUNING) ||
+	    (update->flags & REF_UPDATE_VIA_HEAD))
+		return 0;
+
+	if (strcmp(update->refname, head_ref))
+		return 0;
+
+	/*
+	 * First make sure that HEAD is not already in the
+	 * transaction. This insertion is O(N) in the transaction
+	 * size, but it happens at most once per transaction.
+	 */
+	item = string_list_insert(affected_refnames, "HEAD");
+	if (item->util) {
+		/* An entry already existed */
+		strbuf_addf(err,
+			    "multiple updates for 'HEAD' (including one "
+			    "via its referent '%s') are not allowed",
+			    update->refname);
+		return TRANSACTION_NAME_CONFLICT;
+	}
+
+	new_update = ref_transaction_add_update(
+			transaction, "HEAD",
+			update->flags | REF_LOG_ONLY | REF_NODEREF,
+			update->new_sha1, update->old_sha1,
+			update->msg);
+
+	item->util = new_update;
+
+	return 0;
+}
+
+/*
+ * update is for a symref that points at referent and doesn't have
+ * REF_NODEREF set. Split it into two updates:
+ * - The original update, but with REF_LOG_ONLY and REF_NODEREF set
+ * - A new, separate update for the referent reference
+ * Note that the new update will itself be subject to splitting when
+ * the iteration gets to it.
+ */
+static int split_symref_update(struct ref_update *update,
+			       const char *referent,
+			       struct ref_transaction *transaction,
+			       struct string_list *affected_refnames,
+			       struct strbuf *err)
+{
+	struct string_list_item *item;
+	struct ref_update *new_update;
+	unsigned int new_flags;
+
+	/*
+	 * First make sure that referent is not already in the
+	 * transaction. This insertion is O(N) in the transaction
+	 * size, but it happens at most once per symref in a
+	 * transaction.
+	 */
+	item = string_list_insert(affected_refnames, referent);
+	if (item->util) {
+		/* An entry already existed */
+		strbuf_addf(err,
+			    "multiple updates for '%s' (including one "
+			    "via symref '%s') are not allowed",
+			    referent, update->refname);
+		return TRANSACTION_NAME_CONFLICT;
+	}
+
+	new_flags = update->flags;
+	if (!strcmp(update->refname, "HEAD")) {
+		/*
+		 * Record that the new update came via HEAD, so that
+		 * when we process it, split_head_update() doesn't try
+		 * to add another reflog update for HEAD. Note that
+		 * this bit will be propagated if the new_update
+		 * itself needs to be split.
+		 */
+		new_flags |= REF_UPDATE_VIA_HEAD;
+	}
+
+	new_update = ref_transaction_add_update(
+			transaction, referent, new_flags,
+			update->new_sha1, update->old_sha1,
+			update->msg);
+
+	/* Change the symbolic ref update to log only: */
+	update->flags |= REF_LOG_ONLY | REF_NODEREF;
+
+	item->util = new_update;
+
+	return 0;
+}
+
+/*
+ * Prepare for carrying out update:
+ * - Lock the reference referred to by update.
+ * - Read the reference under lock.
+ * - Check that its old SHA-1 value (if specified) is correct, and in
+ *   any case record it for later use in the reflog.
+ * - If it is a symref update without REF_NODEREF, split it up into a
+ *   REF_LOG_ONLY update of the symref and add a separate update for
+ *   the referent to transaction.
+ * - If it is an update of head_ref, add a corresponding REF_LOG_ONLY
+ *   update of HEAD.
  */
 static int lock_ref_for_update(struct ref_update *update,
 			       struct ref_transaction *transaction,
+			       const char *head_ref,
 			       struct string_list *affected_refnames,
 			       struct strbuf *err)
 {
+	struct strbuf referent = STRBUF_INIT;
+	int mustexist = (update->flags & REF_HAVE_OLD) &&
+		!is_null_sha1(update->old_sha1);
 	int ret;
+	struct ref_lock *lock;
 
-	if ((update->flags & REF_HAVE_NEW) &&
-	    is_null_sha1(update->new_sha1))
+	if ((update->flags & REF_HAVE_NEW) && is_null_sha1(update->new_sha1))
 		update->flags |= REF_DELETING;
-	update->lock = lock_ref_sha1_basic(
-			update->refname,
-			((update->flags & REF_HAVE_OLD) ?
-			 update->old_sha1 : NULL),
-			affected_refnames, NULL,
-			update->flags,
-			&update->type,
-			err);
-	if (!update->lock) {
+
+	if (head_ref) {
+		ret = split_head_update(update, transaction, head_ref,
+					affected_refnames, err);
+		if (ret)
+			return ret;
+	}
+
+	ret = lock_raw_ref(update->refname, mustexist,
+			   affected_refnames, NULL,
+			   &update->lock, &referent,
+			   &update->type, err);
+
+	if (ret) {
 		char *reason;
 
-		ret = (errno == ENOTDIR)
-			? TRANSACTION_NAME_CONFLICT
-			: TRANSACTION_GENERIC_ERROR;
 		reason = strbuf_detach(err, NULL);
 		strbuf_addf(err, "cannot lock ref '%s': %s",
 			    update->refname, reason);
 		free(reason);
 		return ret;
 	}
+
+	lock = update->lock;
+
+	if (read_ref_full(update->refname,
+			  mustexist ? RESOLVE_REF_READING : 0,
+			  lock->old_oid.hash, NULL)) {
+		if (update->flags & REF_HAVE_OLD) {
+			strbuf_addf(err, "cannot lock ref '%s': can't resolve old value",
+				    update->refname);
+			return TRANSACTION_GENERIC_ERROR;
+		} else {
+			hashclr(lock->old_oid.hash);
+		}
+	}
+	if ((update->flags & REF_HAVE_OLD) &&
+	    hashcmp(lock->old_oid.hash, update->old_sha1)) {
+		strbuf_addf(err, "cannot lock ref '%s': is at %s but expected %s",
+			    update->refname,
+			    sha1_to_hex(lock->old_oid.hash),
+			    sha1_to_hex(update->old_sha1));
+		return TRANSACTION_GENERIC_ERROR;
+	}
+
+	if (update->type & REF_ISSYMREF) {
+		if (!(update->flags & REF_NODEREF)) {
+			ret = split_symref_update(update, referent.buf, transaction,
+						  affected_refnames, err);
+			if (ret)
+				return ret;
+		}
+	}
+
 	if ((update->flags & REF_HAVE_NEW) &&
 	    !(update->flags & REF_DELETING) &&
 	    !(update->flags & REF_LOG_ONLY)) {
-		int overwriting_symref = ((update->type & REF_ISSYMREF) &&
-					  (update->flags & REF_NODEREF));
-
-		if (!overwriting_symref &&
-		    !hashcmp(update->lock->old_oid.hash, update->new_sha1)) {
+		if (!(update->type & REF_ISSYMREF) &&
+		    !hashcmp(lock->old_oid.hash, update->new_sha1)) {
 			/*
 			 * The reference already has the desired
 			 * value, so we don't need to write it.
 			 */
-		} else if (write_ref_to_lockfile(update->lock,
-						 update->new_sha1,
+		} else if (write_ref_to_lockfile(lock, update->new_sha1,
 						 err)) {
 			char *write_err = strbuf_detach(err, NULL);
 
@@ -3124,7 +3497,7 @@ static int lock_ref_for_update(struct ref_update *update,
 		 * the lockfile is still open. Close it to
 		 * free up the file descriptor:
 		 */
-		if (close_ref(update->lock)) {
+		if (close_ref(lock)) {
 			strbuf_addf(err, "couldn't close '%s.lock'",
 				    update->refname);
 			return TRANSACTION_GENERIC_ERROR;
@@ -3141,6 +3514,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
 	struct string_list_item *ref_to_delete;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
+	char *head_ref = NULL;
+	int head_type;
+	struct object_id head_oid;
 
 	assert(err);
 
@@ -3152,9 +3528,25 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		return 0;
 	}
 
-	/* Fail if a refname appears more than once in the transaction: */
-	for (i = 0; i < transaction->nr; i++)
-		string_list_append(&affected_refnames, updates[i]->refname);
+	/*
+	 * Fail if a refname appears more than once in the
+	 * transaction. (If we end up splitting up any updates using
+	 * split_symref_update() or split_head_update(), those
+	 * functions will check that the new updates don't have the
+	 * same refname as any existing ones.)
+	 */
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = updates[i];
+		struct string_list_item *item =
+			string_list_append(&affected_refnames, update->refname);
+
+		/*
+		 * We store a pointer to update in item->util, but at
+		 * the moment we never use the value of this field
+		 * except to check whether it is non-NULL.
+		 */
+		item->util = update;
+	}
 	string_list_sort(&affected_refnames);
 	if (ref_update_reject_duplicates(&affected_refnames, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
@@ -3162,6 +3554,32 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	}
 
 	/*
+	 * Special hack: If a branch is updated directly and HEAD
+	 * points to it (may happen on the remote side of a push
+	 * for example) then logically the HEAD reflog should be
+	 * updated too.
+	 *
+	 * A generic solution would require reverse symref lookups,
+	 * but finding all symrefs pointing to a given branch would be
+	 * rather costly for this rare event (the direct update of a
+	 * branch) to be worth it. So let's cheat and check with HEAD
+	 * only, which should cover 99% of all usage scenarios (even
+	 * 100% of the default ones).
+	 *
+	 * So if HEAD is a symbolic reference, then record the name of
+	 * the reference that it points to. If we see an update of
+	 * head_ref within the transaction, then split_head_update()
+	 * arranges for the reflog of HEAD to be updated, too.
+	 */
+	head_ref = resolve_refdup("HEAD", RESOLVE_REF_NO_RECURSE,
+				  head_oid.hash, &head_type);
+
+	if (head_ref && !(head_type & REF_ISSYMREF)) {
+		free(head_ref);
+		head_ref = NULL;
+	}
+
+	/*
 	 * Acquire all locks, verify old values if provided, check
 	 * that new values are valid, and write new values to the
 	 * lockfiles, ready to be activated. Only keep one lockfile
@@ -3170,7 +3588,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = updates[i];
 
-		ret = lock_ref_for_update(update, transaction,
+		ret = lock_ref_for_update(update, transaction, head_ref,
 					  &affected_refnames, err);
 		if (ret)
 			goto cleanup;
@@ -3179,23 +3597,35 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	/* Perform updates first so live commits remain referenced */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = updates[i];
+		struct ref_lock *lock = update->lock;
 
 		if (update->flags & REF_NEEDS_COMMIT ||
 		    update->flags & REF_LOG_ONLY) {
-			if (commit_ref_update(update->lock,
-					      update->new_sha1, update->msg,
-					      update->flags, err)) {
-				/* freed by commit_ref_update(): */
-				update->lock = NULL;
-				ret = TRANSACTION_GENERIC_ERROR;
-				goto cleanup;
-			} else {
-				/* freed by commit_ref_update(): */
-				update->lock = NULL;
-			}
-		}
-	}
+			if (log_ref_write(lock->ref_name, lock->old_oid.hash,
+					  update->new_sha1,
+					  update->msg, update->flags, err)) {
+				char *old_msg = strbuf_detach(err, NULL);
 
+				strbuf_addf(err, "cannot update the ref '%s': %s",
+					    lock->ref_name, old_msg);
+				free(old_msg);
+				unlock_ref(lock);
+				update->lock = NULL;
+				ret = TRANSACTION_GENERIC_ERROR;
+				goto cleanup;
+			}
+		}
+		if (update->flags & REF_NEEDS_COMMIT) {
+			clear_loose_ref_cache(&ref_cache);
+			if (commit_ref(lock)) {
+				strbuf_addf(err, "couldn't set '%s'", lock->ref_name);
+				unlock_ref(lock);
+				update->lock = NULL;
+				ret = TRANSACTION_GENERIC_ERROR;
+				goto cleanup;
+			}
+		}
+	}
 	/* Perform deletes now that updates are safely completed */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = updates[i];
@@ -3228,7 +3658,9 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	string_list_clear(&refs_to_delete, 0);
+	free(head_ref);
 	string_list_clear(&affected_refnames, 0);
+
 	return ret;
 }
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index babdf27..cccd76b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -50,6 +50,12 @@
 #define REF_LOG_ONLY 0x80
 
 /*
+ * Internal flag, meaning that the containing ref_update was via an
+ * update to HEAD.
+ */
+#define REF_UPDATE_VIA_HEAD 0x100
+
+/*
  * Return true iff refname is minimally safe. "Safe" here means that
  * deleting a loose reference by this name will not do any damage, for
  * example by causing a file that is not a reference to be deleted.
@@ -148,11 +154,12 @@ struct ref_update {
 	unsigned char old_sha1[20];
 	/*
 	 * One or more of REF_HAVE_NEW, REF_HAVE_OLD, REF_NODEREF,
-	 * REF_DELETING, and REF_ISPRUNING:
+	 * REF_DELETING, REF_ISPRUNING, REF_LOG_ONLY, and
+	 * REF_UPDATE_VIA_HEAD:
 	 */
 	unsigned int flags;
 	struct ref_lock *lock;
-	int type;
+	unsigned int type;
 	char *msg;
 	const char refname[FLEX_ARRAY];
 };
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 08bd8fd..d226930 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1102,6 +1102,41 @@ test_expect_success 'stdin -z delete refs works with packed and loose refs' '
 	test_must_fail git rev-parse --verify -q $c
 '
 
+test_expect_success 'fails with duplicate HEAD update' '
+	git branch target1 $A &&
+	git checkout target1 &&
+	cat >stdin <<-EOF &&
+	update refs/heads/target1 $C
+	option no-deref
+	update HEAD $B
+	EOF
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: multiple updates for '\''HEAD'\'' (including one via its referent .refs/heads/target1.) are not allowed" err &&
+	echo "refs/heads/target1" >expect &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expect actual &&
+	echo "$A" >expect &&
+	git rev-parse refs/heads/target1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'fails with duplicate ref update via symref' '
+	git branch target2 $A &&
+	git symbolic-ref refs/heads/symref2 refs/heads/target2 &&
+	cat >stdin <<-EOF &&
+	update refs/heads/target2 $C
+	update refs/heads/symref2 $B
+	EOF
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: multiple updates for '\''refs/heads/target2'\'' (including one via symref .refs/heads/symref2.) are not allowed" err &&
+	echo "refs/heads/target2" >expect &&
+	git symbolic-ref refs/heads/symref2 >actual &&
+	test_cmp expect actual &&
+	echo "$A" >expect &&
+	git rev-parse refs/heads/target2 >actual &&
+	test_cmp expect actual
+'
+
 run_with_limited_open_files () {
 	(ulimit -n 32 && "$@")
 }
-- 
2.8.1
