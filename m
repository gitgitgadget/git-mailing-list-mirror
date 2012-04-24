From: mhagger@alum.mit.edu
Subject: [PATCH 30/30] refs: read loose references lazily
Date: Wed, 25 Apr 2012 00:45:36 +0200
Message-ID: <1335307536-26914-31-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:57:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMogF-0000SK-Oz
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488Ab2DXW5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:57:45 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60971 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758455Ab2DXW47 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:56:59 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 2D8F1248188;
	Wed, 25 Apr 2012 00:46:29 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196278>

From: Michael Haggerty <mhagger@alum.mit.edu>

Instead of reading the whole directory of loose references the first
time any are needed, only read them on demand, one directory at a
time.

Use a new ref_entry flag value REF_DIR_INCOMPLETE to indicate that the
entry represents a REF_DIR that hasn't been read yet.  Whenever any
entries from such a directory are needed, read all of the loose
references from that directory.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |  107 +++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 86 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 869c9a7..d72208a 100644
--- a/refs.c
+++ b/refs.c
@@ -101,6 +101,12 @@ int check_refname_format(const char *refname, int flags)
 
 struct ref_entry;
 
+/*
+ * Information used (along with the information in ref_entry) to
+ * describe a single cached reference.  This data structure only
+ * occurs embedded in a union in struct ref_entry, and only when
+ * (ref_entry->flag & REF_DIR) is zero.
+ */
 struct ref_value {
 	unsigned char sha1[20];
 	unsigned char peeled[20];
@@ -108,6 +114,34 @@ struct ref_value {
 
 struct ref_cache;
 
+/*
+ * Information used (along with the information in ref_entry) to
+ * describe a level in the hierarchy of references.  This data
+ * structure only occurs embedded in a union in struct ref_entry, and
+ * only when (ref_entry.flag & REF_DIR) is nonzero.  In that case,
+ * (ref_entry.flag & REF_DIR) can take the following values:
+ *
+ *     REF_DIR_COMPLETE -- a directory of loose or packed references,
+ *         already read.
+ *
+ *     REF_DIR_INCOMPLETE -- a directory of loose references that
+ *         hasn't been read yet (nor has any of its subdirectories).
+ *
+ * Entries within a directory are stored within a growable array of
+ * pointers to ref_entries (entries, nr, alloc).  Entries 0 <= i <
+ * sorted are sorted by their component name in strcmp() order and the
+ * remaining entries are unsorted.
+ *
+ * Loose references are read lazily, one directory at a time.  When a
+ * directory of loose references is read, then all of the references
+ * in that directory are stored, and REF_DIR_INCOMPLETE stubs are
+ * created for any subdirectories, but the subdirectories themselves
+ * are not read.  The reading is triggered either by search_ref_dir()
+ * (called when single references are added or interrogated), by
+ * sort_ref_dir(), or by iteration over a subdirectory of references
+ * using one of the for_each_ref*() functions (because these functions
+ * call sort_ref_dir() for each subdirectory).
+ */
 struct ref_dir {
 	int nr, alloc;
 
@@ -127,19 +161,33 @@ struct ref_dir {
 
 /* ISSYMREF=0x01, ISPACKED=0x02, and ISBROKEN=0x04 are public interfaces */
 #define REF_KNOWS_PEELED 0x08
-#define REF_DIR 0x10
+
+/* If any of these bits are set, the entry represents a directory: */
+#define REF_DIR 0x30
+
+/* A directory that has already been fully read. */
+#define REF_DIR_COMPLETE 0x10
+
+/* A directory of loose references that has not yet been fully read. */
+#define REF_DIR_INCOMPLETE 0x20
 
 /*
  * A ref_entry represents either a reference or a "subdirectory" of
- * references.  Each directory in the reference namespace is
- * represented by a ref_entry with (flags & REF_DIR) set and
- * containing a subdir member that holds the entries in that
- * directory.  References are represented by a ref_entry with (flags &
- * REF_DIR) unset and a value member that describes the reference's
- * value.  The flag member is at the ref_entry level, but it is also
- * needed to interpret the contents of the value field (in other
- * words, a ref_value object is not very much use without the
- * enclosing ref_entry).
+ * references.
+ *
+ * Each directory in the reference namespace is represented by a
+ * ref_entry with (flags & REF_DIR) set and containing a subdir member
+ * that holds the entries in that directory that have been read so
+ * far.  If (flags & REF_DIR) == REF_DIR_INCOMPLETE, then the
+ * directory and its subdirectories haven't been read yet.
+ * REF_DIR_INCOMPLETE is only used for loose references.
+ *
+ * References are represented by a ref_entry with (flags & REF_DIR) ==
+ * 0 and a value member that describes the reference's value.  The
+ * flag member is at the ref_entry level, but it is also needed to
+ * interpret the contents of the value field (in other words, a
+ * ref_value object is not very much use without the enclosing
+ * ref_entry).
  *
  * Reference names cannot end with slash and directories' names are
  * always stored with a trailing slash (except for the top-level
@@ -207,11 +255,13 @@ static void free_ref_entry(struct ref_entry *entry)
 /*
  * Add entry to the end of direntry, unsorted.  entry is always stored
  * directly in direntry; no recursion into subdirectories is done.
+ * direntry must already be REF_DIR_COMPLETE.
  */
 static void add_entry(struct ref_entry *direntry, struct ref_entry *entry)
 {
 	struct ref_dir *dir;
 	assert(direntry->flag & REF_DIR);
+	assert((direntry->flag & REF_DIR) == REF_DIR_COMPLETE);
 	dir = &direntry->u.subdir;
 	ALLOC_GROW(dir->entries, dir->nr + 1, dir->alloc);
 	dir->entries[dir->nr++] = entry;
@@ -256,10 +306,12 @@ static int ref_entry_cmp(const void *a, const void *b)
 
 static void sort_ref_dir(struct ref_entry *direntry);
 
+static void read_loose_refs(struct ref_entry *direntry);
+
 /*
  * Return the entry with the given refname from direntry
- * (non-recursively), sorting direntry if necessary.  Return NULL if
- * no such entry is found.
+ * (non-recursively), reading direntry if it is REF_DIR_INCOMPLETE and
+ * sorting it if necessary.  Return NULL if no such entry is found.
  */
 static struct ref_entry *search_ref_dir(struct ref_entry *direntry,
 					const char *refname)
@@ -269,6 +321,7 @@ static struct ref_entry *search_ref_dir(struct ref_entry *direntry,
 	struct ref_dir *dir;
 
 	assert(direntry->flag & REF_DIR);
+	read_loose_refs(direntry);
 	dir = &direntry->u.subdir;
 	if (refname == NULL || !dir->nr)
 		return NULL;
@@ -303,8 +356,14 @@ static struct ref_entry *search_for_subdir(struct ref_entry *direntry,
 	if (!entry) {
 		if (!mkdir)
 			return NULL;
+		/*
+		 * If search_ref_dir() above didn't make the
+		 * entry spring into existence, then this must
+		 * not be an unread loose reference tree, so
+		 * the correct flag is REF_DIR_COMPLETE.
+		 */
 		entry = create_dir_entry(direntry->u.subdir.ref_cache,
-					 subdirname, REF_DIR);
+					 subdirname, REF_DIR_COMPLETE);
 		add_entry(direntry, entry);
 	}
 	assert(entry->flag & REF_DIR);
@@ -395,7 +454,8 @@ static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2
 
 /*
  * Sort the entries in direntry non-recursively (if they are not
- * already sorted) and remove any duplicate entries.
+ * already sorted) and remove any duplicate entries.  If direntry is
+ * REF_DIR_INCOMPLETE, read it from disk first.
  */
 static void sort_ref_dir(struct ref_entry *direntry)
 {
@@ -404,6 +464,7 @@ static void sort_ref_dir(struct ref_entry *direntry)
 	struct ref_dir *dir;
 
 	assert(direntry->flag & REF_DIR);
+	read_loose_refs(direntry);
 	dir = &direntry->u.subdir;
 	/*
 	 * This check also prevents passing a zero-length array to qsort(),
@@ -768,7 +829,7 @@ static struct ref_entry *get_packed_refs(struct ref_cache *refs)
 		const char *packed_refs_file;
 		FILE *f;
 
-		refs->packed = create_dir_entry(refs, "", REF_DIR);
+		refs->packed = create_dir_entry(refs, "", REF_DIR_COMPLETE);
 		if (*refs->name)
 			packed_refs_file = git_path_submodule(refs->name, "packed-refs");
 		else
@@ -797,12 +858,15 @@ static void read_loose_refs(struct ref_entry *direntry)
 	const char *path;
 	struct dirent *de;
 	const char *dirname = direntry->name;
-	int dirnamelen = strlen(dirname);
+	int dirnamelen;
 	struct strbuf refname;
 	struct ref_cache *refs;
 
 	assert(direntry->flag & REF_DIR);
-
+	if ((direntry->flag & REF_DIR) != REF_DIR_INCOMPLETE)
+		return;
+	direntry->flag = REF_DIR_COMPLETE;
+	dirnamelen = strlen(dirname);
 	refs = direntry->u.subdir.ref_cache;
 	if (*refs->name)
 		path = git_path_submodule(refs->name, "%s", dirname);
@@ -834,8 +898,9 @@ static void read_loose_refs(struct ref_entry *direntry)
 			/* Silently ignore. */
 		} else if (S_ISDIR(st.st_mode)) {
 			strbuf_addch(&refname, '/');
-			read_loose_refs(search_for_subdir(direntry,
-							  refname.buf, 1));
+			add_entry(direntry,
+				  create_dir_entry(refs, refname.buf,
+						   REF_DIR_INCOMPLETE));
 		} else {
 			if (*refs->name) {
 				hashclr(sha1);
@@ -860,8 +925,8 @@ static void read_loose_refs(struct ref_entry *direntry)
 static struct ref_entry *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->loose) {
-		refs->loose = create_dir_entry(refs, "", REF_DIR);
-		read_loose_refs(search_for_subdir(refs->loose, "refs/", 1));
+		refs->loose = create_dir_entry(refs, "", REF_DIR_COMPLETE);
+		add_entry(refs->loose, create_dir_entry(refs, "refs/", REF_DIR_INCOMPLETE));
 	}
 	return refs->loose;
 }
-- 
1.7.10
