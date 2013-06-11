From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/12] refs: implement simple transactions for the packed-refs file
Date: Tue, 11 Jun 2013 23:48:24 +0200
Message-ID: <1370987312-6761-5-git-send-email-mhagger@alum.mit.edu>
References: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 23:49:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWRD-0003pA-0E
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 23:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756554Ab3FKVtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 17:49:04 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:47724 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756474Ab3FKVs7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 17:48:59 -0400
X-AuditID: 12074411-b7f296d000001209-ba-51b79b4aabdb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id D2.35.04617.A4B97B15; Tue, 11 Jun 2013 17:48:58 -0400 (EDT)
Received: from michael.fritz.box (p57A251F0.dip0.t-ipconnect.de [87.162.81.240])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5BLmbis015717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jun 2013 17:48:56 -0400
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsUixO6iqOs1e3ugwe97fBZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTtj04cu1oJ/nhVPv7M3ML616WLk4JAQMJGYfLKki5ETyBSTuHBvPRuILSRwmVHi2fPi
	LkYuIPsCk8S9YxeYQRJsAroSi3qamUBsEQE1iYlth1hAipgF2hkl3jXvAysSFgiWeD6zC6yI
	RUBV4vDvT6wgy3gFnCVe/FGGWCYn8f7OLhYQm1PARWLj5s3MEIudJb73NDFOYORdwMiwilEu
	Mac0Vzc3MTOnODVZtzg5MS8vtUjXVC83s0QvNaV0EyMknAR3MM44KXeIUYCDUYmH94DZ9kAh
	1sSy4srcQ4ySHExKorxs04BCfEn5KZUZicUZ8UWlOanFhxglOJiVRHh1c4FyvCmJlVWpRfkw
	KWkOFiVxXr4l6n5CAumJJanZqakFqUUwWRkODiUJ3rszgRoFi1LTUyvSMnNKENJMHJwgggtk
	Aw/QBr5ZIBuKCxJzizPTIYpOMSpKifM+ApkgAJLIKM2DGwCL/FeM4kD/CPNeBKniASYNuO5X
	QIOZgAYXZYANLklESEk1MDLt3XeYT/TRNMNe60vNnE2HZucHsS85IqgvFfFNon3/gr6iKvv5
	SqZ34wMOTHaXOX39Km/kHltJP4EdK78se621Y9+ByuCfuQsFPxyY5Fb+lekO+6zJH3tPmCl7
	9C3Z4tRy6vmOa0VucrudNZ07XhwRstL69Vlgg6f0jqNF6ZZMhb3Ml01n8SqxFGck 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227523>

Handle simple transactions for the packed-refs file at the
packed_ref_cache level via new functions lock_packed_refs(),
commit_packed_refs(), and rollback_packed_refs().

Only allow the packed ref cache to be modified (via add_packed_ref())
while the packed refs file is locked.

Change clone to add the new references within a transaction.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
The API docs are not clear about whether it is kosher to read
lock_file::fd directly.  It is only done in one file outside of
lockfile.c.  So this patch stores the fd of the lockfile separately in
struct packed_ref_cache, even though the same struct also has a
pointer to the struct lock_file.

So please let me know if it is OK to read lock_file::fd directly.  If
so, then I will drop the fd member of struct packed_ref_cache, as well
as the local variable "fd" in lock_packed_refs().

 builtin/clone.c |  7 ++++-
 refs.c          | 91 +++++++++++++++++++++++++++++++++++++++++++++++----------
 refs.h          | 27 +++++++++++++++--
 3 files changed, 106 insertions(+), 19 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 66bff57..b0c000a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -489,17 +489,22 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 	return local_refs;
 }
 
+static struct lock_file packed_refs_lock;
+
 static void write_remote_refs(const struct ref *local_refs)
 {
 	const struct ref *r;
 
+	lock_packed_refs(&packed_refs_lock, LOCK_DIE_ON_ERROR);
+
 	for (r = local_refs; r; r = r->next) {
 		if (!r->peer_ref)
 			continue;
 		add_packed_ref(r->peer_ref->name, r->old_sha1);
 	}
 
-	pack_refs(PACK_REFS_ALL);
+	if (commit_packed_refs())
+		die_errno("unable to overwrite old ref-pack file");
 }
 
 static void write_followtags(const struct ref *refs, const char *msg)
diff --git a/refs.c b/refs.c
index 4cee36b..114bd5b 100644
--- a/refs.c
+++ b/refs.c
@@ -804,6 +804,16 @@ static int is_refname_available(const char *refname, const char *oldrefname,
 
 struct packed_ref_cache {
 	struct ref_entry *root;
+
+	/*
+	 * Iff the packed-refs file associated with this instance is
+	 * currently locked for writing, this points at the associated
+	 * lock (which is owned by somebody else).
+	 */
+	struct lock_file *lock;
+
+	/* If locked, the file descriptor of the lock file. */
+	int fd;
 };
 
 /*
@@ -825,6 +835,8 @@ static struct ref_cache {
 static void clear_packed_ref_cache(struct ref_cache *refs)
 {
 	if (refs->packed) {
+		if (refs->packed->lock)
+			die("internal error: packed-ref cache cleared while locked");
 		free_ref_entry(refs->packed->root);
 		free(refs->packed);
 		refs->packed = NULL;
@@ -1009,6 +1021,7 @@ static struct packed_ref_cache *get_packed_ref_cache(struct ref_cache *refs)
 
 		refs->packed = xcalloc(1, sizeof(*refs->packed));
 		refs->packed->root = create_dir_entry(refs, "", 0, 0);
+		refs->packed->fd = -1;
 		if (*refs->name)
 			packed_refs_file = git_path_submodule(refs->name, "packed-refs");
 		else
@@ -1034,7 +1047,12 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 
 void add_packed_ref(const char *refname, const unsigned char *sha1)
 {
-	add_ref(get_packed_refs(&ref_cache),
+	struct packed_ref_cache *packed_ref_cache =
+		get_packed_ref_cache(&ref_cache);
+
+	if (!packed_ref_cache->lock)
+		die("internal error: packed refs not locked");
+	add_ref(get_packed_ref_dir(packed_ref_cache),
 		create_ref_entry(refname, sha1, REF_ISPACKED, 1));
 }
 
@@ -2031,6 +2049,56 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
+int lock_packed_refs(struct lock_file *lock, int flags)
+{
+	int fd;
+	struct packed_ref_cache *packed_ref_cache;
+
+	/* Discard the old cache because it might be invalid: */
+	clear_packed_ref_cache(&ref_cache);
+	fd = hold_lock_file_for_update(lock, git_path("packed-refs"), flags);
+	if (fd < 0)
+		return -1;
+	/* Read the current packed-refs while holding the lock: */
+	packed_ref_cache = get_packed_ref_cache(&ref_cache);
+	packed_ref_cache->lock = lock;
+	packed_ref_cache->fd = fd;
+	return 0;
+}
+
+int commit_packed_refs(void)
+{
+	struct packed_ref_cache *packed_ref_cache =
+		get_packed_ref_cache(&ref_cache);
+	int fd = packed_ref_cache->fd;
+	int error = 0;
+
+	if (!packed_ref_cache->lock)
+		die("internal error: packed-refs not locked");
+	write_or_die(fd, PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER));
+
+	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
+				 0, write_packed_entry_fn, &fd);
+	if (commit_lock_file(packed_ref_cache->lock))
+		error = -1;
+	packed_ref_cache->lock = NULL;
+	packed_ref_cache->fd = -1;
+	return error;
+}
+
+void rollback_packed_refs(void)
+{
+	struct packed_ref_cache *packed_ref_cache =
+		get_packed_ref_cache(&ref_cache);
+
+	if (!packed_ref_cache->lock)
+		die("internal error: packed-refs not locked");
+	rollback_lock_file(packed_ref_cache->lock);
+	packed_ref_cache->lock = NULL;
+	packed_ref_cache->fd = -1;
+	clear_packed_ref_cache(&ref_cache);
+}
+
 struct ref_to_prune {
 	struct ref_to_prune *next;
 	unsigned char sha1[20];
@@ -2149,23 +2217,19 @@ static struct lock_file packlock;
 int pack_refs(unsigned int flags)
 {
 	struct pack_refs_cb_data cbdata;
-	int fd;
 
 	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.flags = flags;
 
-	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"),
-				       LOCK_DIE_ON_ERROR);
+	lock_packed_refs(&packlock, LOCK_DIE_ON_ERROR);
 	cbdata.packed_refs = get_packed_refs(&ref_cache);
 
 	do_for_each_entry_in_dir(get_loose_refs(&ref_cache), 0,
 				 pack_if_possible_fn, &cbdata);
 
-	write_or_die(fd, PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER));
-	do_for_each_entry_in_dir(cbdata.packed_refs, 0, write_packed_entry_fn, &fd);
-
-	if (commit_lock_file(&packlock) < 0)
+	if (commit_packed_refs())
 		die_errno("unable to overwrite old ref-pack file");
+
 	prune_refs(cbdata.ref_to_prune);
 	return 0;
 }
@@ -2222,7 +2286,6 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 
 static int repack_without_ref(const char *refname)
 {
-	int fd;
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
 	struct string_list_item *ref_to_delete;
@@ -2230,12 +2293,10 @@ static int repack_without_ref(const char *refname)
 	if (!get_packed_ref(refname))
 		return 0; /* refname does not exist in packed refs */
 
-	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
-	if (fd < 0) {
+	if (lock_packed_refs(&packlock, 0)) {
 		unable_to_lock_error(git_path("packed-refs"), errno);
 		return error("cannot delete '%s' from packed refs", refname);
 	}
-	clear_packed_ref_cache(&ref_cache);
 	packed = get_packed_refs(&ref_cache);
 	/* Remove refname from the cache. */
 	if (remove_entry(packed, refname) == -1) {
@@ -2243,7 +2304,7 @@ static int repack_without_ref(const char *refname)
 		 * The packed entry disappeared while we were
 		 * acquiring the lock.
 		 */
-		rollback_lock_file(&packlock);
+		rollback_packed_refs();
 		return 0;
 	}
 	do_for_each_entry_in_dir(packed, 0, curate_packed_ref_fn, &refs_to_delete);
@@ -2251,9 +2312,7 @@ static int repack_without_ref(const char *refname)
 		if (remove_entry(packed, ref_to_delete->string) == -1)
 			die("internal error");
 	}
-	write_or_die(fd, PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER));
-	do_for_each_entry_in_dir(packed, 0, write_packed_entry_fn, &fd);
-	return commit_lock_file(&packlock);
+	return commit_packed_refs();
 }
 
 int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
diff --git a/refs.h b/refs.h
index 246bf60..b275124 100644
--- a/refs.h
+++ b/refs.h
@@ -77,12 +77,35 @@ extern int for_each_rawref(each_ref_fn, void *);
 extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname);
 
 /*
- * Add a reference to the in-memory packed reference cache.  To actually
- * write the reference to the packed-refs file, call pack_refs().
+ * Lock the packed-refs file for writing using the specified lock_file
+ * instance.  Flags is passed to hold_lock_file_for_update().  Return
+ * 0 on success.
+ */
+extern int lock_packed_refs(struct lock_file *lock, int flags);
+
+/*
+ * Add a reference to the in-memory packed reference cache.  This may
+ * only be called while the packed-refs file is locked (see
+ * lock_packed_refs()).  To actually write the packed-refs file, call
+ * commit_packed_refs().
  */
 extern void add_packed_ref(const char *refname, const unsigned char *sha1);
 
 /*
+ * Write the current version of the packed refs cache from memory to
+ * disk.  The packed-refs file must already be locked for writing (see
+ * lock_packed_refs()).  Return zero on success.
+ */
+extern int commit_packed_refs(void);
+
+/*
+ * Rollback the lockfile for the packed-refs file, and discard the
+ * in-memory packed reference cache.  (The packed-refs file will be
+ * read anew if it is needed again after this function is called.)
+ */
+extern void rollback_packed_refs(void);
+
+/*
  * Flags for controlling behaviour of pack_refs()
  * PACK_REFS_PRUNE: Prune loose refs after packing
  * PACK_REFS_ALL:   Pack _all_ refs, not just tags and already packed refs
-- 
1.8.3
