From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 13/23] Allow querying all attributes on a file
Date: Thu,  4 Aug 2011 06:36:23 +0200
Message-ID: <1312432593-9841-14-git-send-email-mhagger@alum.mit.edu>
References: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:37:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qopgt-0005WA-Cm
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871Ab1HDEho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:37:44 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39663 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab1HDEhE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:37:04 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744agHr029203;
	Thu, 4 Aug 2011 06:36:59 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178687>

Add a function, git_all_attrs(), that reports on all attributes that
are set on a path.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-gitattributes.txt |   46 +++++++++++++++++-------
 attr.c                                        |   28 +++++++++++++++
 attr.h                                        |    9 +++++
 3 files changed, 69 insertions(+), 14 deletions(-)

diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
index ab3a84d..3bd2f57 100644
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
 
@@ -109,4 +109,22 @@ static void setup_check(void)
 	}
 ------------
 
-(JC)
+
+Querying All Attributes
+-----------------------
+
+To get the values of all attributes associated with a file:
+
+* Call `git_all_attrs()`, which returns an array of `git_attr_check`
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
diff --git a/attr.c b/attr.c
index ab30c81..658112e 100644
--- a/attr.c
+++ b/attr.c
@@ -747,6 +747,34 @@ int git_checkattr(const char *path, int num, struct git_attr_check *check)
 	return 0;
 }
 
+int git_all_attrs(const char *path, int *num, struct git_attr_check **check)
+{
+	int i, count, j;
+
+	collect_all_attrs(path);
+
+	/* Count the number of attributes that are set. */
+	count = 0;
+	for (i = 0; i < attr_nr; i++) {
+		const char *value = check_all_attr[i].value;
+		if (value != ATTR__UNSET && value != ATTR__UNKNOWN)
+			++count;
+	}
+	*num = count;
+	*check = xmalloc(sizeof(**check) * count);
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
index d4f875a..9e22893 100644
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
+int git_all_attrs(const char *path, int *num, struct git_attr_check **check);
+
 enum git_attr_direction {
 	GIT_ATTR_CHECKIN,
 	GIT_ATTR_CHECKOUT,
-- 
1.7.6.8.gd2879
