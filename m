From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/38] refs: rename struct ref_cache to files_ref_store
Date: Fri,  3 Jun 2016 23:03:38 +0200
Message-ID: <5d30b5d674b5b30d783f9d7ec0c1f7490f5e151e.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:05:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wHF-0000Yi-Gy
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932939AbcFCVEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:04:46 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:61278 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932365AbcFCVEb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:04:31 -0400
X-AuditID: 1207440c-c3fff70000000b85-11-5751f0dd9361
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 37.45.02949.DD0F1575; Fri,  3 Jun 2016 17:04:29 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4KcT003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:04:27 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqHv3Q2C4weUeQ4v5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGf03Z3HUvCjlbHi95H9TA2Mr3O6
	GDk5JARMJKYfesXexcjFISSwlVHi6M6bbBDOcSaJh7cnMIJUsQnoSizqaWYCsUUEIiQaXrUw
	ghQxC8xhkrj9sJO5i5GDQ1jAXaL5chhIDYuAqsSX01/YQGxegSiJvh2v2SG2yUlcnv4ALM4p
	YCHR8nkVK4gtJGAu0XjqMMsERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3QN9XIzS/RS
	U0o3MULCjmcH47d1MocYBTgYlXh4C54FhguxJpYVV+YeYpTkYFIS5d17ByjEl5SfUpmRWJwR
	X1Sak1p8iFGCg1lJhDflNVCONyWxsiq1KB8mJc3BoiTOq7pE3U9IID2xJDU7NbUgtQgmK8PB
	oSTBa/weqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFAXxxcA4AEnxAO2NAWnn
	LS5IzAWKQrSeYlSUEucNBUkIgCQySvPgxsKSyStGcaAvhXnngFTxABMRXPcroMFMQIMLHvmD
	DC5JREhJNTAaGPItfW/678YL+w1MfsdPzfsi//WCv3BG5VwBsYhVa2Y9v3DLbp5P9TvRealC
	Cx96mV2M5HziUfyWcU/VbsnjH7xWhbNvKT287D5L+uvDdY+7c3femXdLac/WLOnw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296374>

The greater goal of this patch series is to develop the concept of a
reference store, which is a place that references, their values, and
their reflogs are stored, and to virtualize the reference interface so
that different types of ref_stores can be implemented. We will then, for
example, use ref_store instances to access submodule references and
worktree references.

Currently, we keep a ref_cache for each submodule that has had its
references iterated over. It is a far cry from a ref_store, but they are
stored the way we will want to store ref_stores, and ref_stores will
eventually have to hold the reference caches. So let's treat ref_caches
as embryo ref_stores, and build them out from there.

As the first step, simply rename `ref_cache` to `files_ref_store`, and
rename some functions and attributes correspondingly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 126 +++++++++++++++++++++++++--------------------------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2f9d79a..b94aad2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -39,7 +39,7 @@ struct ref_value {
 	struct object_id peeled;
 };
 
-struct ref_cache;
+struct files_ref_store;
 
 /*
  * Information used (along with the information in ref_entry) to
@@ -78,8 +78,8 @@ struct ref_dir {
 	 */
 	int sorted;
 
-	/* A pointer to the ref_cache that contains this ref_dir. */
-	struct ref_cache *ref_cache;
+	/* A pointer to the files_ref_store that contains this ref_dir. */
+	struct files_ref_store *ref_store;
 
 	struct ref_entry **entries;
 };
@@ -161,7 +161,7 @@ struct ref_entry {
 
 static void read_loose_refs(const char *dirname, struct ref_dir *dir);
 static int search_ref_dir(struct ref_dir *dir, const char *refname, size_t len);
-static struct ref_entry *create_dir_entry(struct ref_cache *ref_cache,
+static struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
 					  const char *dirname, size_t len,
 					  int incomplete);
 static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
@@ -183,7 +183,7 @@ static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 			int pos = search_ref_dir(dir, "refs/bisect/", 12);
 			if (pos < 0) {
 				struct ref_entry *child_entry;
-				child_entry = create_dir_entry(dir->ref_cache,
+				child_entry = create_dir_entry(dir->ref_store,
 							       "refs/bisect/",
 							       12, 1);
 				add_entry_to_dir(dir, child_entry);
@@ -261,13 +261,13 @@ static void clear_ref_dir(struct ref_dir *dir)
  * dirname is the name of the directory with a trailing slash (e.g.,
  * "refs/heads/") or "" for the top-level directory.
  */
-static struct ref_entry *create_dir_entry(struct ref_cache *ref_cache,
+static struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
 					  const char *dirname, size_t len,
 					  int incomplete)
 {
 	struct ref_entry *direntry;
 	FLEX_ALLOC_MEM(direntry, name, dirname, len);
-	direntry->u.subdir.ref_cache = ref_cache;
+	direntry->u.subdir.ref_store = ref_store;
 	direntry->flag = REF_DIR | (incomplete ? REF_INCOMPLETE : 0);
 	return direntry;
 }
@@ -343,7 +343,7 @@ static struct ref_dir *search_for_subdir(struct ref_dir *dir,
 		 * therefore, create an empty record for it but mark
 		 * the record complete.
 		 */
-		entry = create_dir_entry(dir->ref_cache, subdirname, len, 0);
+		entry = create_dir_entry(dir->ref_store, subdirname, len, 0);
 		add_entry_to_dir(dir, entry);
 	} else {
 		entry = dir->entries[entry_index];
@@ -887,9 +887,9 @@ struct packed_ref_cache {
 
 	/*
 	 * Count of references to the data structure in this instance,
-	 * including the pointer from ref_cache::packed if any.  The
-	 * data will not be freed as long as the reference count is
-	 * nonzero.
+	 * including the pointer from files_ref_store::packed if any.
+	 * The data will not be freed as long as the reference count
+	 * is nonzero.
 	 */
 	unsigned int referrers;
 
@@ -910,17 +910,17 @@ struct packed_ref_cache {
  * Future: need to be in "struct repository"
  * when doing a full libification.
  */
-static struct ref_cache {
-	struct ref_cache *next;
+static struct files_ref_store {
+	struct files_ref_store *next;
 	struct ref_entry *loose;
 	struct packed_ref_cache *packed;
 	/*
-	 * The submodule name, or "" for the main repo.  We allocate
-	 * length 1 rather than FLEX_ARRAY so that the main ref_cache
-	 * is initialized correctly.
+	 * The submodule name, or "" for the main repo. We allocate
+	 * length 1 rather than FLEX_ARRAY so that the main
+	 * files_ref_store is initialized correctly.
 	 */
 	char name[1];
-} ref_cache, *submodule_ref_caches;
+} ref_store, *submodule_ref_stores;
 
 /* Lock used for the main packed-refs file: */
 static struct lock_file packlock;
@@ -949,7 +949,7 @@ static int release_packed_ref_cache(struct packed_ref_cache *packed_refs)
 	}
 }
 
-static void clear_packed_ref_cache(struct ref_cache *refs)
+static void clear_packed_ref_cache(struct files_ref_store *refs)
 {
 	if (refs->packed) {
 		struct packed_ref_cache *packed_refs = refs->packed;
@@ -961,7 +961,7 @@ static void clear_packed_ref_cache(struct ref_cache *refs)
 	}
 }
 
-static void clear_loose_ref_cache(struct ref_cache *refs)
+static void clear_loose_ref_cache(struct files_ref_store *refs)
 {
 	if (refs->loose) {
 		free_ref_entry(refs->loose);
@@ -973,32 +973,32 @@ static void clear_loose_ref_cache(struct ref_cache *refs)
  * Create a new submodule ref cache and add it to the internal
  * set of caches.
  */
-static struct ref_cache *create_ref_cache(const char *submodule)
+static struct files_ref_store *create_ref_store(const char *submodule)
 {
-	struct ref_cache *refs;
+	struct files_ref_store *refs;
 	if (!submodule)
 		submodule = "";
 	FLEX_ALLOC_STR(refs, name, submodule);
-	refs->next = submodule_ref_caches;
-	submodule_ref_caches = refs;
+	refs->next = submodule_ref_stores;
+	submodule_ref_stores = refs;
 	return refs;
 }
 
-static struct ref_cache *lookup_ref_cache(const char *submodule)
+static struct files_ref_store *lookup_ref_store(const char *submodule)
 {
-	struct ref_cache *refs;
+	struct files_ref_store *refs;
 
 	if (!submodule || !*submodule)
-		return &ref_cache;
+		return &ref_store;
 
-	for (refs = submodule_ref_caches; refs; refs = refs->next)
+	for (refs = submodule_ref_stores; refs; refs = refs->next)
 		if (!strcmp(submodule, refs->name))
 			return refs;
 	return NULL;
 }
 
 /*
- * Return a pointer to a ref_cache for the specified submodule. For
+ * Return a pointer to a files_ref_store for the specified submodule. For
  * the main repository, use submodule==NULL; such a call cannot fail.
  * For a submodule, the submodule must exist and be a nonbare
  * repository, otherwise return NULL.
@@ -1006,16 +1006,16 @@ static struct ref_cache *lookup_ref_cache(const char *submodule)
  * The returned structure will be allocated and initialized but not
  * necessarily populated; it should not be freed.
  */
-static struct ref_cache *get_ref_cache(const char *submodule)
+static struct files_ref_store *get_ref_store(const char *submodule)
 {
-	struct ref_cache *refs = lookup_ref_cache(submodule);
+	struct files_ref_store *refs = lookup_ref_store(submodule);
 
 	if (!refs) {
 		struct strbuf submodule_sb = STRBUF_INIT;
 
 		strbuf_addstr(&submodule_sb, submodule);
 		if (is_nonbare_repository_dir(&submodule_sb))
-			refs = create_ref_cache(submodule);
+			refs = create_ref_store(submodule);
 		strbuf_release(&submodule_sb);
 	}
 
@@ -1151,10 +1151,10 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 }
 
 /*
- * Get the packed_ref_cache for the specified ref_cache, creating it
- * if necessary.
+ * Get the packed_ref_cache for the specified files_ref_store,
+ * creating it if necessary.
  */
-static struct packed_ref_cache *get_packed_ref_cache(struct ref_cache *refs)
+static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *refs)
 {
 	char *packed_refs_file;
 
@@ -1189,7 +1189,7 @@ static struct ref_dir *get_packed_ref_dir(struct packed_ref_cache *packed_ref_ca
 	return get_ref_dir(packed_ref_cache->root);
 }
 
-static struct ref_dir *get_packed_refs(struct ref_cache *refs)
+static struct ref_dir *get_packed_refs(struct files_ref_store *refs)
 {
 	return get_packed_ref_dir(get_packed_ref_cache(refs));
 }
@@ -1203,7 +1203,7 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 static void add_packed_ref(const char *refname, const unsigned char *sha1)
 {
 	struct packed_ref_cache *packed_ref_cache =
-		get_packed_ref_cache(&ref_cache);
+		get_packed_ref_cache(&ref_store);
 
 	if (!packed_ref_cache->lock)
 		die("internal error: packed refs not locked");
@@ -1218,7 +1218,7 @@ static void add_packed_ref(const char *refname, const unsigned char *sha1)
  */
 static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 {
-	struct ref_cache *refs = dir->ref_cache;
+	struct files_ref_store *refs = dir->ref_store;
 	DIR *d;
 	struct dirent *de;
 	int dirnamelen = strlen(dirname);
@@ -1306,7 +1306,7 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 	closedir(d);
 }
 
-static struct ref_dir *get_loose_refs(struct ref_cache *refs)
+static struct ref_dir *get_loose_refs(struct files_ref_store *refs)
 {
 	if (!refs->loose) {
 		/*
@@ -1328,10 +1328,10 @@ static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 
 /*
  * Called by resolve_gitlink_ref_recursive() after it failed to read
- * from the loose refs in ref_cache refs. Find <refname> in the
- * packed-refs file for the submodule.
+ * from the loose refs in refs. Find <refname> in the packed-refs file
+ * for the submodule.
  */
-static int resolve_gitlink_packed_ref(struct ref_cache *refs,
+static int resolve_gitlink_packed_ref(struct files_ref_store *refs,
 				      const char *refname, unsigned char *sha1)
 {
 	struct ref_entry *ref;
@@ -1345,7 +1345,7 @@ static int resolve_gitlink_packed_ref(struct ref_cache *refs,
 	return 0;
 }
 
-static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
+static int resolve_gitlink_ref_recursive(struct files_ref_store *refs,
 					 const char *refname, unsigned char *sha1,
 					 int recursion)
 {
@@ -1389,7 +1389,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
 {
 	int len = strlen(path);
 	struct strbuf submodule = STRBUF_INIT;
-	struct ref_cache *refs;
+	struct files_ref_store *refs;
 
 	while (len && path[len-1] == '/')
 		len--;
@@ -1397,7 +1397,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
 		return -1;
 
 	strbuf_add(&submodule, path, len);
-	refs = get_ref_cache(submodule.buf);
+	refs = get_ref_store(submodule.buf);
 	if (!refs) {
 		strbuf_release(&submodule);
 		return -1;
@@ -1413,7 +1413,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
  */
 static struct ref_entry *get_packed_ref(const char *refname)
 {
-	return find_ref(get_packed_refs(&ref_cache), refname);
+	return find_ref(get_packed_refs(&ref_store), refname);
 }
 
 /*
@@ -1745,7 +1745,7 @@ retry:
 							  REMOVE_DIR_EMPTY_ONLY)) {
 				if (verify_refname_available_dir(
 						    refname, extras, skip,
-						    get_loose_refs(&ref_cache),
+						    get_loose_refs(&ref_store),
 						    err)) {
 					/*
 					 * The error message set by
@@ -1784,7 +1784,7 @@ retry:
 		 */
 		if (verify_refname_available_dir(
 				    refname, extras, skip,
-				    get_packed_refs(&ref_cache),
+				    get_packed_refs(&ref_store),
 				    err)) {
 			goto error_return;
 		}
@@ -1942,7 +1942,7 @@ struct ref_iterator *files_ref_iterator_begin(
 		const char *submodule,
 		const char *prefix, unsigned int flags)
 {
-	struct ref_cache *refs = get_ref_cache(submodule);
+	struct files_ref_store *refs = get_ref_store(submodule);
 	struct ref_dir *loose_dir, *packed_dir;
 	struct ref_iterator *loose_iter, *packed_iter;
 	struct files_ref_iterator *iter;
@@ -2096,7 +2096,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		if (remove_empty_directories(&ref_file)) {
 			last_errno = errno;
 			if (!verify_refname_available_dir(refname, extras, skip,
-							  get_loose_refs(&ref_cache), err))
+							  get_loose_refs(&ref_store), err))
 				strbuf_addf(err, "there are still refs under '%s'",
 					    refname);
 			goto error_return;
@@ -2108,7 +2108,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		last_errno = errno;
 		if (last_errno != ENOTDIR ||
 		    !verify_refname_available_dir(refname, extras, skip,
-						  get_loose_refs(&ref_cache), err))
+						  get_loose_refs(&ref_store), err))
 			strbuf_addf(err, "unable to resolve reference '%s': %s",
 				    refname, strerror(last_errno));
 
@@ -2123,7 +2123,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 */
 	if (is_null_oid(&lock->old_oid) &&
 	    verify_refname_available_dir(refname, extras, skip,
-					 get_packed_refs(&ref_cache), err)) {
+					 get_packed_refs(&ref_store), err)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2232,7 +2232,7 @@ static int lock_packed_refs(int flags)
 	 * this will automatically invalidate the cache and re-read
 	 * the packed-refs file.
 	 */
-	packed_ref_cache = get_packed_ref_cache(&ref_cache);
+	packed_ref_cache = get_packed_ref_cache(&ref_store);
 	packed_ref_cache->lock = &packlock;
 	/* Increment the reference count to prevent it from being freed: */
 	acquire_packed_ref_cache(packed_ref_cache);
@@ -2248,7 +2248,7 @@ static int lock_packed_refs(int flags)
 static int commit_packed_refs(void)
 {
 	struct packed_ref_cache *packed_ref_cache =
-		get_packed_ref_cache(&ref_cache);
+		get_packed_ref_cache(&ref_store);
 	int error = 0;
 	int save_errno = 0;
 	FILE *out;
@@ -2282,14 +2282,14 @@ static int commit_packed_refs(void)
 static void rollback_packed_refs(void)
 {
 	struct packed_ref_cache *packed_ref_cache =
-		get_packed_ref_cache(&ref_cache);
+		get_packed_ref_cache(&ref_store);
 
 	if (!packed_ref_cache->lock)
 		die("internal error: packed-refs not locked");
 	rollback_lock_file(packed_ref_cache->lock);
 	packed_ref_cache->lock = NULL;
 	release_packed_ref_cache(packed_ref_cache);
-	clear_packed_ref_cache(&ref_cache);
+	clear_packed_ref_cache(&ref_store);
 }
 
 struct ref_to_prune {
@@ -2428,9 +2428,9 @@ int pack_refs(unsigned int flags)
 	cbdata.flags = flags;
 
 	lock_packed_refs(LOCK_DIE_ON_ERROR);
-	cbdata.packed_refs = get_packed_refs(&ref_cache);
+	cbdata.packed_refs = get_packed_refs(&ref_store);
 
-	do_for_each_entry_in_dir(get_loose_refs(&ref_cache), 0,
+	do_for_each_entry_in_dir(get_loose_refs(&ref_store), 0,
 				 pack_if_possible_fn, &cbdata);
 
 	if (commit_packed_refs())
@@ -2471,7 +2471,7 @@ static int repack_without_refs(struct string_list *refnames, struct strbuf *err)
 		unable_to_lock_message(git_path("packed-refs"), errno, err);
 		return -1;
 	}
-	packed = get_packed_refs(&ref_cache);
+	packed = get_packed_refs(&ref_store);
 
 	/* Remove refnames from the cache */
 	for_each_string_list_item(refname, refnames)
@@ -2616,8 +2616,8 @@ int verify_refname_available(const char *newname,
 			     const struct string_list *skip,
 			     struct strbuf *err)
 {
-	struct ref_dir *packed_refs = get_packed_refs(&ref_cache);
-	struct ref_dir *loose_refs = get_loose_refs(&ref_cache);
+	struct ref_dir *packed_refs = get_packed_refs(&ref_store);
+	struct ref_dir *loose_refs = get_loose_refs(&ref_store);
 
 	if (verify_refname_available_dir(newname, extras, skip,
 					 packed_refs, err) ||
@@ -2968,7 +2968,7 @@ static int commit_ref_update(struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg,
 			     struct strbuf *err)
 {
-	clear_loose_ref_cache(&ref_cache);
+	clear_loose_ref_cache(&ref_store);
 	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, 0, err)) {
 		char *old_msg = strbuf_detach(err, NULL);
 		strbuf_addf(err, "cannot update the ref '%s': %s",
@@ -3790,7 +3790,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			}
 		}
 		if (update->flags & REF_NEEDS_COMMIT) {
-			clear_loose_ref_cache(&ref_cache);
+			clear_loose_ref_cache(&ref_store);
 			if (commit_ref(lock)) {
 				strbuf_addf(err, "couldn't set '%s'", lock->ref_name);
 				unlock_ref(lock);
@@ -3823,7 +3823,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	}
 	for_each_string_list_item(ref_to_delete, &refs_to_delete)
 		unlink_or_warn(git_path("logs/%s", ref_to_delete->string));
-	clear_loose_ref_cache(&ref_cache);
+	clear_loose_ref_cache(&ref_store);
 
 cleanup:
 	transaction->state = REF_TRANSACTION_CLOSED;
-- 
2.8.1
