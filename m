From: mhagger@alum.mit.edu
Subject: [PATCH v2 37/51] is_refname_available(): take (ref_entry *) instead of (ref_dir *)
Date: Mon, 12 Dec 2011 06:38:44 +0100
Message-ID: <1323668338-1764-38-git-send-email-mhagger@alum.mit.edu>
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
	id 1RZydT-0000k3-2L
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007Ab1LLFkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:40:46 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34895 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab1LLFkm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:42 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8ao015577;
	Mon, 12 Dec 2011 06:40:34 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186851>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 918b787..6b7d374 100644
--- a/refs.c
+++ b/refs.c
@@ -544,14 +544,16 @@ static int name_conflict_fn(const char *existingrefname, const unsigned char *sh
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
@@ -1525,7 +1527,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 */
 	if (missing &&
 	     !is_refname_available(refname, NULL,
-				   &get_packed_refs(get_ref_cache(NULL))->u.subdir)) {
+				   get_packed_refs(get_ref_cache(NULL)))) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -1686,10 +1688,10 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
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
1.7.8
