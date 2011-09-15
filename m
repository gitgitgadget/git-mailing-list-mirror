From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 05/22] Refactor check_refname_format()
Date: Thu, 15 Sep 2011 23:10:26 +0200
Message-ID: <1316121043-29367-6-git-send-email-mhagger@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 23:11:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4JDX-00066p-Vt
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934931Ab1IOVLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:11:25 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40077 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934963Ab1IOVLD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:11:03 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R4J8j-00019o-IQ; Thu, 15 Sep 2011 23:06:33 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181501>

Among other things, extract a function check_refname_component().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   95 +++++++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 55 insertions(+), 40 deletions(-)

diff --git a/refs.c b/refs.c
index aaa8730..5259724 100644
--- a/refs.c
+++ b/refs.c
@@ -872,55 +872,70 @@ static inline int bad_ref_char(int ch)
 	return 0;
 }
 
+/*
+ * Try to read one refname component from the front of ref.  Return
+ * the length of the component found, or -1 if the component is not
+ * legal.
+ */
+static int check_refname_component(const char *ref)
+{
+	const char *cp;
+	char last = '\0';
+
+	for (cp = ref; ; cp++) {
+		char ch = *cp;
+		if (ch == '\0' || ch == '/')
+			break;
+		if (bad_ref_char(ch))
+			return -1; /* Illegal character in refname. */
+		if (last == '.' && ch == '.')
+			return -1; /* Refname contains "..". */
+		if (last == '@' && ch == '{')
+			return -1; /* Refname contains "@{". */
+		last = ch;
+	}
+	if (cp == ref)
+		return -1; /* Component has zero length. */
+	if (ref[0] == '.')
+		return -1; /* Component starts with '.'. */
+	return cp - ref;
+}
+
 int check_refname_format(const char *ref, int flags)
 {
-	int ch, level, last;
-	const char *cp = ref;
+	int component_len, component_count = 0;
 
-	level = 0;
 	while (1) {
-		while ((ch = *cp++) == '/')
-			; /* tolerate duplicated slashes */
-		if (!ch)
-			/* should not end with slashes */
-			return -1;
-
-		/* we are at the beginning of the path component */
-		if (ch == '.')
-			return -1;
-		if (bad_ref_char(ch)) {
-			if ((flags & REFNAME_REFSPEC_PATTERN) && ch == '*' &&
-				(!*cp || *cp == '/'))
+		while (*ref == '/')
+			ref++; /* tolerate leading and repeated slashes */
+
+		/* We are at the start of a path component. */
+		component_len = check_refname_component(ref);
+		if (component_len < 0) {
+			if ((flags & REFNAME_REFSPEC_PATTERN) &&
+					ref[0] == '*' &&
+					(ref[1] == '\0' || ref[1] == '/')) {
 				/* Accept one wildcard as a full refname component. */
 				flags &= ~REFNAME_REFSPEC_PATTERN;
-			else
-				return -1;
-		}
-
-		last = ch;
-		/* scan the rest of the path component */
-		while ((ch = *cp++) != 0) {
-			if (bad_ref_char(ch))
-				return -1;
-			if (ch == '/')
-				break;
-			if (last == '.' && ch == '.')
-				return -1;
-			if (last == '@' && ch == '{')
-				return -1;
-			last = ch;
-		}
-		level++;
-		if (!ch) {
-			if (ref <= cp - 2 && cp[-2] == '.')
-				return -1;
-			if (level < 2 && !(flags & REFNAME_ALLOW_ONELEVEL))
-				return -1;
-			if (has_extension(ref, ".lock"))
+				component_len = 1;
+			} else {
 				return -1;
-			return 0;
+			}
 		}
+		component_count++;
+		if (ref[component_len] == '\0')
+			break;
+		/* Skip to next component. */
+		ref += component_len + 1;
 	}
+
+	if (ref[component_len - 1] == '.')
+		return -1; /* Refname ends with '.'. */
+	if (component_len >= 5 && !memcmp(&ref[component_len - 5], ".lock", 5))
+		return -1; /* Refname ends with ".lock". */
+	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
+		return -1; /* Refname has only one component. */
+	return 0;
 }
 
 const char *prettify_refname(const char *name)
-- 
1.7.6.8.gd2879
