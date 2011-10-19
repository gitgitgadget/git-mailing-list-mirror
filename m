From: mhagger@alum.mit.edu
Subject: [RFC 02/13] parse_refname_prefix(): new function
Date: Wed, 19 Oct 2011 22:55:05 +0200
Message-ID: <1319057716-28094-3-git-send-email-mhagger@alum.mit.edu>
References: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 22:55:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdAo-0003UG-MK
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 22:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528Ab1JSUz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 16:55:29 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:60890 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851Ab1JSUzY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 16:55:24 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RGd4e-000423-I4; Wed, 19 Oct 2011 22:49:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183950>

From: Michael Haggerty <mhagger@alum.mit.edu>

Add a function parse_refname_prefix() that can read a possible refname
from the front of a string.  This is like check_refname_format(),
except:

* It accepts (string, len) parameters and can therefore handle
  non-NUL-terminated strings.

* It returns the length of the part of the string that was parsed,
  allowing it to be used for refnames that are followed by additional
  characters.

Re-implement check_refname_format() using the new function.

Rename function check_refname_component() to parse_refname_component()
for consistency.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   64 ++++++++++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/refs.c b/refs.c
index 3b41252..387da83 100644
--- a/refs.c
+++ b/refs.c
@@ -907,24 +907,30 @@ static inline int bad_ref_char(int ch)
 
 /*
  * Try to read one refname component from the front of ref.  Return
- * the length of the component found, or -1 if the component is not
- * legal.
+ * the length of the component found, or -1 if the start of the string
+ * cannot be interpreted as a component of a legal refname.
  */
-static int check_refname_component(const char *ref, int flags)
+static int parse_refname_component(const char *ref, int len, int flags)
 {
-	int i, len = strlen(ref);
+	int i;
 	char last = '\0';
 
 	for (i = 0; i < len; i++) {
 		char ch = ref[i];
-		if (ch == '\0' || ch == '/')
-			break;
+		if (ch == '/')
+			break; /* Component terminated by "..". */
 		if (bad_ref_char(ch))
-			return -1; /* Illegal character in refname. */
-		if (last == '.' && ch == '.')
-			return -1; /* Refname contains "..". */
-		if (last == '@' && ch == '{')
-			return -1; /* Refname contains "@{". */
+			break; /* Component terminated by illegal character. */
+		if (last == '.' && ch == '.') {
+			/* Component terminated by "..". */
+			i--;
+			break;
+		}
+		if (last == '@' && ch == '{') {
+			/* Component terminated by "@{". */
+			i--;
+			break;
+		}
 		last = ch;
 	}
 	if (i == 0)
@@ -944,17 +950,26 @@ static int check_refname_component(const char *ref, int flags)
 	return i;
 }
 
-int check_refname_format(const char *ref, int flags)
+/*
+ * Try to interpret the beginning of a string as a refname.  Return
+ * the length of the part of the string that could constitute a valid
+ * refname, or -1 if the start of the string cannot possibly be
+ * interpreted as a refname.  flags has the same interpretation as for
+ * check_refname_format().
+ */
+static int parse_refname_prefix(const char *ref, int len, int flags)
 {
 	int component_len, component_count = 0;
+	const char *p = ref;
+	int valid_len;
 
 	while (1) {
-		/* We are at the start of a path component. */
-		component_len = check_refname_component(ref, flags);
+		/* p is at the start of a path component. */
+		component_len = parse_refname_component(p, len, flags);
 		if (component_len < 0) {
 			if ((flags & REFNAME_REFSPEC_PATTERN) &&
-					ref[0] == '*' &&
-					(ref[1] == '\0' || ref[1] == '/')) {
+					len && p[0] == '*' &&
+					(len == 1 || p[1] == '/')) {
 				/* Accept one wildcard as a full refname component. */
 				flags &= ~REFNAME_REFSPEC_PATTERN;
 				component_len = 1;
@@ -963,17 +978,26 @@ int check_refname_format(const char *ref, int flags)
 			}
 		}
 		component_count++;
-		if (ref[component_len] == '\0')
+		if (component_len == len || p[component_len] != '/')
 			break;
 		/* Skip to next component. */
-		ref += component_len + 1;
+		p += component_len + 1;
+		len -= component_len + 1;
 	}
 
-	if (ref[component_len - 1] == '.')
+	valid_len = p + component_len - ref;
+
+	if (ref[valid_len - 1] == '.')
 		return -1; /* Refname ends with '.'. */
 	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
 		return -1; /* Refname has only one component. */
-	return 0;
+	return valid_len;
+}
+
+int check_refname_format(const char *ref, int flags)
+{
+	int len = strlen(ref);
+	return parse_refname_prefix(ref, len, flags) == len ? 0 : -1;
 }
 
 const char *prettify_refname(const char *name)
-- 
1.7.7
