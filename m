From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 10/18] refs: check for D/F conflicts among refs created in a transaction
Date: Mon, 11 May 2015 17:25:12 +0200
Message-ID: <1431357920-25090-11-git-send-email-mhagger@alum.mit.edu>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 17:26:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrpak-0002aa-6u
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 17:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261AbbEKPZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 11:25:54 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:48229 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752740AbbEKPZs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 11:25:48 -0400
X-AuditID: 12074412-f79e46d0000036b4-4f-5550c9fa738f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 0D.B7.14004.AF9C0555; Mon, 11 May 2015 11:25:46 -0400 (EDT)
Received: from michael.fritz.box (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BFPNnM002156
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 11:25:44 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqPvrZECowbQPRhZdV7qZLBp6rzBb
	3F4xn9niR0sPs8Xmze0sFmfeNDI6sHn8ff+ByWPBplKPZ717GD0uXlL2WPzAy+PzJrkAtihu
	m6TEkrLgzPQ8fbsE7oxnrQ1MBRMSK959283UwHjIu4uRk0NCwERi3ceFbBC2mMSFe+uBbC4O
	IYHLjBL3un+BJYQEjjNJtEypA7HZBHQlFvU0M4HYIgJqEhPbDrGANDAL7AJqWDqVBSQhLBAt
	MfPSOrBmFgFViTMTFrCD2LwCrhIXL+9ngdgmJ3H++E9mEJsTKL706mUWiGUuEk2P77FMYORd
	wMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXTC83s0QvNaV0EyMkyIR2MK4/KXeIUYCDUYmH
	1+CCf6gQa2JZcWXuIUZJDiYlUd5fewNChfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwKq8ByvGm
	JFZWpRblw6SkOViUxHl/Llb3ExJITyxJzU5NLUgtgsnKcHAoSfC+OQHUKFiUmp5akZaZU4KQ
	ZuLgBBnOJSVSnJqXklqUWFqSEQ+KjfhiYHSApHiA9n4FaectLkjMBYpCtJ5iVJQS510IkhAA
	SWSU5sGNhaWOV4ziQF8K834EqeIBph247ldAg5mABjvGgQ0uSURISTUwGrMLfH/rzihwqMLs
	0mT2JkPrk6zLFeqj2xSmzjG6++Pik81PjtyOe1J4xGth9tpLISf/2034LhvQWRuu9sXR8dZc
	devDrAkWhdkZ7D8DQ3jsip9tjo5yWxEvLFlQMTe3qYinKvb9m/dXZGR6DQMYA/93 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268784>

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
 refs.c                             | 156 ++++++++++++++++++++++---------------
 t/t1404-update-ref-df-conflicts.sh |   2 +-
 2 files changed, 95 insertions(+), 63 deletions(-)

diff --git a/refs.c b/refs.c
index 6bb65ab..0fa70fb 100644
--- a/refs.c
+++ b/refs.c
@@ -859,19 +859,22 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
 
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
  * leading components of the other; e.g., "refs/foo/bar" conflicts
  * with both "refs/foo" and with "refs/foo/bar/baz" but not with
  * "refs/foo/bar" or "refs/foo/barbados".
  *
- * skip must be sorted.
+ * extras and skip must be sorted.
  */
 static int is_refname_available(const char *refname,
+				const struct string_list *extras,
 				const struct string_list *skip,
 				struct ref_dir *dir)
 {
@@ -895,51 +898,53 @@ static int is_refname_available(const char *refname,
 		 * "refs/foo"; if there is a reference with that name,
 		 * it is a conflict, *unless* it is in skip.
 		 */
-		pos = search_ref_dir(dir, dirname.buf, dirname.len);
-		if (pos >= 0) {
-			/*
-			 * We found a reference whose name is a proper
-			 * prefix of refname; e.g., "refs/foo".
-			 */
-			if (skip && string_list_has_string(skip, dirname.buf)) {
+		if (dir) {
+			pos = search_ref_dir(dir, dirname.buf, dirname.len);
+			if (pos >= 0 &&
+			    (!skip || !string_list_has_string(skip, dirname.buf))) {
 				/*
-				 * The reference we just found, e.g.,
-				 * "refs/foo", is also in skip, so it
-				 * is not considered a conflict.
-				 * Moreover, the fact that "refs/foo"
-				 * exists means that there cannot be
-				 * any references anywhere under the
-				 * "refs/foo/" namespace (because they
-				 * would have conflicted with
-				 * "refs/foo"). So we can stop looking
-				 * now and return true.
+				 * We found a reference whose name is
+				 * a proper prefix of refname; e.g.,
+				 * "refs/foo", and is not in skip.
 				 */
-				ret = 1;
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
 		 * the next component. So try to look up the
-		 * directory, e.g., "refs/foo/".
+		 * directory, e.g., "refs/foo/". If we come up empty,
+		 * we know there is nothing under this whole prefix,
+		 * but even in that case we still have to continue the
+		 * search for conflicts with extras.
 		 */
 		strbuf_addch(&dirname, '/');
-		pos = search_ref_dir(dir, dirname.buf, dirname.len);
-		if (pos < 0) {
-			/*
-			 * There was no directory "refs/foo/", so
-			 * there is nothing under this whole prefix,
-			 * and we are OK.
-			 */
-			ret = 1;
-			goto cleanup;
+		if (dir) {
+			pos = search_ref_dir(dir, dirname.buf, dirname.len);
+			if (pos < 0) {
+				/*
+				 * There was no directory "refs/foo/",
+				 * so there is nothing under this
+				 * whole prefix. So there is no need
+				 * to continue looking for conflicting
+				 * references. But we need to continue
+				 * looking for conflicting extras.
+				 */
+				dir = NULL;
+			} else {
+				dir = get_ref_dir(dir->entries[pos]);
+			}
 		}
-
-		dir = get_ref_dir(dir->entries[pos]);
 	}
 
 	/*
@@ -952,30 +957,56 @@ static int is_refname_available(const char *refname,
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
+			 * We found a directory named "$refname/"
+			 * (e.g., "refs/foo/bar/"). It is a problem
+			 * iff it contains any ref that is not in
+			 * "skip".
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
-		 * We found a directory named "$refname/" (e.g.,
-		 * "refs/foo/bar/"). It is a problem iff it contains
-		 * any ref that is not in "skip".
+		 * Check for entries in extras that start with
+		 * "$refname/". We do that by looking for the place
+		 * where "$refname/" would be inserted in extras. If
+		 * there is an entry at that position that starts with
+		 * "$refname/" and is not in skip, then we have a
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
 
+	/* No conflicts were found */
 	ret = 1;
 
 cleanup:
@@ -2296,6 +2327,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
  */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
+					    const struct string_list *extras,
 					    const struct string_list *skip,
 					    unsigned int flags, int *type_p)
 {
@@ -2351,7 +2383,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * our refname.
 	 */
 	if (is_null_sha1(lock->old_sha1) &&
-	     !is_refname_available(refname, skip, get_packed_refs(&ref_cache))) {
+	    !is_refname_available(refname, extras, skip, get_packed_refs(&ref_cache))) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2792,8 +2824,8 @@ static int rename_ref_available(const char *oldname, const char *newname)
 	int ret;
 
 	string_list_insert(&skip, oldname);
-	ret = is_refname_available(newname, &skip, get_packed_refs(&ref_cache))
-	    && is_refname_available(newname, &skip, get_loose_refs(&ref_cache));
+	ret = is_refname_available(newname, NULL, &skip, get_packed_refs(&ref_cache))
+		&& is_refname_available(newname, NULL, &skip, get_loose_refs(&ref_cache));
 	string_list_clear(&skip, 0);
 	return ret;
 }
@@ -2851,7 +2883,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, 0, NULL);
 	if (!lock) {
 		error("unable to lock %s for update", newrefname);
 		goto rollback;
@@ -2865,7 +2897,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, NULL, 0, NULL);
 	if (!lock) {
 		error("unable to lock %s for rollback", oldrefname);
 		goto rollbacklog;
@@ -3777,7 +3809,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				update->refname,
 				((update->flags & REF_HAVE_OLD) ?
 				 update->old_sha1 : NULL),
-				NULL,
+				&affected_refnames, NULL,
 				flags,
 				&update->type);
 		if (!update->lock) {
@@ -4054,7 +4086,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_sha1_basic(refname, sha1, NULL, 0, &type);
+	lock = lock_ref_sha1_basic(refname, sha1, NULL, NULL, 0, &type);
 	if (!lock)
 		return error("cannot lock ref '%s'", refname);
 	if (!reflog_exists(refname)) {
diff --git a/t/t1404-update-ref-df-conflicts.sh b/t/t1404-update-ref-df-conflicts.sh
index ed1b93e..b0bb7d4 100755
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
