From: mhagger@alum.mit.edu
Subject: [PATCH 14/15] refs: store references hierarchically
Date: Tue, 10 Apr 2012 07:30:26 +0200
Message-ID: <1334035827-20331-15-git-send-email-mhagger@alum.mit.edu>
References: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 07:31:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHTg1-0002SQ-Mf
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 07:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785Ab2DJFb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 01:31:27 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59270 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391Ab2DJFbX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 01:31:23 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0B8CA.dip.t-dialin.net [79.192.184.202])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3A5UXe7000870;
	Tue, 10 Apr 2012 07:31:05 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195070>

From: Michael Haggerty <mhagger@alum.mit.edu>

Store references hierarchically in a tree that matches the
pseudo-directory structure of the reference names.  Add a new kind of
ref_entry (with flag REF_DIR) to represent a whole subdirectory of
references.  Sort ref_dirs one subdirectory at a time.

NOTE: the dirs can now be sorted as a side-effect of other function
calls.  Therefore, it would be problematic to do something from a
each_ref_fn callback that could provoke the sorting of a directory
that is currently being iterated over (i.e., the directory containing
the entry that is being processed or any of its parents).

This is a bit far-fetched, because a directory is always sorted just
before being iterated over.  Therefore, read-only accesses cannot
trigger the sorting of a directory whose iteration has already
started.  But if a callback function would add a reference to a parent
directory of the reference in the iteration, then try to resolve a
reference under that directory, a re-sort could be triggered and cause
the iteration to work incorrectly.

Nevertheless...add a comment in refs.h warning against modifications
during iteration.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |  274 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 refs.h |    7 +-
 2 files changed, 232 insertions(+), 49 deletions(-)

diff --git a/refs.c b/refs.c
index a3b8428..cdfb53d 100644
--- a/refs.c
+++ b/refs.c
@@ -120,15 +120,54 @@ struct ref_dir {
 	struct ref_entry **entries;
 };
 
-/* ISSYMREF=0x01, ISPACKED=0x02 and ISBROKEN=0x04 are public interfaces */
-#define REF_KNOWS_PEELED 0x10
+/* ISSYMREF=0x01, ISPACKED=0x02, and ISBROKEN=0x04 are public interfaces */
+#define REF_KNOWS_PEELED 0x08
+#define REF_DIR 0x10
 
+/*
+ * A ref_entry represents either a reference or a "subdirectory" of
+ * references.  Each directory in the reference namespace is
+ * represented by a ref_entry with (flags & REF_DIR) set and
+ * containing a subdir member that holds the entries in that
+ * directory.  References are represented by a ref_entry with (flags &
+ * REF_DIR) unset and a value member that describes the reference's
+ * value.  The flag member is at the ref_entry level, but it is also
+ * needed to interpret the contents of the value field (in other
+ * words, a ref_value object is not very much use without the
+ * enclosing ref_entry).
+ *
+ * Reference names cannot end with slash and directories' names are
+ * always stored with a trailing slash (except for the top-level
+ * directory, which is always denoted by "").  This has two nice
+ * consequences: (1) when the entries in each subdir are sorted
+ * lexicographically by name (as they usually are), the references in
+ * a whole tree can be generated in lexicographic order by traversing
+ * the tree in left-to-right, depth-first order; (2) the names of
+ * references and subdirectories cannot conflict, and therefore the
+ * presence of an empty subdirectory does not block the creation of a
+ * similarly-named reference.  (The fact that reference names with the
+ * same leading components can conflict *with each other* is a
+ * separate issue that is regulated by is_refname_available().)
+ *
+ * Please note that the name field contains the fully-qualified
+ * reference (or subdirectory) name.  Space could be saved by only
+ * storing the relative names.  But that would require the full names
+ * to be generated on the fly when iterating in do_for_each_ref(), and
+ * would break callback functions, who have always been able to assume
+ * that the name strings that they are passed will not be freed during
+ * the iteration.
+ */
 struct ref_entry {
 	unsigned char flag; /* ISSYMREF? ISPACKED? */
 	union {
-		struct ref_value value;
+		struct ref_value value; /* if not (flags&REF_DIR) */
+		struct ref_dir subdir; /* if (flags&REF_DIR) */
 	} u;
-	/* The full name of the reference (e.g., "refs/heads/master"): */
+	/*
+	 * The full name of the reference (e.g., "refs/heads/master")
+	 * or the full name of the directory with a trailing slash
+	 * (e.g., "refs/heads/"):
+	 */
 	char name[FLEX_ARRAY];
 };
 
@@ -151,18 +190,29 @@ static struct ref_entry *create_ref_entry(const char *refname,
 	return ref;
 }
 
+static void clear_ref_dir(struct ref_dir *dir);
+
 static void free_ref_entry(struct ref_entry *entry)
 {
+	if (entry->flag & REF_DIR)
+		clear_ref_dir(&entry->u.subdir);
 	free(entry);
 }
 
-/* Add a ref_entry to the end of the ref_dir (unsorted). */
-static void add_ref(struct ref_dir *refs, struct ref_entry *ref)
+/*
+ * Add a ref_entry to the end of dir (unsorted).  Entry is always
+ * stored directly in dir; no recursion into subdirectories is
+ * done.
+ */
+static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry)
 {
-	ALLOC_GROW(refs->entries, refs->nr + 1, refs->alloc);
-	refs->entries[refs->nr++] = ref;
+	ALLOC_GROW(dir->entries, dir->nr + 1, dir->alloc);
+	dir->entries[dir->nr++] = entry;
 }
 
+/*
+ * Clear and free all entries in dir, recursively.
+ */
 static void clear_ref_dir(struct ref_dir *dir)
 {
 	int i;
@@ -173,6 +223,21 @@ static void clear_ref_dir(struct ref_dir *dir)
 	dir->entries = NULL;
 }
 
+/*
+ * Create a struct ref_entry object for the specified dirname.
+ * dirname is the name of the directory with a trailing slash (e.g.,
+ * "refs/heads/") or "" for the top-level directory.
+ */
+static struct ref_entry *create_dir_entry(const char *dirname)
+{
+	struct ref_entry *direntry;
+	int len = strlen(dirname);
+	direntry = xcalloc(1, sizeof(struct ref_entry) + len + 1);
+	memcpy(direntry->name, dirname, len + 1);
+	direntry->flag = REF_DIR;
+	return direntry;
+}
+
 static int ref_entry_cmp(const void *a, const void *b)
 {
 	struct ref_entry *one = *(struct ref_entry **)a;
@@ -182,17 +247,21 @@ static int ref_entry_cmp(const void *a, const void *b)
 
 static void sort_ref_dir(struct ref_dir *dir);
 
+/*
+ * Return the entry with the given refname from the ref_dir
+ * (non-recursively), sorting dir if necessary.  Return NULL if no
+ * such entry is found.
+ */
 static struct ref_entry *search_ref_dir(struct ref_dir *dir, const char *refname)
 {
 	struct ref_entry *e, **r;
 	int len;
 
-	if (refname == NULL)
+	if (refname == NULL || !dir->nr)
 		return NULL;
 
-	if (!dir->nr)
-		return NULL;
 	sort_ref_dir(dir);
+
 	len = strlen(refname) + 1;
 	e = xmalloc(sizeof(struct ref_entry) + len);
 	memcpy(e->name, refname, len);
@@ -208,27 +277,96 @@ static struct ref_entry *search_ref_dir(struct ref_dir *dir, const char *refname
 }
 
 /*
+ * If refname is a reference name, find the ref_dir within the dir
+ * tree that should hold refname.  If refname is a directory name
+ * (i.e., ends in '/'), then return that ref_dir itself.  dir must
+ * represent the top-level directory.  Sort ref_dirs and recurse into
+ * subdirectories as necessary.  If mkdir is set, then create any
+ * missing directories; otherwise, return NULL if the desired
+ * directory cannot be found.
+ */
+static struct ref_dir *find_containing_dir(struct ref_dir *dir,
+					   const char *refname, int mkdir)
+{
+	char *refname_copy = xstrdup(refname);
+	char *slash;
+	struct ref_entry *entry;
+	for (slash = strchr(refname_copy, '/'); slash; slash = strchr(slash + 1, '/')) {
+		char tmp = slash[1];
+		slash[1] = '\0';
+		entry = search_ref_dir(dir, refname_copy);
+		if (!entry) {
+			if (!mkdir) {
+				dir = NULL;
+				break;
+			}
+			entry = create_dir_entry(refname_copy);
+			add_entry_to_dir(dir, entry);
+		}
+		slash[1] = tmp;
+		assert(entry->flag & REF_DIR);
+		dir = &entry->u.subdir;
+	}
+
+	free(refname_copy);
+	return dir;
+}
+
+/*
+ * Find the value entry with the given name in dir, sorting ref_dirs
+ * and recursing into subdirectories as necessary.  If the name is not
+ * found or it corresponds to a directory entry, return NULL.
+ */
+static struct ref_entry *find_ref(struct ref_dir *dir, const char *refname)
+{
+	struct ref_entry *entry;
+	dir = find_containing_dir(dir, refname, 0);
+	if (!dir)
+		return NULL;
+	entry = search_ref_dir(dir, refname);
+	return (entry && !(entry->flag & REF_DIR)) ? entry : NULL;
+}
+
+/*
+ * Add a ref_entry to the ref_dir (unsorted), recursing into
+ * subdirectories as necessary.  dir must represent the top-level
+ * directory.  Return 0 on success.
+ */
+static int add_ref(struct ref_dir *dir, struct ref_entry *ref)
+{
+	dir = find_containing_dir(dir, ref->name, 1);
+	if (!dir)
+		return -1;
+	add_entry_to_dir(dir, ref);
+	return 0;
+}
+
+/*
  * Emit a warning and return true iff ref1 and ref2 have the same name
  * and the same sha1.  Die if they have the same name but different
  * sha1s.
  */
 static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2)
 {
-	if (!strcmp(ref1->name, ref2->name)) {
-		/* Duplicate name; make sure that the SHA1s match: */
-		if (hashcmp(ref1->u.value.sha1, ref2->u.value.sha1))
-			die("Duplicated ref, and SHA1s don't match: %s",
-			    ref1->name);
-		warning("Duplicated ref: %s", ref1->name);
-		return 1;
-	} else {
+	if (strcmp(ref1->name, ref2->name))
 		return 0;
-	}
+
+	/* Duplicate name; make sure that they don't conflict: */
+
+	if ((ref1->flag & REF_DIR) || (ref2->flag & REF_DIR))
+		/* This is impossible by construction */
+		die("Reference directory conflict: %s", ref1->name);
+
+	if (hashcmp(ref1->u.value.sha1, ref2->u.value.sha1))
+		die("Duplicated ref, and SHA1s don't match: %s", ref1->name);
+
+	warning("Duplicated ref: %s", ref1->name);
+	return 1;
 }
 
 /*
- * Sort the entries in dir (if they are not already sorted)
- * and remove any duplicate entries.
+ * Sort the entries in dir non-recursively (if they are not already
+ * sorted) and remove any duplicate entries.
  */
 static void sort_ref_dir(struct ref_dir *dir)
 {
@@ -283,8 +421,9 @@ static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 
 /*
  * Call fn for each reference in dir that has index in the range
- * offset <= index < dir->nr.  This function does not sort the dir;
- * sorting should be done by the caller.
+ * offset <= index < dir->nr.  Recurse into subdirectories that are in
+ * that index range, sorting them before iterating.  This function
+ * does not sort dir itself; it should be sorted beforehand.
  */
 static int do_for_each_ref_in_dir(struct ref_dir *dir, int offset,
 				  const char *base,
@@ -293,7 +432,15 @@ static int do_for_each_ref_in_dir(struct ref_dir *dir, int offset,
 	int i;
 	assert(dir->sorted == dir->nr);
 	for (i = offset; i < dir->nr; i++) {
-		int retval = do_one_ref(base, fn, trim, flags, cb_data, dir->entries[i]);
+		struct ref_entry *entry = dir->entries[i];
+		int retval;
+		if (entry->flag & REF_DIR) {
+			sort_ref_dir(&entry->u.subdir);
+			retval = do_for_each_ref_in_dir(&entry->u.subdir, 0,
+							base, fn, trim, flags, cb_data);
+		} else {
+			retval = do_one_ref(base, fn, trim, flags, cb_data, entry);
+		}
 		if (retval)
 			return retval;
 	}
@@ -302,9 +449,10 @@ static int do_for_each_ref_in_dir(struct ref_dir *dir, int offset,
 
 /*
  * Call fn for each reference in the union of dir1 and dir2, in order
- * by refname.  If an entry appears in both dir1 and dir2, then only
- * process the version that is in dir2.  The input dirs must already
- * be sorted.
+ * by refname.  Recurse into subdirectories.  If a value entry appears
+ * in both dir1 and dir2, then only process the version that is in
+ * dir2.  The input dirs must already be sorted, but subdirs will be
+ * sorted as needed.
  */
 static int do_for_each_ref_in_dirs(struct ref_dir *dir1,
 				   struct ref_dir *dir2,
@@ -316,22 +464,55 @@ static int do_for_each_ref_in_dirs(struct ref_dir *dir1,
 
 	assert(dir1->sorted == dir1->nr);
 	assert(dir2->sorted == dir2->nr);
-	while (i1 < dir1->nr && i2 < dir2->nr) {
-		struct ref_entry *e1 = dir1->entries[i1];
-		struct ref_entry *e2 = dir2->entries[i2];
-		int cmp = strcmp(e1->name, e2->name);
-		if (cmp < 0) {
-			retval = do_one_ref(base, fn, trim, flags, cb_data, e1);
-			i1++;
+	while (1) {
+		struct ref_entry *e1, *e2;
+		int cmp;
+		if (i1 == dir1->nr) {
+			return do_for_each_ref_in_dir(dir2, i2,
+						      base, fn, trim, flags, cb_data);
+		}
+		if (i2 == dir2->nr) {
+			return do_for_each_ref_in_dir(dir1, i1,
+						      base, fn, trim, flags, cb_data);
+		}
+		e1 = dir1->entries[i1];
+		e2 = dir2->entries[i2];
+		cmp = strcmp(e1->name, e2->name);
+		if (cmp == 0) {
+			if ((e1->flag & REF_DIR) && (e2->flag & REF_DIR)) {
+				/* Both are directories; descend them in parallel. */
+				sort_ref_dir(&e1->u.subdir);
+				sort_ref_dir(&e2->u.subdir);
+				retval = do_for_each_ref_in_dirs(
+						&e1->u.subdir, &e2->u.subdir,
+						base, fn, trim, flags, cb_data);
+				i1++;
+				i2++;
+			} else if (!(e1->flag & REF_DIR) && !(e2->flag & REF_DIR)) {
+				/* Both are references; ignore the one from dir1. */
+				retval = do_one_ref(base, fn, trim, flags, cb_data, e2);
+				i1++;
+				i2++;
+			} else {
+				die("conflict between reference and directory: %s",
+				    e1->name);
+			}
 		} else {
-			retval = do_one_ref(base, fn, trim, flags, cb_data, e2);
-			i2++;
-			if (cmp == 0) {
-				/*
-				 * There was a ref in array1 with the
-				 * same name; ignore it.
-				 */
+			struct ref_entry *e;
+			if (cmp < 0) {
+				e = e1;
 				i1++;
+			} else {
+				e = e2;
+				i2++;
+			}
+			if (e->flag & REF_DIR) {
+				sort_ref_dir(&e->u.subdir);
+				retval = do_for_each_ref_in_dir(
+						&e->u.subdir, 0,
+						base, fn, trim, flags, cb_data);
+			} else {
+				retval = do_one_ref(base, fn, trim, flags, cb_data, e);
 			}
 		}
 		if (retval)
@@ -656,7 +837,7 @@ static int resolve_gitlink_packed_ref(struct ref_cache *refs,
 	struct ref_entry *ref;
 	struct ref_dir *dir = get_packed_refs(refs);
 
-	ref = search_ref_dir(dir, refname);
+	ref = find_ref(dir, refname);
 	if (ref == NULL)
 		return -1;
 
@@ -728,7 +909,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
 static int get_packed_ref(const char *refname, unsigned char *sha1)
 {
 	struct ref_dir *packed = get_packed_refs(get_ref_cache(NULL));
-	struct ref_entry *entry = search_ref_dir(packed, refname);
+	struct ref_entry *entry = find_ref(packed, refname);
 	if (entry) {
 		hashcpy(sha1, entry->u.value.sha1);
 		return 0;
@@ -905,7 +1086,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 
 	if ((flag & REF_ISPACKED)) {
 		struct ref_dir *dir = get_packed_refs(get_ref_cache(NULL));
-		struct ref_entry *r = search_ref_dir(dir, refname);
+		struct ref_entry *r = find_ref(dir, refname);
 
 		if (r != NULL && r->flag & REF_KNOWS_PEELED) {
 			hashcpy(sha1, r->u.value.peeled);
@@ -1405,8 +1586,7 @@ static int repack_without_ref(const char *refname)
 {
 	struct repack_without_ref_sb data;
 	struct ref_dir *packed = get_packed_refs(get_ref_cache(NULL));
-	sort_ref_dir(packed);
-	if (search_ref_dir(packed, refname) == NULL)
+	if (find_ref(packed, refname) == NULL)
 		return 0;
 	data.refname = refname;
 	data.fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
diff --git a/refs.h b/refs.h
index 33202b0..d6c2fe2 100644
--- a/refs.h
+++ b/refs.h
@@ -15,8 +15,11 @@ struct ref_lock {
 #define REF_ISBROKEN 0x04
 
 /*
- * Calls the specified function for each ref file until it returns nonzero,
- * and returns the value
+ * Calls the specified function for each ref file until it returns
+ * nonzero, and returns the value.  Please note that it is not safe to
+ * modify references while an iteration is in progress, unless the
+ * same callback function invocation that modifies the reference also
+ * returns a nonzero value to immediately stop the iteration.
  */
 typedef int each_ref_fn(const char *refname, const unsigned char *sha1, int flags, void *cb_data);
 extern int head_ref(each_ref_fn, void *);
-- 
1.7.10
