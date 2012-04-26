From: mhagger@alum.mit.edu
Subject: [PATCH v2 18/18] refs: read loose references lazily
Date: Fri, 27 Apr 2012 00:27:07 +0200
Message-ID: <1335479227-7877-19-git-send-email-mhagger@alum.mit.edu>
References: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 00:27:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNXAK-0008Gp-Kn
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 00:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759531Ab2DZW1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 18:27:45 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:37170 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755628Ab2DZW1n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 18:27:43 -0400
Received: from michael.berlin.jpk.com (michael2.berlin.jpk.com [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 25F64248140;
	Fri, 27 Apr 2012 00:27:42 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196436>

From: Michael Haggerty <mhagger@alum.mit.edu>

Instead of reading the whole directory of loose references the first
time any are needed, only read them on demand, one directory at a
time.

Use a new ref_entry flag bit REF_INCOMPLETE to indicate that the entry
represents a REF_DIR that hasn't been read yet.  Whenever any entries
from such a directory are needed, read all of the loose references
from that directory.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |  127 +++++++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 97 insertions(+), 30 deletions(-)

diff --git a/refs.c b/refs.c
index a0c687f..27ce968 100644
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
@@ -108,6 +114,32 @@ struct ref_value {
 
 struct ref_cache;
 
+/*
+ * Information used (along with the information in ref_entry) to
+ * describe a level in the hierarchy of references.  This data
+ * structure only occurs embedded in a union in struct ref_entry, and
+ * only when (ref_entry.flag & REF_DIR) is set.  In that case,
+ * (ref_entry.flag & REF_INCOMPLETE) determines whether the references
+ * in the directory have already been read:
+ *
+ *     (ref_entry.flag & REF_INCOMPLETE) unset -- a directory of loose
+ *         or packed references, already read.
+ *
+ *     (ref_entry.flag & REF_INCOMPLETE) set -- a directory of loose
+ *         references that hasn't been read yet (nor has any of its
+ *         subdirectories).
+ *
+ * Entries within a directory are stored within a growable array of
+ * pointers to ref_entries (entries, nr, alloc).  Entries 0 <= i <
+ * sorted are sorted by their component name in strcmp() order and the
+ * remaining entries are unsorted.
+ *
+ * Loose references are read lazily, one directory at a time.  When a
+ * directory of loose references is read, then all of the references
+ * in that directory are stored, and REF_INCOMPLETE stubs are created
+ * for any subdirectories, but the subdirectories themselves are not
+ * read.  The reading is triggered by get_ref_dir().
+ */
 struct ref_dir {
 	int nr, alloc;
 
@@ -127,19 +159,33 @@ struct ref_dir {
 
 /* ISSYMREF=0x01, ISPACKED=0x02, and ISBROKEN=0x04 are public interfaces */
 #define REF_KNOWS_PEELED 0x08
+
+/* ref_entry represents a directory of references */
 #define REF_DIR 0x10
 
 /*
+ * Entry has not yet been read from disk (used only for REF_DIR
+ * entries representing loose references)
+ */
+#define REF_INCOMPLETE 0x20
+
+/*
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
+ * far.  If (flags & REF_INCOMPLETE) is set, then the directory and
+ * its subdirectories haven't been read yet.  REF_INCOMPLETE is only
+ * used for loose reference directories.
+ *
+ * References are represented by a ref_entry with (flags & REF_DIR)
+ * unset and a value member that describes the reference's value.  The
+ * flag member is at the ref_entry level, but it is also needed to
+ * interpret the contents of the value field (in other words, a
+ * ref_value object is not very much use without the enclosing
+ * ref_entry).
  *
  * Reference names cannot end with slash and directories' names are
  * always stored with a trailing slash (except for the top-level
@@ -176,10 +222,18 @@ struct ref_entry {
 	char name[FLEX_ARRAY];
 };
 
+static void read_loose_refs(const char *dirname, struct ref_dir *dir);
+
 static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 {
+	struct ref_dir *dir;
 	assert(entry->flag & REF_DIR);
-	return &entry->u.subdir;
+	dir = &entry->u.subdir;
+	if (entry->flag & REF_INCOMPLETE) {
+		read_loose_refs(entry->name, dir);
+		entry->flag &= ~REF_INCOMPLETE;
+	}
+	return dir;
 }
 
 static struct ref_entry *create_ref_entry(const char *refname,
@@ -237,17 +291,17 @@ static void clear_ref_dir(struct ref_dir *dir)
 /*
  * Create a struct ref_entry object for the specified dirname.
  * dirname is the name of the directory with a trailing slash (e.g.,
- * "refs/heads/") or "" for the top-level directory.
+ * "refs/heads/") or "" for the top-level directory.  
  */
 static struct ref_entry *create_dir_entry(struct ref_cache *ref_cache,
-					  const char *dirname)
+					  const char *dirname, int incomplete)
 {
 	struct ref_entry *direntry;
 	int len = strlen(dirname);
 	direntry = xcalloc(1, sizeof(struct ref_entry) + len + 1);
 	memcpy(direntry->name, dirname, len + 1);
 	direntry->u.subdir.ref_cache = ref_cache;
-	direntry->flag = REF_DIR;
+	direntry->flag = REF_DIR | (incomplete ? REF_INCOMPLETE : 0);
 	return direntry;
 }
 
@@ -263,7 +317,7 @@ static void sort_ref_dir(struct ref_dir *dir);
 /*
  * Return the entry with the given refname from the ref_dir
  * (non-recursively), sorting dir if necessary.  Return NULL if no
- * such entry is found.
+ * such entry is found.  dir must already be complete.
  */
 static struct ref_entry *search_ref_dir(struct ref_dir *dir, const char *refname)
 {
@@ -294,7 +348,7 @@ static struct ref_entry *search_ref_dir(struct ref_dir *dir, const char *refname
  * recursing).  Sort dir if necessary.  subdirname must be a directory
  * name (i.e., end in '/').  If mkdir is set, then create the
  * directory if it is missing; otherwise, return NULL if the desired
- * directory cannot be found.
+ * directory cannot be found.  dir must already be complete.
  */
 static struct ref_dir *search_for_subdir(struct ref_dir *dir,
 					 const char *subdirname, int mkdir)
@@ -303,7 +357,13 @@ static struct ref_dir *search_for_subdir(struct ref_dir *dir,
 	if (!entry) {
 		if (!mkdir)
 			return NULL;
-		entry = create_dir_entry(dir->ref_cache, subdirname);
+		/*
+		 * Since dir is complete, the absence of a subdir
+		 * means that the subdir really doesn't exist;
+		 * therefore, create an empty record for it but mark
+		 * the record complete.
+		 */
+		entry = create_dir_entry(dir->ref_cache, subdirname, 0);
 		add_entry_to_dir(dir, entry);
 	}
 	return get_ref_dir(entry);
@@ -313,10 +373,10 @@ static struct ref_dir *search_for_subdir(struct ref_dir *dir,
  * If refname is a reference name, find the ref_dir within the dir
  * tree that should hold refname.  If refname is a directory name
  * (i.e., ends in '/'), then return that ref_dir itself.  dir must
- * represent the top-level directory.  Sort ref_dirs and recurse into
- * subdirectories as necessary.  If mkdir is set, then create any
- * missing directories; otherwise, return NULL if the desired
- * directory cannot be found.
+ * represent the top-level directory and must already be complete.
+ * Sort ref_dirs and recurse into subdirectories as necessary.  If
+ * mkdir is set, then create any missing directories; otherwise,
+ * return NULL if the desired directory cannot be found.
  */
 static struct ref_dir *find_containing_dir(struct ref_dir *dir,
 					   const char *refname, int mkdir)
@@ -760,7 +820,7 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 		const char *packed_refs_file;
 		FILE *f;
 
-		refs->packed = create_dir_entry(refs, "");
+		refs->packed = create_dir_entry(refs, "", 0);
 		if (*refs->name)
 			packed_refs_file = git_path_submodule(refs->name, "packed-refs");
 		else
@@ -781,9 +841,9 @@ void add_packed_ref(const char *refname, const unsigned char *sha1)
 }
 
 /*
- * Read the loose references for refs from the namespace dirname.
- * dirname must end with '/'.  dir must be the directory entry
- * corresponding to dirname.
+ * Read the loose references from the namespace dirname into dir
+ * (without recursing).  dirname must end with '/'.  dir must be the
+ * directory entry corresponding to dirname.
  */
 static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 {
@@ -824,8 +884,8 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 			/* Silently ignore. */
 		} else if (S_ISDIR(st.st_mode)) {
 			strbuf_addch(&refname, '/');
-			read_loose_refs(refname.buf,
-					search_for_subdir(dir, refname.buf, 1));
+			add_entry_to_dir(dir,
+					 create_dir_entry(refs, refname.buf, 1));
 		} else {
 			if (*refs->name) {
 				hashclr(sha1);
@@ -850,10 +910,17 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->loose) {
-		refs->loose = create_dir_entry(refs, "");
-		read_loose_refs("refs/",
-				search_for_subdir(get_ref_dir(refs->loose),
-						  "refs/", 1));
+		/*
+		 * Mark the top-level directory complete because we
+		 * are about to read the only subdirectory that can
+		 * hold references:
+		 */
+		refs->loose = create_dir_entry(refs, "", 0);
+		/*
+		 * Create an incomplete entry for "refs/":
+		 */
+		add_entry_to_dir(get_ref_dir(refs->loose),
+				 create_dir_entry(refs, "refs/", 1));
 	}
 	return get_ref_dir(refs->loose);
 }
-- 
1.7.10
