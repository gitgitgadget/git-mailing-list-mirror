From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 04/12] refs: implement simple transactions for the packed-refs file
Date: Thu, 20 Jun 2013 10:37:46 +0200
Message-ID: <1371717474-28942-5-git-send-email-mhagger@alum.mit.edu>
References: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 10:38:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpaO8-00075w-1g
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 10:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935330Ab3FTIiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 04:38:17 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:57456 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932757Ab3FTIiO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jun 2013 04:38:14 -0400
X-AuditID: 12074413-b7f136d000006de1-7c-51c2bf75b4a3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 99.03.28129.57FB2C15; Thu, 20 Jun 2013 04:38:13 -0400 (EDT)
Received: from michael.fritz.box (p57A25408.dip0.t-ipconnect.de [87.162.84.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5K8c0sC001560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Jun 2013 04:38:12 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqFu6/1Cgwdw92hZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLXZPW8DmwObx9/0HJo9LL7+zeTzr3cPocfGSssfjiSdYPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzni7+zlTwS6Hikcd7cwNjF9Nuhg5OSQETCSm/PrACGGLSVy4t56t
	i5GLQ0jgMqNEy54+KOcck8TlBX+ZQarYBHQlFvU0M4HYIgJqEhPbDrGAFDEL7GaUWH76FDtI
	QlggTOLL1XOsXYwcHCwCqhIrLqqDhHkFXCQenzrOBrFNQWLKw/dgMzkFXCXeHJ7DCmILAdVs
	3bWDdQIj7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuuZ6uZkleqkppZsYIYEmvINx10m5
	Q4wCHIxKPLyalw8GCrEmlhVX5h5ilORgUhLlnbvvUKAQX1J+SmVGYnFGfFFpTmrxIUYJDmYl
	Ed7UOUA53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IEbxrIUMGi1PTU
	irTMnBKENBMHJ4jgAtnAA7RhGUghb3FBYm5xZjpE0SlGRSlx3lUgCQGQREZpHtwAWEp4xSgO
	9I8wbzRIFQ8wncB1vwIazAQ0eM9qsMEliQgpqQZGVVfLmsydjifzFoTkmi5Lj+1cOflhY5eP
	2qXjFsrLAlyENu1YcPj0Xa2obZcdjtprerpyiaZlVs1lilrzdu6SxOUZh4UPvXnaLnChollq
	/Z2UxWURrWVG/+QFrJe8nhhjwjdPxOhlxRTlf3wK33bIcU7Lnv+R51LOUoseu2Nx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228454>

Handle simple transactions for the packed-refs file at the
packed_ref_cache level via new functions lock_packed_refs(),
commit_packed_refs(), and rollback_packed_refs().

Only allow the packed ref cache to be modified (via add_packed_ref())
while the packed refs file is locked.

Change clone to add the new references within a transaction.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/clone.c |  5 +++-
 refs.c          | 88 +++++++++++++++++++++++++++++++++++++++++++++------------
 refs.h          | 26 +++++++++++++++--
 3 files changed, 98 insertions(+), 21 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 66bff57..14b1323 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -493,13 +493,16 @@ static void write_remote_refs(const struct ref *local_refs)
 {
 	const struct ref *r;
 
+	lock_packed_refs(LOCK_DIE_ON_ERROR);
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
index 373d95b..b345799 100644
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
@@ -826,9 +833,14 @@ static struct ref_cache {
 	char name[1];
 } ref_cache, *submodule_ref_caches;
 
+/* Lock used for the main packed-refs file: */
+static struct lock_file packlock;
+
 static void clear_packed_ref_cache(struct ref_cache *refs)
 {
 	if (refs->packed) {
+		if (refs->packed->lock)
+			die("internal error: packed-ref cache cleared while locked");
 		free_ref_entry(refs->packed->root);
 		free(refs->packed);
 		refs->packed = NULL;
@@ -1038,7 +1050,12 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 
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
 
@@ -2035,6 +2052,52 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
+int lock_packed_refs(int flags)
+{
+	struct packed_ref_cache *packed_ref_cache;
+
+	/* Discard the old cache because it might be invalid: */
+	clear_packed_ref_cache(&ref_cache);
+	if (hold_lock_file_for_update(&packlock, git_path("packed-refs"), flags) < 0)
+		return -1;
+	/* Read the current packed-refs while holding the lock: */
+	packed_ref_cache = get_packed_ref_cache(&ref_cache);
+	packed_ref_cache->lock = &packlock;
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
@@ -2148,28 +2211,22 @@ static void prune_refs(struct ref_to_prune *r)
 	}
 }
 
-static struct lock_file packlock;
-
 int pack_refs(unsigned int flags)
 {
 	struct pack_refs_cb_data cbdata;
-	int fd;
 
 	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.flags = flags;
 
-	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"),
-				       LOCK_DIE_ON_ERROR);
+	lock_packed_refs(LOCK_DIE_ON_ERROR);
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
@@ -2233,7 +2290,6 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 
 static int repack_without_ref(const char *refname)
 {
-	int fd;
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
 	struct string_list_item *ref_to_delete;
@@ -2241,12 +2297,10 @@ static int repack_without_ref(const char *refname)
 	if (!get_packed_ref(refname))
 		return 0; /* refname does not exist in packed refs */
 
-	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
-	if (fd < 0) {
+	if (lock_packed_refs(0)) {
 		unable_to_lock_error(git_path("packed-refs"), errno);
 		return error("cannot delete '%s' from packed refs", refname);
 	}
-	clear_packed_ref_cache(&ref_cache);
 	packed = get_packed_refs(&ref_cache);
 
 	/* Remove refname from the cache: */
@@ -2255,7 +2309,7 @@ static int repack_without_ref(const char *refname)
 		 * The packed entry disappeared while we were
 		 * acquiring the lock.
 		 */
-		rollback_lock_file(&packlock);
+		rollback_packed_refs();
 		return 0;
 	}
 
@@ -2267,9 +2321,7 @@ static int repack_without_ref(const char *refname)
 	}
 
 	/* Write what remains: */
-	write_or_die(fd, PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER));
-	do_for_each_entry_in_dir(packed, 0, write_packed_entry_fn, &fd);
-	return commit_lock_file(&packlock);
+	return commit_packed_refs();
 }
 
 int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
diff --git a/refs.h b/refs.h
index 246bf60..9e5db3a 100644
--- a/refs.h
+++ b/refs.h
@@ -77,12 +77,34 @@ extern int for_each_rawref(each_ref_fn, void *);
 extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname);
 
 /*
- * Add a reference to the in-memory packed reference cache.  To actually
- * write the reference to the packed-refs file, call pack_refs().
+ * Lock the packed-refs file for writing.  Flags is passed to
+ * hold_lock_file_for_update().  Return 0 on success.
+ */
+extern int lock_packed_refs(int flags);
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
