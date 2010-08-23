From: Justin Frankel <justin@cockos.com>
Subject: [PATCH v2] git-merge: ignore space support
Date: Mon, 23 Aug 2010 13:59:15 -0700
Message-ID: <20100823205915.GA4484@ns1.cockos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jrnieder@gmail.com, eyvind.bernhardsen@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 23 22:59:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1One7D-0001Tq-FK
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 22:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489Ab0HWU70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 16:59:26 -0400
Received: from ns1.cockos.com ([204.11.104.229]:54469 "EHLO ns1.blorp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752697Ab0HWU7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 16:59:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by ns1.blorp.com (Postfix) with ESMTP id 9450A1259C06;
	Mon, 23 Aug 2010 13:59:19 -0700 (PDT)
Received: from ns1.blorp.com ([127.0.0.1])
	by localhost (ns1.cockos.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rhqX-F3lXphK; Mon, 23 Aug 2010 13:59:15 -0700 (PDT)
Received: by ns1.blorp.com (Postfix, from userid 1000)
	id 66B8C1259C07; Mon, 23 Aug 2010 13:59:15 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.3i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154257>

git-merge and git-rebase can now be passed -Xignore-space-at-eol,
-Xignore-space-change, -Xignore-all-space, -Xpatience options.

This is for the next/ branch (as the ll-merge flag interface has been
cleaned up). This version of the patch is signed-off and passes git diff 
--check. 

Signed-off-by: Justin Frankel <justin@cockos.com>
---
 builtin/merge-recursive.c |    9 +++++++++
 builtin/merge.c           |    9 +++++++++
 ll-merge.c                |    1 +
 ll-merge.h                |   15 ++++++++++++++-
 merge-recursive.c         |    2 +-
 merge-recursive.h         |    1 +
 6 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index c2d4677..7cbc913 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -2,6 +2,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "merge-recursive.h"
+#include "xdiff-interface.h"
 
 static const char *better_branch_name(const char *branch)
 {
@@ -49,6 +50,14 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 				o.renormalize = 1;
 			else if (!strcmp(arg+2, "no-renormalize"))
 				o.renormalize = 0;
+			else if (!strcmp(arg+2, "ignore-all-space"))
+				o.xdl_opts |= XDF_IGNORE_WHITESPACE;
+			else if (!strcmp(arg+2, "ignore-space-change"))
+				o.xdl_opts |= XDF_IGNORE_WHITESPACE_CHANGE;
+			else if (!strcmp(arg+2, "ignore-space-at-eol"))
+				o.xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;
+			else if (!strcmp(arg+2, "patience"))
+				o.xdl_opts |= XDF_PATIENCE_DIFF;
 			else
 				die("Unknown option %s", arg);
 			continue;
diff --git a/builtin/merge.c b/builtin/merge.c
index 4e4ec89..3fe5dc7 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -25,6 +25,7 @@
 #include "help.h"
 #include "merge-recursive.h"
 #include "resolve-undo.h"
+#include "xdiff-interface.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -647,6 +648,14 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 				o.renormalize = 1;
 			else if (!strcmp(xopts[x], "no-renormalize"))
 				o.renormalize = 0;
+			else if (!strcmp(xopts[x], "ignore-all-space"))
+				o.xdl_opts |= XDF_IGNORE_WHITESPACE;
+			else if (!strcmp(xopts[x], "ignore-space-change"))
+				o.xdl_opts |= XDF_IGNORE_WHITESPACE_CHANGE;
+			else if (!strcmp(xopts[x], "ignore-space-at-eol"))
+				o.xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;
+			else if (!strcmp(xopts[x], "patience"))
+				o.xdl_opts |= XDF_PATIENCE_DIFF;
 			else
 				die("Unknown option for merge-recursive: -X%s", xopts[x]);
 		}
diff --git a/ll-merge.c b/ll-merge.c
index 6bb3095..8a0a076 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -80,6 +80,7 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 	memset(&xmp, 0, sizeof(xmp));
 	xmp.level = XDL_MERGE_ZEALOUS;
 	xmp.favor = ll_opt_favor(flag);
+	xmp.xpp.flags = ll_opt_xdl_opt(flag);
 	if (git_xmerge_style >= 0)
 		xmp.style = git_xmerge_style;
 	if (marker_size > 0)
diff --git a/ll-merge.h b/ll-merge.h
index ff7ca87..cf2d7b9 100644
--- a/ll-merge.h
+++ b/ll-merge.h
@@ -7,19 +7,32 @@
 
 #define LL_OPT_VIRTUAL_ANCESTOR	(1 << 0)
 #define LL_OPT_FAVOR_MASK	((1 << 1) | (1 << 2))
-#define LL_OPT_FAVOR_SHIFT 1
+#define LL_OPT_FAVOR_SHIFT 	1
 #define LL_OPT_RENORMALIZE	(1 << 3)
+#define LL_OPT_XDL_MASK 	(0x3F << 4)
+#define LL_OPT_XDL_SHIFT 	4
 
 static inline int ll_opt_favor(int flag)
 {
 	return (flag & LL_OPT_FAVOR_MASK) >> LL_OPT_FAVOR_SHIFT;
 }
 
+static inline int ll_opt_xdl_opt(int flag)
+{
+	return ((flag & LL_OPT_XDL_MASK) >> LL_OPT_XDL_SHIFT);
+}
+
 static inline int create_ll_flag(int favor)
 {
 	return ((favor << LL_OPT_FAVOR_SHIFT) & LL_OPT_FAVOR_MASK);
 }
 
+static inline int create_ll_flag_xdl_opt(int favor, int xdl_opt)
+{
+	return ((favor << LL_OPT_FAVOR_SHIFT) & LL_OPT_FAVOR_MASK) |
+		((xdl_opt << LL_OPT_XDL_SHIFT) & LL_OPT_XDL_MASK);
+}
+
 int ll_merge(mmbuffer_t *result_buf,
 	     const char *path,
 	     mmfile_t *ancestor, const char *ancestor_label,
diff --git a/merge-recursive.c b/merge-recursive.c
index aadd48c..506c9db 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -646,7 +646,7 @@ static int merge_3way(struct merge_options *o,
 				&src1, name1, &src2, name2,
 				((o->call_depth ? LL_OPT_VIRTUAL_ANCESTOR : 0) |
 				 (o->renormalize ? LL_OPT_RENORMALIZE : 0) |
-				 create_ll_flag(favor)));
+				 create_ll_flag_xdl_opt(favor,o->xdl_opts)));
 
 	free(name1);
 	free(name2);
diff --git a/merge-recursive.h b/merge-recursive.h
index 196f053..47f718f 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -13,6 +13,7 @@ struct merge_options {
 		MERGE_RECURSIVE_THEIRS
 	} recursive_variant;
 	const char *subtree_shift;
+	int xdl_opts;
 	unsigned buffer_output : 1;
 	unsigned renormalize : 1;
 	int verbosity;
-- 
1.7.0.2.msysgit.0
