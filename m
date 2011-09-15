From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 22/22] add_ref(): verify that the refname is formatted correctly
Date: Thu, 15 Sep 2011 23:10:43 +0200
Message-ID: <1316121043-29367-23-git-send-email-mhagger@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 23:18:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4JKS-0000tO-08
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934952Ab1IOVSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:18:35 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40153 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934922Ab1IOVSf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:18:35 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R4J97-00019o-Cy; Thu, 15 Sep 2011 23:06:57 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181507>

In add_ref(), verify that the refname is formatted correctly before
adding it to the ref_list.  Here we have to allow refname components
that start with ".", since (for example) the remote protocol uses
synthetic reference name ".have".  So add a new REFNAME_DOT_COMPONENT
flag that can be passed to check_refname_format() to allow leading
dots.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   18 ++++++++++++++----
 refs.h |    6 +++++-
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 096b42c..832a52f 100644
--- a/refs.c
+++ b/refs.c
@@ -56,6 +56,8 @@ static struct ref_list *add_ref(const char *name, const unsigned char *sha1,
 	entry = xmalloc(sizeof(struct ref_list) + len);
 	hashcpy(entry->sha1, sha1);
 	hashclr(entry->peeled);
+	if (check_refname_format(name, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT))
+		die("Reference has invalid format: '%s'", name);
 	memcpy(entry->name, name, len);
 	entry->flag = flag;
 	entry->next = list;
@@ -900,7 +902,7 @@ static inline int bad_ref_char(int ch)
  * the length of the component found, or -1 if the component is not
  * legal.
  */
-static int check_refname_component(const char *ref)
+static int check_refname_component(const char *ref, int flags)
 {
 	const char *cp;
 	char last = '\0';
@@ -919,8 +921,16 @@ static int check_refname_component(const char *ref)
 	}
 	if (cp == ref)
 		return -1; /* Component has zero length. */
-	if (ref[0] == '.')
-		return -1; /* Component starts with '.'. */
+	if (ref[0] == '.') {
+		if (!(flags & REFNAME_DOT_COMPONENT))
+			return -1; /* Component starts with '.'. */
+		/*
+		 * Even if leading dots are allowed, don't allow "."
+		 * as a component (".." is prevented by a rule above).
+		 */
+		if (ref[1] == '\0')
+			return -1; /* Component equals ".". */
+	}
 	if (cp - ref >= 5 && !memcmp(cp - 5, ".lock", 5))
 		return -1; /* Refname ends with ".lock". */
 	return cp - ref;
@@ -932,7 +942,7 @@ int check_refname_format(const char *ref, int flags)
 
 	while (1) {
 		/* We are at the start of a path component. */
-		component_len = check_refname_component(ref);
+		component_len = check_refname_component(ref, flags);
 		if (component_len < 0) {
 			if ((flags & REFNAME_REFSPEC_PATTERN) &&
 					ref[0] == '*' &&
diff --git a/refs.h b/refs.h
index b0da5fc..d5ac133 100644
--- a/refs.h
+++ b/refs.h
@@ -99,6 +99,7 @@ extern int for_each_reflog(each_ref_fn, void *);
 
 #define REFNAME_ALLOW_ONELEVEL 1
 #define REFNAME_REFSPEC_PATTERN 2
+#define REFNAME_DOT_COMPONENT 4
 
 /*
  * Return 0 iff ref has the correct format for a refname according to
@@ -106,7 +107,10 @@ extern int for_each_reflog(each_ref_fn, void *);
  * REFNAME_ALLOW_ONELEVEL is set in flags, then accept one-level
  * reference names.  If REFNAME_REFSPEC_PATTERN is set in flags, then
  * allow a "*" wildcard character in place of one of the name
- * components.  No leading or repeated slashes are accepted.
+ * components.  No leading or repeated slashes are accepted.  If
+ * REFNAME_DOT_COMPONENT is set in flags, then allow refname
+ * components to start with "." (but not a whole component equal to
+ * "." or "..").
  */
 extern int check_refname_format(const char *ref, int flags);
 
-- 
1.7.6.8.gd2879
