From: mhagger@alum.mit.edu
Subject: [PATCH 21/28] do_for_each_ref_in_dir*(): take (ref_entry *) instead of (ref_dir *)
Date: Fri, 28 Oct 2011 14:28:34 +0200
Message-ID: <1319804921-17545-22-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:32:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlba-00056m-Fg
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755653Ab1J1McH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:32:07 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:55954 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755649Ab1J1McF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:32:05 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-Pt; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184399>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   38 ++++++++++++++++++++++----------------
 1 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 3567d56..c3ee93d 100644
--- a/refs.c
+++ b/refs.c
@@ -471,17 +471,20 @@ static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 	return fn(entry->name + trim, entry->u.value.sha1, entry->flag, cb_data);
 }
 
-static int do_for_each_ref_in_dir(struct ref_dir *dir, int offset,
+static int do_for_each_ref_in_dir(struct ref_entry *direntry, int offset,
 				  const char *base,
 				  each_ref_fn fn, int trim, int flags, void *cb_data)
 {
 	int i;
+	struct ref_dir *dir;
+	assert(direntry->flag & REF_DIR);
+	dir = &direntry->u.subdir;
 	sort_ref_dir(dir);
 	for (i = offset; i < dir->nr; i++) {
 		struct ref_entry *entry = dir->entries[i];
 		int retval;
 		if (entry->flag & REF_DIR) {
-			retval = do_for_each_ref_in_dir(&entry->u.subdir, 0,
+			retval = do_for_each_ref_in_dir(entry, 0,
 							base, fn, trim, flags, cb_data);
 		} else {
 			retval = do_one_ref(base, fn, trim, flags, cb_data, entry);
@@ -492,25 +495,30 @@ static int do_for_each_ref_in_dir(struct ref_dir *dir, int offset,
 	return 0;
 }
 
-static int do_for_each_ref_in_dirs(struct ref_dir *dir1,
-				   struct ref_dir *dir2,
+static int do_for_each_ref_in_dirs(struct ref_entry *direntry1,
+				   struct ref_entry *direntry2,
 				   const char *base, each_ref_fn fn, int trim,
 				   int flags, void *cb_data)
 {
 	int retval;
 	int i1 = 0, i2 = 0;
+	struct ref_dir *dir1, *dir2;
 
+	assert(direntry1->flag & REF_DIR);
+	assert(direntry2->flag & REF_DIR);
+	dir1 = &direntry1->u.subdir;
+	dir2 = &direntry2->u.subdir;
 	sort_ref_dir(dir1);
 	sort_ref_dir(dir2);
 	while (1) {
 		struct ref_entry *e1, *e2, *entry;
 		int cmp;
 		if (i1 == dir1->nr) {
-			return do_for_each_ref_in_dir(dir2, i2,
+			return do_for_each_ref_in_dir(direntry2, i2,
 						      base, fn, trim, flags, cb_data);
 		}
 		if (i2 == dir2->nr) {
-			return do_for_each_ref_in_dir(dir1, i1,
+			return do_for_each_ref_in_dir(direntry1, i1,
 						      base, fn, trim, flags, cb_data);
 		}
 		e1 = dir1->entries[i1];
@@ -520,7 +528,7 @@ static int do_for_each_ref_in_dirs(struct ref_dir *dir1,
 			if ((e1->flag & REF_DIR) && (e2->flag & REF_DIR)) {
 				/* Both are directories; descend them in parallel. */
 				retval = do_for_each_ref_in_dirs(
-						&e1->u.subdir, &e2->u.subdir,
+						e1, e2,
 						base, fn, trim, flags, cb_data);
 				i1++;
 				i2++;
@@ -543,7 +551,7 @@ static int do_for_each_ref_in_dirs(struct ref_dir *dir1,
 			}
 			if (entry->flag & REF_DIR) {
 				retval = do_for_each_ref_in_dir(
-						&entry->u.subdir, 0,
+						entry, 0,
 						base, fn, trim, flags, cb_data);
 			} else {
 				retval = do_one_ref(base, fn, trim, flags, cb_data, entry);
@@ -605,7 +613,7 @@ static int is_refname_available(const char *refname, const char *oldrefname,
 
 	assert(direntry->flag & REF_DIR);
 
-	if (do_for_each_ref_in_dir(&direntry->u.subdir, 0, "", name_conflict_fn,
+	if (do_for_each_ref_in_dir(direntry, 0, "", name_conflict_fn,
 				   0, DO_FOR_EACH_INCLUDE_BROKEN,
 				   &data)) {
 		error("'%s' exists; cannot create '%s'",
@@ -1196,21 +1204,20 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 
 	if (extra_direntry)
 		retval = do_for_each_ref_in_dir(
-				&extra_direntry->u.subdir, 0,
+				extra_direntry, 0,
 				base, fn, trim, flags, cb_data);
 	if (!retval) {
 		if (packed_direntry && loose_direntry)
 			retval = do_for_each_ref_in_dirs(
-					&packed_direntry->u.subdir,
-					&loose_direntry->u.subdir,
+					packed_direntry, loose_direntry,
 					base, fn, trim, flags, cb_data);
 		else if (packed_direntry)
 			retval = do_for_each_ref_in_dir(
-					&packed_direntry->u.subdir, 0,
+					packed_direntry, 0,
 					base, fn, trim, flags, cb_data);
 		else if (loose_direntry)
 			retval = do_for_each_ref_in_dir(
-					&loose_direntry->u.subdir, 0,
+					loose_direntry, 0,
 					base, fn, trim, flags, cb_data);
 	}
 
@@ -1668,8 +1675,7 @@ static int repack_without_ref(const char *refname)
 		unable_to_lock_error(git_path("packed-refs"), errno);
 		return error("cannot delete '%s' from packed refs", refname);
 	}
-	do_for_each_ref_in_dir(&packed->u.subdir, 0,
-			       "", repack_without_ref_fn, 0, 0, &data);
+	do_for_each_ref_in_dir(packed, 0, "", repack_without_ref_fn, 0, 0, &data);
 	return commit_lock_file(&packlock);
 }
 
-- 
1.7.7
