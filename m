From: Brad King <brad.king@kitware.com>
Subject: [PATCH/RFC] submodule: Search for merges only at end of recursive merge
Date: Fri, 26 Aug 2011 10:18:28 -0400
Message-ID: <03300e44101092641810b34086738a151e01d8ee.1314368109.git.brad.king@kitware.com>
References: <074f22629c034dba738b7241c78229db7f9159ec.1314275112.git.brad.king@kitware.com>
Cc: gitster@pobox.com, Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 16:18:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwxEx-0006Ca-Nh
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 16:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273Ab1HZOSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 10:18:30 -0400
Received: from 66-194-253-20.static.twtelecom.net ([66.194.253.20]:42200 "EHLO
	public.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755153Ab1HZOSa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 10:18:30 -0400
Received: from vesper (vesper.kitwarein.com [192.168.1.207])
	by public.kitware.com (Postfix) with ESMTP id 4F603357F3;
	Fri, 26 Aug 2011 10:18:28 -0400 (EDT)
Received: by vesper (Postfix, from userid 1000)
	id 485A96098; Fri, 26 Aug 2011 10:18:28 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <074f22629c034dba738b7241c78229db7f9159ec.1314275112.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180172>

The submodule merge search is not useful during virtual merges because
the results cannot be used automatically.  Furthermore any suggesions
made by the search may apply to commits different than HEAD:sub and
MERGE_HEAD:sub, thus confusing the user.  Skip searching for submodule
merges during a virtual merge such as that between B and C while merging
the heads of:

    B---BC
   / \ /
  A   X
   \ / \
    C---CB

Run the search only when the recursion level is zero (!o->call_depth).
This fixes known breakage tested in t7405-submodule-merge.

Signed-off-by: Brad King <brad.king@kitware.com>
---

This addresses the submodule search problem reported in the message
to which this replies.  If you think it is correct I can resubmit
both the test and this patch as a single series.

 merge-recursive.c          |    3 ++-
 submodule.c                |   11 ++++++++---
 submodule.h                |    4 +++-
 t/t7405-submodule-merge.sh |    2 +-
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 0cc1e6f..2118ee9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -830,7 +830,8 @@ static struct merge_file_info merge_file(struct merge_options *o,
 			free(result_buf.ptr);
 			result.clean = (merge_status == 0);
 		} else if (S_ISGITLINK(a->mode)) {
-			result.clean = merge_submodule(result.sha, one->path, one->sha1,
+			result.clean = merge_submodule(o, result.sha,
+						       one->path, one->sha1,
 						       a->sha1, b->sha1);
 		} else if (S_ISLNK(a->mode)) {
 			hashcpy(result.sha, a->sha1);
diff --git a/submodule.c b/submodule.c
index 1ba9646..c7fdafa 100644
--- a/submodule.c
+++ b/submodule.c
@@ -8,6 +8,7 @@
 #include "diffcore.h"
 #include "refs.h"
 #include "string-list.h"
+#include "merge-recursive.h"
 
 static struct string_list config_name_for_path;
 static struct string_list config_fetch_recurse_submodules_for_name;
@@ -642,9 +643,9 @@ static void print_commit(struct commit *commit)
 #define MERGE_WARNING(path, msg) \
 	warning("Failed to merge submodule %s (%s)", path, msg);
 
-int merge_submodule(unsigned char result[20], const char *path,
-		    const unsigned char base[20], const unsigned char a[20],
-		    const unsigned char b[20])
+int merge_submodule(struct merge_options *o, unsigned char result[20],
+		    const char *path, const unsigned char base[20],
+		    const unsigned char a[20], const unsigned char b[20])
 {
 	struct commit *commit_base, *commit_a, *commit_b;
 	int parent_count;
@@ -699,6 +700,10 @@ int merge_submodule(unsigned char result[20], const char *path,
 	 * user needs to confirm the resolution.
 	 */
 
+	/* This case makes sense only at the main depth 0 merge.  */
+	if (o->call_depth)
+		return 0;
+
 	/* find commit which merges them */
 	parent_count = find_first_merges(&merges, path, commit_a, commit_b);
 	switch (parent_count) {
diff --git a/submodule.h b/submodule.h
index 5350b0d..f22172c 100644
--- a/submodule.h
+++ b/submodule.h
@@ -2,6 +2,7 @@
 #define SUBMODULE_H
 
 struct diff_options;
+struct merge_options;
 
 enum {
 	RECURSE_SUBMODULES_ON_DEMAND = -1,
@@ -27,7 +28,8 @@ int fetch_populated_submodules(int num_options, const char **options,
 			       const char *prefix, int command_line_option,
 			       int quiet);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
-int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
+int merge_submodule(struct merge_options *o, unsigned char result[20],
+		    const char *path, const unsigned char base[20],
 		    const unsigned char a[20], const unsigned char b[20]);
 
 #endif
diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 14da2e3..0d5b42a 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -269,7 +269,7 @@ test_expect_success 'setup for recursive merge with submodule' '
 '
 
 # merge should leave submodule unmerged in index
-test_expect_failure 'recursive merge with submodule' '
+test_expect_success 'recursive merge with submodule' '
 	(cd merge-recursive &&
 	 test_must_fail git merge top-bc &&
 	 echo "160000 $(git rev-parse top-cb:sub) 2	sub" > expect2 &&
-- 
1.7.4.4
