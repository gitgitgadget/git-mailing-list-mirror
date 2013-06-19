From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/12] refs: implement simple transactions for the packed-refs file
Date: Wed, 19 Jun 2013 09:51:25 +0200
Message-ID: <1371628293-28824-5-git-send-email-mhagger@alum.mit.edu>
References: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 09:52:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpDBa-0002ed-Nf
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 09:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756658Ab3FSHv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 03:51:57 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:46208 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756651Ab3FSHvz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jun 2013 03:51:55 -0400
X-AuditID: 12074412-b7f656d00000102f-a9-51c1631afa80
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 40.27.04143.A1361C15; Wed, 19 Jun 2013 03:51:54 -0400 (EDT)
Received: from michael.berlin.jpk.com (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5J7pZWW002453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Jun 2013 03:51:52 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqCuVfDDQ4Hsrp0XXlW4mi4beK8wW
	8+7uYrK4vWI+s8WPlh5mi93TFrA5sHn8ff+ByePSy+9sHs969zB6XLyk7PF44glWj8+b5ALY
	orhtkhJLyoIz0/P07RK4M+Y8ec1e8N6hYsUymQbGdaZdjJwcEgImEpt3N7JB2GISF+6tB7K5
	OIQELjNK/Di9lB3Cuc0ksWv9IhaQKjYBXYlFPc1MILaIgJrExLZDLCBFzAK7GSWWnz7FDpIQ
	FgiTuNl1GqyIRUBV4tmR88wgNq+Ai8T6m7dZINYpSEx5+B4ozsHBKeAqcXaZJ0hYCKhk3qnJ
	rBMYeRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXTy80s0UtNKd3ECAkzoR2M60/KHWIU
	4GBU4uFtWHkgUIg1say4MvcQoyQHk5IoL3vSwUAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrx6
	DkA53pTEyqrUonyYlDQHi5I478/F6n5CAumJJanZqakFqUUwWRkODiUJ3jCQoYJFqempFWmZ
	OSUIaSYOThDBBbKBB2hDKUghb3FBYm5xZjpE0SlGRSlx3kiQhABIIqM0D24ALCG8YhQH+keY
	txqkigeYTOC6XwENZgIaLPR9H8jgkkSElFQDo427oWeHpcH+xWkREe2dKQzF/xomCytIHmvu
	vLF9Vf55875vjJyHD/w80cClteDnlESvz6+yrxi+2cztGVl8+rpFlRe7CsPB13EuWdxyZXe1
	q5ISPvxn+9bmJf/Optz5dG/WMsbZayzP6eyZ+OBElfuj0wsXJRbK9tufPSRzRC2f 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228360>

Handle simple transactions for the packed-refs file at the
packed_ref_cache level via new functions lock_packed_refs(),
commit_packed_refs(), and rollback_packed_refs().

Only allow the packed ref cache to be modified (via add_packed_ref())
while the packed refs file is locked.

Change clone to add the new references within a transaction.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/clone.c |  7 ++++-
 refs.c          | 83 ++++++++++++++++++++++++++++++++++++++++++++++-----------
 refs.h          | 27 +++++++++++++++++--
 3 files changed, 98 insertions(+), 19 deletions(-)

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
index 373d95b..ad73251 100644
--- a/refs.c
+++ b/refs.c
@@ -808,6 +808,13 @@ static int is_refname_available(const char *refname, const char *oldrefname,
 
 struct packed_ref_cache {
 	struct ref_entry *root;
+
+	/*
+	 * Iff the packed-refs file associated with this instance is
+	 * currently locked for writing, this points at the associated
+	 * lock (which is owned by somebody else).
+	 */
+	struct lock_file *lock;
 };
 
 /*
@@ -829,6 +836,8 @@ static struct ref_cache {
 static void clear_packed_ref_cache(struct ref_cache *refs)
 {
 	if (refs->packed) {
+		if (refs->packed->lock)
+			die("internal error: packed-ref cache cleared while locked");
 		free_ref_entry(refs->packed->root);
 		free(refs->packed);
 		refs->packed = NULL;
@@ -1038,7 +1047,12 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 
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
 
@@ -2035,6 +2049,52 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
+int lock_packed_refs(struct lock_file *lock, int flags)
+{
+	struct packed_ref_cache *packed_ref_cache;
+
+	/* Discard the old cache because it might be invalid: */
+	clear_packed_ref_cache(&ref_cache);
+	if (hold_lock_file_for_update(lock, git_path("packed-refs"), flags) < 0)
+		return -1;
+	/* Read the current packed-refs while holding the lock: */
+	packed_ref_cache = get_packed_ref_cache(&ref_cache);
+	packed_ref_cache->lock = lock;
+	return 0;
+}
+
+int commit_packed_refs(void)
+{
+	struct packed_ref_cache *packed_ref_cache =
+		get_packed_ref_cache(&ref_cache);
+	int error = 0;
+
+	if (!packed_ref_cache->lock)
+		die("internal error: packed-refs not locked");
+	write_or_die(packed_ref_cache->lock->fd,
+		     PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER));
+
+	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
+				 0, write_packed_entry_fn,
+				 &packed_ref_cache->lock->fd);
+	if (commit_lock_file(packed_ref_cache->lock))
+		error = -1;
+	packed_ref_cache->lock = NULL;
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
+	clear_packed_ref_cache(&ref_cache);
+}
+
 struct ref_to_prune {
 	struct ref_to_prune *next;
 	unsigned char sha1[20];
@@ -2153,23 +2213,19 @@ static struct lock_file packlock;
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
@@ -2233,7 +2289,6 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 
 static int repack_without_ref(const char *refname)
 {
-	int fd;
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
 	struct string_list_item *ref_to_delete;
@@ -2241,12 +2296,10 @@ static int repack_without_ref(const char *refname)
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
 
 	/* Remove refname from the cache: */
@@ -2255,7 +2308,7 @@ static int repack_without_ref(const char *refname)
 		 * The packed entry disappeared while we were
 		 * acquiring the lock.
 		 */
-		rollback_lock_file(&packlock);
+		rollback_packed_refs();
 		return 0;
 	}
 
@@ -2267,9 +2320,7 @@ static int repack_without_ref(const char *refname)
 	}
 
 	/* Write what remains: */
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
1.8.3.1
