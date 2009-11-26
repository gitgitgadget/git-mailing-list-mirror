From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: [PATCH 3/8] git-merge-recursive-{ours,theirs}
Date: Wed, 25 Nov 2009 21:23:55 -0500
Message-ID: <7e1f1179fc5fe2f568e2c75f75366fa40d7bbbfb.1259201377.git.apenwarr@gmail.com>
References: <cover.1259201377.git.apenwarr@gmail.com> <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com> <905749faf5ccb2c7c54d3318dbc662d69daf8d0e.1259201377.git.apenwarr@gmail.com>
Cc: <gitster@pobox.com>, "Avery Pennarun" <apenwarr@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 26 03:43:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDUKO-0004ry-IP
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 03:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757451AbZKZCnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 21:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755669AbZKZCmt
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 21:42:49 -0500
Received: from mailhost.pwcorp.com ([216.13.111.70]:4746 "EHLO
	mailhost.pwcorp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727AbZKZCmf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 21:42:35 -0500
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2009 21:42:31 EST
X-Brightmail-Tracker: AAAAAgAAA+4AAAPs
thread-index: AcpuP/gxz514msgTR4OFwvJPrHh/IQ==
X-Language-Identified: TRUE
Received: from weaver.open.versabanq.com ([10.65.1.2]) by mailhost.pwcorp.com with Microsoft SMTPSVC(6.0.3790.3959); Wed, 25 Nov 2009 21:26:41 -0500
Content-Class: urn:content-classes:message
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4325
Received: (qmail 5537 invoked from network); 26 Nov 2009 02:25:38 -0000
Received: from unknown (HELO harmony.mtl.versabanq.com) (10.65.1.133)  by weaver.open.versabanq.com with SMTP; 26 Nov 2009 02:25:38 -0000
Received: by harmony.mtl.versabanq.com (sSMTP sendmail emulation); Wed, 25 Nov 2009 21:24:13 -0500
X-Mailer: git-send-email 1.6.6.rc0.62.gaccf
In-Reply-To: <905749faf5ccb2c7c54d3318dbc662d69daf8d0e.1259201377.git.apenwarr@gmail.com>
In-Reply-To: <cover.1259201377.git.apenwarr@gmail.com>
References: <cover.1259201377.git.apenwarr@gmail.com>
X-OriginalArrivalTime: 26 Nov 2009 02:26:41.0137 (UTC) FILETIME=[E371EE10:01CA6E3F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133760>

This uses the low-level mechanism for "ours" and "theirs" autoresolution
introduced by the previous commit to introduce two additional merge
strategies, merge-recursive-ours and merge-recursive-theirs.

(Patch originally by Junio Hamano <gitster@pobox.com>.)

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 .gitignore                    |    2 +
 Makefile                      |    3 ++
 builtin-checkout.c            |    2 +-
 builtin-merge-recursive.c     |    9 ++++--
 builtin-merge.c               |    4 ++-
 contrib/examples/git-merge.sh |    3 +-
 git-compat-util.h             |    1 +
 git.c                         |    2 +
 ll-merge.c                    |   20 +++++++-------
 ll-merge.h                    |    2 +-
 merge-recursive.c             |   21 ++++++++++++++-
 merge-recursive.h             |    6 +++-
 strbuf.c                      |    9 ++++++
 t/t6034-merge-ours-theirs.sh  |   56 +++++++++++++++++++++++++++++++++++++++++
 14 files changed, 120 insertions(+), 20 deletions(-)
 create mode 100755 t/t6034-merge-ours-theirs.sh

diff --git a/.gitignore b/.gitignore
index ac02a58..87467d6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -79,6 +79,8 @@
 /git-merge-one-file
 /git-merge-ours
 /git-merge-recursive
+/git-merge-recursive-ours
+/git-merge-recursive-theirs
 /git-merge-resolve
 /git-merge-subtree
 /git-mergetool
diff --git a/Makefile b/Makefile
index 5a0b3d4..f92b375 100644
--- a/Makefile
+++ b/Makefile
@@ -401,6 +401,8 @@ BUILT_INS += git-format-patch$X
 BUILT_INS += git-fsck-objects$X
 BUILT_INS += git-get-tar-commit-id$X
 BUILT_INS += git-init$X
+BUILT_INS += git-merge-recursive-ours$X
+BUILT_INS += git-merge-recursive-theirs$X
 BUILT_INS += git-merge-subtree$X
 BUILT_INS += git-peek-remote$X
 BUILT_INS += git-repo-config$X
@@ -1909,6 +1911,7 @@ check-docs::
 	do \
 		case "$$v" in \
 		git-merge-octopus | git-merge-ours | git-merge-recursive | \
+		git-merge-recursive-ours | git-merge-recursive-theirs | \
 		git-merge-resolve | git-merge-subtree | \
 		git-fsck-objects | git-init-db | \
 		git-?*--?* ) continue ;; \
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 64f3a11..b392d1b 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -167,7 +167,7 @@ static int checkout_merged(int pos, struct checkout *state)
 	fill_mm(active_cache[pos+2]->sha1, &theirs);
 
 	status = ll_merge(&result_buf, path, &ancestor,
-			  &ours, "ours", &theirs, "theirs", 1);
+			  &ours, "ours", &theirs, "theirs", 1, 0);
 	free(ancestor.ptr);
 	free(ours.ptr);
 	free(theirs.ptr);
diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 710674c..f5082da 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -27,9 +27,12 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	init_merge_options(&o);
 	if (argv[0]) {
 		int namelen = strlen(argv[0]);
-		if (8 < namelen &&
-		    !strcmp(argv[0] + namelen - 8, "-subtree"))
-			o.subtree_merge = 1;
+		if (!suffixcmp(argv[0], "-subtree"))
+			o.recursive_variant = MERGE_RECURSIVE_SUBTREE;
+		else if (!suffixcmp(argv[0], "-ours"))
+			o.recursive_variant = MERGE_RECURSIVE_OURS;
+		else if (!suffixcmp(argv[0], "-theirs"))
+			o.recursive_variant = MERGE_RECURSIVE_THEIRS;
 	}
 
 	if (argc < 4)
diff --git a/builtin-merge.c b/builtin-merge.c
index 855cf65..df089bb 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -55,6 +55,8 @@ static int verbosity;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
+	{ "recursive-ours", DEFAULT_TWOHEAD | NO_TRIVIAL },
+	{ "recursive-theirs", DEFAULT_TWOHEAD | NO_TRIVIAL },
 	{ "octopus",    DEFAULT_OCTOPUS },
 	{ "resolve",    0 },
 	{ "ours",       NO_FAST_FORWARD | NO_TRIVIAL },
@@ -563,7 +565,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 
 		init_merge_options(&o);
 		if (!strcmp(strategy, "subtree"))
-			o.subtree_merge = 1;
+			o.recursive_variant = MERGE_RECURSIVE_SUBTREE;
 
 		o.branch1 = head_arg;
 		o.branch2 = remoteheads->item->util;
diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.sh
index 500635f..8f617fc 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -31,10 +31,11 @@ LF='
 '
 
 all_strategies='recur recursive octopus resolve stupid ours subtree'
+all_strategies="$all_strategies recursive-ours recursive-theirs"
 default_twohead_strategies='recursive'
 default_octopus_strategies='octopus'
 no_fast_forward_strategies='subtree ours'
-no_trivial_strategies='recursive recur subtree ours'
+no_trivial_strategies='recursive recur subtree ours recursive-ours recursive-theirs'
 use_strategies=
 
 allow_fast_forward=t
diff --git a/git-compat-util.h b/git-compat-util.h
index 5c59687..f64cc45 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -198,6 +198,7 @@ extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)))
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
 
 extern int prefixcmp(const char *str, const char *prefix);
+extern int suffixcmp(const char *str, const char *suffix);
 extern time_t tm_to_time_t(const struct tm *tm);
 
 static inline const char *skip_prefix(const char *str, const char *prefix)
diff --git a/git.c b/git.c
index 11544cd..4735f11 100644
--- a/git.c
+++ b/git.c
@@ -332,6 +332,8 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "merge-file", cmd_merge_file },
 		{ "merge-ours", cmd_merge_ours, RUN_SETUP },
 		{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
+		{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
+		{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
 		{ "mktree", cmd_mktree, RUN_SETUP },
 		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
diff --git a/ll-merge.c b/ll-merge.c
index 2d6b6d6..cc6814f 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -18,7 +18,7 @@ typedef int (*ll_merge_fn)(const struct ll_merge_driver *,
 			   mmfile_t *orig,
 			   mmfile_t *src1, const char *name1,
 			   mmfile_t *src2, const char *name2,
-			   int virtual_ancestor);
+			   int virtual_ancestor, int favor);
 
 struct ll_merge_driver {
 	const char *name;
@@ -38,7 +38,7 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 			   mmfile_t *orig,
 			   mmfile_t *src1, const char *name1,
 			   mmfile_t *src2, const char *name2,
-			   int virtual_ancestor)
+			   int virtual_ancestor, int favor)
 {
 	/*
 	 * The tentative merge result is "ours" for the final round,
@@ -59,7 +59,7 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 			mmfile_t *orig,
 			mmfile_t *src1, const char *name1,
 			mmfile_t *src2, const char *name2,
-			int virtual_ancestor)
+			int virtual_ancestor, int favor)
 {
 	xpparam_t xpp;
 	int style = 0;
@@ -73,7 +73,7 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 				       path,
 				       orig, src1, name1,
 				       src2, name2,
-				       virtual_ancestor);
+				       virtual_ancestor, favor);
 	}
 
 	memset(&xpp, 0, sizeof(xpp));
@@ -82,7 +82,7 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 	return xdl_merge(orig,
 			 src1, name1,
 			 src2, name2,
-			 &xpp, XDL_MERGE_ZEALOUS | style,
+			 &xpp, XDL_MERGE_ZEALOUS | style | favor,
 			 result);
 }
 
@@ -92,7 +92,7 @@ static int ll_union_merge(const struct ll_merge_driver *drv_unused,
 			  mmfile_t *orig,
 			  mmfile_t *src1, const char *name1,
 			  mmfile_t *src2, const char *name2,
-			  int virtual_ancestor)
+			  int virtual_ancestor, int favor)
 {
 	char *src, *dst;
 	long size;
@@ -104,7 +104,7 @@ static int ll_union_merge(const struct ll_merge_driver *drv_unused,
 	git_xmerge_style = 0;
 	status = ll_xdl_merge(drv_unused, result, path_unused,
 			      orig, src1, NULL, src2, NULL,
-			      virtual_ancestor);
+			      virtual_ancestor, favor);
 	git_xmerge_style = saved_style;
 	if (status <= 0)
 		return status;
@@ -165,7 +165,7 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 			mmfile_t *orig,
 			mmfile_t *src1, const char *name1,
 			mmfile_t *src2, const char *name2,
-			int virtual_ancestor)
+			int virtual_ancestor, int favor)
 {
 	char temp[3][50];
 	struct strbuf cmd = STRBUF_INIT;
@@ -356,7 +356,7 @@ int ll_merge(mmbuffer_t *result_buf,
 	     mmfile_t *ancestor,
 	     mmfile_t *ours, const char *our_label,
 	     mmfile_t *theirs, const char *their_label,
-	     int virtual_ancestor)
+	     int virtual_ancestor, int favor)
 {
 	const char *ll_driver_name;
 	const struct ll_merge_driver *driver;
@@ -369,5 +369,5 @@ int ll_merge(mmbuffer_t *result_buf,
 	return driver->fn(driver, result_buf, path,
 			  ancestor,
 			  ours, our_label,
-			  theirs, their_label, virtual_ancestor);
+			  theirs, their_label, virtual_ancestor, favor);
 }
diff --git a/ll-merge.h b/ll-merge.h
index 5388422..2c94fdb 100644
--- a/ll-merge.h
+++ b/ll-merge.h
@@ -10,6 +10,6 @@ int ll_merge(mmbuffer_t *result_buf,
 	     mmfile_t *ancestor,
 	     mmfile_t *ours, const char *our_label,
 	     mmfile_t *theirs, const char *their_label,
-	     int virtual_ancestor);
+	     int virtual_ancestor, int favor);
 
 #endif
diff --git a/merge-recursive.c b/merge-recursive.c
index a91208f..257bf8f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -642,6 +642,23 @@ static int merge_3way(struct merge_options *o,
 	mmfile_t orig, src1, src2;
 	char *name1, *name2;
 	int merge_status;
+	int favor;
+	
+	if (o->call_depth)
+        	favor = 0;
+	else {
+		switch (o->recursive_variant) {
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
 
 	if (strcmp(a->path, b->path)) {
 		name1 = xstrdup(mkpath("%s:%s", branch1, a->path));
@@ -657,7 +674,7 @@ static int merge_3way(struct merge_options *o,
 
 	merge_status = ll_merge(result_buf, a->path, &orig,
 				&src1, name1, &src2, name2,
-				o->call_depth);
+				o->call_depth, favor);
 
 	free(name1);
 	free(name2);
@@ -1196,7 +1213,7 @@ int merge_trees(struct merge_options *o,
 {
 	int code, clean;
 
-	if (o->subtree_merge) {
+	if (o->recursive_variant == MERGE_RECURSIVE_SUBTREE) {
 		merge = shift_tree_object(head, merge);
 		common = shift_tree_object(head, common);
 	}
diff --git a/merge-recursive.h b/merge-recursive.h
index fd138ca..9d54219 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -6,7 +6,11 @@
 struct merge_options {
 	const char *branch1;
 	const char *branch2;
-	unsigned subtree_merge : 1;
+	enum {
+        	MERGE_RECURSIVE_SUBTREE = 1,
+        	MERGE_RECURSIVE_OURS,
+        	MERGE_RECURSIVE_THEIRS,
+	} recursive_variant;
 	unsigned buffer_output : 1;
 	int verbosity;
 	int diff_rename_limit;
diff --git a/strbuf.c b/strbuf.c
index a6153dc..d71a623 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -10,6 +10,15 @@ int prefixcmp(const char *str, const char *prefix)
 			return (unsigned char)*prefix - (unsigned char)*str;
 }
 
+int suffixcmp(const char *str, const char *suffix)
+{
+	int len = strlen(str), suflen = strlen(suffix);
+	if (len < suflen)
+		return -1;
+	else
+		return strcmp(str + len - suflen, suffix);
+}
+
 /*
  * Used as the default ->buf value, so that people can always assume
  * buf is non NULL and ->buf is NUL terminated even for a freshly
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
1.6.6.rc0.62.gaccf
