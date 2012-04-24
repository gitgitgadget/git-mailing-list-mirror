From: mhagger@alum.mit.edu
Subject: [PATCH 23/30] do_for_each_ref_in_dirs(): take (ref_entry *) instead of (ref_dir *)
Date: Wed, 25 Apr 2012 00:45:29 +0200
Message-ID: <1335307536-26914-24-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:57:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMogE-0000SK-37
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472Ab2DXW5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:57:32 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60967 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758462Ab2DXW5A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:57:00 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 56879248169;
	Wed, 25 Apr 2012 00:46:21 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196277>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   48 +++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/refs.c b/refs.c
index a794d3a..4448b14 100644
--- a/refs.c
+++ b/refs.c
@@ -468,35 +468,38 @@ static int do_for_each_ref_in_dir(struct ref_dir *dir, int offset,
 }
 
 /*
- * Call fn for each reference in the union of dir1 and dir2, in order
- * by refname.  Recurse into subdirectories.  If a value entry appears
- * in both dir1 and dir2, then only process the version that is in
- * dir2.  The input dirs must already be sorted, but subdirs will be
- * sorted as needed.
+ * Call fn for each reference in the union of direntry1 and direntry2,
+ * in order by refname.  Recurse into subdirectories.  If a value
+ * entry appears in both direntry1 and direntry2, then only process
+ * the version that is in direntry2.  The input direntries must
+ * already be sorted, but subdirs will be sorted as needed.
  */
-static int do_for_each_ref_in_dirs(struct ref_dir *dir1,
-				   struct ref_dir *dir2,
+static int do_for_each_ref_in_dirs(struct ref_entry *direntry1,
+				   struct ref_entry *direntry2,
 				   const char *base, each_ref_fn fn, int trim,
 				   int flags, void *cb_data)
 {
 	int retval;
 	int i1 = 0, i2 = 0;
 
-	assert(dir1->sorted == dir1->nr);
-	assert(dir2->sorted == dir2->nr);
+	assert(direntry1->flag & REF_DIR);
+	assert(direntry2->flag & REF_DIR);
+	assert(direntry1->u.subdir.sorted == direntry1->u.subdir.nr);
+	assert(direntry2->u.subdir.sorted == direntry2->u.subdir.nr);
+
 	while (1) {
 		struct ref_entry *e1, *e2;
 		int cmp;
-		if (i1 == dir1->nr) {
-			return do_for_each_ref_in_dir(dir2, i2,
+		if (i1 == direntry1->u.subdir.nr) {
+			return do_for_each_ref_in_dir(&direntry2->u.subdir, i2,
 						      base, fn, trim, flags, cb_data);
 		}
-		if (i2 == dir2->nr) {
-			return do_for_each_ref_in_dir(dir1, i1,
+		if (i2 == direntry2->u.subdir.nr) {
+			return do_for_each_ref_in_dir(&direntry1->u.subdir, i1,
 						      base, fn, trim, flags, cb_data);
 		}
-		e1 = dir1->entries[i1];
-		e2 = dir2->entries[i2];
+		e1 = direntry1->u.subdir.entries[i1];
+		e2 = direntry2->u.subdir.entries[i2];
 		cmp = strcmp(e1->name, e2->name);
 		if (cmp == 0) {
 			if ((e1->flag & REF_DIR) && (e2->flag & REF_DIR)) {
@@ -504,12 +507,12 @@ static int do_for_each_ref_in_dirs(struct ref_dir *dir1,
 				sort_ref_dir(&e1->u.subdir);
 				sort_ref_dir(&e2->u.subdir);
 				retval = do_for_each_ref_in_dirs(
-						&e1->u.subdir, &e2->u.subdir,
+						e1, e2,
 						base, fn, trim, flags, cb_data);
 				i1++;
 				i2++;
 			} else if (!(e1->flag & REF_DIR) && !(e2->flag & REF_DIR)) {
-				/* Both are references; ignore the one from dir1. */
+				/* Both are references; ignore the one from direntry1. */
 				retval = do_one_ref(base, fn, trim, flags, cb_data, e2);
 				i1++;
 				i2++;
@@ -538,11 +541,11 @@ static int do_for_each_ref_in_dirs(struct ref_dir *dir1,
 		if (retval)
 			return retval;
 	}
-	if (i1 < dir1->nr)
-		return do_for_each_ref_in_dir(dir1, i1,
+	if (i1 < direntry1->u.subdir.nr)
+		return do_for_each_ref_in_dir(&direntry1->u.subdir, i1,
 					      base, fn, trim, flags, cb_data);
-	if (i2 < dir2->nr)
-		return do_for_each_ref_in_dir(dir2, i2,
+	if (i2 < direntry2->u.subdir.nr)
+		return do_for_each_ref_in_dir(&direntry2->u.subdir, i2,
 					      base, fn, trim, flags, cb_data);
 	return 0;
 }
@@ -1186,8 +1189,7 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 		sort_ref_dir(&packed_direntry->u.subdir);
 		sort_ref_dir(&loose_direntry->u.subdir);
 		retval = do_for_each_ref_in_dirs(
-				&packed_direntry->u.subdir,
-				&loose_direntry->u.subdir,
+				packed_direntry, loose_direntry,
 				base, fn, trim, flags, cb_data);
 	} else if (packed_direntry) {
 		sort_ref_dir(&packed_direntry->u.subdir);
-- 
1.7.10
