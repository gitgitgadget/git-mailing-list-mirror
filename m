From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix segfault in merge-recursive
Date: Fri, 8 May 2009 22:30:32 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905082229520.4601@intel-tinevez-2-302>
References: <alpine.DEB.2.00.0905070102010.30999@narbuckle.genericorp.net> <alpine.DEB.1.00.0905071144370.18521@pacific.mpi-cbg.de> <alpine.DEB.2.00.0905072131470.30999@narbuckle.genericorp.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dave O <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 22:30:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2WiS-0003ON-Ff
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 22:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756712AbZEHUag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 16:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756066AbZEHUaf
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 16:30:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:55935 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755978AbZEHUae (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 16:30:34 -0400
Received: (qmail invoked by alias); 08 May 2009 20:30:34 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp063) with SMTP; 08 May 2009 22:30:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196NEUc0Vh6zEQ6pteoEleOpl69zNTKnIKNmJOFMN
	Y9boLbmm5HD8Nk
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.DEB.2.00.0905072131470.30999@narbuckle.genericorp.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118627>


When there is no "common" tree (for whatever reason), we must not
throw a segmentation fault.

Noticed by Dave O.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Sorry, did not have much time, so I only fixed the segfault.  
	Could you verify that the result is correct?

 merge-recursive.c          |   23 +++++--
 t/t3031-merge-criscross.sh |  135 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+), 7 deletions(-)
 create mode 100755 t/t3031-merge-criscross.sh

diff --git a/merge-recursive.c b/merge-recursive.c
index a3721ef..920ccc1 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -176,17 +176,26 @@ static int git_merge_trees(int index_only,
 		opts.index_only = 1;
 	else
 		opts.update = 1;
-	opts.merge = 1;
-	opts.head_idx = 2;
 	opts.fn = threeway_merge;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 
-	init_tree_desc_from_tree(t+0, common);
-	init_tree_desc_from_tree(t+1, head);
-	init_tree_desc_from_tree(t+2, merge);
+	if (common) {
+		opts.merge = 1;
+		opts.head_idx = 2;
+		init_tree_desc_from_tree(t+0, common);
+		init_tree_desc_from_tree(t+1, head);
+		init_tree_desc_from_tree(t+2, merge);
+		rc = unpack_trees(3, t, &opts);
+	}
+	else {
+		opts.merge = 0;
+		opts.head_idx = 1;
+		init_tree_desc_from_tree(t+0, head);
+		init_tree_desc_from_tree(t+1, merge);
+		rc = unpack_trees(2, t, &opts);
+	}
 
-	rc = unpack_trees(3, t, &opts);
 	cache_tree_free(&active_cache_tree);
 	return rc;
 }
@@ -1152,7 +1161,7 @@ int merge_trees(struct merge_options *o,
 		common = shift_tree_object(head, common);
 	}
 
-	if (sha_eq(common->object.sha1, merge->object.sha1)) {
+	if (common && sha_eq(common->object.sha1, merge->object.sha1)) {
 		output(o, 0, "Already uptodate!");
 		*result = head;
 		return 1;
diff --git a/t/t3031-merge-criscross.sh b/t/t3031-merge-criscross.sh
new file mode 100755
index 0000000..525afea
--- /dev/null
+++ b/t/t3031-merge-criscross.sh
@@ -0,0 +1,135 @@
+#!/bin/sh
+
+test_description='merge-recursive backend test'
+
+. ./test-lib.sh
+
+#         A      <- create some files
+#        / \
+#       B   C    <- cause rename/delete conflicts between B and C
+#      /     \
+# ->  1       1  <- merge-bases for F and G: B1, C1
+#     |\     /|
+#     2 D   E 2
+#     | |   | |
+#     | 1   1 |  <- overload rename_limit in E1
+#     |  \ /  |
+#     |   X   |
+#     |  / \  |
+#     | /   \ |
+#     |/     \|
+#     F       G  <- merge E into B, D into C
+#      \     /
+#       \   /
+#        \ /
+#         H      <- recursive merge crashes
+#
+
+# initialize
+test_expect_success 'setup' '
+	mkdir data &&
+
+	test_debug create a bunch of files &&
+	n=1 &&
+	while test $n -le 1000
+	do
+		echo $n > data/$n &&
+		n=$(($n+1)) ||
+		break
+	done &&
+
+	test_debug check them in &&
+	git add data &&
+	git commit -m A &&
+	git branch A &&
+
+	test_debug remove some files in one branch &&
+	git checkout -b B A &&
+	git rm data/99* &&
+	git add data &&
+	git commit -m B &&
+
+	test_debug few more commits on B &&
+	echo testB > data/testB &&
+	git add data &&
+	git commit -m B1 &&
+
+	test_debug with a branch off of it &&
+	git branch D &&
+
+	echo testB2 > data/testB2 &&
+	git add data &&
+	git commit -m B2 &&
+
+	test_debug put some commits on D &&
+	git checkout D &&
+	echo testD > data/testD &&
+	git add data &&
+	git commit -m D &&
+
+	echo testD1 > data/testD1 &&
+	git add data &&
+	git commit -m D1 &&
+
+	test_debug back up to the top, create another branch and cause a rename  &&
+	test_debug conflict with the files we deleted earlier &&
+	git checkout -b C A &&
+	git rm --cached data/99* &&
+	rename "s!/9!/moved-9!" data/99* &&
+	git add data &&
+	git commit -m C &&
+
+	test_debug few more commits on C &&
+	echo testC > data/testC &&
+	git add data &&
+	git commit -m C1 &&
+
+	test_debug with a branch off of it &&
+	git branch E &&
+
+	echo testC2 > data/testC2 &&
+	git add data &&
+	git commit -m C2 &&
+
+	test_debug put a commits on E &&
+	git checkout E &&
+	echo testE > data/testE &&
+	git add data &&
+	git commit -m E &&
+
+	test_debug and now, overload add/delete &&
+	git rm data/[123456]* &&
+	n=10000 &&
+	while test $n -le 11000
+	do
+		echo $n > data/$n &&
+		n=$(($n+1)) ||
+		break
+	done &&
+	git add data &&
+	git commit -m E1 &&
+
+
+	test_debug now, merge E into B &&
+	git checkout B &&
+	test_must_fail git merge E &&
+	test_debug force-resolve? &&
+	git add data &&
+	git commit -m F &&
+	git branch F &&
+
+
+	test_debug and merge D into C &&
+	git checkout C &&
+	test_must_fail git merge D &&
+	test_debug force-resolve? &&
+	git add data &&
+	git commit -m G &&
+	git branch G
+'
+
+test_expect_failure 'now, force a recursive merge between F and G' '
+	git merge F
+'
+
+test_done
-- 
1.6.2.1.493.g67cf3
