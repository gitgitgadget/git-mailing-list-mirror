From: mhagger@alum.mit.edu
Subject: [PATCH v2 10/12] names_conflict(): new function, extracted from is_refname_available()
Date: Fri, 28 Oct 2011 13:28:02 +0200
Message-ID: <1319801284-15625-11-git-send-email-mhagger@alum.mit.edu>
References: <1319801284-15625-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 13:31:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJkeo-0003kX-Q4
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 13:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444Ab1J1Lb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 07:31:26 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:55082 "EHLO
	homer.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751913Ab1J1LbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 07:31:25 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJkVI-0007Cx-MA; Fri, 28 Oct 2011 13:21:40 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319801284-15625-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184372>

From: Michael Haggerty <mhagger@alum.mit.edu>


This costs an extra strlen() in the loop, but even that small price
will be clawed back in the next patch.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   43 +++++++++++++++++++++++++++++++------------
 1 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index d56f265..62e5fd3 100644
--- a/refs.c
+++ b/refs.c
@@ -1092,6 +1092,30 @@ static int remove_empty_directories(const char *file)
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
@@ -1101,20 +1125,15 @@ static int remove_empty_directories(const char *file)
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
1.7.7
