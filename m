From: mhagger@alum.mit.edu
Subject: [PATCH 11/30] get_packed_refs(): return (ref_entry *) instead of (ref_dir *)
Date: Wed, 25 Apr 2012 00:45:17 +0200
Message-ID: <1335307536-26914-12-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:58:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMoh1-00010Q-Qn
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549Ab2DXW6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:58:34 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60963 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758419Ab2DXW44 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:56:56 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id D738C248155;
	Wed, 25 Apr 2012 00:46:04 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196287>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 4c92dc9..24930ab 100644
--- a/refs.c
+++ b/refs.c
@@ -737,7 +737,7 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 	}
 }
 
-static struct ref_dir *get_packed_refs(struct ref_cache *refs)
+static struct ref_entry *get_packed_refs(struct ref_cache *refs)
 {
 	if (!refs->packed) {
 		const char *packed_refs_file;
@@ -754,13 +754,13 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 			fclose(f);
 		}
 	}
-	return &refs->packed->u.subdir;
+	return refs->packed;
 }
 
 void add_packed_ref(const char *refname, const unsigned char *sha1)
 {
-	add_ref(get_packed_refs(get_ref_cache(NULL)),
-			create_ref_entry(refname, sha1, REF_ISPACKED, 1));
+	add_ref(&get_packed_refs(get_ref_cache(NULL))->u.subdir,
+		create_ref_entry(refname, sha1, REF_ISPACKED, 1));
 }
 
 /*
@@ -854,9 +854,9 @@ static int resolve_gitlink_packed_ref(struct ref_cache *refs,
 				      const char *refname, unsigned char *sha1)
 {
 	struct ref_entry *ref;
-	struct ref_dir *dir = get_packed_refs(refs);
+	struct ref_entry *direntry = get_packed_refs(refs);
 
-	ref = find_ref(dir, refname);
+	ref = find_ref(&direntry->u.subdir, refname);
 	if (ref == NULL)
 		return -1;
 
@@ -927,8 +927,8 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
  */
 static int get_packed_ref(const char *refname, unsigned char *sha1)
 {
-	struct ref_dir *packed = get_packed_refs(get_ref_cache(NULL));
-	struct ref_entry *entry = find_ref(packed, refname);
+	struct ref_entry *packed = get_packed_refs(get_ref_cache(NULL));
+	struct ref_entry *entry = find_ref(&packed->u.subdir, refname);
 	if (entry) {
 		hashcpy(sha1, entry->u.value.sha1);
 		return 0;
@@ -1104,8 +1104,8 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		return -1;
 
 	if ((flag & REF_ISPACKED)) {
-		struct ref_dir *dir = get_packed_refs(get_ref_cache(NULL));
-		struct ref_entry *r = find_ref(dir, refname);
+		struct ref_entry *direntry = get_packed_refs(get_ref_cache(NULL));
+		struct ref_entry *r = find_ref(&direntry->u.subdir, refname);
 
 		if (r != NULL && r->flag & REF_KNOWS_PEELED) {
 			hashcpy(sha1, r->u.value.peeled);
@@ -1163,7 +1163,8 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 			   int trim, int flags, void *cb_data)
 {
 	struct ref_cache *refs = get_ref_cache(submodule);
-	struct ref_dir *packed_dir = get_packed_refs(refs);
+	struct ref_entry *packed_direntry = get_packed_refs(refs);
+	struct ref_dir *packed_dir = &packed_direntry->u.subdir;
 	struct ref_dir *loose_dir = get_loose_refs(refs);
 	int retval = 0;
 
@@ -1545,7 +1546,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(refname, NULL, get_packed_refs(get_ref_cache(NULL)))) {
+	     !is_refname_available(refname, NULL,
+				   &get_packed_refs(get_ref_cache(NULL))->u.subdir)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -1625,8 +1627,8 @@ static struct lock_file packlock;
 static int repack_without_ref(const char *refname)
 {
 	struct repack_without_ref_sb data;
-	struct ref_dir *packed = get_packed_refs(get_ref_cache(NULL));
-	if (find_ref(packed, refname) == NULL)
+	struct ref_entry *packed = get_packed_refs(get_ref_cache(NULL));
+	if (find_ref(&packed->u.subdir, refname) == NULL)
 		return 0;
 	data.refname = refname;
 	data.fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
@@ -1634,7 +1636,8 @@ static int repack_without_ref(const char *refname)
 		unable_to_lock_error(git_path("packed-refs"), errno);
 		return error("cannot delete '%s' from packed refs", refname);
 	}
-	do_for_each_ref_in_dir(packed, 0, "", repack_without_ref_fn, 0, 0, &data);
+	do_for_each_ref_in_dir(&packed->u.subdir, 0,
+			       "", repack_without_ref_fn, 0, 0, &data);
 	return commit_lock_file(&packlock);
 }
 
@@ -1705,7 +1708,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (!symref)
 		return error("refname %s not found", oldrefname);
 
-	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(refs)))
+	if (!is_refname_available(newrefname, oldrefname, &get_packed_refs(refs)->u.subdir))
 		return 1;
 
 	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(refs)))
-- 
1.7.10
