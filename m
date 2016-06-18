Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B9B820179
	for <e@80x24.org>; Sat, 18 Jun 2016 04:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbcFREPu (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 00:15:50 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:58383 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751239AbcFREPr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2016 00:15:47 -0400
X-AuditID: 12074412-52fff700000009f7-51-5764caf10596
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id F7.D6.02551.1FAC4675; Sat, 18 Jun 2016 00:15:46 -0400 (EDT)
Received: from michael.fritz.box (p4FEEA991.dip0.t-ipconnect.de [79.238.169.145])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5I4FLJl029401
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jun 2016 00:15:44 -0400
From:	Michael Haggerty <mhagger@alum.mit.edu>
To:	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
Cc:	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 10/13] do_for_each_ref(): reimplement using reference iteration
Date:	Sat, 18 Jun 2016 06:15:16 +0200
Message-Id: <979bfff977c0d51ccecd337bdf20d0689d2469d8.1466222921.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1466222921.git.mhagger@alum.mit.edu>
References: <cover.1466222921.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsUixO6iqPvpVEq4wZkOdov5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGcsnPmQrWB1YcWzW/9YGhgPRHUx
	cnBICJhI9F1K6WLk4hAS2Moo8W7FNyYI5ySTxKTdC9m6GDk52AR0JRb1NDOB2CICERINr1oY
	QYqYBeYwSdx+2MkMkhAWCJJoXniMHcRmEVCV+LdnCVicVyBKYumbFYwgtoSAnMTl6Q/AhnIK
	WEgs2LKPCeQKIQFzib2LDScw8ixgZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuml5tZopea
	UrqJERJyQjsY15+UO8QowMGoxMMbYJ8SLsSaWFZcmXuIUZKDSUmU90olUIgvKT+lMiOxOCO+
	qDQntfgQowQHs5II75YTQDnelMTKqtSifJiUNAeLkjjvz8XqfkIC6YklqdmpqQWpRTBZGQ4O
	JQnepSeBGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBERBfDIwBkBQP0N4nIO28
	xQWJuUBRiNZTjIpS4rzPQBICIImM0jy4sbBE8opRHOhLYV5lYFoR4gEmIbjuV0CDmYAGa85L
	BhlckoiQkmpg7J6nI1JkFe7T3WA4w9No39u/r4Mj3c1/BLq513jMLQ24H3daPT12UZTa4z37
	23jsxU98Lvu1deum5XMk/19Y2GBpwas/8byZw6uDj5mvz7utUqB7R/JV4fOJ01fxX/7saWJV
	POXAfgujT+0pi5ee8GwVz/CL7GnjSGHRXmk1j4+d7fD7RfvKlFiKMxINtZiLihMBbPwAFf8C
	AAA=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Use the reference iterator interface to implement do_for_each_ref().
Delete a bunch of code supporting the old for_each_ref() implementation.
And now that do_for_each_ref() is generic code (it is no longer tied to
the files backend), move it to refs.c.

The implementation is via a new function, do_for_each_ref_iterator(),
which takes a reference iterator as argument and calls a callback
function for each of the references in the iterator.

This change requires the current_ref performance hack for peel_ref() to
be implemented via ref_iterator_peel() rather than peel_entry() because
we don't have a ref_entry handy (it is hidden under three layers:
file_ref_iterator, merge_ref_iterator, and cache_ref_iterator). So:

* do_for_each_ref_iterator() records the active iterator in
  current_ref_iter while it is running.

* peel_ref() checks whether current_ref_iter is pointing at the
  requested reference. If so, it asks the iterator to peel the
  reference (which it can do efficiently via its "peel" virtual
  function). For extra safety, we do the optimization only if the
  refname *addresses* are the same, not only if the refname *strings*
  are the same, to forestall possible mixups between refnames that come
  from different ref_iterators.

Please note that this optimization of peel_ref() is only available when
iterating via do_for_each_ref_iterator() (including all of the
for_each_ref() functions, which call it indirectly). It would be
complicated to implement a similar optimization when iterating directly
using a reference iterator, because multiple reference iterators can be
in use at the same time, with interleaved calls to
ref_iterator_advance(). (In fact we do exactly that in
merge_ref_iterator.)

But that is not necessary. peel_ref() is only called while iterating
over references. Callers who iterate using the for_each_ref() functions
benefit from the optimization described above. Callers who iterate using
reference iterators directly have access to the ref_iterator, so they
can call ref_iterator_peel() themselves to get an analogous optimization
in a more straightforward manner.

If we rewrite all callers to use the reference iteration API, then we
can remove the current_ref_iter hack permanently.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               |  20 +++++
 refs/files-backend.c | 206 ++-------------------------------------------------
 refs/iterator.c      |  29 ++++++++
 refs/refs-internal.h |  33 ++++++---
 4 files changed, 76 insertions(+), 212 deletions(-)

diff --git a/refs.c b/refs.c
index 842c5c7..814cad3 100644
--- a/refs.c
+++ b/refs.c
@@ -1120,6 +1120,26 @@ int head_ref(each_ref_fn fn, void *cb_data)
 	return head_ref_submodule(NULL, fn, cb_data);
 }
 
+/*
+ * Call fn for each reference in the specified submodule for which the
+ * refname begins with prefix. If trim is non-zero, then trim that
+ * many characters off the beginning of each refname before passing
+ * the refname to fn. flags can be DO_FOR_EACH_INCLUDE_BROKEN to
+ * include broken references in the iteration. If fn ever returns a
+ * non-zero value, stop the iteration and return that value;
+ * otherwise, return 0.
+ */
+static int do_for_each_ref(const char *submodule, const char *prefix,
+			   each_ref_fn fn, int trim, int flags, void *cb_data)
+{
+	struct ref_iterator *iter;
+
+	iter = files_ref_iterator_begin(submodule, prefix, flags);
+	iter = prefix_ref_iterator_begin(iter, prefix, trim);
+
+	return do_for_each_ref_iterator(iter, fn, cb_data);
+}
+
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(NULL, "", fn, 0, 0, cb_data);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 395056b..4232da8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -542,53 +542,8 @@ static int entry_resolves_to_object(struct ref_entry *entry)
 				      &entry->u.value.oid, entry->flag);
 }
 
-/*
- * current_ref is a performance hack: when iterating over references
- * using the for_each_ref*() functions, current_ref is set to the
- * current reference's entry before calling the callback function.  If
- * the callback function calls peel_ref(), then peel_ref() first
- * checks whether the reference to be peeled is the current reference
- * (it usually is) and if so, returns that reference's peeled version
- * if it is available.  This avoids a refname lookup in a common case.
- */
-static struct ref_entry *current_ref;
-
 typedef int each_ref_entry_fn(struct ref_entry *entry, void *cb_data);
 
-struct ref_entry_cb {
-	const char *prefix;
-	int trim;
-	int flags;
-	each_ref_fn *fn;
-	void *cb_data;
-};
-
-/*
- * Handle one reference in a do_for_each_ref*()-style iteration,
- * calling an each_ref_fn for each entry.
- */
-static int do_one_ref(struct ref_entry *entry, void *cb_data)
-{
-	struct ref_entry_cb *data = cb_data;
-	struct ref_entry *old_current_ref;
-	int retval;
-
-	if (!starts_with(entry->name, data->prefix))
-		return 0;
-
-	if (!(data->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
-	      !entry_resolves_to_object(entry))
-		return 0;
-
-	/* Store the old value, in case this is a recursive call: */
-	old_current_ref = current_ref;
-	current_ref = entry;
-	retval = data->fn(entry->name + data->trim, &entry->u.value.oid,
-			  entry->flag, data->cb_data);
-	current_ref = old_current_ref;
-	return retval;
-}
-
 /*
  * Call fn for each reference in dir that has index in the range
  * offset <= index < dir->nr.  Recurse into subdirectories that are in
@@ -618,78 +573,6 @@ static int do_for_each_entry_in_dir(struct ref_dir *dir, int offset,
 }
 
 /*
- * Call fn for each reference in the union of dir1 and dir2, in order
- * by refname.  Recurse into subdirectories.  If a value entry appears
- * in both dir1 and dir2, then only process the version that is in
- * dir2.  The input dirs must already be sorted, but subdirs will be
- * sorted as needed.  fn is called for all references, including
- * broken ones.
- */
-static int do_for_each_entry_in_dirs(struct ref_dir *dir1,
-				     struct ref_dir *dir2,
-				     each_ref_entry_fn fn, void *cb_data)
-{
-	int retval;
-	int i1 = 0, i2 = 0;
-
-	assert(dir1->sorted == dir1->nr);
-	assert(dir2->sorted == dir2->nr);
-	while (1) {
-		struct ref_entry *e1, *e2;
-		int cmp;
-		if (i1 == dir1->nr) {
-			return do_for_each_entry_in_dir(dir2, i2, fn, cb_data);
-		}
-		if (i2 == dir2->nr) {
-			return do_for_each_entry_in_dir(dir1, i1, fn, cb_data);
-		}
-		e1 = dir1->entries[i1];
-		e2 = dir2->entries[i2];
-		cmp = strcmp(e1->name, e2->name);
-		if (cmp == 0) {
-			if ((e1->flag & REF_DIR) && (e2->flag & REF_DIR)) {
-				/* Both are directories; descend them in parallel. */
-				struct ref_dir *subdir1 = get_ref_dir(e1);
-				struct ref_dir *subdir2 = get_ref_dir(e2);
-				sort_ref_dir(subdir1);
-				sort_ref_dir(subdir2);
-				retval = do_for_each_entry_in_dirs(
-						subdir1, subdir2, fn, cb_data);
-				i1++;
-				i2++;
-			} else if (!(e1->flag & REF_DIR) && !(e2->flag & REF_DIR)) {
-				/* Both are references; ignore the one from dir1. */
-				retval = fn(e2, cb_data);
-				i1++;
-				i2++;
-			} else {
-				die("conflict between reference and directory: %s",
-				    e1->name);
-			}
-		} else {
-			struct ref_entry *e;
-			if (cmp < 0) {
-				e = e1;
-				i1++;
-			} else {
-				e = e2;
-				i2++;
-			}
-			if (e->flag & REF_DIR) {
-				struct ref_dir *subdir = get_ref_dir(e);
-				sort_ref_dir(subdir);
-				retval = do_for_each_entry_in_dir(
-						subdir, 0, fn, cb_data);
-			} else {
-				retval = fn(e, cb_data);
-			}
-		}
-		if (retval)
-			return retval;
-	}
-}
-
-/*
  * Load all of the refs from the dir into our in-memory cache. The hard work
  * of loading loose refs is done by get_ref_dir(), so we just need to recurse
  * through all of the sub-directories. We do not even need to care about
@@ -1959,11 +1842,12 @@ int peel_ref(const char *refname, unsigned char *sha1)
 	int flag;
 	unsigned char base[20];
 
-	if (current_ref && (current_ref->name == refname
-			    || !strcmp(current_ref->name, refname))) {
-		if (peel_entry(current_ref, 0))
+	if (current_ref_iter && current_ref_iter->refname == refname) {
+		struct object_id peeled;
+
+		if (ref_iterator_peel(current_ref_iter, &peeled))
 			return -1;
-		hashcpy(sha1, current_ref->u.value.peeled.hash);
+		hashcpy(sha1, peeled.hash);
 		return 0;
 	}
 
@@ -2125,86 +2009,6 @@ struct ref_iterator *files_ref_iterator_begin(
 }
 
 /*
- * Call fn for each reference in the specified ref_cache, omitting
- * references not in the containing_dir of prefix. Call fn for all
- * references, including broken ones. If fn ever returns a non-zero
- * value, stop the iteration and return that value; otherwise, return
- * 0.
- */
-static int do_for_each_entry(struct ref_cache *refs, const char *prefix,
-			     each_ref_entry_fn fn, void *cb_data)
-{
-	struct packed_ref_cache *packed_ref_cache;
-	struct ref_dir *loose_dir;
-	struct ref_dir *packed_dir;
-	int retval = 0;
-
-	/*
-	 * We must make sure that all loose refs are read before accessing the
-	 * packed-refs file; this avoids a race condition in which loose refs
-	 * are migrated to the packed-refs file by a simultaneous process, but
-	 * our in-memory view is from before the migration. get_packed_ref_cache()
-	 * takes care of making sure our view is up to date with what is on
-	 * disk.
-	 */
-	loose_dir = get_loose_refs(refs);
-	if (prefix && *prefix) {
-		loose_dir = find_containing_dir(loose_dir, prefix, 0);
-	}
-	if (loose_dir)
-		prime_ref_dir(loose_dir);
-
-	packed_ref_cache = get_packed_ref_cache(refs);
-	acquire_packed_ref_cache(packed_ref_cache);
-	packed_dir = get_packed_ref_dir(packed_ref_cache);
-	if (prefix && *prefix) {
-		packed_dir = find_containing_dir(packed_dir, prefix, 0);
-	}
-
-	if (packed_dir && loose_dir) {
-		sort_ref_dir(packed_dir);
-		sort_ref_dir(loose_dir);
-		retval = do_for_each_entry_in_dirs(
-				packed_dir, loose_dir, fn, cb_data);
-	} else if (packed_dir) {
-		sort_ref_dir(packed_dir);
-		retval = do_for_each_entry_in_dir(
-				packed_dir, 0, fn, cb_data);
-	} else if (loose_dir) {
-		sort_ref_dir(loose_dir);
-		retval = do_for_each_entry_in_dir(
-				loose_dir, 0, fn, cb_data);
-	}
-
-	release_packed_ref_cache(packed_ref_cache);
-	return retval;
-}
-
-int do_for_each_ref(const char *submodule, const char *prefix,
-		    each_ref_fn fn, int trim, int flags, void *cb_data)
-{
-	struct ref_entry_cb data;
-	struct ref_cache *refs;
-
-	refs = get_ref_cache(submodule);
-	if (!refs)
-		return 0;
-
-	data.prefix = prefix;
-	data.trim = trim;
-	data.flags = flags;
-	data.fn = fn;
-	data.cb_data = cb_data;
-
-	if (ref_paranoia < 0)
-		ref_paranoia = git_env_bool("GIT_REF_PARANOIA", 0);
-	if (ref_paranoia)
-		data.flags |= DO_FOR_EACH_INCLUDE_BROKEN;
-
-	return do_for_each_entry(refs, prefix, do_one_ref, &data);
-}
-
-/*
  * Verify that the reference locked by lock has the value old_sha1.
  * Fail if the reference doesn't exist and mustexist is set. Return 0
  * on success. On error, write an error message to err, set errno, and
diff --git a/refs/iterator.c b/refs/iterator.c
index 93ba472..bce1f19 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -353,3 +353,32 @@ struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
 
 	return ref_iterator;
 }
+
+struct ref_iterator *current_ref_iter = NULL;
+
+int do_for_each_ref_iterator(struct ref_iterator *iter,
+			     each_ref_fn fn, void *cb_data)
+{
+	int retval = 0, ok;
+	struct ref_iterator *old_ref_iter = current_ref_iter;
+
+	current_ref_iter = iter;
+	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
+		retval = fn(iter->refname, iter->oid, iter->flags, cb_data);
+		if (retval) {
+			/*
+			 * If ref_iterator_abort() returns ITER_ERROR,
+			 * we ignore that error in deference to the
+			 * callback function's return value.
+			 */
+			ref_iterator_abort(iter);
+			goto out;
+		}
+	}
+
+out:
+	current_ref_iter = old_ref_iter;
+	if (ok == ITER_ERROR)
+		return -1;
+	return retval;
+}
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index fc2088b..f73e022 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -443,18 +443,29 @@ struct ref_iterator_vtable {
 };
 
 /*
- * Call fn for each reference in the specified submodule for which the
- * refname begins with prefix. If trim is non-zero, then trim that
- * many characters off the beginning of each refname before passing
- * the refname to fn. flags can be DO_FOR_EACH_INCLUDE_BROKEN to
- * include broken references in the iteration. If fn ever returns a
- * non-zero value, stop the iteration and return that value;
- * otherwise, return 0.
- *
- * This is the common backend for the for_each_*ref* functions.
+ * current_ref_iter is a performance hack: when iterating over
+ * references using the for_each_ref*() functions, current_ref_iter is
+ * set to the reference iterator before calling the callback function.
+ * If the callback function calls peel_ref(), then peel_ref() first
+ * checks whether the reference to be peeled is the one referred to by
+ * the iterator (it usually is) and if so, asks the iterator for the
+ * peeled version of the reference if it is available. This avoids a
+ * refname lookup in a common case. current_ref_iter is set to NULL
+ * when the iteration is over.
  */
-int do_for_each_ref(const char *submodule, const char *prefix,
-		    each_ref_fn fn, int trim, int flags, void *cb_data);
+extern struct ref_iterator *current_ref_iter;
+
+/*
+ * The common backend for the for_each_*ref* functions. Call fn for
+ * each reference in iter. If the iterator itself ever returns
+ * ITER_ERROR, return -1. If fn ever returns a non-zero value, stop
+ * the iteration and return that value. Otherwise, return 0. In any
+ * case, free the iterator when done. This function is basically an
+ * adapter between the callback style of reference iteration and the
+ * iterator style.
+ */
+int do_for_each_ref_iterator(struct ref_iterator *iter,
+			     each_ref_fn fn, void *cb_data);
 
 /*
  * Read the specified reference from the filesystem or packed refs
-- 
2.8.1

