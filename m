From: mhagger@alum.mit.edu
Subject: [PATCH 25/30] sort_ref_dir(): take (ref_entry *) instead of (ref_dir *)
Date: Wed, 25 Apr 2012 00:45:31 +0200
Message-ID: <1335307536-26914-26-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:58:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMoh0-00010Q-4h
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520Ab2DXW6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:58:05 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60965 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758446Ab2DXW46 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:56:58 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 77BE724816B;
	Wed, 25 Apr 2012 00:46:23 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196284>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index 722545f..90bdd7c 100644
--- a/refs.c
+++ b/refs.c
@@ -247,7 +247,7 @@ static int ref_entry_cmp(const void *a, const void *b)
 	return strcmp(one->name, two->name);
 }
 
-static void sort_ref_dir(struct ref_dir *dir);
+static void sort_ref_dir(struct ref_entry *direntry);
 
 /*
  * Return the entry with the given refname from direntry
@@ -266,7 +266,7 @@ static struct ref_entry *search_ref_dir(struct ref_entry *direntry,
 	if (refname == NULL || !dir->nr)
 		return NULL;
 
-	sort_ref_dir(dir);
+	sort_ref_dir(direntry);
 
 	len = strlen(refname) + 1;
 	e = xmalloc(sizeof(struct ref_entry) + len);
@@ -386,14 +386,17 @@ static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2
 }
 
 /*
- * Sort the entries in dir non-recursively (if they are not already
- * sorted) and remove any duplicate entries.
+ * Sort the entries in direntry non-recursively (if they are not
+ * already sorted) and remove any duplicate entries.
  */
-static void sort_ref_dir(struct ref_dir *dir)
+static void sort_ref_dir(struct ref_entry *direntry)
 {
 	int i, j;
 	struct ref_entry *last = NULL;
+	struct ref_dir *dir;
 
+	assert(direntry->flag & REF_DIR);
+	dir = &direntry->u.subdir;
 	/*
 	 * This check also prevents passing a zero-length array to qsort(),
 	 * which is a problem on some platforms.
@@ -456,7 +459,7 @@ static int do_for_each_ref_in_dir(struct ref_entry *direntry, int offset,
 		struct ref_entry *entry = direntry->u.subdir.entries[i];
 		int retval;
 		if (entry->flag & REF_DIR) {
-			sort_ref_dir(&entry->u.subdir);
+			sort_ref_dir(entry);
 			retval = do_for_each_ref_in_dir(entry, 0,
 							base, fn, trim, flags, cb_data);
 		} else {
@@ -505,8 +508,8 @@ static int do_for_each_ref_in_dirs(struct ref_entry *direntry1,
 		if (cmp == 0) {
 			if ((e1->flag & REF_DIR) && (e2->flag & REF_DIR)) {
 				/* Both are directories; descend them in parallel. */
-				sort_ref_dir(&e1->u.subdir);
-				sort_ref_dir(&e2->u.subdir);
+				sort_ref_dir(e1);
+				sort_ref_dir(e2);
 				retval = do_for_each_ref_in_dirs(
 						e1, e2,
 						base, fn, trim, flags, cb_data);
@@ -531,7 +534,7 @@ static int do_for_each_ref_in_dirs(struct ref_entry *direntry1,
 				i2++;
 			}
 			if (e->flag & REF_DIR) {
-				sort_ref_dir(&e->u.subdir);
+				sort_ref_dir(e);
 				retval = do_for_each_ref_in_dir(
 						e, 0,
 						base, fn, trim, flags, cb_data);
@@ -601,7 +604,7 @@ static int is_refname_available(const char *refname, const char *oldrefname,
 	data.conflicting_refname = NULL;
 
 	assert(direntry->flag & REF_DIR);
-	sort_ref_dir(&direntry->u.subdir);
+	sort_ref_dir(direntry);
 
 	if (do_for_each_ref_in_dir(direntry, 0, "", name_conflict_fn,
 				   0, DO_FOR_EACH_INCLUDE_BROKEN,
@@ -1187,18 +1190,18 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 	}
 
 	if (packed_direntry && loose_direntry) {
-		sort_ref_dir(&packed_direntry->u.subdir);
-		sort_ref_dir(&loose_direntry->u.subdir);
+		sort_ref_dir(packed_direntry);
+		sort_ref_dir(loose_direntry);
 		retval = do_for_each_ref_in_dirs(
 				packed_direntry, loose_direntry,
 				base, fn, trim, flags, cb_data);
 	} else if (packed_direntry) {
-		sort_ref_dir(&packed_direntry->u.subdir);
+		sort_ref_dir(packed_direntry);
 		retval = do_for_each_ref_in_dir(
 				packed_direntry, 0,
 				base, fn, trim, flags, cb_data);
 	} else if (loose_direntry) {
-		sort_ref_dir(&loose_direntry->u.subdir);
+		sort_ref_dir(loose_direntry);
 		retval = do_for_each_ref_in_dir(
 				loose_direntry, 0,
 				base, fn, trim, flags, cb_data);
-- 
1.7.10
