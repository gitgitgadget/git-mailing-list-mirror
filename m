From: mhagger@alum.mit.edu
Subject: [PATCH 14/30] find_ref(): take (ref_entry *) instead of (ref_dir *)
Date: Wed, 25 Apr 2012 00:45:20 +0200
Message-ID: <1335307536-26914-15-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:57:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMofw-0000Gj-6b
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758495Ab2DXW5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:57:19 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60968 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758464Ab2DXW5A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:57:00 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 873D8248159;
	Wed, 25 Apr 2012 00:46:11 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196270>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 044dee9..c40cbd6 100644
--- a/refs.c
+++ b/refs.c
@@ -327,14 +327,17 @@ static struct ref_dir *find_containing_dir(struct ref_dir *dir,
 }
 
 /*
- * Find the value entry with the given name in dir, sorting ref_dirs
- * and recursing into subdirectories as necessary.  If the name is not
- * found or it corresponds to a directory entry, return NULL.
+ * Find the value entry with the given name in direntry, sorting
+ * reference directories and recursing into subdirectories as
+ * necessary.  If the name is not found or it corresponds to a
+ * directory entry, return NULL.
  */
-static struct ref_entry *find_ref(struct ref_dir *dir, const char *refname)
+static struct ref_entry *find_ref(struct ref_entry *direntry, const char *refname)
 {
 	struct ref_entry *entry;
-	dir = find_containing_dir(dir, refname, 0);
+	struct ref_dir *dir;
+	assert(direntry->flag & REF_DIR);
+	dir = find_containing_dir(&direntry->u.subdir, refname, 0);
 	if (!dir)
 		return NULL;
 	entry = search_ref_dir(dir, refname);
@@ -858,7 +861,7 @@ static int resolve_gitlink_packed_ref(struct ref_cache *refs,
 	struct ref_entry *ref;
 	struct ref_entry *direntry = get_packed_refs(refs);
 
-	ref = find_ref(&direntry->u.subdir, refname);
+	ref = find_ref(direntry, refname);
 	if (ref == NULL)
 		return -1;
 
@@ -930,7 +933,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
 static int get_packed_ref(const char *refname, unsigned char *sha1)
 {
 	struct ref_entry *packed = get_packed_refs(get_ref_cache(NULL));
-	struct ref_entry *entry = find_ref(&packed->u.subdir, refname);
+	struct ref_entry *entry = find_ref(packed, refname);
 	if (entry) {
 		hashcpy(sha1, entry->u.value.sha1);
 		return 0;
@@ -1107,7 +1110,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 
 	if ((flag & REF_ISPACKED)) {
 		struct ref_entry *direntry = get_packed_refs(get_ref_cache(NULL));
-		struct ref_entry *r = find_ref(&direntry->u.subdir, refname);
+		struct ref_entry *r = find_ref(direntry, refname);
 
 		if (r != NULL && r->flag & REF_KNOWS_PEELED) {
 			hashcpy(sha1, r->u.value.peeled);
@@ -1631,7 +1634,7 @@ static int repack_without_ref(const char *refname)
 {
 	struct repack_without_ref_sb data;
 	struct ref_entry *packed = get_packed_refs(get_ref_cache(NULL));
-	if (find_ref(&packed->u.subdir, refname) == NULL)
+	if (find_ref(packed, refname) == NULL)
 		return 0;
 	data.refname = refname;
 	data.fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
-- 
1.7.10
