From: mhagger@alum.mit.edu
Subject: [PATCH v2 06/14] is_refname_available(): remove the "quiet" argument
Date: Mon, 17 Oct 2011 09:39:15 +0200
Message-ID: <1318837163-27112-7-git-send-email-mhagger@alum.mit.edu>
References: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 09:39:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFhnW-0007hN-7S
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 09:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924Ab1JQHjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 03:39:41 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:33548 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab1JQHji (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 03:39:38 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RFhhY-0000eM-46; Mon, 17 Oct 2011 09:33:36 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183773>

From: Michael Haggerty <mhagger@alum.mit.edu>

quiet was always set to 0, so get rid of it.  Add a function docstring
for good measure.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 30e505a..597800a 100644
--- a/refs.c
+++ b/refs.c
@@ -1049,8 +1049,15 @@ static int remove_empty_directories(const char *file)
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
@@ -1062,9 +1069,8 @@ static int is_refname_available(const char *refname, const char *oldrefname,
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
@@ -1117,7 +1123,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(refname, NULL, get_packed_refs(NULL), 0)) {
+	     !is_refname_available(refname, NULL, get_packed_refs(NULL))) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -1272,10 +1278,10 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (!symref)
 		return error("refname %s not found", oldrefname);
 
-	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(NULL), 0))
+	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(NULL)))
 		return 1;
 
-	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(NULL), 0))
+	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(NULL)))
 		return 1;
 
 	lock = lock_ref_sha1_basic(renamed_ref, NULL, 0, NULL);
-- 
1.7.7.rc2
