From: mhagger@alum.mit.edu
Subject: [PATCH v2 49/51] is_refname_available(): query only possibly-conflicting references
Date: Mon, 12 Dec 2011 06:38:56 +0100
Message-ID: <1323668338-1764-50-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:41:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZydY-0000k3-Ow
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131Ab1LLFlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:41:13 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:35044 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147Ab1LLFlG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:41:06 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8b2015577;
	Mon, 12 Dec 2011 06:40:56 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186862>

From: Michael Haggerty <mhagger@alum.mit.edu>

Instead of iterating through all of the references, inquire more
pointedly about the references that could conflict with the new name.
This requires checking for a few individual references, plus iterating
through a small subtree of the rest of the references (and usually the
subtree iteration ends without having to recurse).  A big benefit is
that populating the whole loose reference cache (which can be very
expensive) can usually be avoided.

Also, simplify name_conflict_fn().  Since it now will only be called
for possibly-conflicting references, there is necessarily a conflict
if it is called for *any* reference besides "oldrefname".

Remove function names_conflict(), which is now unused.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   74 ++++++++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/refs.c b/refs.c
index 3cd8e04..312ca3b 100644
--- a/refs.c
+++ b/refs.c
@@ -591,23 +591,7 @@ static int do_for_each_ref_in_dirs(struct ref_entry *direntry1,
 	}
 }
 
-/*
- * Return true iff refname1 and refname2 conflict with each other.
- * Two reference names conflict if one of them exactly matches the
- * leading components of the other; e.g., "foo/bar" conflicts with
- * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
- * "foo/barbados".
- */
-static int names_conflict(const char *refname1, const char *refname2)
-{
-	for (; *refname1 && *refname1 == *refname2; refname1++, refname2++)
-		;
-	return (*refname1 == '\0' && *refname2 == '/')
-		|| (*refname1 == '/' && *refname2 == '\0');
-}
-
 struct name_conflict_cb {
-	const char *refname;
 	const char *oldrefname;
 	const char *conflicting_refname;
 };
@@ -616,31 +600,67 @@ static int name_conflict_fn(const char *existingrefname, const unsigned char *sh
 			    int flags, void *cb_data)
 {
 	struct name_conflict_cb *data = (struct name_conflict_cb *)cb_data;
-	if (data->oldrefname && !strcmp(data->oldrefname, existingrefname))
+	if (!strcmp(data->oldrefname, existingrefname))
 		return 0;
-	if (names_conflict(data->refname, existingrefname)) {
-		data->conflicting_refname = existingrefname;
-		return 1;
-	}
-	return 0;
+
+	/*
+	 * Since we are only iterating over the subtree that has the
+	 * new refname as prefix, *any* reference found is a conflict.
+	 */
+	data->conflicting_refname = existingrefname;
+	return 1;
 }
 
 /*
  * Return true iff a reference named refname could be created without
- * conflicting with the name of an existing reference.  If oldrefname
- * is non-NULL, ignore potential conflicts with oldrefname (e.g.,
- * because oldrefname is scheduled for deletion in the same
+ * conflicting with the name of an existing reference in direntry.  If
+ * oldrefname is non-NULL, ignore potential conflicts with oldrefname
+ * (e.g., because oldrefname is scheduled for deletion in the same
  * operation).
+ *
+ * Two reference names conflict if one of them exactly matches the
+ * leading components of the other; e.g., "foo/bar" conflicts with
+ * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
+ * "foo/barbados".
  */
 static int is_refname_available(const char *refname, const char *oldrefname,
 				struct ref_entry *direntry)
 {
+	int prefixlen = strlen(refname);
+	char *prefix;
+	char *slash;
 	struct name_conflict_cb data;
-	data.refname = refname;
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
 	data.oldrefname = oldrefname;
 	data.conflicting_refname = NULL;
 
-	assert(direntry->flag & REF_DIR);
+	direntry = find_containing_direntry(direntry, prefix, 0);
+	if (!direntry)
+		return 1;
 
 	if (do_for_each_ref_in_dir(direntry, 0, "", name_conflict_fn,
 				   0, DO_FOR_EACH_INCLUDE_BROKEN,
-- 
1.7.8
