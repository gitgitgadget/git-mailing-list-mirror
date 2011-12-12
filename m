From: mhagger@alum.mit.edu
Subject: [PATCH v2 05/51] is_refname_available(): remove the "quiet" argument
Date: Mon, 12 Dec 2011 06:38:12 +0100
Message-ID: <1323668338-1764-6-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:40:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZycY-0000Sq-HR
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254Ab1LLFju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:39:50 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34566 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab1LLFjj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:39:39 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aI015577;
	Mon, 12 Dec 2011 06:39:22 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186830>

From: Michael Haggerty <mhagger@alum.mit.edu>

quiet was always set to 0, so get rid of it.  Add a function docstring
for good measure.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 7be91d1..d7d422f 100644
--- a/refs.c
+++ b/refs.c
@@ -1057,8 +1057,15 @@ static int remove_empty_directories(const char *file)
 	return result;
 }
 
+/*
+ * Return true iff a reference named refname could be created without
+ * conflicting with the name of an existing reference.  If oldrefname
+ * is non-NULL, ignore potential conflicts with oldrefname (e.g.,
+ * because oldrefname is scheduled for deletion in the same
+ * operation).
+ */
 static int is_refname_available(const char *refname, const char *oldrefname,
-				struct ref_array *array, int quiet)
+				struct ref_array *array)
 {
 	int i, namlen = strlen(refname); /* e.g. 'foo/bar' */
 	for (i = 0; i < array->nr; i++ ) {
@@ -1070,9 +1077,8 @@ static int is_refname_available(const char *refname, const char *oldrefname,
 			const char *lead = (namlen < len) ? entry->name : refname;
 			if (!strncmp(refname, entry->name, cmplen) &&
 			    lead[cmplen] == '/') {
-				if (!quiet)
-					error("'%s' exists; cannot create '%s'",
-					      entry->name, refname);
+				error("'%s' exists; cannot create '%s'",
+				      entry->name, refname);
 				return 0;
 			}
 		}
@@ -1213,7 +1219,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(refname, NULL, get_packed_refs(NULL), 0)) {
+	     !is_refname_available(refname, NULL, get_packed_refs(NULL))) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -1367,10 +1373,10 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (!symref)
 		return error("refname %s not found", oldrefname);
 
-	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(NULL), 0))
+	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(NULL)))
 		return 1;
 
-	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(NULL), 0))
+	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(NULL)))
 		return 1;
 
 	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
-- 
1.7.8
