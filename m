From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/18] refs: check for D/F conflicts among refs processed in a transaction
Date: Fri,  1 May 2015 14:25:50 +0200
Message-ID: <1430483158-14349-11-git-send-email-mhagger@alum.mit.edu>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 14:27:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoA24-0001MH-Bv
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 14:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbbEAM0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 08:26:49 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:45075 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753553AbbEAM02 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 08:26:28 -0400
X-AuditID: 12074414-f797f6d000004084-17-554370ee6bd3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 5A.EA.16516.EE073455; Fri,  1 May 2015 08:26:22 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D7E.dip0.t-ipconnect.de [79.201.125.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t41CQ3Zn004310
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 08:26:21 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqPuuwDnUYOpMM4uuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZyz4eYa94G5qxbwHn1kbGKf7dzFyckgImEhc3fOHDcIWk7hwbz2QzcUhJHCZUeLV7M2M
	EM4JJollK9eDVbEJ6Eos6mlmArFFBNQkJrYdYgEpYhboYJS4sHwbO0hCWCBKYvKPd4wgNouA
	qsTdB52sXYwcHLwCrhL/d7pAbJOTOH/8JzNImBMo/GVqIkhYSMBF4v73r2wTGHkXMDKsYpRL
	zCnN1c1NzMwpTk3WLU5OzMtLLdK10MvNLNFLTSndxAgJKJEdjEdOyh1iFOBgVOLh3XDMKVSI
	NbGsuDL3EKMkB5OSKK9tgnOoEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHee+pAOd6UxMqq1KJ8
	mJQ0B4uSOO+3xep+QgLpiSWp2ampBalFMFkZDg4lCd7EfKBGwaLU9NSKtMycEoQ0EwcnyHAu
	KZHi1LyU1KLE0pKMeFBkxBcDYwMkxQO09yFIO29xQWIuUBSi9RSjopQ47wmQhABIIqM0D24s
	LE28YhQH+lKYlxWYNIR4gCkGrvsV0GAmoMHnbzmADC5JREhJNTAysfnwLz4RoM+f9Ngx96HX
	d0Zda0F/wWmTEwPObzTbGaEXPEVu//yJYmwqwkvf8Z2+Kqb5PzVQ7hEzV90LNfeVs/oWPl29
	a6H07/oc89jVJVYdOysVPCu5pkg8nLDR7IFC5IyvwX0rKt893PBn77Jgjav26ddc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268130>

If two references that D/F conflict (e.g., "refs/foo" and
"refs/foo/bar") are created in a single transaction, the old code
discovered the problem only after the "commit" phase of
ref_transaction_commit() had already begun. This could leave some
references updated and others not, which violates the promise of
atomicity.

Instead, check for such conflicts during the "locking" phase:

* Teach is_refname_available() to take an "extras" parameter that can
  contain extra reference names with which the specified refname must
  not conflict.

* Change lock_ref_sha1_basic() to take an "extras" parameter, which it
  passes through to is_refname_available().

* Change ref_transaction_commit() to pass "affected_refnames" to
  lock_ref_sha1_basic() as its "extras" argument.

This change fixes a test case in t1404.

This code is a bit stricter than it needs to be. We could conceivably
allow reference "refs/foo/bar" to be created in the same transaction
as "refs/foo" is deleted (or vice versa). But that would be
complicated to implement, because it is not possible to lock
"refs/foo/bar" while "refs/foo" exists as a loose reference, but on
the other hand we don't want to delete some references before adding
others (because that could leave a gap during which required objects
are unreachable). There is also a complication that reflog files'
paths can conflict.

Any less-strict implementation would probably require tricks like the
packing of all references before the start of the real transaction, or
the use of temporary intermediate reference names.

So for now let's accept too-strict checks. Some reference update
transactions will be rejected unnecessarily, but they will be rejected
in their entirety rather than leaving the repository in an
intermediate state, as would happen now.

Please note that there is still one kind of D/F conflict that is *not*
handled correctly. If two processes are running at the same time, and
one tries to create "refs/foo" at the same time that the other tries
to create "refs/foo/bar", then they can race with each other. Both
processes can obtain their respective locks ("refs/foo.lock" and
"refs/foo/bar.lock"), proceed to the "commit" phase of
ref_transaction_commit(), and then the slower process will discover
that it cannot rename its lockfile into place (after possibly having
committed changes to other references). There appears to be no way to
fix this race without changing the locking policy, which in turn would
require a change to *all* Git clients.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c                             | 156 +++++++++++++++++++++----------------
 t/t1404-update-ref-df-conflicts.sh |   2 +-
 2 files changed, 90 insertions(+), 68 deletions(-)

diff --git a/refs.c b/refs.c
index fca3ef1..81fbb33 100644
--- a/refs.c
+++ b/refs.c
@@ -864,19 +864,22 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
 
 /*
  * Return true iff a reference named refname could be created without
- * conflicting with the name of an existing reference in dir.  If
- * skip is non-NULL, ignore potential conflicts with refs in skip
- * (e.g., because they are scheduled for deletion in the same
- * operation).
+ * conflicting with the name of an existing reference in dir. If
+ * extras is non-NULL, it is a list of additional refnames with which
+ * refname is not allowed to conflict. If skip is non-NULL, ignore
+ * potential conflicts with refs in skip (e.g., because they are
+ * scheduled for deletion in the same operation). Behavior is
+ * undefined if the same name is listed in both extras and skip.
  *
  * Two reference names conflict if one of them exactly matches the
  * leading components of the other; e.g., "foo/bar" conflicts with
  * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
  * "foo/barbados".
  *
- * skip must be sorted.
+ * extras and skip must be sorted.
  */
 static int is_refname_available(const char *refname,
+				const struct string_list *extras,
 				const struct string_list *skip,
 				struct ref_dir *dir)
 {
@@ -891,84 +894,101 @@ static int is_refname_available(const char *refname,
 		strbuf_add(&dirname, refname + dirname.len, slash - refname - dirname.len);
 
 		/*
-		 * We are still at a leading dir of the refname; we are
-		 * looking for a conflict with a leaf entry.
+		 * We are still at a leading dir of refname; look for
+		 * a conflict with a leaf entry.
 		 *
 		 * If we find one, we still must make sure it is
 		 * not in "skip".
 		 */
-		pos = search_ref_dir(dir, dirname.buf, dirname.len);
-		if (pos >= 0) {
-			if (skip && string_list_has_string(skip, dirname.buf)) {
-				/*
-				 * The fact that entry is a ref whose
-				 * name is a prefix of refname means
-				 * that there cannot be any other ref
-				 * whose name starts with that prefix
-				 * (because it would have been a D/F
-				 * conflict with entry). So, since we
-				 * don't care about entry (because it
-				 * is in skip), we can stop looking
-				 * now and return true.
-				 */
-				ret = 1;
+		if (dir) {
+			pos = search_ref_dir(dir, dirname.buf, dirname.len);
+			if (pos >= 0 &&
+			    (!skip || !string_list_has_string(skip, dirname.buf))) {
+				error("'%s' exists; cannot create '%s'",
+				      dirname.buf, refname);
 				goto cleanup;
 			}
-			error("'%s' exists; cannot create '%s'", dirname.buf, refname);
-			goto cleanup;
 		}
 
+		if (extras && string_list_has_string(extras, dirname.buf) &&
+		    (!skip || !string_list_has_string(skip, dirname.buf))) {
+			error("cannot process '%s' and '%s' at the same time",
+			      refname, dirname.buf);
+			goto cleanup;
+		}
 
 		/*
 		 * Otherwise, we can try to continue our search with
-		 * the next component; if we come up empty, we know
-		 * there is nothing under this whole prefix.
+		 * the next component. If we come up empty, we know
+		 * there is nothing under this whole prefix, but even
+		 * in that case we still have to continue the search
+		 * for conflicts with extras.
 		 */
 		strbuf_addch(&dirname, '/');
-		pos = search_ref_dir(dir, dirname.buf, dirname.len);
-		if (pos < 0) {
-			ret = 1;
-			goto cleanup;
+		if (dir) {
+			pos = search_ref_dir(dir, dirname.buf, dirname.len);
+			dir = (pos < 0) ? NULL : get_ref_dir(dir->entries[pos]);
 		}
-
-		dir = get_ref_dir(dir->entries[pos]);
 	}
 
 	/*
-	 * We are at the leaf of our refname; we want to
-	 * make sure there are no directories which match it.
+	 * We are at the leaf of our refname; we want to make sure
+	 * that there are no directories that match it. (There is no
+	 * point in searching for another leaf node that matches it;
+	 * such an entry would be the ref we are looking for, which is
+	 * not a conflict.)
 	 */
 	strbuf_addstr(&dirname, refname + dirname.len);
 	strbuf_addch(&dirname, '/');
-	pos = search_ref_dir(dir, dirname.buf, dirname.len);
 
-	if (pos >= 0) {
+	if (dir) {
+		pos = search_ref_dir(dir, dirname.buf, dirname.len);
+
+		if (pos >= 0) {
+			/*
+			 * We found a directory named "refname". It is
+			 * a problem if it contains any ref that is
+			 * not in "skip".
+			 */
+			struct nonmatching_ref_data data;
+
+			data.skip = skip;
+			data.conflicting_refname = NULL;
+			dir = get_ref_dir(dir->entries[pos]);
+			sort_ref_dir(dir);
+			if (do_for_each_entry_in_dir(dir, 0, nonmatching_ref_fn, &data)) {
+				error("'%s' exists; cannot create '%s'",
+				      data.conflicting_refname, refname);
+				goto cleanup;
+			}
+		}
+	}
+
+	if (extras) {
 		/*
-		 * We found a directory named "refname". It is a
-		 * problem iff it contains any ref that is not
-		 * in "skip".
+		 * Check for entries in extras that start with
+		 * "refname/". We do that by looking for the place
+		 * where "refname/" would be inserted in extras. If
+		 * there is an entry at that position that starts with
+		 * "refname/" and is not in skip, then we have a
+		 * conflict.
 		 */
-		struct nonmatching_ref_data data;
-		struct ref_entry *entry = dir->entries[pos];
-
-		dir = get_ref_dir(entry);
-		data.skip = skip;
-		sort_ref_dir(dir);
-		if (!do_for_each_entry_in_dir(dir, 0, nonmatching_ref_fn, &data)) {
-			ret = 1;
-			goto cleanup;
-		}
+		for (pos = string_list_find_insert_index(extras, dirname.buf, 0);
+		     pos < extras->nr; pos++) {
+			const char *extra_refname = extras->items[pos].string;
 
-		error("'%s' exists; cannot create '%s'",
-		      data.conflicting_refname, refname);
-		goto cleanup;
+			if (!starts_with(extra_refname, dirname.buf))
+				break;
+
+			if (!skip || !string_list_has_string(skip, extra_refname)) {
+				error("cannot process '%s' and '%s' at the same time",
+				      refname, extra_refname);
+				goto cleanup;
+			}
+		}
 	}
 
-	/*
-	 * There is no point in searching for another leaf
-	 * node which matches it; such an entry would be the
-	 * ref we are looking for, not a conflict.
-	 */
+	/* No conflicts were found */
 	ret = 1;
 
 cleanup:
@@ -2289,6 +2309,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
  */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
+					    const struct string_list *extras,
 					    const struct string_list *skip,
 					    unsigned int flags, int *type_p)
 {
@@ -2343,7 +2364,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * our refname.
 	 */
 	if (is_null_sha1(lock->old_sha1) &&
-	     !is_refname_available(refname, skip, get_packed_refs(&ref_cache))) {
+	    !is_refname_available(refname, extras, skip, get_packed_refs(&ref_cache))) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2783,8 +2804,8 @@ static int rename_ref_available(const char *oldname, const char *newname)
 	int ret;
 
 	string_list_insert(&skip, oldname);
-	ret = is_refname_available(newname, &skip, get_packed_refs(&ref_cache))
-	    && is_refname_available(newname, &skip, get_loose_refs(&ref_cache));
+	ret = is_refname_available(newname, NULL, &skip, get_packed_refs(&ref_cache))
+		&& is_refname_available(newname, NULL, &skip, get_loose_refs(&ref_cache));
 	string_list_clear(&skip, 0);
 	return ret;
 }
@@ -2844,7 +2865,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, 0, NULL);
 	if (!lock) {
 		error("unable to lock %s for update", newrefname);
 		goto rollback;
@@ -2859,7 +2880,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, NULL, 0, NULL);
 	if (!lock) {
 		error("unable to lock %s for rollback", oldrefname);
 		goto rollbacklog;
@@ -3766,9 +3787,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/*
 	 * Acquire all locks, verify old values if provided, check
-	 * that new values are valid, and write new values to the
-	 * lockfiles, ready to be activated. Only keep one lockfile
-	 * open at a time to avoid running out of file descriptors.
+	 * that new values are valid, check for D/F conflicts, and
+	 * write new values to the lockfiles, ready to be activated.
+	 * Only keep one lockfile open at a time to avoid running out
+	 * of file descriptors.
 	 */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
@@ -3779,7 +3801,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				update->refname,
 				((update->flags & REF_HAVE_OLD) ?
 				 update->old_sha1 : NULL),
-				NULL,
+				&affected_refnames, NULL,
 				update->flags,
 				&update->type);
 		if (!update->lock) {
@@ -4076,7 +4098,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_sha1_basic(refname, sha1, NULL, 0, &type);
+	lock = lock_ref_sha1_basic(refname, sha1, NULL, NULL, 0, &type);
 	if (!lock)
 		return error("cannot lock ref '%s'", refname);
 	if (!reflog_exists(refname)) {
diff --git a/t/t1404-update-ref-df-conflicts.sh b/t/t1404-update-ref-df-conflicts.sh
index 2fc2ac6..136fb48 100755
--- a/t/t1404-update-ref-df-conflicts.sh
+++ b/t/t1404-update-ref-df-conflicts.sh
@@ -96,7 +96,7 @@ test_expect_success 'new ref is a deeper prefix of existing packed' '
 
 '
 
-test_expect_failure 'one new ref is a simple prefix of another' '
+test_expect_success 'one new ref is a simple prefix of another' '
 
 	prefix=refs/5 &&
 	test_update_rejected $prefix "a e" false "b c c/x d" \
-- 
2.1.4
