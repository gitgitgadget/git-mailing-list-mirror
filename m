From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/2] git-merge-recursive-{ours,theirs}
Date: Mon, 23 Jun 2008 14:45:27 +0200
Message-ID: <e0243ced5ebe387a18c33da236b7310b4e5d0e82.1214224424.git.vmiklos@frugalware.org>
References: <cover.1214224424.git.vmiklos@frugalware.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 14:46:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAlRV-0001zm-SW
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 14:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbYFWMpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 08:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755901AbYFWMpc
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 08:45:32 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:48110 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbYFWMp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 08:45:28 -0400
Received: from vmobile.example.net (dsl5401C3C5.pool.t-online.hu [84.1.195.197])
	by yugo.frugalware.org (Postfix) with ESMTP id 74EA11DDC5B;
	Mon, 23 Jun 2008 14:45:25 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 707DE18E0E4; Mon, 23 Jun 2008 14:45:27 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <cover.1214224424.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1214224424.git.vmiklos@frugalware.org>
References: <cover.1214224424.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85859>

From: Junio C Hamano <gitster@pobox.com>

This uses the low-level mechanism for "ours" and "theirs" autoresolution
introduced by the previous commit to introduce two additional merge
strategies, merge-recursive-ours and merge-recursive-theirs.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

The patch is the same, but I removed modifications to git-merge.sh and
added them to builtin-merge.c.

 Makefile                     |    3 ++
 builtin-merge-recursive.c    |   37 ++++++++++++++++++++++++---
 builtin-merge.c              |    2 +
 git.c                        |    2 +
 ll-merge.c                   |   24 +++++++++++------
 ll-merge.h                   |    4 ++-
 t/t6034-merge-ours-theirs.sh |   56 ++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 114 insertions(+), 14 deletions(-)
 create mode 100755 t/t6034-merge-ours-theirs.sh

diff --git a/Makefile b/Makefile
index 3d8c3d2..4e354fc 100644
--- a/Makefile
+++ b/Makefile
@@ -303,6 +303,8 @@ BUILT_INS += git-format-patch$X
 BUILT_INS += git-fsck-objects$X
 BUILT_INS += git-get-tar-commit-id$X
 BUILT_INS += git-init$X
+BUILT_INS += git-merge-recursive-ours$X
+BUILT_INS += git-merge-recursive-theirs$X
 BUILT_INS += git-merge-subtree$X
 BUILT_INS += git-peek-remote$X
 BUILT_INS += git-repo-config$X
@@ -1381,6 +1383,7 @@ check-docs::
 	do \
 		case "$$v" in \
 		git-merge-octopus | git-merge-ours | git-merge-recursive | \
+		git-merge-recursive-ours | git-merge-recursive-theirs | \
 		git-merge-resolve | git-merge-stupid | git-merge-subtree | \
 		git-fsck-objects | git-init-db | \
 		git-?*--?* ) continue ;; \
diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 98b09fb..c535596 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -20,7 +20,11 @@
 #include "attr.h"
 #include "merge-recursive.h"
 
-static int subtree_merge;
+static enum {
+	MERGE_RECURSIVE_SUBTREE = 1,
+	MERGE_RECURSIVE_OURS,
+	MERGE_RECURSIVE_THEIRS,
+} merge_recursive_variants;
 
 static struct tree *shift_tree_object(struct tree *one, struct tree *two)
 {
@@ -634,6 +638,7 @@ static int merge_3way(mmbuffer_t *result_buf,
 	mmfile_t orig, src1, src2;
 	char *name1, *name2;
 	int merge_status;
+	int flag, favor;
 
 	name1 = xstrdup(mkpath("%s:%s", branch1, a->path));
 	name2 = xstrdup(mkpath("%s:%s", branch2, b->path));
@@ -642,9 +647,26 @@ static int merge_3way(mmbuffer_t *result_buf,
 	fill_mm(a->sha1, &src1);
 	fill_mm(b->sha1, &src2);
 
+	if (index_only)
+		favor = 0;
+	else {
+		switch (merge_recursive_variants) {
+		case MERGE_RECURSIVE_OURS:
+			favor = XDL_MERGE_FAVOR_OURS;
+			break;
+		case MERGE_RECURSIVE_THEIRS:
+			favor = XDL_MERGE_FAVOR_THEIRS;
+			break;
+		default:
+			favor = 0;
+			break;
+		}
+	}
+	flag = LL_MERGE_FLAGS(index_only, favor);
+
 	merge_status = ll_merge(result_buf, a->path, &orig,
 				&src1, name1, &src2, name2,
-				index_only);
+				flag);
 
 	free(name1);
 	free(name2);
@@ -1163,7 +1185,7 @@ int merge_trees(struct tree *head,
 {
 	int code, clean;
 
-	if (subtree_merge) {
+	if (merge_recursive_variants == MERGE_RECURSIVE_SUBTREE) {
 		merge = shift_tree_object(head, merge);
 		common = shift_tree_object(head, common);
 	}
@@ -1371,11 +1393,18 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 	int index_fd;
 
+	merge_recursive_variants = 0;
 	if (argv[0]) {
 		int namelen = strlen(argv[0]);
 		if (8 < namelen &&
 		    !strcmp(argv[0] + namelen - 8, "-subtree"))
-			subtree_merge = 1;
+			merge_recursive_variants = MERGE_RECURSIVE_SUBTREE;
+		else if (5 < namelen &&
+			 !strcmp(argv[0] + namelen - 5, "-ours"))
+			merge_recursive_variants = MERGE_RECURSIVE_OURS;
+		else if (7 < namelen &&
+			 !strcmp(argv[0] + namelen - 7, "-theirs"))
+			merge_recursive_variants = MERGE_RECURSIVE_THEIRS;
 	}
 
 	git_config(merge_config, NULL);
diff --git a/builtin-merge.c b/builtin-merge.c
index dadde80..b7b1b71 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -52,6 +52,8 @@ static struct path_list_item strategy_items[] = {
 	{ "stupid",     (void *)0 },
 	{ "ours",       (void *)(NO_FAST_FORWARD | NO_TRIVIAL) },
 	{ "subtree",    (void *)(NO_FAST_FORWARD | NO_TRIVIAL) },
+	{ "recursive-ours", (void *)NO_TRIVIAL },
+	{ "recursive-theirs", (void *)NO_TRIVIAL },
 };
 static struct path_list strategies = { strategy_items,
 	ARRAY_SIZE(strategy_items), 0, 0 };
diff --git a/git.c b/git.c
index 770aadd..f2a8ce5 100644
--- a/git.c
+++ b/git.c
@@ -276,6 +276,8 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "merge-file", cmd_merge_file },
 		{ "merge-ours", cmd_merge_ours, RUN_SETUP },
 		{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
+		{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
+		{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
 		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
diff --git a/ll-merge.c b/ll-merge.c
index 9837c84..c6a05bf 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -19,7 +19,7 @@ typedef int (*ll_merge_fn)(const struct ll_merge_driver *,
 			   mmfile_t *orig,
 			   mmfile_t *src1, const char *name1,
 			   mmfile_t *src2, const char *name2,
-			   int virtual_ancestor);
+			   int flag);
 
 struct ll_merge_driver {
 	const char *name;
@@ -39,13 +39,15 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 			   mmfile_t *orig,
 			   mmfile_t *src1, const char *name1,
 			   mmfile_t *src2, const char *name2,
-			   int virtual_ancestor)
+			   int flag)
 {
 	/*
 	 * The tentative merge result is "ours" for the final round,
 	 * or common ancestor for an internal merge.  Still return
 	 * "conflicted merge" status.
 	 */
+	int virtual_ancestor = flag & 01;
+
 	mmfile_t *stolen = virtual_ancestor ? orig : src1;
 
 	result->ptr = stolen->ptr;
@@ -60,9 +62,10 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 			mmfile_t *orig,
 			mmfile_t *src1, const char *name1,
 			mmfile_t *src2, const char *name2,
-			int virtual_ancestor)
+			int flag)
 {
 	xpparam_t xpp;
+	int favor = ((flag)>>1) & 03;
 
 	if (buffer_is_binary(orig->ptr, orig->size) ||
 	    buffer_is_binary(src1->ptr, src1->size) ||
@@ -73,14 +76,15 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 				       path_unused,
 				       orig, src1, name1,
 				       src2, name2,
-				       virtual_ancestor);
+				       flag);
 	}
 
 	memset(&xpp, 0, sizeof(xpp));
 	return xdl_merge(orig,
 			 src1, name1,
 			 src2, name2,
-			 &xpp, XDL_MERGE_ZEALOUS,
+			 &xpp,
+			 XDL_MERGE_FLAGS(XDL_MERGE_ZEALOUS, favor),
 			 result);
 }
 
@@ -90,11 +94,12 @@ static int ll_union_merge(const struct ll_merge_driver *drv_unused,
 			  mmfile_t *orig,
 			  mmfile_t *src1, const char *name1,
 			  mmfile_t *src2, const char *name2,
-			  int virtual_ancestor)
+			  int flag)
 {
 	char *src, *dst;
 	long size;
 	const int marker_size = 7;
+	int virtual_ancestor = flag & 01;
 
 	int status = ll_xdl_merge(drv_unused, result, path_unused,
 				  orig, src1, NULL, src2, NULL,
@@ -158,7 +163,7 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 			mmfile_t *orig,
 			mmfile_t *src1, const char *name1,
 			mmfile_t *src2, const char *name2,
-			int virtual_ancestor)
+			int flag)
 {
 	char temp[3][50];
 	char cmdbuf[2048];
@@ -362,10 +367,11 @@ int ll_merge(mmbuffer_t *result_buf,
 	     mmfile_t *ancestor,
 	     mmfile_t *ours, const char *our_label,
 	     mmfile_t *theirs, const char *their_label,
-	     int virtual_ancestor)
+	     int flag)
 {
 	const char *ll_driver_name;
 	const struct ll_merge_driver *driver;
+	int virtual_ancestor = flag & 01;
 
 	ll_driver_name = git_path_check_merge(path);
 	driver = find_ll_merge_driver(ll_driver_name);
@@ -375,5 +381,5 @@ int ll_merge(mmbuffer_t *result_buf,
 	return driver->fn(driver, result_buf, path,
 			  ancestor,
 			  ours, our_label,
-			  theirs, their_label, virtual_ancestor);
+			  theirs, their_label, flag);
 }
diff --git a/ll-merge.h b/ll-merge.h
index 5388422..5daef58 100644
--- a/ll-merge.h
+++ b/ll-merge.h
@@ -5,11 +5,13 @@
 #ifndef LL_MERGE_H
 #define LL_MERGE_H
 
+#define LL_MERGE_FLAGS(virtual_ancestor,favor) ((!!(virtual_ancestor)) | ((favor)<<1))
+
 int ll_merge(mmbuffer_t *result_buf,
 	     const char *path,
 	     mmfile_t *ancestor,
 	     mmfile_t *ours, const char *our_label,
 	     mmfile_t *theirs, const char *their_label,
-	     int virtual_ancestor);
+	     int flag);
 
 #endif
diff --git a/t/t6034-merge-ours-theirs.sh b/t/t6034-merge-ours-theirs.sh
new file mode 100755
index 0000000..56a9247
--- /dev/null
+++ b/t/t6034-merge-ours-theirs.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+
+test_description='Merge-recursive ours and theirs variants'
+. ./test-lib.sh
+
+test_expect_success setup '
+	for i in 1 2 3 4 5 6 7 8 9
+	do
+		echo "$i"
+	done >file &&
+	git add file &&
+	cp file elif &&
+	git commit -m initial &&
+
+	sed -e "s/1/one/" -e "s/9/nine/" >file <elif &&
+	git commit -a -m ours &&
+
+	git checkout -b side HEAD^ &&
+
+	sed -e "s/9/nueve/" >file <elif &&
+	git commit -a -m theirs &&
+
+	git checkout master^0
+'
+
+test_expect_success 'plain recursive - should conflict' '
+	git reset --hard master &&
+	test_must_fail git merge -s recursive side &&
+	grep nine file &&
+	grep nueve file &&
+	! grep 9 file &&
+	grep one file &&
+	! grep 1 file
+'
+
+test_expect_success 'recursive favouring theirs' '
+	git reset --hard master &&
+	git merge -s recursive-theirs side &&
+	! grep nine file &&
+	grep nueve file &&
+	! grep 9 file &&
+	grep one file &&
+	! grep 1 file
+'
+
+test_expect_success 'recursive favouring ours' '
+	git reset --hard master &&
+	git merge -s recursive-ours side &&
+	grep nine file &&
+	! grep nueve file &&
+	! grep 9 file &&
+	grep one file &&
+	! grep 1 file
+'
+
+test_done
-- 
1.5.6
