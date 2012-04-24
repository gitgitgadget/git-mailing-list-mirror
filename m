From: mhagger@alum.mit.edu
Subject: [PATCH 13/30] is_refname_available(): take (ref_entry *) instead of (ref_dir *)
Date: Wed, 25 Apr 2012 00:45:19 +0200
Message-ID: <1335307536-26914-14-git-send-email-mhagger@alum.mit.edu>
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
	id 1SMogE-0000SK-KK
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475Ab2DXW5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:57:33 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60975 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758461Ab2DXW47 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:56:59 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 69E5D248158;
	Wed, 25 Apr 2012 00:46:10 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196274>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 0259ad1..044dee9 100644
--- a/refs.c
+++ b/refs.c
@@ -576,21 +576,23 @@ static int name_conflict_fn(const char *existingrefname, const unsigned char *sh
 
 /*
  * Return true iff a reference named refname could be created without
- * conflicting with the name of an existing reference in array.  If
+ * conflicting with the name of an existing reference in direntry.  If
  * oldrefname is non-NULL, ignore potential conflicts with oldrefname
  * (e.g., because oldrefname is scheduled for deletion in the same
  * operation).
  */
 static int is_refname_available(const char *refname, const char *oldrefname,
-				struct ref_dir *dir)
+				struct ref_entry *direntry)
 {
 	struct name_conflict_cb data;
 	data.refname = refname;
 	data.oldrefname = oldrefname;
 	data.conflicting_refname = NULL;
 
-	sort_ref_dir(dir);
-	if (do_for_each_ref_in_dir(dir, 0, "", name_conflict_fn,
+	assert(direntry->flag & REF_DIR);
+	sort_ref_dir(&direntry->u.subdir);
+
+	if (do_for_each_ref_in_dir(&direntry->u.subdir, 0, "", name_conflict_fn,
 				   0, DO_FOR_EACH_INCLUDE_BROKEN,
 				   &data)) {
 		error("'%s' exists; cannot create '%s'",
@@ -1548,7 +1550,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 */
 	if (missing &&
 	     !is_refname_available(refname, NULL,
-				   &get_packed_refs(get_ref_cache(NULL))->u.subdir)) {
+				   get_packed_refs(get_ref_cache(NULL)))) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -1709,10 +1711,10 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (!symref)
 		return error("refname %s not found", oldrefname);
 
-	if (!is_refname_available(newrefname, oldrefname, &get_packed_refs(refs)->u.subdir))
+	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(refs)))
 		return 1;
 
-	if (!is_refname_available(newrefname, oldrefname, &get_loose_refs(refs)->u.subdir))
+	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(refs)))
 		return 1;
 
 	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
-- 
1.7.10
