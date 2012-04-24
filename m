From: mhagger@alum.mit.edu
Subject: [PATCH 17/30] find_containing_direntry(): use (ref_entry *) instead of (ref_dir *)
Date: Wed, 25 Apr 2012 00:45:23 +0200
Message-ID: <1335307536-26914-18-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:58:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMogb-0000i7-EE
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503Ab2DXW55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:57:57 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60968 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758449Ab2DXW46 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:56:58 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id CD931248163;
	Wed, 25 Apr 2012 00:46:14 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196282>

From: Michael Haggerty <mhagger@alum.mit.edu>

Change type of both argument and return value, and rename function
from find_containing_dir() to find_containing_direntry().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   67 ++++++++++++++++++++++++++++++----------------------------------
 1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/refs.c b/refs.c
index 6077cfb..140fbe2 100644
--- a/refs.c
+++ b/refs.c
@@ -298,32 +298,30 @@ static struct ref_entry *search_for_subdir(struct ref_dir *dir,
 }
 
 /*
- * If refname is a reference name, find the ref_dir within the dir
- * tree that should hold refname.  If refname is a directory name
- * (i.e., ends in '/'), then return that ref_dir itself.  dir must
- * represent the top-level directory.  Sort ref_dirs and recurse into
- * subdirectories as necessary.  If mkdir is set, then create any
- * missing directories; otherwise, return NULL if the desired
- * directory cannot be found.
+ * If refname is a reference name, find the directory entry within the
+ * direntry tree that should hold refname.  If refname is a directory
+ * name (i.e., ends in '/'), then return that directory entry itself.
+ * direntry must represent the top-level directory.  Sort directories
+ * and recurse into subdirectories as necessary.  If mkdir is set,
+ * then create any missing directories; otherwise, return NULL if the
+ * desired directory cannot be found.
  */
-static struct ref_dir *find_containing_dir(struct ref_dir *dir,
-					   const char *refname, int mkdir)
+static struct ref_entry *find_containing_direntry(struct ref_entry *direntry,
+						  const char *refname, int mkdir)
 {
 	char *refname_copy = xstrdup(refname);
 	char *slash;
-	struct ref_entry *entry;
 	for (slash = strchr(refname_copy, '/'); slash; slash = strchr(slash + 1, '/')) {
 		char tmp = slash[1];
 		slash[1] = '\0';
-		entry = search_for_subdir(dir, refname_copy, mkdir);
+		direntry = search_for_subdir(&direntry->u.subdir, refname_copy, mkdir);
 		slash[1] = tmp;
-		if (!entry)
+		if (!direntry)
 			break;
-		dir = &entry->u.subdir;
 	}
 
 	free(refname_copy);
-	return dir;
+	return direntry;
 }
 
 /*
@@ -335,12 +333,11 @@ static struct ref_dir *find_containing_dir(struct ref_dir *dir,
 static struct ref_entry *find_ref(struct ref_entry *direntry, const char *refname)
 {
 	struct ref_entry *entry;
-	struct ref_dir *dir;
 	assert(direntry->flag & REF_DIR);
-	dir = find_containing_dir(&direntry->u.subdir, refname, 0);
-	if (!dir)
+	direntry = find_containing_direntry(direntry, refname, 0);
+	if (!direntry)
 		return NULL;
-	entry = search_ref_dir(dir, refname);
+	entry = search_ref_dir(&direntry->u.subdir, refname);
 	return (entry && !(entry->flag & REF_DIR)) ? entry : NULL;
 }
 
@@ -351,12 +348,11 @@ static struct ref_entry *find_ref(struct ref_entry *direntry, const char *refnam
  */
 static int add_ref(struct ref_entry *direntry, struct ref_entry *ref)
 {
-	struct ref_dir *dir;
 	assert(direntry->flag & REF_DIR);
-	dir = find_containing_dir(&direntry->u.subdir, ref->name, 1);
-	if (!dir)
+	direntry = find_containing_direntry(direntry, ref->name, 1);
+	if (!direntry)
 		return -1;
-	add_entry_to_dir(dir, ref);
+	add_entry_to_dir(&direntry->u.subdir, ref);
 	return 0;
 }
 
@@ -1172,31 +1168,30 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 {
 	struct ref_cache *refs = get_ref_cache(submodule);
 	struct ref_entry *packed_direntry = get_packed_refs(refs);
-	struct ref_dir *packed_dir = &packed_direntry->u.subdir;
 	struct ref_entry *loose_direntry = get_loose_refs(refs);
-	struct ref_dir *loose_dir = &loose_direntry->u.subdir;
 	int retval = 0;
 
 	if (base && *base) {
-		packed_dir = find_containing_dir(packed_dir, base, 0);
-		loose_dir = find_containing_dir(loose_dir, base, 0);
+		packed_direntry = find_containing_direntry(packed_direntry, base, 0);
+		loose_direntry = find_containing_direntry(loose_direntry, base, 0);
 	}
 
-	if (packed_dir && loose_dir) {
-		sort_ref_dir(packed_dir);
-		sort_ref_dir(loose_dir);
+	if (packed_direntry && loose_direntry) {
+		sort_ref_dir(&packed_direntry->u.subdir);
+		sort_ref_dir(&loose_direntry->u.subdir);
 		retval = do_for_each_ref_in_dirs(
-				packed_dir, loose_dir,
+				&packed_direntry->u.subdir,
+				&loose_direntry->u.subdir,
 				base, fn, trim, flags, cb_data);
-	} else if (packed_dir) {
-		sort_ref_dir(packed_dir);
+	} else if (packed_direntry) {
+		sort_ref_dir(&packed_direntry->u.subdir);
 		retval = do_for_each_ref_in_dir(
-				packed_dir, 0,
+				&packed_direntry->u.subdir, 0,
 				base, fn, trim, flags, cb_data);
-	} else if (loose_dir) {
-		sort_ref_dir(loose_dir);
+	} else if (loose_direntry) {
+		sort_ref_dir(&loose_direntry->u.subdir);
 		retval = do_for_each_ref_in_dir(
-				loose_dir, 0,
+				&loose_direntry->u.subdir, 0,
 				base, fn, trim, flags, cb_data);
 	}
 
-- 
1.7.10
