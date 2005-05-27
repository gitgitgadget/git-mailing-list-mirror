From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 11/12] Move pathspec to the beginning of the diffcore chain.
Date: Fri, 27 May 2005 15:56:17 -0700
Message-ID: <7vmzqg2s8e.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 00:55:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbnjd-0002QC-Jc
	for gcvg-git@gmane.org; Sat, 28 May 2005 00:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbVE0W51 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 18:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbVE0W51
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 18:57:27 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:30950 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262645AbVE0W4T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 18:56:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527225618.SDXW8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 18:56:18 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 27 May 2005 15:43:58 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This changes the way how pathspec is used in the three diff-*
brothers.  Earlier, they tried to grab as much information from
the original input and used pathspec to limit the output.  This
version uses pathspec upfront to narrow the world diffcore
operates in, so "git-diff-* <arguments> some-directory" does not
look at things outside the specified subtree when finding
rename/copy or running pickaxe.

Since diff-tree already takes this view and does not feed
anything outside the specified directotires to begin with, this
patch does not have to touch that command.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-cache.c        |    4 ++--
diff-files.c        |    4 ++--
diff-helper.c       |    8 ++++----
t/t4007-rename-3.sh |   22 +++++++++++-----------
4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -240,12 +240,12 @@ int main(int argc, const char **argv)
 		die("unable to read tree object %s", tree_name);
 
 	ret = diff_cache(active_cache, active_nr);
+	if (pathspec)
+		diffcore_pathspec(pathspec);
 	if (detect_rename)
 		diffcore_rename(detect_rename, diff_score_opt);
 	if (pickaxe)
 		diffcore_pickaxe(pickaxe, pickaxe_opts);
-	if (pathspec)
-		diffcore_pathspec(pathspec);
 	diff_flush(diff_output_format, 1);
 	return ret;
 }
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -116,12 +116,12 @@ int main(int argc, const char **argv)
 		show_modified(oldmode, mode, ce->sha1, null_sha1,
 			      ce->name);
 	}
+	if (1 < argc)
+		diffcore_pathspec(argv + 1);
 	if (detect_rename)
 		diffcore_rename(detect_rename, diff_score_opt);
 	if (pickaxe)
 		diffcore_pickaxe(pickaxe, pickaxe_opts);
-	if (1 < argc)
-		diffcore_pathspec(argv + 1);
 	diff_flush(diff_output_format, 1);
 	return 0;
 }
diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -129,17 +129,17 @@ int main(int ac, const char **av) {
 					  new_path);
 			continue;
 		}
-		if (pickaxe)
-			diffcore_pickaxe(pickaxe, pickaxe_opts);
 		if (1 < ac)
 			diffcore_pathspec(av + 1);
+		if (pickaxe)
+			diffcore_pickaxe(pickaxe, pickaxe_opts);
 		diff_flush(DIFF_FORMAT_PATCH, 0);
 		printf("%s\n", sb.buf);
 	}
-	if (pickaxe)
-		diffcore_pickaxe(pickaxe, pickaxe_opts);
 	if (1 < ac)
 		diffcore_pathspec(av + 1);
+	if (pickaxe)
+		diffcore_pickaxe(pickaxe, pickaxe_opts);
 	diff_flush(DIFF_FORMAT_PATCH, 0);
 	return 0;
 }
diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
--- a/t/t4007-rename-3.sh
+++ b/t/t4007-rename-3.sh
@@ -46,23 +46,23 @@ cat >expected <<\EOF
 EOF
 
 test_expect_success \
-    'validate the result' \
+    'validate the result (#1)' \
     'compare_diff_raw current expected'
 
 # In the tree, there is only path0/COPYING.  In the cache, path0 and
 # path1 both have COPYING and the latter is a copy of path0/COPYING.
-# When we omit output from path0 it should still be able to tell us
-# that path1/COPYING is result from a copy from path0/COPYING, not
-# rename, which would imply path0/COPYING is now gone.
+# However when we say we care only about path1, we should just see
+# path1/COPYING suddenly appearing from nowhere, not detected as
+# a copy from path0/COPYING.
 
 git-diff-cache -C $tree path1 >current
 
 cat >expected <<\EOF
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 C100	path0/COPYING	path1/COPYING
+:000000 100644 0000000000000000000000000000000000000000 6ff87c4664981e4397625791c8ea3bbb5f2279a3 N	path1/COPYING
 EOF
 
 test_expect_success \
-    'validate the result' \
+    'validate the result (#2)' \
     'compare_diff_raw current expected'
 
 test_expect_success \
@@ -82,22 +82,22 @@ cat >expected <<\EOF
 EOF
 
 test_expect_success \
-    'validate the result' \
+    'validate the result (#3)' \
     'compare_diff_raw current expected'
 
 # In the tree, there is only path0/COPYING.  In the cache, path0 does
 # not have COPYING anymore and path1 has COPYING which is a copy of
-# path0/COPYING.  Even if we restrict the output to path1, it still
-# should show us the rename.
+# path0/COPYING.  When we say we care only about path1, we should just
+# see path1/COPYING appearing from nowhere.
 
 git-diff-cache -C $tree path1 >current
 
 cat >expected <<\EOF
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 R100	path0/COPYING	path1/COPYING
+:000000 100644 0000000000000000000000000000000000000000 6ff87c4664981e4397625791c8ea3bbb5f2279a3 N	path1/COPYING
 EOF
 
 test_expect_success \
-    'validate the result' \
+    'validate the result (#4)' \
     'compare_diff_raw current expected'
 
 test_done
------------------------------------------------

