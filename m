From: mhagger@alum.mit.edu
Subject: [PATCH 12/28] get_packed_refs(): return (ref_entry *) instead of (ref_dir *)
Date: Fri, 28 Oct 2011 14:28:25 +0200
Message-ID: <1319804921-17545-13-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:31:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlaq-0004j8-Tt
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709Ab1J1MbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:31:20 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:55828 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932685Ab1J1MbU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:31:20 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-KS; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184389>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 673fa04..425fdaa 100644
--- a/refs.c
+++ b/refs.c
@@ -760,7 +760,7 @@ void clear_extra_refs(void)
 	}
 }
 
-static struct ref_dir *get_packed_refs(struct ref_cache *refs)
+static struct ref_entry *get_packed_refs(struct ref_cache *refs)
 {
 	if (!refs->packed) {
 		const char *packed_refs_file;
@@ -777,7 +777,7 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 			fclose(f);
 		}
 	}
-	return &refs->packed->u.subdir;
+	return refs->packed;
 }
 
 /*
@@ -877,9 +877,9 @@ static int resolve_gitlink_packed_ref(struct ref_cache *refs,
 				      const char *refname, unsigned char *sha1)
 {
 	struct ref_entry *ref;
-	struct ref_dir *dir = get_packed_refs(refs);
+	struct ref_entry *direntry = get_packed_refs(refs);
 
-	ref = find_ref(dir, refname);
+	ref = find_ref(&direntry->u.subdir, refname);
 	if (ref == NULL)
 		return -1;
 
@@ -950,8 +950,8 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
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
@@ -1110,8 +1110,8 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		return -1;
 
 	if ((flag & REF_ISPACKED)) {
-		struct ref_dir *dir = get_packed_refs(get_ref_cache(NULL));
-		struct ref_entry *r = find_ref(dir, refname);
+		struct ref_entry *direntry = get_packed_refs(get_ref_cache(NULL));
+		struct ref_entry *r = find_ref(&direntry->u.subdir, refname);
 
 		if (r != NULL && r->flag & REF_KNOWS_PEELED) {
 			hashcpy(sha1, r->u.value.peeled);
@@ -1171,7 +1171,8 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 	int retval = 0;
 	struct ref_cache *refs = get_ref_cache(submodule);
 	struct ref_dir *extra_dir = extra_refs ? &extra_refs->u.subdir : NULL;
-	struct ref_dir *packed_dir = get_packed_refs(refs);
+	struct ref_entry *packed_direntry = get_packed_refs(refs);
+	struct ref_dir *packed_dir = &packed_direntry->u.subdir;
 	struct ref_dir *loose_dir = get_loose_refs(refs);
 
 	if (base && *base) {
@@ -1564,7 +1565,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(refname, NULL, get_packed_refs(get_ref_cache(NULL)))) {
+	     !is_refname_available(refname, NULL,
+				   &get_packed_refs(get_ref_cache(NULL))->u.subdir)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -1644,10 +1646,8 @@ static struct lock_file packlock;
 static int repack_without_ref(const char *refname)
 {
 	struct repack_without_ref_sb data;
-	struct ref_dir *packed;
-
-	packed = get_packed_refs(get_ref_cache(NULL));
-	if (find_ref(packed, refname) == NULL)
+	struct ref_entry *packed = get_packed_refs(get_ref_cache(NULL));
+	if (find_ref(&packed->u.subdir, refname) == NULL)
 		return 0;
 	data.refname = refname;
 	data.fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
@@ -1655,7 +1655,8 @@ static int repack_without_ref(const char *refname)
 		unable_to_lock_error(git_path("packed-refs"), errno);
 		return error("cannot delete '%s' from packed refs", refname);
 	}
-	do_for_each_ref_in_dir(packed, 0, "", repack_without_ref_fn, 0, 0, &data);
+	do_for_each_ref_in_dir(&packed->u.subdir, 0,
+			       "", repack_without_ref_fn, 0, 0, &data);
 	return commit_lock_file(&packlock);
 }
 
@@ -1726,7 +1727,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (!symref)
 		return error("refname %s not found", oldrefname);
 
-	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(refs)))
+	if (!is_refname_available(newrefname, oldrefname, &get_packed_refs(refs)->u.subdir))
 		return 1;
 
 	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(refs)))
-- 
1.7.7
