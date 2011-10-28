From: mhagger@alum.mit.edu
Subject: [PATCH 14/28] is_refname_available(): take (ref_entry *) instead of (ref_dir *)
Date: Fri, 28 Oct 2011 14:28:27 +0200
Message-ID: <1319804921-17545-15-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:32:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlbO-0004ys-BD
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618Ab1J1Mbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:31:55 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:55913 "EHLO
	homer.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755609Ab1J1Mby (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:31:54 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-LV; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184396>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index d6d5d0e..6bda033 100644
--- a/refs.c
+++ b/refs.c
@@ -586,14 +586,16 @@ static int name_conflict_fn(const char *existingrefname, const unsigned char *sh
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
 
-	if (do_for_each_ref_in_dir(dir, 0, "", name_conflict_fn,
+	assert(direntry->flag & REF_DIR);
+
+	if (do_for_each_ref_in_dir(&direntry->u.subdir, 0, "", name_conflict_fn,
 				   0, DO_FOR_EACH_INCLUDE_BROKEN,
 				   &data)) {
 		error("'%s' exists; cannot create '%s'",
@@ -1567,7 +1569,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 */
 	if (missing &&
 	     !is_refname_available(refname, NULL,
-				   &get_packed_refs(get_ref_cache(NULL))->u.subdir)) {
+				   get_packed_refs(get_ref_cache(NULL)))) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -1728,10 +1730,10 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
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
1.7.7
