From: mhagger@alum.mit.edu
Subject: [PATCH 06/15] names_conflict(): new function, extracted from is_refname_available()
Date: Tue, 10 Apr 2012 07:30:18 +0200
Message-ID: <1334035827-20331-7-git-send-email-mhagger@alum.mit.edu>
References: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 07:31:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHTff-0002Gn-J3
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 07:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263Ab2DJFbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 01:31:01 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59211 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010Ab2DJFaz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 01:30:55 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0B8CA.dip.t-dialin.net [79.192.184.202])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3A5UXdx000870;
	Tue, 10 Apr 2012 07:30:48 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195064>

From: Michael Haggerty <mhagger@alum.mit.edu>

This costs an extra strlen() in the loop, but even that small price
will be clawed back in the next patch.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 78dbda6..cdb66d9 100644
--- a/refs.c
+++ b/refs.c
@@ -334,6 +334,30 @@ static int do_for_each_ref_in_arrays(struct ref_array *array1,
 }
 
 /*
+ * Return true iff refname1 and refname2 conflict with each other.
+ * Two reference names conflict if one of them exactly matches the
+ * leading components of the other; e.g., "foo/bar" conflicts with
+ * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
+ * "foo/barbados".
+ */
+static int names_conflict(const char *refname1, const char *refname2)
+{
+	int len1 = strlen(refname1);
+	int len2 = strlen(refname2);
+	int cmplen;
+	const char *lead;
+
+	if (len1 < len2) {
+		cmplen = len1;
+		lead = refname2;
+	} else {
+		cmplen = len2;
+		lead = refname1;
+	}
+	return !strncmp(refname1, refname2, cmplen) && lead[cmplen] == '/';
+}
+
+/*
  * Return true iff a reference named refname could be created without
  * conflicting with the name of an existing reference.  If oldrefname
  * is non-NULL, ignore potential conflicts with oldrefname (e.g.,
@@ -343,20 +367,15 @@ static int do_for_each_ref_in_arrays(struct ref_array *array1,
 static int is_refname_available(const char *refname, const char *oldrefname,
 				struct ref_array *array)
 {
-	int i, namlen = strlen(refname); /* e.g. 'foo/bar' */
+	int i;
 	for (i = 0; i < array->nr; i++ ) {
 		struct ref_entry *entry = array->refs[i];
-		/* entry->name could be 'foo' or 'foo/bar/baz' */
-		if (!oldrefname || strcmp(oldrefname, entry->name)) {
-			int len = strlen(entry->name);
-			int cmplen = (namlen < len) ? namlen : len;
-			const char *lead = (namlen < len) ? entry->name : refname;
-			if (!strncmp(refname, entry->name, cmplen) &&
-			    lead[cmplen] == '/') {
-				error("'%s' exists; cannot create '%s'",
-				      entry->name, refname);
-				return 0;
-			}
+		if (oldrefname && !strcmp(oldrefname, entry->name))
+			continue;
+		if (names_conflict(refname, entry->name)) {
+			error("'%s' exists; cannot create '%s'",
+			      entry->name, refname);
+			return 0;
 		}
 	}
 	return 1;
-- 
1.7.10
