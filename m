From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] Teach 'diff' about 'nodiff' attribute.
Date: Fri, 13 Apr 2007 02:01:39 -0700
Message-ID: <7vodlsd4wc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 11:02:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcHfj-0006Ne-7u
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 11:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979AbXDMJBm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 05:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752986AbXDMJBm
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 05:01:42 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:61802 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979AbXDMJBk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 05:01:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070413090138.SUNV1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 13 Apr 2007 05:01:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id mZ1f1W0071kojtg0000000; Fri, 13 Apr 2007 05:01:39 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44397>

This makes paths with 'nodiff' attribute not to produce
"textual" diffs from 'git-diff' family.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 attr.c |   18 ------------------
 diff.c |   40 +++++++++++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/attr.c b/attr.c
index d35ae9e..bdbc4a3 100644
--- a/attr.c
+++ b/attr.c
@@ -299,21 +299,3 @@ int git_checkattr(const char *path, int num, struct git_attr_check *check)
 		rem = fill(path, pathlen, stk, check, num, rem);
 	return 0;
 }
-
-static void setup_binary_check(struct git_attr_check *check)
-{
-	static struct git_attr *attr_binary;
-
-	if (!attr_binary)
-		attr_binary = git_attr("binary", 6);
-	check->attr = attr_binary;
-}
-
-int git_path_is_binary(const char *path)
-{
-	struct git_attr_check attr_binary_check;
-
-	setup_binary_check(&attr_binary_check);
-	return (!git_checkattr(path, 1, &attr_binary_check) &&
-		(0 < attr_binary_check.isset));
-}
diff --git a/diff.c b/diff.c
index fbb79d7..bc4af5c 100644
--- a/diff.c
+++ b/diff.c
@@ -8,6 +8,7 @@
 #include "delta.h"
 #include "xdiff-interface.h"
 #include "color.h"
+#include "attr.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -1051,13 +1052,34 @@ static void emit_binary_diff(mmfile_t *one, mmfile_t *two)
 	emit_binary_diff_body(two, one);
 }
 
+static void setup_nodiff_check(struct git_attr_check *check)
+{
+	static struct git_attr *attr_nodiff;
+
+	if (!attr_nodiff)
+		attr_nodiff = git_attr("nodiff", 6);
+	check->attr = attr_nodiff;
+}
+
 #define FIRST_FEW_BYTES 8000
-static int mmfile_is_binary(mmfile_t *mf)
+static int file_is_binary(struct diff_filespec *one)
 {
-	long sz = mf->size;
+	unsigned long sz;
+	struct git_attr_check attr_nodiff_check;
+
+	setup_nodiff_check(&attr_nodiff_check);
+	if (!git_checkattr(one->path, 1, &attr_nodiff_check) &&
+	    (0 < attr_nodiff_check.isset))
+		return 1;
+	if (!one->data) {
+		if (!DIFF_FILE_VALID(one))
+			return 0;
+		diff_populate_filespec(one, 0);
+	}
+	sz = one->size;
 	if (FIRST_FEW_BYTES < sz)
 		sz = FIRST_FEW_BYTES;
-	return !!memchr(mf->ptr, 0, sz);
+	return !!memchr(one->data, 0, sz);
 }
 
 static void builtin_diff(const char *name_a,
@@ -1114,7 +1136,7 @@ static void builtin_diff(const char *name_a,
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
 
-	if (!o->text && (mmfile_is_binary(&mf1) || mmfile_is_binary(&mf2))) {
+	if (!o->text && (file_is_binary(one) || file_is_binary(two))) {
 		/* Quite common confusing case */
 		if (mf1.size == mf2.size &&
 		    !memcmp(mf1.ptr, mf2.ptr, mf1.size))
@@ -1190,7 +1212,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
 
-	if (mmfile_is_binary(&mf1) || mmfile_is_binary(&mf2)) {
+	if (file_is_binary(one) || file_is_binary(two)) {
 		data->is_binary = 1;
 		data->added = mf2.size;
 		data->deleted = mf1.size;
@@ -1228,7 +1250,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
 
-	if (mmfile_is_binary(&mf2))
+	if (file_is_binary(two))
 		return;
 	else {
 		/* Crazy xdl interfaces.. */
@@ -1805,8 +1827,8 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 
 		if (o->binary) {
 			mmfile_t mf;
-			if ((!fill_mmfile(&mf, one) && mmfile_is_binary(&mf)) ||
-			    (!fill_mmfile(&mf, two) && mmfile_is_binary(&mf)))
+			if ((!fill_mmfile(&mf, one) && file_is_binary(one)) ||
+			    (!fill_mmfile(&mf, two) && file_is_binary(two)))
 				abbrev = 40;
 		}
 		len += snprintf(msg + len, sizeof(msg) - len,
@@ -2701,7 +2723,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 			return error("unable to read files to diff");
 
 		/* Maybe hash p->two? into the patch id? */
-		if (mmfile_is_binary(&mf2))
+		if (file_is_binary(p->two))
 			continue;
 
 		len1 = remove_space(p->one->path, strlen(p->one->path));
-- 
1.5.1.1.784.g95e2
