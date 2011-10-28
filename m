From: mhagger@alum.mit.edu
Subject: [PATCH 05/28] refs.c: rename ref_array -> ref_dir
Date: Fri, 28 Oct 2011 14:28:18 +0200
Message-ID: <1319804921-17545-6-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:29:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlZH-0003uv-Vj
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663Ab1J1M3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:29:30 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:55673 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab1J1M2u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:28:50 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-G1; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184383>

From: Michael Haggerty <mhagger@alum.mit.edu>

This purely textual change is in preparation for storing references
hierarchically, when the old ref_array structure will represent one
"directory" of references.  Rename functions that deal with this
structure analogously, and also rename the structure's "refs" member
to "entries".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |  168 ++++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 84 insertions(+), 84 deletions(-)

diff --git a/refs.c b/refs.c
index dafb585..708eebf 100644
--- a/refs.c
+++ b/refs.c
@@ -106,9 +106,9 @@ struct ref_value {
 	unsigned char peeled[20];
 };
 
-struct ref_array {
+struct ref_dir {
 	int nr, alloc;
-	struct ref_entry **refs;
+	struct ref_entry **entries;
 };
 
 /* ISSYMREF=0x01, ISPACKED=0x02 and ISBROKEN=0x04 are public interfaces */
@@ -145,21 +145,21 @@ static void free_ref_entry(struct ref_entry *entry)
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
-	array->nr = array->alloc = 0;
-	array->refs = NULL;
+	for (i = 0; i < dir->nr; i++)
+		free_ref_entry(dir->entries[i]);
+	free(dir->entries);
+	dir->nr = dir->alloc = 0;
+	dir->entries = NULL;
 }
 
 static int ref_entry_cmp(const void *a, const void *b)
@@ -169,7 +169,7 @@ static int ref_entry_cmp(const void *a, const void *b)
 	return strcmp(one->name, two->name);
 }
 
-static struct ref_entry *search_ref_array(struct ref_array *array, const char *refname)
+static struct ref_entry *search_ref_dir(struct ref_dir *dir, const char *refname)
 {
 	struct ref_entry *e, **r;
 	int len;
@@ -177,14 +177,14 @@ static struct ref_entry *search_ref_array(struct ref_array *array, const char *r
 	if (refname == NULL)
 		return NULL;
 
-	if (!array->nr)
+	if (!dir->nr)
 		return NULL;
 
 	len = strlen(refname) + 1;
 	e = xmalloc(sizeof(struct ref_entry) + len);
 	memcpy(e->name, refname, len);
 
-	r = bsearch(&e, array->refs, array->nr, sizeof(*array->refs), ref_entry_cmp);
+	r = bsearch(&e, dir->entries, dir->nr, sizeof(*dir->entries), ref_entry_cmp);
 
 	free(e);
 
@@ -213,28 +213,28 @@ static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2
 	}
 }
 
-static void sort_ref_array(struct ref_array *array)
+static void sort_ref_dir(struct ref_dir *dir)
 {
 	int i = 0, j = 1;
 
 	/* Nothing to sort unless there are at least two entries */
-	if (array->nr < 2)
+	if (dir->nr < 2)
 		return;
 
-	qsort(array->refs, array->nr, sizeof(*array->refs), ref_entry_cmp);
+	qsort(dir->entries, dir->nr, sizeof(*dir->entries), ref_entry_cmp);
 
-	/* Remove any duplicates from the ref_array */
-	for (; j < array->nr; j++) {
-		struct ref_entry *a = array->refs[i];
-		struct ref_entry *b = array->refs[j];
+	/* Remove any duplicates from the ref_dir */
+	for (; j < dir->nr; j++) {
+		struct ref_entry *a = dir->entries[i];
+		struct ref_entry *b = dir->entries[j];
 		if (is_dup_ref(a, b)) {
 			free_ref_entry(b);
 			continue;
 		}
 		i++;
-		array->refs[i] = array->refs[j];
+		dir->entries[i] = dir->entries[j];
 	}
-	array->nr = i + 1;
+	dir->nr = i + 1;
 }
 
 #define DO_FOR_EACH_INCLUDE_BROKEN 01
@@ -259,23 +259,23 @@ static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 	return fn(entry->name + trim, entry->u.value.sha1, entry->flag, cb_data);
 }
 
-static int do_for_each_ref_in_array(struct ref_array *array, int offset,
-				    const char *base,
-				    each_ref_fn fn, int trim, int flags, void *cb_data)
+static int do_for_each_ref_in_dir(struct ref_dir *dir, int offset,
+				  const char *base,
+				  each_ref_fn fn, int trim, int flags, void *cb_data)
 {
 	int i;
-	for (i = offset; i < array->nr; i++) {
-		int retval = do_one_ref(base, fn, trim, flags, cb_data, array->refs[i]);
+	for (i = offset; i < dir->nr; i++) {
+		int retval = do_one_ref(base, fn, trim, flags, cb_data, dir->entries[i]);
 		if (retval)
 			return retval;
 	}
 	return 0;
 }
 
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
@@ -283,19 +283,19 @@ static int do_for_each_ref_in_arrays(struct ref_array *array1,
 	while (1) {
 		struct ref_entry *e1, *e2;
 		int cmp;
-		if (i1 == array1->nr) {
-			return do_for_each_ref_in_array(array2, i2,
-							base, fn, trim, flags, cb_data);
+		if (i1 == dir1->nr) {
+			return do_for_each_ref_in_dir(dir2, i2,
+						      base, fn, trim, flags, cb_data);
 		}
-		if (i2 == array2->nr) {
-			return do_for_each_ref_in_array(array1, i1,
-							base, fn, trim, flags, cb_data);
+		if (i2 == dir2->nr) {
+			return do_for_each_ref_in_dir(dir1, i1,
+						      base, fn, trim, flags, cb_data);
 		}
-		e1 = array1->refs[i1];
-		e2 = array2->refs[i2];
+		e1 = dir1->entries[i1];
+		e2 = dir2->entries[i2];
 		cmp = strcmp(e1->name, e2->name);
 		if (cmp == 0) {
-			/* Two refs with the same name; ignore the one from array1. */
+			/* Two refs with the same name; ignore the one from dir1. */
 			i1++;
 			continue;
 		}
@@ -353,16 +353,16 @@ static int name_conflict_fn(const char *existingrefname, const unsigned char *sh
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
 
-	if (do_for_each_ref_in_array(array, 0, "", name_conflict_fn,
-				     0, DO_FOR_EACH_INCLUDE_BROKEN,
-				     &data)) {
+	if (do_for_each_ref_in_dir(dir, 0, "", name_conflict_fn,
+				   0, DO_FOR_EACH_INCLUDE_BROKEN,
+				   &data)) {
 		error("'%s' exists; cannot create '%s'",
 		      data.conflicting_refname, refname);
 		return 0;
@@ -378,25 +378,25 @@ static struct ref_cache {
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
 
-static struct ref_array extra_refs;
+static struct ref_dir extra_refs;
 
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
 
@@ -478,7 +478,7 @@ static const char *parse_ref_line(char *line, unsigned char *sha1)
 	return line;
 }
 
-static void read_packed_refs(FILE *f, struct ref_array *array)
+static void read_packed_refs(FILE *f, struct ref_dir *dir)
 {
 	struct ref_entry *last = NULL;
 	char refline[PATH_MAX];
@@ -500,7 +500,7 @@ static void read_packed_refs(FILE *f, struct ref_array *array)
 		refname = parse_ref_line(refline, sha1);
 		if (refname) {
 			last = create_ref_entry(refname, sha1, flag);
-			add_ref(array, last);
+			add_ref(dir, last);
 			continue;
 		}
 		if (last &&
@@ -510,7 +510,7 @@ static void read_packed_refs(FILE *f, struct ref_array *array)
 		    !get_sha1_hex(refline + 1, sha1))
 			hashcpy(last->u.value.peeled, sha1);
 	}
-	sort_ref_array(array);
+	sort_ref_dir(dir);
 }
 
 void add_extra_ref(const char *refname, const unsigned char *sha1, int flag)
@@ -520,10 +520,10 @@ void add_extra_ref(const char *refname, const unsigned char *sha1, int flag)
 
 void clear_extra_refs(void)
 {
-	clear_ref_array(&extra_refs);
+	clear_ref_dir(&extra_refs);
 }
 
-static struct ref_array *get_packed_refs(struct ref_cache *refs)
+static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 {
 	if (!refs->did_packed) {
 		const char *packed_refs_file;
@@ -544,9 +544,9 @@ static struct ref_array *get_packed_refs(struct ref_cache *refs)
 }
 
 static void get_ref_dir(struct ref_cache *refs, const char *base,
-			struct ref_array *array)
+			struct ref_dir *dir)
 {
-	DIR *dir;
+	DIR *d;
 	const char *path;
 
 	if (*refs->name)
@@ -555,9 +555,9 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 		path = git_path("%s", base);
 
 
-	dir = opendir(path);
+	d = opendir(path);
 
-	if (dir) {
+	if (d) {
 		struct dirent *de;
 		int baselen = strlen(base);
 		char *refname = xmalloc(baselen + 257);
@@ -566,7 +566,7 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 		if (baselen && base[baselen-1] != '/')
 			refname[baselen++] = '/';
 
-		while ((de = readdir(dir)) != NULL) {
+		while ((de = readdir(d)) != NULL) {
 			unsigned char sha1[20];
 			struct stat st;
 			int flag;
@@ -587,7 +587,7 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 			if (stat(refdir, &st) < 0)
 				continue;
 			if (S_ISDIR(st.st_mode)) {
-				get_ref_dir(refs, refname, array);
+				get_ref_dir(refs, refname, dir);
 				continue;
 			}
 			if (*refs->name) {
@@ -602,18 +602,18 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 					hashclr(sha1);
 					flag |= REF_ISBROKEN;
 				}
-			add_ref(array, create_ref_entry(refname, sha1, flag));
+			add_ref(dir, create_ref_entry(refname, sha1, flag));
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
-		sort_ref_array(&refs->loose);
+		sort_ref_dir(&refs->loose);
 		refs->did_loose = 1;
 	}
 	return &refs->loose;
@@ -632,9 +632,9 @@ static int resolve_gitlink_packed_ref(struct ref_cache *refs,
 				      const char *refname, unsigned char *sha1)
 {
 	struct ref_entry *ref;
-	struct ref_array *array = get_packed_refs(refs);
+	struct ref_dir *dir = get_packed_refs(refs);
 
-	ref = search_ref_array(array, refname);
+	ref = search_ref_dir(dir, refname);
 	if (ref == NULL)
 		return -1;
 
@@ -705,8 +705,8 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
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
@@ -865,8 +865,8 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		return -1;
 
 	if ((flag & REF_ISPACKED)) {
-		struct ref_array *array = get_packed_refs(get_ref_cache(NULL));
-		struct ref_entry *r = search_ref_array(array, refname);
+		struct ref_dir *dir = get_packed_refs(get_ref_cache(NULL));
+		struct ref_entry *r = search_ref_dir(dir, refname);
 
 		if (r != NULL && r->flag & REF_KNOWS_PEELED) {
 			hashcpy(sha1, r->u.value.peeled);
@@ -926,12 +926,12 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 	int retval = 0;
 	struct ref_cache *refs = get_ref_cache(submodule);
 
-	retval = do_for_each_ref_in_array(&extra_refs, 0,
-					  base, fn, trim, flags, cb_data);
+	retval = do_for_each_ref_in_dir(&extra_refs, 0,
+					base, fn, trim, flags, cb_data);
 	if (!retval)
-		retval = do_for_each_ref_in_arrays(get_packed_refs(refs),
-						   get_loose_refs(refs),
-						   base, fn, trim, flags, cb_data);
+		retval = do_for_each_ref_in_dirs(get_packed_refs(refs),
+						 get_loose_refs(refs),
+						 base, fn, trim, flags, cb_data);
 
 	current_ref = NULL;
 	return retval;
@@ -1377,10 +1377,10 @@ static struct lock_file packlock;
 static int repack_without_ref(const char *refname)
 {
 	struct repack_without_ref_sb data;
-	struct ref_array *packed;
+	struct ref_dir *packed;
 
 	packed = get_packed_refs(get_ref_cache(NULL));
-	if (search_ref_array(packed, refname) == NULL)
+	if (search_ref_dir(packed, refname) == NULL)
 		return 0;
 	data.refname = refname;
 	data.fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
@@ -1388,7 +1388,7 @@ static int repack_without_ref(const char *refname)
 		unable_to_lock_error(git_path("packed-refs"), errno);
 		return error("cannot delete '%s' from packed refs", refname);
 	}
-	do_for_each_ref_in_array(packed, 0, "", repack_without_ref_fn, 0, 0, &data);
+	do_for_each_ref_in_dir(packed, 0, "", repack_without_ref_fn, 0, 0, &data);
 	return commit_lock_file(&packlock);
 }
 
@@ -1998,10 +1998,10 @@ int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_dat
 
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
@@ -2010,7 +2010,7 @@ static int do_for_each_reflog(const char *base, each_ref_fn fn, void *cb_data)
 		if (baselen && base[baselen-1] != '/')
 			log[baselen++] = '/';
 
-		while ((de = readdir(dir)) != NULL) {
+		while ((de = readdir(d)) != NULL) {
 			struct stat st;
 			int namelen;
 
@@ -2037,7 +2037,7 @@ static int do_for_each_reflog(const char *base, each_ref_fn fn, void *cb_data)
 				break;
 		}
 		free(log);
-		closedir(dir);
+		closedir(d);
 	}
 	else if (*base)
 		return errno;
-- 
1.7.7
