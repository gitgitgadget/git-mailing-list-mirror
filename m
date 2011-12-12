From: mhagger@alum.mit.edu
Subject: [PATCH v2 48/51] refs: read loose references lazily
Date: Mon, 12 Dec 2011 06:38:55 +0100
Message-ID: <1323668338-1764-49-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:42:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZyeF-00015m-BC
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133Ab1LLFl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:41:27 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:35041 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753143Ab1LLFlF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:41:05 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8b1015577;
	Mon, 12 Dec 2011 06:40:55 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186868>

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
 refs.c |  112 ++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 88 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index a85a8a5..3cd8e04 100644
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
+ * using one of the for_each_ref*() functions (which calls
+ * sort_ref_dir() for each subdirectory).
+ */
 struct ref_dir {
 	int nr, alloc;
 
@@ -125,19 +159,33 @@ struct ref_dir {
 
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
@@ -229,19 +277,21 @@ static void clear_ref_dir(struct ref_dir *dir)
 	dir->entries = NULL;
 }
 
+static void read_loose_refs(struct ref_entry *direntry);
+
 /*
  * Create a struct ref_entry object for the specified dirname.
  * dirname is the name of the directory with a trailing slash (e.g.,
  * "refs/heads/") or "" for the top-level directory.
  */
 static struct ref_entry *create_dir_entry(struct ref_cache *ref_cache,
-					  const char *dirname)
+					  const char *dirname, int flag)
 {
 	struct ref_entry *direntry;
 	int len = strlen(dirname);
 	direntry = xcalloc(1, sizeof(struct ref_entry) + len + 1);
 	memcpy(direntry->name, dirname, len + 1);
-	direntry->flag = REF_DIR;
+	direntry->flag = flag;
 	direntry->u.subdir.ref_cache = ref_cache;
 	return direntry;
 }
@@ -266,6 +316,7 @@ static struct ref_entry *search_ref_dir(struct ref_entry *direntry, const char *
 	struct ref_dir *dir;
 
 	assert(direntry->flag & REF_DIR);
+	read_loose_refs(direntry);
 	dir = &direntry->u.subdir;
 	if (refname == NULL || !dir->nr)
 		return NULL;
@@ -322,8 +373,14 @@ static struct ref_entry *find_containing_direntry(struct ref_entry *direntry,
 				direntry = NULL;
 				break;
 			}
+			/*
+			 * If search_ref_dir() above didn't make the
+			 * entry spring into existence, then this must
+			 * not be an unread loose reference tree, so
+			 * the correct flag is REF_DIR_COMPLETE.
+			 */
 			entry = create_dir_entry(direntry->u.subdir.ref_cache,
-						 refname_copy);
+						 refname_copy, REF_DIR_COMPLETE);
 			add_entry(direntry, entry);
 		}
 		slash[1] = tmp;
@@ -399,6 +456,7 @@ static void sort_ref_dir(struct ref_entry *direntry)
 	struct ref_entry *last = NULL;
 	struct ref_dir *dir;
 	assert(direntry->flag & REF_DIR);
+	read_loose_refs(direntry);
 	dir = &direntry->u.subdir;
 	if (dir->sorted == dir->nr)
 		return; /* This directory is already sorted and de-duped */
@@ -449,8 +507,8 @@ static int do_for_each_ref_in_dir(struct ref_entry *direntry, int offset,
 	int i;
 	struct ref_dir *dir;
 	assert(direntry->flag & REF_DIR);
-	dir = &direntry->u.subdir;
 	sort_ref_dir(direntry);
+	dir = &direntry->u.subdir;
 	for (i = offset; i < dir->nr; i++) {
 		struct ref_entry *entry = dir->entries[i];
 		int retval;
@@ -477,10 +535,10 @@ static int do_for_each_ref_in_dirs(struct ref_entry *direntry1,
 
 	assert(direntry1->flag & REF_DIR);
 	assert(direntry2->flag & REF_DIR);
-	dir1 = &direntry1->u.subdir;
-	dir2 = &direntry2->u.subdir;
 	sort_ref_dir(direntry1);
 	sort_ref_dir(direntry2);
+	dir1 = &direntry1->u.subdir;
+	dir2 = &direntry2->u.subdir;
 	while (1) {
 		struct ref_entry *e1, *e2, *entry;
 		int cmp;
@@ -737,7 +795,7 @@ static void read_packed_refs(FILE *f, struct ref_entry *direntry)
 void add_extra_ref(const char *refname, const unsigned char *sha1, int flag)
 {
 	if (!extra_refs)
-		extra_refs = create_dir_entry(NULL, "");
+		extra_refs = create_dir_entry(NULL, "", REF_DIR_COMPLETE);
 	add_ref(extra_refs, create_ref_entry(refname, sha1, flag, 0));
 }
 
@@ -755,7 +813,7 @@ static struct ref_entry *get_packed_refs(struct ref_cache *refs)
 		const char *packed_refs_file;
 		FILE *f;
 
-		refs->packed = create_dir_entry(refs, "");
+		refs->packed = create_dir_entry(refs, "", REF_DIR_COMPLETE);
 		if (*refs->name)
 			packed_refs_file = git_path_submodule(refs->name, "packed-refs");
 		else
@@ -777,11 +835,14 @@ static void read_loose_refs(struct ref_entry *direntry)
 	DIR *d;
 	char *path;
 	char *dirname = direntry->name;
-	int dirnamelen = strlen(dirname);
+	int dirnamelen;
 	int pathlen;
 	struct ref_cache *refs;
 
 	assert(direntry->flag & REF_DIR);
+	if ((direntry->flag & REF_DIR) != REF_DIR_INCOMPLETE)
+		return;
+	dirnamelen = strlen(dirname);
 	assert(dirnamelen && direntry->name[dirnamelen - 1] == '/');
 	refs = direntry->u.subdir.ref_cache;
 	if (*refs->name)
@@ -819,11 +880,12 @@ static void read_loose_refs(struct ref_entry *direntry)
 			if (stat(refdir, &st) < 0)
 				continue;
 			if (S_ISDIR(st.st_mode)) {
+				struct ref_entry *subdirentry;
 				refname[dirnamelen + namelen] = '/';
 				refname[dirnamelen + namelen + 1] = '\0';
-				read_loose_refs(find_containing_direntry(
-								refs->loose,
-								refname, 1));
+				subdirentry = create_dir_entry(direntry->u.subdir.ref_cache,
+							       refname, REF_DIR_INCOMPLETE);
+				add_entry(direntry, subdirentry);
 				continue;
 			}
 			if (*refs->name) {
@@ -842,13 +904,15 @@ static void read_loose_refs(struct ref_entry *direntry)
 		free(refname);
 		closedir(d);
 	}
+	direntry->flag = REF_DIR_COMPLETE;
 }
 
 static struct ref_entry *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->loose) {
-		refs->loose = create_dir_entry(refs, "");
-		read_loose_refs(find_containing_direntry(refs->loose, "refs/", 1));
+		refs->loose = create_dir_entry(refs, "", REF_DIR_COMPLETE);
+		add_entry(refs->loose,
+			  create_dir_entry(refs, "refs/", REF_DIR_INCOMPLETE));
 	}
 	return refs->loose;
 }
-- 
1.7.8
