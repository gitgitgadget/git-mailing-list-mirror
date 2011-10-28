From: mhagger@alum.mit.edu
Subject: [PATCH 06/28] refs: store references hierarchically
Date: Fri, 28 Oct 2011 14:28:19 +0200
Message-ID: <1319804921-17545-7-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:29:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlYx-0003gi-04
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755616Ab1J1M3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:29:16 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:55689 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607Ab1J1M2u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:28:50 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-Gg; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184377>

From: Michael Haggerty <mhagger@alum.mit.edu>

Store references hierarchically in a tree that matches the
pseudo-directory structure of the reference names.  Add a new kind of
ref_entry (with flag REF_DIR) to represent a whole subdirectory of
references.  Teach check_refname_format() to decide whether a
reference directory name is valid.

Please note that this change causes some extra sorting to be required,
and therefore a performance regression.  The old performance will be
regained in the next couple of commits by (1) keeping track of when a
directory is already sorted and not re-sorting it; (2) only sorting a
directory when the correct order needed; and (3) not sorting
directories recursively.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |  325 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 271 insertions(+), 54 deletions(-)

diff --git a/refs.c b/refs.c
index 708eebf..6b4d5d5 100644
--- a/refs.c
+++ b/refs.c
@@ -67,6 +67,23 @@ static int check_refname_component(const char *refname, int flags)
 	return cp - refname;
 }
 
+/*
+ * Non-public option to check_refname_format(), for asking it to check
+ * that refname is a valid reference "directory" name.
+ */
+#define REFNAME_DIR 0x08
+
+/*
+ * See refs.h for a description of the public interface of this
+ * function.  In addition, there is a private interface that can be
+ * accessed by setting the REFNAME_DIR bit.  If REFNAME_DIR is set,
+ * then refname must be a valid reference "directory" name.  This
+ * means that it must include at least one valid component (which *is*
+ * allowed to end with '.') followed by a trailing '/'.  If
+ * REFNAME_DIR and REFNAME_ALLOW_ONELEVEL are both passed, then
+ * additionally the empty string (no trailing slash allowed) is
+ * allowed.
+ */
 int check_refname_format(const char *refname, int flags)
 {
 	int component_len, component_count = 0;
@@ -74,7 +91,7 @@ int check_refname_format(const char *refname, int flags)
 	while (1) {
 		/* We are at the start of a path component. */
 		component_len = check_refname_component(refname, flags);
-		if (component_len <= 0) {
+		if (component_len < 0) {
 			if ((flags & REFNAME_REFSPEC_PATTERN) &&
 					refname[0] == '*' &&
 					(refname[1] == '\0' || refname[1] == '/')) {
@@ -86,16 +103,36 @@ int check_refname_format(const char *refname, int flags)
 			}
 		}
 		component_count++;
-		if (refname[component_len] == '\0')
+		if (refname[component_len] == '\0') {
+			if (flags & REFNAME_DIR) {
+				/*
+				 * The last component of a REFNAME_DIR
+				 * *must* be the empty string.
+				 */
+				if (component_len != 0)
+					return -1;
+			} else {
+				/*
+				 * The last component of a
+				 * non-REFNAME_DIR *must not* be the
+				 * empty string.
+				 */
+				if (component_len == 0)
+					return -1;
+				if (refname[component_len - 1] == '.')
+					return -1; /* Refname ends with '.'. */
+			}
+			if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
+				return -1; /* Refname has only one component. */
+
 			break;
+		}
+		if (component_len == 0)
+			return -1; /* Double '/' */
 		/* Skip to next component. */
 		refname += component_len + 1;
 	}
 
-	if (refname[component_len - 1] == '.')
-		return -1; /* Refname ends with '.'. */
-	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
-		return -1; /* Refname has only one component. */
 	return 0;
 }
 
@@ -111,15 +148,54 @@ struct ref_dir {
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
 
@@ -140,18 +216,29 @@ static struct ref_entry *create_ref_entry(const char *refname,
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
@@ -162,6 +249,28 @@ static void clear_ref_dir(struct ref_dir *dir)
 	dir->entries = NULL;
 }
 
+/*
+ * Create a struct ref_entry object for the specified dirname.
+ * dirname is the name of the directory with a trailing slash (e.g.,
+ * "refs/heads/").
+ */
+static struct ref_entry *create_dir_entry(const char *dirname)
+{
+	struct ref_entry *direntry;
+	if (*dirname) {
+		int len = strlen(dirname);
+		direntry = xcalloc(1, sizeof(struct ref_entry) + len + 1);
+		memcpy(direntry->name, dirname, len + 1);
+		if (check_refname_format(direntry->name, REFNAME_DIR|REFNAME_ALLOW_ONELEVEL))
+			die("reference directory has invalid format: '%s'", direntry->name);
+	} else {
+		direntry = xcalloc(1, sizeof(struct ref_entry) + 1);
+		direntry->name[0] = '\0';
+	}
+	direntry->flag = REF_DIR;
+	return direntry;
+}
+
 static int ref_entry_cmp(const void *a, const void *b)
 {
 	struct ref_entry *one = *(struct ref_entry **)a;
@@ -169,16 +278,26 @@ static int ref_entry_cmp(const void *a, const void *b)
 	return strcmp(one->name, two->name);
 }
 
+static void sort_ref_dir(struct ref_dir *dir);
+
+/*
+ * Return the entry with the given refname from the ref_dir
+ * (non-recursively).  Return NULL if no such entry is found.
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
+	/*
+	 * We need dir to be sorted so that binary search works.
+	 * FIXME: Sorting the array each time is terribly inefficient,
+	 * and has to be changed.
+	 */
+	sort_ref_dir(dir);
 
 	len = strlen(refname) + 1;
 	e = xmalloc(sizeof(struct ref_entry) + len);
@@ -195,46 +314,116 @@ static struct ref_entry *search_ref_dir(struct ref_dir *dir, const char *refname
 }
 
 /*
+ * If refname is a reference name, find the ref_dir within the dir
+ * tree that should hold refname.  If refname is a directory name
+ * (i.e., ends in '/'), then return that ref_dir itself.  dir must
+ * represent the top-level directory.  Recurse into subdirectories as
+ * necessary.  If mkdir is set, then create any missing directories;
+ * otherwise, return NULL if the desired directory cannot be found.
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
+ * Find the value entry with the given name in dir, recursing into
+ * subdirectories as necessary.  If the name is not found or it
+ * corresponds to a directory entry, return NULL.
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
 
 static void sort_ref_dir(struct ref_dir *dir)
 {
-	int i = 0, j = 1;
+	int i, j;
+	struct ref_entry *last = NULL;
 
-	/* Nothing to sort unless there are at least two entries */
-	if (dir->nr < 2)
+	if (!dir->nr)
 		return;
 
 	qsort(dir->entries, dir->nr, sizeof(*dir->entries), ref_entry_cmp);
 
-	/* Remove any duplicates from the ref_dir */
-	for (; j < dir->nr; j++) {
-		struct ref_entry *a = dir->entries[i];
-		struct ref_entry *b = dir->entries[j];
-		if (is_dup_ref(a, b)) {
-			free_ref_entry(b);
-			continue;
+	/* Remove any duplicates and sort subdirectories: */
+	for (i = 0, j = 0; j < dir->nr; j++) {
+		struct ref_entry *entry = dir->entries[j];
+		if (last && is_dup_ref(last, entry)) {
+			free_ref_entry(entry);
+		} else if (entry->flag & REF_DIR) {
+			sort_ref_dir(&entry->u.subdir);
+			dir->entries[i++] = entry;
+			last = NULL;
+		} else {
+			last = dir->entries[i++] = entry;
 		}
-		i++;
-		dir->entries[i] = dir->entries[j];
 	}
-	dir->nr = i + 1;
+	dir->nr = i;
 }
 
 #define DO_FOR_EACH_INCLUDE_BROKEN 01
@@ -265,7 +454,14 @@ static int do_for_each_ref_in_dir(struct ref_dir *dir, int offset,
 {
 	int i;
 	for (i = offset; i < dir->nr; i++) {
-		int retval = do_one_ref(base, fn, trim, flags, cb_data, dir->entries[i]);
+		struct ref_entry *entry = dir->entries[i];
+		int retval;
+		if (entry->flag & REF_DIR) {
+			retval = do_for_each_ref_in_dir(&entry->u.subdir, 0,
+							base, fn, trim, flags, cb_data);
+		} else {
+			retval = do_one_ref(base, fn, trim, flags, cb_data, entry);
+		}
 		if (retval)
 			return retval;
 	}
@@ -281,7 +477,7 @@ static int do_for_each_ref_in_dirs(struct ref_dir *dir1,
 	int i1 = 0, i2 = 0;
 
 	while (1) {
-		struct ref_entry *e1, *e2;
+		struct ref_entry *e1, *e2, *entry;
 		int cmp;
 		if (i1 == dir1->nr) {
 			return do_for_each_ref_in_dir(dir2, i2,
@@ -295,16 +491,37 @@ static int do_for_each_ref_in_dirs(struct ref_dir *dir1,
 		e2 = dir2->entries[i2];
 		cmp = strcmp(e1->name, e2->name);
 		if (cmp == 0) {
-			/* Two refs with the same name; ignore the one from dir1. */
-			i1++;
-			continue;
-		}
-		if (cmp < 0) {
-			retval = do_one_ref(base, fn, trim, flags, cb_data, e1);
-			i1++;
+			if ((e1->flag & REF_DIR) && (e2->flag & REF_DIR)) {
+				/* Both are directories; descend them in parallel. */
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
+			if (cmp < 0) {
+				entry = e1;
+				i1++;
+			} else {
+				entry = e2;
+				i2++;
+			}
+			if (entry->flag & REF_DIR) {
+				retval = do_for_each_ref_in_dir(
+						&entry->u.subdir, 0,
+						base, fn, trim, flags, cb_data);
+			} else {
+				retval = do_one_ref(base, fn, trim, flags, cb_data, entry);
+			}
 		}
 		if (retval)
 			return retval;
@@ -634,7 +851,7 @@ static int resolve_gitlink_packed_ref(struct ref_cache *refs,
 	struct ref_entry *ref;
 	struct ref_dir *dir = get_packed_refs(refs);
 
-	ref = search_ref_dir(dir, refname);
+	ref = find_ref(dir, refname);
 	if (ref == NULL)
 		return -1;
 
@@ -706,7 +923,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
 static int get_packed_ref(const char *refname, unsigned char *sha1)
 {
 	struct ref_dir *packed = get_packed_refs(get_ref_cache(NULL));
-	struct ref_entry *entry = search_ref_dir(packed, refname);
+	struct ref_entry *entry = find_ref(packed, refname);
 	if (entry) {
 		hashcpy(sha1, entry->u.value.sha1);
 		return 0;
@@ -866,7 +1083,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 
 	if ((flag & REF_ISPACKED)) {
 		struct ref_dir *dir = get_packed_refs(get_ref_cache(NULL));
-		struct ref_entry *r = search_ref_dir(dir, refname);
+		struct ref_entry *r = find_ref(dir, refname);
 
 		if (r != NULL && r->flag & REF_KNOWS_PEELED) {
 			hashcpy(sha1, r->u.value.peeled);
@@ -1380,7 +1597,7 @@ static int repack_without_ref(const char *refname)
 	struct ref_dir *packed;
 
 	packed = get_packed_refs(get_ref_cache(NULL));
-	if (search_ref_dir(packed, refname) == NULL)
+	if (find_ref(packed, refname) == NULL)
 		return 0;
 	data.refname = refname;
 	data.fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
-- 
1.7.7
