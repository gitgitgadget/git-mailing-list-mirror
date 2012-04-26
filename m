From: mhagger@alum.mit.edu
Subject: [PATCH v2 14/18] get_ref_dir(): add function for getting a ref_dir from a ref_entry
Date: Fri, 27 Apr 2012 00:27:03 +0200
Message-ID: <1335479227-7877-15-git-send-email-mhagger@alum.mit.edu>
References: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 00:27:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNXAJ-0008Gp-G1
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 00:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759524Ab2DZW1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 18:27:40 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:37142 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759512Ab2DZW1g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 18:27:36 -0400
Received: from michael.berlin.jpk.com (michael2.berlin.jpk.com [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 629B7248140;
	Fri, 27 Apr 2012 00:27:35 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196434>

From: Michael Haggerty <mhagger@alum.mit.edu>

Convert all accesses of a ref_dir within a ref_entry to use this
function.  This function will later be responsible for reading loose
references from disk on demand.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index 1d18ae6..2e71bfa 100644
--- a/refs.c
+++ b/refs.c
@@ -171,6 +171,12 @@ struct ref_entry {
 	char name[FLEX_ARRAY];
 };
 
+static struct ref_dir *get_ref_dir(struct ref_entry *entry)
+{
+	assert(entry->flag & REF_DIR);
+	return &entry->u.subdir;
+}
+
 static struct ref_entry *create_ref_entry(const char *refname,
 					  const unsigned char *sha1, int flag,
 					  int check_name)
@@ -195,7 +201,7 @@ static void clear_ref_dir(struct ref_dir *dir);
 static void free_ref_entry(struct ref_entry *entry)
 {
 	if (entry->flag & REF_DIR)
-		clear_ref_dir(&entry->u.subdir);
+		clear_ref_dir(get_ref_dir(entry));
 	free(entry);
 }
 
@@ -320,7 +326,7 @@ static struct ref_dir *find_containing_dir(struct ref_dir *dir,
 		entry = search_for_subdir(dir, dirname.buf, mkdir);
 		if (!entry)
 			break;
-		dir = &entry->u.subdir;
+		dir = get_ref_dir(entry);
 	}
 
 	strbuf_release(&dirname);
@@ -449,8 +455,9 @@ static int do_for_each_ref_in_dir(struct ref_dir *dir, int offset,
 		struct ref_entry *entry = dir->entries[i];
 		int retval;
 		if (entry->flag & REF_DIR) {
-			sort_ref_dir(&entry->u.subdir);
-			retval = do_for_each_ref_in_dir(&entry->u.subdir, 0,
+			struct ref_dir *subdir = get_ref_dir(entry);
+			sort_ref_dir(subdir);
+			retval = do_for_each_ref_in_dir(subdir, 0,
 							base, fn, trim, flags, cb_data);
 		} else {
 			retval = do_one_ref(base, fn, trim, flags, cb_data, entry);
@@ -495,10 +502,12 @@ static int do_for_each_ref_in_dirs(struct ref_dir *dir1,
 		if (cmp == 0) {
 			if ((e1->flag & REF_DIR) && (e2->flag & REF_DIR)) {
 				/* Both are directories; descend them in parallel. */
-				sort_ref_dir(&e1->u.subdir);
-				sort_ref_dir(&e2->u.subdir);
+				struct ref_dir *subdir1 = get_ref_dir(e1);
+				struct ref_dir *subdir2 = get_ref_dir(e2);
+				sort_ref_dir(subdir1);
+				sort_ref_dir(subdir2);
 				retval = do_for_each_ref_in_dirs(
-						&e1->u.subdir, &e2->u.subdir,
+						subdir1, subdir2,
 						base, fn, trim, flags, cb_data);
 				i1++;
 				i2++;
@@ -521,9 +530,10 @@ static int do_for_each_ref_in_dirs(struct ref_dir *dir1,
 				i2++;
 			}
 			if (e->flag & REF_DIR) {
-				sort_ref_dir(&e->u.subdir);
+				struct ref_dir *subdir = get_ref_dir(e);
+				sort_ref_dir(subdir);
 				retval = do_for_each_ref_in_dir(
-						&e->u.subdir, 0,
+						subdir, 0,
 						base, fn, trim, flags, cb_data);
 			} else {
 				retval = do_one_ref(base, fn, trim, flags, cb_data, e);
@@ -751,11 +761,11 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 			packed_refs_file = git_path("packed-refs");
 		f = fopen(packed_refs_file, "r");
 		if (f) {
-			read_packed_refs(f, &refs->packed->u.subdir);
+			read_packed_refs(f, get_ref_dir(refs->packed));
 			fclose(f);
 		}
 	}
-	return &refs->packed->u.subdir;
+	return get_ref_dir(refs->packed);
 }
 
 void add_packed_ref(const char *refname, const unsigned char *sha1)
@@ -809,7 +819,7 @@ static void read_loose_refs(struct ref_cache *refs, const char *dirname,
 		} else if (S_ISDIR(st.st_mode)) {
 			strbuf_addch(&refname, '/');
 			read_loose_refs(refs, refname.buf,
-					&search_for_subdir(dir, refname.buf, 1)->u.subdir);
+					get_ref_dir(search_for_subdir(dir, refname.buf, 1)));
 		} else {
 			if (*refs->name) {
 				hashclr(sha1);
@@ -836,10 +846,10 @@ static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 	if (!refs->loose) {
 		refs->loose = create_dir_entry("");
 		read_loose_refs(refs, "refs/",
-				&search_for_subdir(&refs->loose->u.subdir,
-						   "refs/", 1)->u.subdir);
+				get_ref_dir(search_for_subdir(get_ref_dir(refs->loose),
+							      "refs/", 1)));
 	}
-	return &refs->loose->u.subdir;
+	return get_ref_dir(refs->loose);
 }
 
 /* We allow "recursive" symbolic refs. Only within reason, though */
-- 
1.7.10
