From: mhagger@alum.mit.edu
Subject: [PATCH v2 21/51] names_conflict(): new function, extracted from is_refname_available()
Date: Mon, 12 Dec 2011 06:38:28 +0100
Message-ID: <1323668338-1764-22-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:40:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZycg-0000Sq-2w
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691Ab1LLFkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:40:17 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34733 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710Ab1LLFkO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:14 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aY015577;
	Mon, 12 Dec 2011 06:39:58 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186842>

From: Michael Haggerty <mhagger@alum.mit.edu>

This costs an extra strlen() in the loop, but even that small price
will be clawed back in the next patch.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   43 +++++++++++++++++++++++++++++++------------
 1 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 2cdedf8..c33e94a 100644
--- a/refs.c
+++ b/refs.c
@@ -1086,6 +1086,30 @@ static int remove_empty_directories(const char *file)
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
@@ -1095,20 +1119,15 @@ static int remove_empty_directories(const char *file)
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
1.7.8
