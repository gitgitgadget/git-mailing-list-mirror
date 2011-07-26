From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/19] Allow querying all attributes on a file
Date: Tue, 26 Jul 2011 16:12:52 +0200
Message-ID: <1311689582-3116-10-git-send-email-mhagger@alum.mit.edu>
References: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 16:33:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlihB-0005lg-ST
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 16:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374Ab1GZOdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 10:33:16 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40233 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039Ab1GZOdO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 10:33:14 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QliM6-0004aQ-PE; Tue, 26 Jul 2011 16:11:30 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177878>

Add a function, git_allattrs(), that reports on all attributes that
are set on a path.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

Please check that the function name conforms to git conventions.

 Documentation/technical/api-gitattributes.txt |   45 +++++++++++++++++-------
 attr.c                                        |   43 +++++++++++++++++++++++
 attr.h                                        |    9 +++++
 3 files changed, 84 insertions(+), 13 deletions(-)

diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
index ab3a84d..640240e 100644
--- a/Documentation/technical/api-gitattributes.txt
+++ b/Documentation/technical/api-gitattributes.txt
@@ -22,19 +22,6 @@ Data Structure
 	to `git_checkattr()` function, and receives the results.
 
 
-Calling Sequence
-----------------
-
-* Prepare an array of `struct git_attr_check` to define the list of
-  attributes you would want to check.  To populate this array, you would
-  need to define necessary attributes by calling `git_attr()` function.
-
-* Call git_checkattr() to check the attributes for the path.
-
-* Inspect `git_attr_check` structure to see how each of the attribute in
-  the array is defined for the path.
-
-
 Attribute Values
 ----------------
 
@@ -58,6 +45,19 @@ If none of the above returns true, `.value` member points at a string
 value of the attribute for the path.
 
 
+Querying Specific Attributes
+----------------------------
+
+* Prepare an array of `struct git_attr_check` to define the list of
+  attributes you would want to check.  To populate this array, you would
+  need to define necessary attributes by calling `git_attr()` function.
+
+* Call `git_checkattr()` to check the attributes for the path.
+
+* Inspect `git_attr_check` structure to see how each of the attribute in
+  the array is defined for the path.
+
+
 Example
 -------
 
@@ -109,4 +109,23 @@ static void setup_check(void)
 	}
 ------------
 
+
+Querying All Attributes
+-----------------------
+
+To get the values of all attributes associated with a file:
+
+* Call `git_allattrs()`, which returns an array of `git_attr_check`
+  structures.
+
+* Iterate over the `git_attr_check` array to examine the attribute
+  names and values.  The name of the attribute described by a
+  `git_attr_check` object can be retrieved via
+  `git_attr_name(check[i].attr)`.  (Please note that no items will be
+  returned for unset attributes, so `ATTR_UNSET()` will return false
+  for all returned `git_array_check` objects.)
+
+* Free the `git_array_check` array.
+
+
 (JC)
diff --git a/attr.c b/attr.c
index a261550..976c830 100644
--- a/attr.c
+++ b/attr.c
@@ -736,6 +736,49 @@ int git_checkattr(const char *path, int num, struct git_attr_check *check)
 	return 0;
 }
 
+int git_allattrs(const char *path, int *num, struct git_attr_check **check)
+{
+	struct attr_stack *stk;
+	const char *cp;
+	int dirlen, pathlen, i, rem, count, j;
+
+	bootstrap_attr_stack();
+	for (i = 0; i < attr_nr; i++)
+		check_all_attr[i].value = ATTR__UNKNOWN;
+
+	pathlen = strlen(path);
+	cp = strrchr(path, '/');
+	if (!cp)
+		dirlen = 0;
+	else
+		dirlen = cp - path;
+	prepare_attr_stack(path, dirlen);
+	rem = attr_nr;
+	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
+		rem = fill(path, pathlen, stk, rem);
+
+	/* Count the number of attributes that are set. */
+	count = 0;
+	for (i = 0; i < attr_nr; i++) {
+		const char *value = check_all_attr[i].value;
+		if (value != ATTR__UNSET && value != ATTR__UNKNOWN)
+			++count;
+	}
+	*num = count;
+	*check = xmalloc(sizeof(*check_all_attr) * count);
+	j = 0;
+	for (i = 0; i < attr_nr; i++) {
+		const char *value = check_all_attr[i].value;
+		if (value != ATTR__UNSET && value != ATTR__UNKNOWN) {
+			(*check)[j].attr = check_all_attr[i].attr;
+			(*check)[j].value = value;
+			++j;
+		}
+	}
+
+	return 0;
+}
+
 void git_attr_set_direction(enum git_attr_direction new, struct index_state *istate)
 {
 	enum git_attr_direction old = direction;
diff --git a/attr.h b/attr.h
index d4f875a..83202f0 100644
--- a/attr.h
+++ b/attr.h
@@ -38,6 +38,15 @@ char *git_attr_name(struct git_attr *);
 
 int git_checkattr(const char *path, int, struct git_attr_check *);
 
+/*
+ * Retrieve all attributes that apply to the specified path.  *num
+ * will be set the the number of attributes on the path; **check will
+ * be set to point at a newly-allocated array of git_attr_check
+ * objects describing the attributes and their values.  *check must be
+ * free()ed by the caller.
+ */
+int git_allattrs(const char *path, int *num, struct git_attr_check **check);
+
 enum git_attr_direction {
 	GIT_ATTR_CHECKIN,
 	GIT_ATTR_CHECKOUT,
-- 
1.7.6.8.gd2879
