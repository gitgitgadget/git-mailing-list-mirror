From: mhagger@alum.mit.edu
Subject: [PATCH 24/30] do_for_each_ref_in_dir(): take (ref_entry *) instead of (ref_dir *)
Date: Wed, 25 Apr 2012 00:45:30 +0200
Message-ID: <1335307536-26914-25-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:57:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMogH-0000SK-3v
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491Ab2DXW5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:57:50 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60972 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758454Ab2DXW46 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:56:58 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 2B72F24816A;
	Wed, 25 Apr 2012 00:46:22 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196280>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 4448b14..722545f 100644
--- a/refs.c
+++ b/refs.c
@@ -440,23 +440,24 @@ static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 }
 
 /*
- * Call fn for each reference in dir that has index in the range
+ * Call fn for each reference in direntry that has index in the range
  * offset <= index < dir->nr.  Recurse into subdirectories that are in
  * that index range, sorting them before iterating.  This function
- * does not sort dir itself; it should be sorted beforehand.
+ * does not sort direntry itself; it should be sorted beforehand.
  */
-static int do_for_each_ref_in_dir(struct ref_dir *dir, int offset,
+static int do_for_each_ref_in_dir(struct ref_entry *direntry, int offset,
 				  const char *base,
 				  each_ref_fn fn, int trim, int flags, void *cb_data)
 {
 	int i;
-	assert(dir->sorted == dir->nr);
-	for (i = offset; i < dir->nr; i++) {
-		struct ref_entry *entry = dir->entries[i];
+	assert(direntry->flag & REF_DIR);
+	assert(direntry->u.subdir.sorted == direntry->u.subdir.nr);
+	for (i = offset; i < direntry->u.subdir.nr; i++) {
+		struct ref_entry *entry = direntry->u.subdir.entries[i];
 		int retval;
 		if (entry->flag & REF_DIR) {
 			sort_ref_dir(&entry->u.subdir);
-			retval = do_for_each_ref_in_dir(&entry->u.subdir, 0,
+			retval = do_for_each_ref_in_dir(entry, 0,
 							base, fn, trim, flags, cb_data);
 		} else {
 			retval = do_one_ref(base, fn, trim, flags, cb_data, entry);
@@ -491,11 +492,11 @@ static int do_for_each_ref_in_dirs(struct ref_entry *direntry1,
 		struct ref_entry *e1, *e2;
 		int cmp;
 		if (i1 == direntry1->u.subdir.nr) {
-			return do_for_each_ref_in_dir(&direntry2->u.subdir, i2,
+			return do_for_each_ref_in_dir(direntry2, i2,
 						      base, fn, trim, flags, cb_data);
 		}
 		if (i2 == direntry2->u.subdir.nr) {
-			return do_for_each_ref_in_dir(&direntry1->u.subdir, i1,
+			return do_for_each_ref_in_dir(direntry1, i1,
 						      base, fn, trim, flags, cb_data);
 		}
 		e1 = direntry1->u.subdir.entries[i1];
@@ -532,7 +533,7 @@ static int do_for_each_ref_in_dirs(struct ref_entry *direntry1,
 			if (e->flag & REF_DIR) {
 				sort_ref_dir(&e->u.subdir);
 				retval = do_for_each_ref_in_dir(
-						&e->u.subdir, 0,
+						e, 0,
 						base, fn, trim, flags, cb_data);
 			} else {
 				retval = do_one_ref(base, fn, trim, flags, cb_data, e);
@@ -542,10 +543,10 @@ static int do_for_each_ref_in_dirs(struct ref_entry *direntry1,
 			return retval;
 	}
 	if (i1 < direntry1->u.subdir.nr)
-		return do_for_each_ref_in_dir(&direntry1->u.subdir, i1,
+		return do_for_each_ref_in_dir(direntry1, i1,
 					      base, fn, trim, flags, cb_data);
 	if (i2 < direntry2->u.subdir.nr)
-		return do_for_each_ref_in_dir(&direntry2->u.subdir, i2,
+		return do_for_each_ref_in_dir(direntry2, i2,
 					      base, fn, trim, flags, cb_data);
 	return 0;
 }
@@ -602,7 +603,7 @@ static int is_refname_available(const char *refname, const char *oldrefname,
 	assert(direntry->flag & REF_DIR);
 	sort_ref_dir(&direntry->u.subdir);
 
-	if (do_for_each_ref_in_dir(&direntry->u.subdir, 0, "", name_conflict_fn,
+	if (do_for_each_ref_in_dir(direntry, 0, "", name_conflict_fn,
 				   0, DO_FOR_EACH_INCLUDE_BROKEN,
 				   &data)) {
 		error("'%s' exists; cannot create '%s'",
@@ -1194,12 +1195,12 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 	} else if (packed_direntry) {
 		sort_ref_dir(&packed_direntry->u.subdir);
 		retval = do_for_each_ref_in_dir(
-				&packed_direntry->u.subdir, 0,
+				packed_direntry, 0,
 				base, fn, trim, flags, cb_data);
 	} else if (loose_direntry) {
 		sort_ref_dir(&loose_direntry->u.subdir);
 		retval = do_for_each_ref_in_dir(
-				&loose_direntry->u.subdir, 0,
+				loose_direntry, 0,
 				base, fn, trim, flags, cb_data);
 	}
 
@@ -1648,7 +1649,7 @@ static int repack_without_ref(const char *refname)
 		unable_to_lock_error(git_path("packed-refs"), errno);
 		return error("cannot delete '%s' from packed refs", refname);
 	}
-	do_for_each_ref_in_dir(&packed->u.subdir, 0,
+	do_for_each_ref_in_dir(packed, 0,
 			       "", repack_without_ref_fn, 0, 0, &data);
 	return commit_lock_file(&packlock);
 }
-- 
1.7.10
