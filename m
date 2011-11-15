From: mhagger@alum.mit.edu
Subject: [PATCH] Fix "is_refname_available(): query only possibly-conflicting references"
Date: Tue, 15 Nov 2011 06:55:25 +0100
Message-ID: <1321336525-19374-1-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-27-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 06:55:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQBzw-0002T0-8N
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 06:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627Ab1KOFzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 00:55:51 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:55455 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab1KOFzu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 00:55:50 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB582.dip.t-dialin.net [84.190.181.130])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pAF5tRfr030877;
	Tue, 15 Nov 2011 06:55:27 +0100
X-Mailer: git-send-email 1.7.7.2
In-Reply-To: <1319804921-17545-27-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185423>

From: Michael Haggerty <mhagger@alum.mit.edu>

The above-named commit didn't do all that its commit message claimed.
The problem is that do_for_each_ref_in_dir() doesn't avoid iterating
through reference subtrees outside of "prefix"; it only skips passing
those references to the callback function.  So the function
unnecessarily caused all loose references to be loaded rather than
just those in the required subtree.

So instead, explicitly select the possibly-conflicting subtree and
pass it to do_for_each_ref_in_dir().

Also, simplify name_conflict_fn().  Since it will only be called for
possibly-conflicting references, there is necessarily a conflict if it
is called for *any* reference besides "oldrefname".

Remove function names_conflict(), which is now unused.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

This patch can be squashed on top of "is_refname_available(): query
only possibly-conflicting references", or applied at the end of
mh/ref-api-take-2; it does not conflict with the two commits later in
the series.

 refs.c |   40 +++++++++++++++++-----------------------
 1 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/refs.c b/refs.c
index 6a7f9c3..b185c32 100644
--- a/refs.c
+++ b/refs.c
@@ -633,23 +633,7 @@ static int do_for_each_ref_in_dirs(struct ref_entry *direntry1,
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
@@ -660,11 +644,13 @@ static int name_conflict_fn(const char *existingrefname, const unsigned char *sh
 	struct name_conflict_cb *data = (struct name_conflict_cb *)cb_data;
 	if (!strcmp(data->oldrefname, existingrefname))
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
@@ -673,6 +659,11 @@ static int name_conflict_fn(const char *existingrefname, const unsigned char *sh
  * oldrefname is non-NULL, ignore potential conflicts with oldrefname
  * (e.g., because oldrefname is scheduled for deletion in the same
  * operation).
+ *
+ * Two reference names conflict if one of them exactly matches the
+ * leading components of the other; e.g., "foo/bar" conflicts with
+ * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
+ * "foo/barbados".
  */
 static int is_refname_available(const char *refname, const char *oldrefname,
 				struct ref_entry *direntry)
@@ -706,11 +697,14 @@ static int is_refname_available(const char *refname, const char *oldrefname,
 	/* Check whether refname is a proper prefix of an existing reference: */
 	prefix[prefixlen++] = '/';
 	prefix[prefixlen] = '\0';
-	data.refname = refname;
 	data.oldrefname = oldrefname;
 	data.conflicting_refname = NULL;
 
-	if (do_for_each_ref_in_dir(direntry, 0, prefix, name_conflict_fn,
+	direntry = find_containing_direntry(direntry, prefix, 0);
+	if (!direntry)
+		return 1;
+
+	if (do_for_each_ref_in_dir(direntry, 0, "", name_conflict_fn,
 				   0, DO_FOR_EACH_INCLUDE_BROKEN,
 				   &data)) {
 		error("'%s' exists; cannot create '%s'",
-- 
1.7.7.2
