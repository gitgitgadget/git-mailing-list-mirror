From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 6/9] Build-in merge-recursive
Date: Mon, 4 Feb 2008 13:35:59 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802041335220.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 19:36:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM6BV-0006Qr-AG
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 19:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573AbYBDSgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 13:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754533AbYBDSgD
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 13:36:03 -0500
Received: from iabervon.org ([66.92.72.58]:51154 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754386AbYBDSgB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 13:36:01 -0500
Received: (qmail 7582 invoked by uid 1000); 4 Feb 2008 18:35:59 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Feb 2008 18:35:59 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72544>

This makes write_tree_from_memory(), which writes the active cache as
a tree and returns the struct tree for it, available to other code. It
also makes available merge_trees(), which does the internal merge of
two trees with a known base, and merge_recursive(), which does the
recursive internal merge of two commits with a list of common
ancestors.

The first two of these will be used by checkout -m, and the third is
presumably useful in general, although the implementation of checkout
-m which entirely matches the behavior of the shell version does not
use it (since it ignores the difference of ancestry between the old
branch and the new branch).

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Makefile                                       |    2 +-
 merge-recursive.c => builtin-merge-recursive.c |   44 ++++++++++++-----------
 builtin.h                                      |    1 +
 git.c                                          |    1 +
 merge-recursive.h                              |   20 +++++++++++
 5 files changed, 46 insertions(+), 22 deletions(-)
 rename merge-recursive.c => builtin-merge-recursive.c (98%)
 create mode 100644 merge-recursive.h

diff --git a/Makefile b/Makefile
index 91a460f..85ec1c6 100644
--- a/Makefile
+++ b/Makefile
@@ -258,7 +258,6 @@ PROGRAMS = \
 	git-upload-pack$X \
 	git-pack-redundant$X git-var$X \
 	git-merge-tree$X git-imap-send$X \
-	git-merge-recursive$X \
 	$(EXTRA_PROGRAMS)
 
 # Empty...
@@ -362,6 +361,7 @@ BUILTIN_OBJS = \
 	builtin-merge-base.o \
 	builtin-merge-file.o \
 	builtin-merge-ours.o \
+	builtin-merge-recursive.o \
 	builtin-mv.o \
 	builtin-name-rev.o \
 	builtin-pack-objects.o \
diff --git a/merge-recursive.c b/builtin-merge-recursive.c
similarity index 98%
rename from merge-recursive.c
rename to builtin-merge-recursive.c
index bdf03b1..45d4601 100644
--- a/merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -7,6 +7,7 @@
 #include "cache-tree.h"
 #include "commit.h"
 #include "blob.h"
+#include "builtin.h"
 #include "tree-walk.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -17,6 +18,7 @@
 #include "xdiff-interface.h"
 #include "interpolate.h"
 #include "attr.h"
+#include "merge-recursive.h"
 
 static int subtree_merge;
 
@@ -232,7 +234,7 @@ static int unmerged_index(void)
 	return 0;
 }
 
-static struct tree *git_write_tree(void)
+struct tree *write_tree_from_memory(void)
 {
 	struct tree *result = NULL;
 
@@ -1495,12 +1497,12 @@ static int process_entry(const char *path, struct stage_data *entry,
 	return clean_merge;
 }
 
-static int merge_trees(struct tree *head,
-		       struct tree *merge,
-		       struct tree *common,
-		       const char *branch1,
-		       const char *branch2,
-		       struct tree **result)
+int merge_trees(struct tree *head,
+		struct tree *merge,
+		struct tree *common,
+		const char *branch1,
+		const char *branch2,
+		struct tree **result)
 {
 	int code, clean;
 
@@ -1552,7 +1554,7 @@ static int merge_trees(struct tree *head,
 		clean = 1;
 
 	if (index_only)
-		*result = git_write_tree();
+		*result = write_tree_from_memory();
 
 	return clean;
 }
@@ -1572,12 +1574,12 @@ static struct commit_list *reverse_commit_list(struct commit_list *list)
  * Merge the commits h1 and h2, return the resulting virtual
  * commit object and a flag indicating the cleanness of the merge.
  */
-static int merge(struct commit *h1,
-		 struct commit *h2,
-		 const char *branch1,
-		 const char *branch2,
-		 struct commit_list *ca,
-		 struct commit **result)
+int merge_recursive(struct commit *h1,
+		    struct commit *h2,
+		    const char *branch1,
+		    const char *branch2,
+		    struct commit_list *ca,
+		    struct commit **result)
 {
 	struct commit_list *iter;
 	struct commit *merged_common_ancestors;
@@ -1622,11 +1624,11 @@ static int merge(struct commit *h1,
 		 * "conflicts" were already resolved.
 		 */
 		discard_cache();
-		merge(merged_common_ancestors, iter->item,
-		      "Temporary merge branch 1",
-		      "Temporary merge branch 2",
-		      NULL,
-		      &merged_common_ancestors);
+		merge_recursive(merged_common_ancestors, iter->item,
+				"Temporary merge branch 1",
+				"Temporary merge branch 2",
+				NULL,
+				&merged_common_ancestors);
 		call_depth--;
 
 		if (!merged_common_ancestors)
@@ -1695,7 +1697,7 @@ static int merge_config(const char *var, const char *value)
 	return git_default_config(var, value);
 }
 
-int main(int argc, char *argv[])
+int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 {
 	static const char *bases[20];
 	static unsigned bases_count = 0;
@@ -1749,7 +1751,7 @@ int main(int argc, char *argv[])
 		struct commit *ancestor = get_ref(bases[i]);
 		ca = commit_list_insert(ancestor, &ca);
 	}
-	clean = merge(h1, h2, branch1, branch2, ca, &result);
+	clean = merge_recursive(h1, h2, branch1, branch2, ca, &result);
 
 	if (active_cache_changed &&
 	    (write_cache(index_fd, active_cache, active_nr) ||
diff --git a/builtin.h b/builtin.h
index cb675c4..428160d 100644
--- a/builtin.h
+++ b/builtin.h
@@ -57,6 +57,7 @@ extern int cmd_mailsplit(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_base(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
+extern int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index c8b7e74..57c9712 100644
--- a/git.c
+++ b/git.c
@@ -339,6 +339,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "merge-base", cmd_merge_base, RUN_SETUP },
 		{ "merge-file", cmd_merge_file },
 		{ "merge-ours", cmd_merge_ours, RUN_SETUP },
+		{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
 		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
diff --git a/merge-recursive.h b/merge-recursive.h
new file mode 100644
index 0000000..f37630a
--- /dev/null
+++ b/merge-recursive.h
@@ -0,0 +1,20 @@
+#ifndef MERGE_RECURSIVE_H
+#define MERGE_RECURSIVE_H
+
+int merge_recursive(struct commit *h1,
+		    struct commit *h2,
+		    const char *branch1,
+		    const char *branch2,
+		    struct commit_list *ancestors,
+		    struct commit **result);
+
+int merge_trees(struct tree *head,
+		struct tree *merge,
+		struct tree *common,
+		const char *branch1,
+		const char *branch2,
+		struct tree **result);
+
+struct tree *write_tree_from_memory(void);
+
+#endif
-- 
1.5.4
