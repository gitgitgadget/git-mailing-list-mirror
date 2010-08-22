From: Justin Frankel <justin@cockos.com>
Subject: [PATCH 1/2] git-merge: ignore space support
Date: Sat, 21 Aug 2010 22:45:10 -0700
Message-ID: <20100822054510.GB64856@ns1.cockos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 22 07:52:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1On3To-0000a0-Bz
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 07:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab0HVFwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 01:52:22 -0400
Received: from ns1.cockos.com ([204.11.104.229]:65435 "EHLO ns1.blorp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283Ab0HVFwV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 01:52:21 -0400
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Aug 2010 01:52:21 EDT
Received: from localhost (localhost [127.0.0.1])
	by ns1.blorp.com (Postfix) with ESMTP id 9D1E81259C06
	for <git@vger.kernel.org>; Sat, 21 Aug 2010 22:45:14 -0700 (PDT)
Received: from ns1.blorp.com ([127.0.0.1])
	by localhost (ns1.cockos.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oxfSC5DGSmuL for <git@vger.kernel.org>;
	Sat, 21 Aug 2010 22:45:10 -0700 (PDT)
Received: by ns1.blorp.com (Postfix, from userid 1000)
	id 879B31259C07; Sat, 21 Aug 2010 22:45:10 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.3i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154166>


---
 builtin/merge-recursive.c |    9 +++++++++
 builtin/merge.c           |    9 +++++++++
 ll-merge.c                |    3 ++-
 merge-recursive.c         |    2 +-
 merge-recursive.h         |    1 +
 5 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index d8875d5..0f0cd6a 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -2,6 +2,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "merge-recursive.h"
+#include "xdiff-interface.h"
 
 static const char *better_branch_name(const char *branch)
 {
@@ -45,6 +46,14 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 				o.subtree_shift = "";
 			else if (!prefixcmp(arg+2, "subtree="))
 				o.subtree_shift = arg + 10;
+                        else if (!strcmp(arg+2, "ignore-all-space"))
+                                o.xdl_opts |= XDF_IGNORE_WHITESPACE;
+                        else if (!strcmp(arg+2, "ignore-space-change"))
+                                o.xdl_opts |= XDF_IGNORE_WHITESPACE_CHANGE;
+                        else if (!strcmp(arg+2, "ignore-space-at-eol"))
+                                o.xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;
+                        else if (!strcmp(arg+2, "patience"))
+                                o.xdl_opts |= XDF_PATIENCE_DIFF;
 			else
 				die("Unknown option %s", arg);
 			continue;
diff --git a/builtin/merge.c b/builtin/merge.c
index 37ce4f5..00580f3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -25,6 +25,7 @@
 #include "help.h"
 #include "merge-recursive.h"
 #include "resolve-undo.h"
+#include "xdiff-interface.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -633,6 +634,14 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 				o.subtree_shift = "";
 			else if (!prefixcmp(xopts[x], "subtree="))
 				o.subtree_shift = xopts[x]+8;
+		        else if (!strcmp(xopts[x], "ignore-all-space"))
+		                o.xdl_opts |= XDF_IGNORE_WHITESPACE;
+		        else if (!strcmp(xopts[x], "ignore-space-change"))
+		                o.xdl_opts |= XDF_IGNORE_WHITESPACE_CHANGE;
+		        else if (!strcmp(xopts[x], "ignore-space-at-eol"))
+		                o.xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;
+		        else if (!strcmp(xopts[x], "patience"))
+		                o.xdl_opts |= XDF_PATIENCE_DIFF;
 			else
 				die("Unknown option for merge-recursive: -X%s", xopts[x]);
 		}
diff --git a/ll-merge.c b/ll-merge.c
index 3764a1a..1d09eab 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -87,6 +87,7 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 	xmp.ancestor = orig_name;
 	xmp.file1 = name1;
 	xmp.file2 = name2;
+        xmp.xpp.flags = (flag >> 4) & 0x3f;
 	return xdl_merge(orig, src1, src2, &xmp, result);
 }
 
@@ -99,7 +100,7 @@ static int ll_union_merge(const struct ll_merge_driver *drv_unused,
 			  int flag, int marker_size)
 {
 	/* Use union favor */
-	flag = (flag & 1) | (XDL_MERGE_FAVOR_UNION << 1);
+	flag = (flag & ~0xE) | (XDL_MERGE_FAVOR_UNION << 1);
 	return ll_xdl_merge(drv_unused, result, path_unused,
 			    orig, NULL, src1, NULL, src2, NULL,
 			    flag, marker_size);
diff --git a/merge-recursive.c b/merge-recursive.c
index 6cff9cd..c6f6d1d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -641,7 +641,7 @@ static int merge_3way(struct merge_options *o,
 
 	merge_status = ll_merge(result_buf, a->path, &orig, base_name,
 				&src1, name1, &src2, name2,
-				(!!o->call_depth) | (favor << 1));
+				(!!o->call_depth) | (favor << 1) | (o->xdl_opts << 4));
 
 	free(name1);
 	free(name2);
diff --git a/merge-recursive.h b/merge-recursive.h
index b831293..633ec29 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -13,6 +13,7 @@ struct merge_options {
 		MERGE_RECURSIVE_THEIRS
 	} recursive_variant;
 	const char *subtree_shift;
+        int xdl_opts;
 	unsigned buffer_output : 1;
 	int verbosity;
 	int diff_rename_limit;
-- 
1.7.2.2.333.gec5bc.dirty
