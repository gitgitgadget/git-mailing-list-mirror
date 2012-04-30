From: mhagger@alum.mit.edu
Subject: [RFC 4/7] parse_refname_component(): parse until terminator
Date: Tue,  1 May 2012 01:02:52 +0200
Message-ID: <1335826975-3093-5-git-send-email-mhagger@alum.mit.edu>
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
	id 1SOzcv-0000Ul-JF
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 01:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757356Ab2D3XDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 19:03:15 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41750 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757285Ab2D3XDM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 19:03:12 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0D9D4.dip.t-dialin.net [79.192.217.212])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3UN2xbD028766;
	Tue, 1 May 2012 01:03:05 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335826975-3093-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196630>

From: Michael Haggerty <mhagger@alum.mit.edu>

Rename check_refname_component() to parse_refname_component() and
change it to parse whatever part of the beginning of the string that
can be considered a valid refname component.  The old version reported
an error if a refname component was terminated by anything other then
end-of-string or '/'; this version just reports the length of the part
of the string that can be considered a valid refname component
(whether it is terminated by end-of-string, '/', "..", "@{", or some
character that is illegal in a refname component).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   64 +++++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 39008f2..6e4cba0 100644
--- a/refs.c
+++ b/refs.c
@@ -29,25 +29,32 @@ static inline int bad_ref_char(int ch)
 }
 
 /*
- * Try to read one refname component from the first refnamelen
- * characters of refname.  Return the length of the component found,
- * or -1 if the component is not legal.
+ * Try to read one refname component from the front of refname.
+ * Return the length of the part of the string that could constitute a
+ * valid refname component (which might be zero), or -1 if the start
+ * of the string looks like a refname component but is formatted
+ * illegally.  A refname component can be terminated by the end of the
+ * string, '/', any character forbidden by bad_ref_char(), "..", or
+ * "@{".
  */
-static int check_refname_component(const char *refname, int refnamelen, int flags)
+static int parse_refname_component(const char *refname, int refnamelen, int flags)
 {
 	int i;
 	char last = '\0';
 
 	for (i = 0; i < refnamelen; i++) {
 		char ch = refname[i];
-		if (ch == '/')
+		if (ch == '/') {
 			break;
-		if (bad_ref_char(ch))
-			return -1; /* Illegal character in refname. */
-		if (last == '.' && ch == '.')
-			return -1; /* Refname contains "..". */
-		if (last == '@' && ch == '{')
-			return -1; /* Refname contains "@{". */
+		} else if (bad_ref_char(ch)) {
+			break; /* Component terminated by illegal character. */
+		} else if (last == '.' && ch == '.') {
+			i--;
+			break; /* Component terminated by "..". */
+		} else if (last == '@' && ch == '{') {
+			i--;
+			break; /* Refname terminated by "@{". */
+		}
 		last = ch;
 	}
 	if (i == 0)
@@ -57,13 +64,14 @@ static int check_refname_component(const char *refname, int refnamelen, int flag
 			return -1; /* Component starts with '.'. */
 		/*
 		 * Even if leading dots are allowed, don't allow "."
-		 * as a component (".." is prevented by a rule above).
+		 * as a component (".." is treated as a terminator by
+		 * a rule above).
 		 */
 		if (i == 1)
 			return -1; /* Component equals ".". */
 	}
 	if (i >= 5 && !memcmp(&refname[i - 5], ".lock", 5))
-		return -1; /* Refname ends with ".lock". */
+		return -1; /* Component is not allowed to end with ".lock". */
 	return i;
 }
 
@@ -74,11 +82,14 @@ int check_refname_format(const char *refname, int flags)
 
 	while (1) {
 		/* We are at the start of a path component. */
-		component_len = check_refname_component(refname, refnamelen, flags);
-		if (component_len <= 0) {
+		component_len = parse_refname_component(refname, refnamelen, flags);
+		if (component_len < 0) {
+			/* This case includes a refname that ends with '/': */
+			return -1;
+		} else if (component_len == 0) {
 			if ((flags & REFNAME_REFSPEC_PATTERN) &&
-					refname[0] == '*' &&
-					(refname[1] == '\0' || refname[1] == '/')) {
+					refnamelen >= 1 && refname[0] == '*' &&
+					(refnamelen == 1 || refname[1] == '/')) {
 				/* Accept one wildcard as a full refname component. */
 				flags &= ~REFNAME_REFSPEC_PATTERN;
 				component_len = 1;
@@ -87,11 +98,22 @@ int check_refname_format(const char *refname, int flags)
 			}
 		}
 		component_count++;
-		if (refname[component_len] == '\0')
+		/* See what terminated the component: */
+		if (component_len == refnamelen) {
+			/* We've parsed the whole string: */
 			break;
-		/* Skip to next component. */
-		refname += component_len + 1;
-		refnamelen -= component_len + 1;
+		} else if (refname[component_len] == '/') {
+			/* Skip to the start of the next component: */
+			refname += component_len + 1;
+			refnamelen -= component_len + 1;
+		} else {
+			/*
+			 * The component was ended by something else
+			 * (something that cannot be part of a legal
+			 * refname).
+			 */
+			return -1;
+		}
 	}
 
 	if (refname[component_len - 1] == '.')
-- 
1.7.10
