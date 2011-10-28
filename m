From: mhagger@alum.mit.edu
Subject: [PATCH 18/28] find_containing_direntry(): use (ref_entry *) instead of (ref_dir *)
Date: Fri, 28 Oct 2011 14:28:31 +0200
Message-ID: <1319804921-17545-19-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:31:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlb0-0004nM-M9
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715Ab1J1Mbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:31:33 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:55864 "EHLO
	homer.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932685Ab1J1Mbc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:31:32 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-Ng; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184391>

From: Michael Haggerty <mhagger@alum.mit.edu>

Change type of both argument and return value.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   78 ++++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/refs.c b/refs.c
index f5aaafe..35b3ff2 100644
--- a/refs.c
+++ b/refs.c
@@ -324,38 +324,40 @@ static struct ref_entry *search_ref_dir(struct ref_dir *dir, const char *refname
 }
 
 /*
- * If refname is a reference name, find the ref_dir within the dir
+ * If refname is a reference name, find the ref_entry within the dir
  * tree that should hold refname.  If refname is a directory name
- * (i.e., ends in '/'), then return that ref_dir itself.  dir must
- * represent the top-level directory.  Recurse into subdirectories as
- * necessary.  If mkdir is set, then create any missing directories;
- * otherwise, return NULL if the desired directory cannot be found.
+ * (i.e., "" or ends in '/'), then return that ref_entry itself.  dir
+ * must represent the top-level directory.  Recurse into
+ * subdirectories as necessary.  If mkdir is set, then create any
+ * missing directories; otherwise, return NULL if the desired
+ * directory cannot be found.
  */
-static struct ref_dir *find_containing_dir(struct ref_dir *dir,
-					   const char *refname, int mkdir)
+static struct ref_entry *find_containing_direntry(struct ref_entry *direntry,
+						  const char *refname, int mkdir)
 {
 	char *refname_copy = xstrdup(refname);
 	char *slash;
-	struct ref_entry *entry;
+	assert(direntry->flag & REF_DIR);
 	for (slash = strchr(refname_copy, '/'); slash; slash = strchr(slash + 1, '/')) {
 		char tmp = slash[1];
+		struct ref_entry *entry;
 		slash[1] = '\0';
-		entry = search_ref_dir(dir, refname_copy);
+		entry = search_ref_dir(&direntry->u.subdir, refname_copy);
 		if (!entry) {
 			if (!mkdir) {
-				dir = NULL;
+				direntry = NULL;
 				break;
 			}
 			entry = create_dir_entry(refname_copy);
-			add_entry_to_dir(dir, entry);
+			add_entry_to_dir(&direntry->u.subdir, entry);
 		}
 		slash[1] = tmp;
 		assert(entry->flag & REF_DIR);
-		dir = &entry->u.subdir;
+		direntry = entry;
 	}
 
 	free(refname_copy);
-	return dir;
+	return direntry;
 }
 
 /*
@@ -366,12 +368,11 @@ static struct ref_dir *find_containing_dir(struct ref_dir *dir,
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
 
@@ -382,12 +383,11 @@ static struct ref_entry *find_ref(struct ref_entry *direntry, const char *refnam
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
 
@@ -797,11 +797,11 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname)
 	char *path;
 	int dirnamelen = strlen(dirname);
 	int pathlen;
-	struct ref_dir *dir;
+	struct ref_entry *direntry;
 
 	assert(dirnamelen && dirname[dirnamelen - 1] == '/');
 
-	dir = find_containing_dir(&refs->loose->u.subdir, dirname, 1);
+	direntry = find_containing_direntry(refs->loose, dirname, 1);
 
 	if (*refs->name)
 		path = git_path_submodule(refs->name, "%s", dirname);
@@ -855,7 +855,8 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname)
 					hashclr(sha1);
 					flag |= REF_ISBROKEN;
 				}
-			add_entry_to_dir(dir, create_ref_entry(refname, sha1, flag));
+			add_entry_to_dir(&direntry->u.subdir,
+					 create_ref_entry(refname, sha1, flag));
 		}
 		free(refname);
 		closedir(d);
@@ -1177,35 +1178,34 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 {
 	int retval = 0;
 	struct ref_cache *refs = get_ref_cache(submodule);
-	struct ref_dir *extra_dir = extra_refs ? &extra_refs->u.subdir : NULL;
+	struct ref_entry *extra_direntry = extra_refs;
 	struct ref_entry *packed_direntry = get_packed_refs(refs);
-	struct ref_dir *packed_dir = &packed_direntry->u.subdir;
 	struct ref_entry *loose_direntry = get_loose_refs(refs);
-	struct ref_dir *loose_dir = &loose_direntry->u.subdir;
 
 	if (base && *base) {
-		if (extra_dir)
-			extra_dir = find_containing_dir(extra_dir, base, 0);
-		packed_dir = find_containing_dir(packed_dir, base, 0);
-		loose_dir = find_containing_dir(loose_dir, base, 0);
+		if (extra_direntry)
+			extra_direntry = find_containing_direntry(extra_direntry, base, 0);
+		packed_direntry = find_containing_direntry(packed_direntry, base, 0);
+		loose_direntry = find_containing_direntry(loose_direntry, base, 0);
 	}
 
-	if (extra_dir)
+	if (extra_direntry)
 		retval = do_for_each_ref_in_dir(
-				extra_dir, 0,
+				&extra_direntry->u.subdir, 0,
 				base, fn, trim, flags, cb_data);
 	if (!retval) {
-		if (packed_dir && loose_dir)
+		if (packed_direntry && loose_direntry)
 			retval = do_for_each_ref_in_dirs(
-					packed_dir, loose_dir,
+					&packed_direntry->u.subdir,
+					&loose_direntry->u.subdir,
 					base, fn, trim, flags, cb_data);
-		else if (packed_dir)
+		else if (packed_direntry)
 			retval = do_for_each_ref_in_dir(
-					packed_dir, 0,
+					&packed_direntry->u.subdir, 0,
 					base, fn, trim, flags, cb_data);
-		else if (loose_dir)
+		else if (loose_direntry)
 			retval = do_for_each_ref_in_dir(
-					loose_dir, 0,
+					&loose_direntry->u.subdir, 0,
 					base, fn, trim, flags, cb_data);
 	}
 
-- 
1.7.7
