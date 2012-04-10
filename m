From: mhagger@alum.mit.edu
Subject: [PATCH 12/15] refs.c: rename ref_array -> ref_dir
Date: Tue, 10 Apr 2012 07:30:24 +0200
Message-ID: <1334035827-20331-13-git-send-email-mhagger@alum.mit.edu>
References: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 07:31:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHTfz-0002SQ-Ou
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 07:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501Ab2DJFbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 01:31:17 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59265 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422Ab2DJFbM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 01:31:12 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0B8CA.dip.t-dialin.net [79.192.184.202])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3A5UXe5000870;
	Tue, 10 Apr 2012 07:31:01 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195068>

From: Michael Haggerty <mhagger@alum.mit.edu>

This purely textual change is in preparation for storing references
hierarchically, when the old ref_array structure will represent one
"directory" of references.  Rename functions that deal with this
structure analogously, and also rename the structure's "refs" member
to "entries".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |  195 ++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 97 insertions(+), 98 deletions(-)

diff --git a/refs.c b/refs.c
index 416c97f..4e0cfb2 100644
--- a/refs.c
+++ b/refs.c
@@ -106,7 +106,7 @@ struct ref_value {
 	unsigned char peeled[20];
 };
 
-struct ref_array {
+struct ref_dir {
 	int nr, alloc;
 
 	/*
@@ -117,7 +117,7 @@ struct ref_array {
 	 */
 	int sorted;
 
-	struct ref_entry **refs;
+	struct ref_entry **entries;
 };
 
 /* ISSYMREF=0x01, ISPACKED=0x02 and ISBROKEN=0x04 are public interfaces */
@@ -156,21 +156,21 @@ static void free_ref_entry(struct ref_entry *entry)
 	free(entry);
 }
 
-/* Add a ref_entry to the end of the ref_array (unsorted). */
-static void add_ref(struct ref_array *refs, struct ref_entry *ref)
+/* Add a ref_entry to the end of the ref_dir (unsorted). */
+static void add_ref(struct ref_dir *refs, struct ref_entry *ref)
 {
-	ALLOC_GROW(refs->refs, refs->nr + 1, refs->alloc);
-	refs->refs[refs->nr++] = ref;
+	ALLOC_GROW(refs->entries, refs->nr + 1, refs->alloc);
+	refs->entries[refs->nr++] = ref;
 }
 
-static void clear_ref_array(struct ref_array *array)
+static void clear_ref_dir(struct ref_dir *dir)
 {
 	int i;
-	for (i = 0; i < array->nr; i++)
-		free_ref_entry(array->refs[i]);
-	free(array->refs);
-	array->sorted = array->nr = array->alloc = 0;
-	array->refs = NULL;
+	for (i = 0; i < dir->nr; i++)
+		free_ref_entry(dir->entries[i]);
+	free(dir->entries);
+	dir->sorted = dir->nr = dir->alloc = 0;
+	dir->entries = NULL;
 }
 
 static int ref_entry_cmp(const void *a, const void *b)
@@ -180,9 +180,9 @@ static int ref_entry_cmp(const void *a, const void *b)
 	return strcmp(one->name, two->name);
 }
 
-static void sort_ref_array(struct ref_array *array);
+static void sort_ref_dir(struct ref_dir *dir);
 
-static struct ref_entry *search_ref_array(struct ref_array *array, const char *refname)
+static struct ref_entry *search_ref_dir(struct ref_dir *dir, const char *refname)
 {
 	struct ref_entry *e, **r;
 	int len;
@@ -190,14 +190,14 @@ static struct ref_entry *search_ref_array(struct ref_array *array, const char *r
 	if (refname == NULL)
 		return NULL;
 
-	if (!array->nr)
+	if (!dir->nr)
 		return NULL;
-	sort_ref_array(array);
+	sort_ref_dir(dir);
 	len = strlen(refname) + 1;
 	e = xmalloc(sizeof(struct ref_entry) + len);
 	memcpy(e->name, refname, len);
 
-	r = bsearch(&e, array->refs, array->nr, sizeof(*array->refs), ref_entry_cmp);
+	r = bsearch(&e, dir->entries, dir->nr, sizeof(*dir->entries), ref_entry_cmp);
 
 	free(e);
 
@@ -227,9 +227,9 @@ static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2
 }
 
 /*
- * Sort the entries in array (if they are not already sorted).
+ * Sort the entries in dir (if they are not already sorted).
  */
-static void sort_ref_array(struct ref_array *array)
+static void sort_ref_dir(struct ref_dir *dir)
 {
 	int i, j;
 
@@ -237,21 +237,21 @@ static void sort_ref_array(struct ref_array *array)
 	 * This check also prevents passing a zero-length array to qsort(),
 	 * which is a problem on some platforms.
 	 */
-	if (array->sorted == array->nr)
+	if (dir->sorted == dir->nr)
 		return;
 
-	qsort(array->refs, array->nr, sizeof(*array->refs), ref_entry_cmp);
+	qsort(dir->entries, dir->nr, sizeof(*dir->entries), ref_entry_cmp);
 
-	/* Remove any duplicates from the ref_array */
+	/* Remove any duplicates from the ref_dir */
 	i = 0;
-	for (j = 1; j < array->nr; j++) {
-		if (is_dup_ref(array->refs[i], array->refs[j])) {
-			free_ref_entry(array->refs[j]);
+	for (j = 1; j < dir->nr; j++) {
+		if (is_dup_ref(dir->entries[i], dir->entries[j])) {
+			free_ref_entry(dir->entries[j]);
 			continue;
 		}
-		array->refs[++i] = array->refs[j];
+		dir->entries[++i] = dir->entries[j];
 	}
-	array->sorted = array->nr = i + 1;
+	dir->sorted = dir->nr = i + 1;
 }
 
 #define DO_FOR_EACH_INCLUDE_BROKEN 01
@@ -280,18 +280,18 @@ static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 }
 
 /*
- * Call fn for each reference in array that has index in the range
- * offset <= index < array->nr.  This function does not sort the
- * array; sorting should be done by the caller.
+ * Call fn for each reference in dir that has index in the range
+ * offset <= index < dir->nr.  This function does not sort the dir;
+ * sorting should be done by the caller.
  */
-static int do_for_each_ref_in_array(struct ref_array *array, int offset,
-				    const char *base,
-				    each_ref_fn fn, int trim, int flags, void *cb_data)
+static int do_for_each_ref_in_dir(struct ref_dir *dir, int offset,
+				  const char *base,
+				  each_ref_fn fn, int trim, int flags, void *cb_data)
 {
 	int i;
-	assert(array->sorted == array->nr);
-	for (i = offset; i < array->nr; i++) {
-		int retval = do_one_ref(base, fn, trim, flags, cb_data, array->refs[i]);
+	assert(dir->sorted == dir->nr);
+	for (i = offset; i < dir->nr; i++) {
+		int retval = do_one_ref(base, fn, trim, flags, cb_data, dir->entries[i]);
 		if (retval)
 			return retval;
 	}
@@ -299,24 +299,24 @@ static int do_for_each_ref_in_array(struct ref_array *array, int offset,
 }
 
 /*
- * Call fn for each reference in the union of array1 and array2, in
- * order by refname.  If an entry appears in both array1 and array2,
- * then only process the version that is in array2.  The input arrays
- * must already be sorted.
+ * Call fn for each reference in the union of dir1 and dir2, in order
+ * by refname.  If an entry appears in both dir1 and dir2, then only
+ * process the version that is in dir2.  The input dirs must already
+ * be sorted.
  */
-static int do_for_each_ref_in_arrays(struct ref_array *array1,
-				     struct ref_array *array2,
-				     const char *base, each_ref_fn fn, int trim,
-				     int flags, void *cb_data)
+static int do_for_each_ref_in_dirs(struct ref_dir *dir1,
+				   struct ref_dir *dir2,
+				   const char *base, each_ref_fn fn, int trim,
+				   int flags, void *cb_data)
 {
 	int retval;
 	int i1 = 0, i2 = 0;
 
-	assert(array1->sorted == array1->nr);
-	assert(array2->sorted == array2->nr);
-	while (i1 < array1->nr && i2 < array2->nr) {
-		struct ref_entry *e1 = array1->refs[i1];
-		struct ref_entry *e2 = array2->refs[i2];
+	assert(dir1->sorted == dir1->nr);
+	assert(dir2->sorted == dir2->nr);
+	while (i1 < dir1->nr && i2 < dir2->nr) {
+		struct ref_entry *e1 = dir1->entries[i1];
+		struct ref_entry *e2 = dir2->entries[i2];
 		int cmp = strcmp(e1->name, e2->name);
 		if (cmp < 0) {
 			retval = do_one_ref(base, fn, trim, flags, cb_data, e1);
@@ -335,12 +335,12 @@ static int do_for_each_ref_in_arrays(struct ref_array *array1,
 		if (retval)
 			return retval;
 	}
-	if (i1 < array1->nr)
-		return do_for_each_ref_in_array(array1, i1,
-						base, fn, trim, flags, cb_data);
-	if (i2 < array2->nr)
-		return do_for_each_ref_in_array(array2, i2,
-						base, fn, trim, flags, cb_data);
+	if (i1 < dir1->nr)
+		return do_for_each_ref_in_dir(dir1, i1,
+					      base, fn, trim, flags, cb_data);
+	if (i2 < dir2->nr)
+		return do_for_each_ref_in_dir(dir2, i2,
+					      base, fn, trim, flags, cb_data);
 	return 0;
 }
 
@@ -386,17 +386,17 @@ static int name_conflict_fn(const char *existingrefname, const unsigned char *sh
  * operation).
  */
 static int is_refname_available(const char *refname, const char *oldrefname,
-				struct ref_array *array)
+				struct ref_dir *dir)
 {
 	struct name_conflict_cb data;
 	data.refname = refname;
 	data.oldrefname = oldrefname;
 	data.conflicting_refname = NULL;
 
-	sort_ref_array(array);
-	if (do_for_each_ref_in_array(array, 0, "", name_conflict_fn,
-				     0, DO_FOR_EACH_INCLUDE_BROKEN,
-				     &data)) {
+	sort_ref_dir(dir);
+	if (do_for_each_ref_in_dir(dir, 0, "", name_conflict_fn,
+				   0, DO_FOR_EACH_INCLUDE_BROKEN,
+				   &data)) {
 		error("'%s' exists; cannot create '%s'",
 		      data.conflicting_refname, refname);
 		return 0;
@@ -412,8 +412,8 @@ static struct ref_cache {
 	struct ref_cache *next;
 	char did_loose;
 	char did_packed;
-	struct ref_array loose;
-	struct ref_array packed;
+	struct ref_dir loose;
+	struct ref_dir packed;
 	/* The submodule name, or "" for the main repo. */
 	char name[FLEX_ARRAY];
 } *ref_cache;
@@ -421,14 +421,14 @@ static struct ref_cache {
 static void clear_packed_ref_cache(struct ref_cache *refs)
 {
 	if (refs->did_packed)
-		clear_ref_array(&refs->packed);
+		clear_ref_dir(&refs->packed);
 	refs->did_packed = 0;
 }
 
 static void clear_loose_ref_cache(struct ref_cache *refs)
 {
 	if (refs->did_loose)
-		clear_ref_array(&refs->loose);
+		clear_ref_dir(&refs->loose);
 	refs->did_loose = 0;
 }
 
@@ -507,7 +507,7 @@ static const char *parse_ref_line(char *line, unsigned char *sha1)
 	return line;
 }
 
-static void read_packed_refs(FILE *f, struct ref_array *array)
+static void read_packed_refs(FILE *f, struct ref_dir *dir)
 {
 	struct ref_entry *last = NULL;
 	char refline[PATH_MAX];
@@ -529,7 +529,7 @@ static void read_packed_refs(FILE *f, struct ref_array *array)
 		refname = parse_ref_line(refline, sha1);
 		if (refname) {
 			last = create_ref_entry(refname, sha1, flag, 1);
-			add_ref(array, last);
+			add_ref(dir, last);
 			continue;
 		}
 		if (last &&
@@ -541,7 +541,7 @@ static void read_packed_refs(FILE *f, struct ref_array *array)
 	}
 }
 
-static struct ref_array *get_packed_refs(struct ref_cache *refs)
+static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 {
 	if (!refs->did_packed) {
 		const char *packed_refs_file;
@@ -568,9 +568,9 @@ void add_packed_ref(const char *refname, const unsigned char *sha1)
 }
 
 static void get_ref_dir(struct ref_cache *refs, const char *base,
-			struct ref_array *array)
+			struct ref_dir *dir)
 {
-	DIR *dir;
+	DIR *d;
 	const char *path;
 
 	if (*refs->name)
@@ -578,9 +578,8 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 	else
 		path = git_path("%s", base);
 
-	dir = opendir(path);
-
-	if (dir) {
+	d = opendir(path);
+	if (d) {
 		struct dirent *de;
 		int baselen = strlen(base);
 		char *refname = xmalloc(baselen + 257);
@@ -589,7 +588,7 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 		if (baselen && base[baselen-1] != '/')
 			refname[baselen++] = '/';
 
-		while ((de = readdir(dir)) != NULL) {
+		while ((de = readdir(d)) != NULL) {
 			unsigned char sha1[20];
 			struct stat st;
 			int flag;
@@ -610,7 +609,7 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 			if (stat(refdir, &st) < 0)
 				continue;
 			if (S_ISDIR(st.st_mode)) {
-				get_ref_dir(refs, refname, array);
+				get_ref_dir(refs, refname, dir);
 				continue;
 			}
 			if (*refs->name) {
@@ -624,14 +623,14 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
 			}
-			add_ref(array, create_ref_entry(refname, sha1, flag, 1));
+			add_ref(dir, create_ref_entry(refname, sha1, flag, 1));
 		}
 		free(refname);
-		closedir(dir);
+		closedir(d);
 	}
 }
 
-static struct ref_array *get_loose_refs(struct ref_cache *refs)
+static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->did_loose) {
 		get_ref_dir(refs, "refs", &refs->loose);
@@ -653,9 +652,9 @@ static int resolve_gitlink_packed_ref(struct ref_cache *refs,
 				      const char *refname, unsigned char *sha1)
 {
 	struct ref_entry *ref;
-	struct ref_array *array = get_packed_refs(refs);
+	struct ref_dir *dir = get_packed_refs(refs);
 
-	ref = search_ref_array(array, refname);
+	ref = search_ref_dir(dir, refname);
 	if (ref == NULL)
 		return -1;
 
@@ -726,8 +725,8 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
  */
 static int get_packed_ref(const char *refname, unsigned char *sha1)
 {
-	struct ref_array *packed = get_packed_refs(get_ref_cache(NULL));
-	struct ref_entry *entry = search_ref_array(packed, refname);
+	struct ref_dir *packed = get_packed_refs(get_ref_cache(NULL));
+	struct ref_entry *entry = search_ref_dir(packed, refname);
 	if (entry) {
 		hashcpy(sha1, entry->u.value.sha1);
 		return 0;
@@ -903,8 +902,8 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		return -1;
 
 	if ((flag & REF_ISPACKED)) {
-		struct ref_array *array = get_packed_refs(get_ref_cache(NULL));
-		struct ref_entry *r = search_ref_array(array, refname);
+		struct ref_dir *dir = get_packed_refs(get_ref_cache(NULL));
+		struct ref_entry *r = search_ref_dir(dir, refname);
 
 		if (r != NULL && r->flag & REF_KNOWS_PEELED) {
 			hashcpy(sha1, r->u.value.peeled);
@@ -962,13 +961,13 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 			   int trim, int flags, void *cb_data)
 {
 	struct ref_cache *refs = get_ref_cache(submodule);
-	struct ref_array *packed_refs = get_packed_refs(refs);
-	struct ref_array *loose_refs = get_loose_refs(refs);
-	sort_ref_array(packed_refs);
-	sort_ref_array(loose_refs);
-	return do_for_each_ref_in_arrays(packed_refs,
-					 loose_refs,
-					 base, fn, trim, flags, cb_data);
+	struct ref_dir *packed_refs = get_packed_refs(refs);
+	struct ref_dir *loose_refs = get_loose_refs(refs);
+	sort_ref_dir(packed_refs);
+	sort_ref_dir(loose_refs);
+	return do_for_each_ref_in_dirs(packed_refs,
+				       loose_refs,
+				       base, fn, trim, flags, cb_data);
 }
 
 static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
@@ -1403,9 +1402,9 @@ static struct lock_file packlock;
 static int repack_without_ref(const char *refname)
 {
 	struct repack_without_ref_sb data;
-	struct ref_array *packed = get_packed_refs(get_ref_cache(NULL));
-	sort_ref_array(packed);
-	if (search_ref_array(packed, refname) == NULL)
+	struct ref_dir *packed = get_packed_refs(get_ref_cache(NULL));
+	sort_ref_dir(packed);
+	if (search_ref_dir(packed, refname) == NULL)
 		return 0;
 	data.refname = refname;
 	data.fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
@@ -1413,7 +1412,7 @@ static int repack_without_ref(const char *refname)
 		unable_to_lock_error(git_path("packed-refs"), errno);
 		return error("cannot delete '%s' from packed refs", refname);
 	}
-	do_for_each_ref_in_array(packed, 0, "", repack_without_ref_fn, 0, 0, &data);
+	do_for_each_ref_in_dir(packed, 0, "", repack_without_ref_fn, 0, 0, &data);
 	return commit_lock_file(&packlock);
 }
 
@@ -2024,10 +2023,10 @@ int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_dat
 
 static int do_for_each_reflog(const char *base, each_ref_fn fn, void *cb_data)
 {
-	DIR *dir = opendir(git_path("logs/%s", base));
+	DIR *d = opendir(git_path("logs/%s", base));
 	int retval = 0;
 
-	if (dir) {
+	if (d) {
 		struct dirent *de;
 		int baselen = strlen(base);
 		char *log = xmalloc(baselen + 257);
@@ -2036,7 +2035,7 @@ static int do_for_each_reflog(const char *base, each_ref_fn fn, void *cb_data)
 		if (baselen && base[baselen-1] != '/')
 			log[baselen++] = '/';
 
-		while ((de = readdir(dir)) != NULL) {
+		while ((de = readdir(d)) != NULL) {
 			struct stat st;
 			int namelen;
 
@@ -2063,7 +2062,7 @@ static int do_for_each_reflog(const char *base, each_ref_fn fn, void *cb_data)
 				break;
 		}
 		free(log);
-		closedir(dir);
+		closedir(d);
 	}
 	else if (*base)
 		return errno;
-- 
1.7.10
