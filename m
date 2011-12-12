From: mhagger@alum.mit.edu
Subject: [PATCH v2 35/51] get_packed_refs(): return (ref_entry *) instead of (ref_dir *)
Date: Mon, 12 Dec 2011 06:38:42 +0100
Message-ID: <1323668338-1764-36-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:41:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZydR-0000k3-UH
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966Ab1LLFkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:40:41 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34876 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab1LLFkj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:39 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8am015577;
	Mon, 12 Dec 2011 06:40:30 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186855>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index b4019e6..6a65a21 100644
--- a/refs.c
+++ b/refs.c
@@ -715,7 +715,7 @@ void clear_extra_refs(void)
 	}
 }
 
-static struct ref_dir *get_packed_refs(struct ref_cache *refs)
+static struct ref_entry *get_packed_refs(struct ref_cache *refs)
 {
 	if (!refs->packed) {
 		const char *packed_refs_file;
@@ -732,7 +732,7 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 			fclose(f);
 		}
 	}
-	return &refs->packed->u.subdir;
+	return refs->packed;
 }
 
 /*
@@ -831,9 +831,9 @@ static int resolve_gitlink_packed_ref(struct ref_cache *refs,
 				      const char *refname, unsigned char *sha1)
 {
 	struct ref_entry *ref;
-	struct ref_dir *dir = get_packed_refs(refs);
+	struct ref_entry *direntry = get_packed_refs(refs);
 
-	ref = find_ref(dir, refname);
+	ref = find_ref(&direntry->u.subdir, refname);
 	if (ref == NULL)
 		return -1;
 
@@ -904,8 +904,8 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
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
@@ -1075,8 +1075,8 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		return -1;
 
 	if ((flag & REF_ISPACKED)) {
-		struct ref_dir *dir = get_packed_refs(get_ref_cache(NULL));
-		struct ref_entry *r = find_ref(dir, refname);
+		struct ref_entry *direntry = get_packed_refs(get_ref_cache(NULL));
+		struct ref_entry *r = find_ref(&direntry->u.subdir, refname);
 
 		if (r != NULL && r->flag & REF_KNOWS_PEELED) {
 			hashcpy(sha1, r->u.value.peeled);
@@ -1136,7 +1136,8 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 	int retval = 0;
 	struct ref_cache *refs = get_ref_cache(submodule);
 	struct ref_dir *extra_dir = extra_refs ? &extra_refs->u.subdir : NULL;
-	struct ref_dir *packed_dir = get_packed_refs(refs);
+	struct ref_entry *packed_direntry = get_packed_refs(refs);
+	struct ref_dir *packed_dir = &packed_direntry->u.subdir;
 	struct ref_dir *loose_dir = get_loose_refs(refs);
 
 	if (base && *base) {
@@ -1522,7 +1523,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(refname, NULL, get_packed_refs(get_ref_cache(NULL)))) {
+	     !is_refname_available(refname, NULL,
+				   &get_packed_refs(get_ref_cache(NULL))->u.subdir)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -1602,10 +1604,8 @@ static struct lock_file packlock;
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
@@ -1613,7 +1613,8 @@ static int repack_without_ref(const char *refname)
 		unable_to_lock_error(git_path("packed-refs"), errno);
 		return error("cannot delete '%s' from packed refs", refname);
 	}
-	do_for_each_ref_in_dir(packed, 0, "", repack_without_ref_fn, 0, 0, &data);
+	do_for_each_ref_in_dir(&packed->u.subdir, 0,
+			       "", repack_without_ref_fn, 0, 0, &data);
 	return commit_lock_file(&packlock);
 }
 
@@ -1684,7 +1685,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (!symref)
 		return error("refname %s not found", oldrefname);
 
-	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(refs)))
+	if (!is_refname_available(newrefname, oldrefname, &get_packed_refs(refs)->u.subdir))
 		return 1;
 
 	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(refs)))
-- 
1.7.8
