From: mhagger@alum.mit.edu
Subject: [RFC 5/7] parse_refname_prefix(): new function
Date: Tue,  1 May 2012 01:02:53 +0200
Message-ID: <1335826975-3093-6-git-send-email-mhagger@alum.mit.edu>
References: <1335826975-3093-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 01:03:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOzcv-0000Ul-2u
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 01:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757340Ab2D3XDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 19:03:15 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41753 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757284Ab2D3XDO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 19:03:14 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0D9D4.dip.t-dialin.net [79.192.217.212])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3UN2xbE028766;
	Tue, 1 May 2012 01:03:07 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335826975-3093-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196633>

From: Michael Haggerty <mhagger@alum.mit.edu>

Add a new function, parse_refname_prefix(), which looks for a possible
refname at the front of a string and returns its length.  Use this
function to implement check_refname_format().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index 6e4cba0..70578ee 100644
--- a/refs.c
+++ b/refs.c
@@ -75,21 +75,28 @@ static int parse_refname_component(const char *refname, int refnamelen, int flag
 	return i;
 }
 
-int check_refname_format(const char *refname, int flags)
+/*
+ * Try to interpret the beginning of string refname as a reference
+ * name.  Return the length of the part of the string that could
+ * constitute a valid refname, or -1 if the start of the string cannot
+ * possibly be interpreted as a refname.  flags has the same
+ * interpretation as for check_refname_format().
+ */
+static int parse_refname_prefix(const char *refname, int refnamelen, int flags)
 {
-	int refnamelen = strlen(refname);
+	const char *p = refname;
+	int len = refnamelen;
 	int component_len, component_count = 0;
 
 	while (1) {
 		/* We are at the start of a path component. */
-		component_len = parse_refname_component(refname, refnamelen, flags);
+		component_len = parse_refname_component(p, len, flags);
 		if (component_len < 0) {
-			/* This case includes a refname that ends with '/': */
 			return -1;
 		} else if (component_len == 0) {
 			if ((flags & REFNAME_REFSPEC_PATTERN) &&
-					refnamelen >= 1 && refname[0] == '*' &&
-					(refnamelen == 1 || refname[1] == '/')) {
+					len >= 1 && p[0] == '*' &&
+					(len == 1 || p[1] == '/')) {
 				/* Accept one wildcard as a full refname component. */
 				flags &= ~REFNAME_REFSPEC_PATTERN;
 				component_len = 1;
@@ -99,28 +106,34 @@ int check_refname_format(const char *refname, int flags)
 		}
 		component_count++;
 		/* See what terminated the component: */
-		if (component_len == refnamelen) {
+		if (component_len == len) {
 			/* We've parsed the whole string: */
 			break;
-		} else if (refname[component_len] == '/') {
+		} else if (p[component_len] == '/') {
 			/* Skip to the start of the next component: */
-			refname += component_len + 1;
-			refnamelen -= component_len + 1;
+			p += component_len + 1;
+			len -= component_len + 1;
 		} else {
 			/*
 			 * The component was ended by something else
 			 * (something that cannot be part of a legal
 			 * refname).
 			 */
-			return -1;
+			break;
 		}
 	}
 
-	if (refname[component_len - 1] == '.')
+	if (p[component_len - 1] == '.')
 		return -1; /* Refname ends with '.'. */
 	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
 		return -1; /* Refname has only one component. */
-	return 0;
+	return p + component_len - refname;
+}
+
+int check_refname_format(const char *refname, int flags)
+{
+	int refnamelen = strlen(refname);
+	return parse_refname_prefix(refname, refnamelen, flags) == refnamelen ? 0 : -1;
 }
 
 struct ref_entry;
-- 
1.7.10
