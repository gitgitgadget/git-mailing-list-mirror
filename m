From: mhagger@alum.mit.edu
Subject: [PATCH 26/28] is_refname_available(): query only possibly-conflicting references
Date: Fri, 28 Oct 2011 14:28:39 +0200
Message-ID: <1319804921-17545-27-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:32:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlbp-0005Dk-BE
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484Ab1J1McW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:32:22 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:55991 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932387Ab1J1McU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:32:20 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-Tu; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184402>

From: Michael Haggerty <mhagger@alum.mit.edu>

Instead of iterating through all of the references, inquire more
pointedly about the references that could conflict with the new name.
This requires checking for a few individual references, plus iterating
through a small subtree of the rest of the references (and usually the
subtree iteration ends without having to recurse).  A big benefit is
that populating the whole loose reference cache (which can be very
expensive) can usually be avoided.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   40 +++++++++++++++++++++++++++++++++-------
 1 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 88ef9dd..6a7f9c3 100644
--- a/refs.c
+++ b/refs.c
@@ -658,7 +658,7 @@ static int name_conflict_fn(const char *existingrefname, const unsigned char *sh
 			    int flags, void *cb_data)
 {
 	struct name_conflict_cb *data = (struct name_conflict_cb *)cb_data;
-	if (data->oldrefname && !strcmp(data->oldrefname, existingrefname))
+	if (!strcmp(data->oldrefname, existingrefname))
 		return 0;
 	if (names_conflict(data->refname, existingrefname)) {
 		data->conflicting_refname = existingrefname;
@@ -669,22 +669,48 @@ static int name_conflict_fn(const char *existingrefname, const unsigned char *sh
 
 /*
  * Return true iff a reference named refname could be created without
- * conflicting with the name of an existing reference.  If oldrefname
- * is non-NULL, ignore potential conflicts with oldrefname (e.g.,
- * because oldrefname is scheduled for deletion in the same
+ * conflicting with the name of an existing reference in direntry.  If
+ * oldrefname is non-NULL, ignore potential conflicts with oldrefname
+ * (e.g., because oldrefname is scheduled for deletion in the same
  * operation).
  */
 static int is_refname_available(const char *refname, const char *oldrefname,
 				struct ref_entry *direntry)
 {
+	int prefixlen = strlen(refname);
+	char *prefix;
+	char *slash;
 	struct name_conflict_cb data;
+
+	assert(direntry->flag & REF_DIR);
+
+	if (!oldrefname)
+		oldrefname = ""; /* invalid; cannot match any existing refname */
+
+	/* Check whether a prefix of refname is an existing reference: */
+	prefix = xmalloc(prefixlen + 2);
+	memcpy(prefix, refname, prefixlen + 1);
+	for (slash = strchr(prefix, '/'); slash; slash = strchr(slash + 1, '/')) {
+		*slash = '\0';
+		if (strcmp(oldrefname, prefix)) {
+			struct ref_entry *entry = find_ref(direntry, prefix);
+			if (entry) {
+				error("'%s' exists; cannot create '%s'", prefix, refname);
+				free(prefix);
+				return 0;
+			}
+		}
+		*slash = '/';
+	}
+
+	/* Check whether refname is a proper prefix of an existing reference: */
+	prefix[prefixlen++] = '/';
+	prefix[prefixlen] = '\0';
 	data.refname = refname;
 	data.oldrefname = oldrefname;
 	data.conflicting_refname = NULL;
 
-	assert(direntry->flag & REF_DIR);
-
-	if (do_for_each_ref_in_dir(direntry, 0, "", name_conflict_fn,
+	if (do_for_each_ref_in_dir(direntry, 0, prefix, name_conflict_fn,
 				   0, DO_FOR_EACH_INCLUDE_BROKEN,
 				   &data)) {
 		error("'%s' exists; cannot create '%s'",
-- 
1.7.7
