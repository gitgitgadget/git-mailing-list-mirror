X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] read-tree: further loosen "working file will be lost" check.
Date: Mon, 04 Dec 2006 17:08:42 -0800
Message-ID: <7vlklnkv39.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 01:08:53 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33278>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrOnf-00059y-NO for gcvg-git@gmane.org; Tue, 05 Dec
 2006 02:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967948AbWLEBIo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 20:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967949AbWLEBIo
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 20:08:44 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:59223 "EHLO
 fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S967948AbWLEBIn (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 20:08:43 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061205010843.IMAV4817.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Mon, 4
 Dec 2006 20:08:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id up8s1V00l1kojtg0000000; Mon, 04 Dec 2006
 20:08:53 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This follows up commit ed93b449 where we removed overcautious
"working file will be lost" check.

A new option "--ignore=.gitignore" can be used to tell the
"git-read-tree" command that the user does not mind losing
contents in untracked files in the working tree if it needs to
be overwritten by a merge (either a two-way "switch branch"
merge, or a three-way merge).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-read-tree.c         |   20 ++++++++++
 dir.c                       |    4 +-
 dir.h                       |    3 ++
 t/t1004-read-tree-m-u-wf.sh |   82 ++++++++++++++++++++++++++++++++++++++----
 unpack-trees.c              |   24 ++++++++++---
 unpack-trees.h              |    1 +
 6 files changed, 119 insertions(+), 15 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index c1867d2..37b2214 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -10,6 +10,7 @@
 #include "tree-walk.h"
 #include "cache-tree.h"
 #include "unpack-trees.h"
+#include "dir.h"
 #include "builtin.h"
 
 static struct object_list *trees;
@@ -178,6 +179,23 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			continue;
 		}
 
+		if (!strncmp(arg, "--ignore=", 9)) {
+			struct dir_struct *dir;
+
+			if (opts.dir)
+				die("more than one --ignore is given.");
+
+			dir = calloc(1, sizeof(*opts.dir));
+			dir->show_ignored = 1;
+			dir->exclude_per_dir = arg + 9;
+			opts.dir = dir;
+			/* We do not need to nor want to do read-directory
+			 * here; we are merely interested in reusing the
+			 * per directory ignore stack mechanism.
+			 */
+			continue;
+		}
+
 		/* using -u and -i at the same time makes no sense */
 		if (1 < opts.index_only + opts.update)
 			usage(read_tree_usage);
@@ -190,6 +208,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	}
 	if ((opts.update||opts.index_only) && !opts.merge)
 		usage(read_tree_usage);
+	if ((opts.dir && !opts.update))
+		die("--ignore is meaningless unless -u");
 
 	if (opts.prefix) {
 		int pfxlen = strlen(opts.prefix);
diff --git a/dir.c b/dir.c
index 96389b3..e6a61ee 100644
--- a/dir.c
+++ b/dir.c
@@ -156,7 +156,7 @@ void add_excludes_from_file(struct dir_struct *dir, const char *fname)
 		die("cannot use %s as an exclude file", fname);
 }
 
-static int push_exclude_per_directory(struct dir_struct *dir, const char *base, int baselen)
+int push_exclude_per_directory(struct dir_struct *dir, const char *base, int baselen)
 {
 	char exclude_file[PATH_MAX];
 	struct exclude_list *el = &dir->exclude_list[EXC_DIRS];
@@ -170,7 +170,7 @@ static int push_exclude_per_directory(struct dir_struct *dir, const char *base,
 	return current_nr;
 }
 
-static void pop_exclude_per_directory(struct dir_struct *dir, int stk)
+void pop_exclude_per_directory(struct dir_struct *dir, int stk)
 {
 	struct exclude_list *el = &dir->exclude_list[EXC_DIRS];
 
diff --git a/dir.h b/dir.h
index 313f8ab..550551a 100644
--- a/dir.h
+++ b/dir.h
@@ -43,6 +43,9 @@ extern int common_prefix(const char **pathspec);
 extern int match_pathspec(const char **pathspec, const char *name, int namelen, int prefix, char *seen);
 
 extern int read_directory(struct dir_struct *, const char *path, const char *base, int baselen);
+extern int push_exclude_per_directory(struct dir_struct *, const char *, int);
+extern void pop_exclude_per_directory(struct dir_struct *, int);
+
 extern int excluded(struct dir_struct *, const char *);
 extern void add_excludes_from_file(struct dir_struct *, const char *fname);
 extern void add_exclude(const char *string, const char *base,
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index 018fbea..3f6f361 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -8,23 +8,27 @@ test_description='read-tree -m -u checks working tree files'
 
 test_expect_success 'two-way setup' '
 
+	mkdir subdir &&
 	echo >file1 file one &&
 	echo >file2 file two &&
-	git update-index --add file1 file2 &&
+	echo >subdir/file1 file one in subdirectory &&
+	echo >subdir/file2 file two in subdirectory &&
+	git update-index --add file1 file2 subdir/file1 subdir/file2 &&
 	git commit -m initial &&
 
 	git branch side &&
 	git tag -f branch-point &&
 
 	echo file2 is not tracked on the master anymore &&
-	rm -f file2 &&
-	git update-index --remove file2 &&
-	git commit -a -m "master removes file2"
+	rm -f file2 subdir/file2 &&
+	git update-index --remove file2 subdir/file2 &&
+	git commit -a -m "master removes file2 and subdir/file2"
 '
 
 test_expect_success 'two-way not clobbering' '
 
 	echo >file2 master creates untracked file2 &&
+	echo >subdir/file2 master creates untracked subdir/file2 &&
 	if err=`git read-tree -m -u master side 2>&1`
 	then
 		echo should have complained
@@ -34,20 +38,82 @@ test_expect_success 'two-way not clobbering' '
 	fi
 '
 
+echo file2 >.gitignore
+
+test_expect_success 'two-way with incorrect --ignore (1)' '
+
+	if err=`git read-tree -m --ignore=.gitignore master side 2>&1`
+	then
+		echo should have complained
+		false
+	else
+		echo "happy to see $err"
+	fi
+'
+
+test_expect_success 'two-way with incorrect --ignore (2)' '
+
+	if err=`git read-tree -m -u --ignore=foo --ignore=.gitignore master side 2>&1`
+	then
+		echo should have complained
+		false
+	else
+		echo "happy to see $err"
+	fi
+'
+
+test_expect_success 'two-way clobbering a ignored file' '
+
+	git read-tree -m -u --ignore=.gitignore master side
+'
+
+rm -f .gitignore
+
 # three-tree test
 
-test_expect_success 'three-way not complaining' '
+test_expect_success 'three-way not complaining on an untracked path in both' '
 
-	rm -f file2 &&
+	rm -f file2 subdir/file2 &&
 	git checkout side &&
 	echo >file3 file three &&
-	git update-index --add file3 &&
-	git commit -a -m "side adds file3" &&
+	echo >subdir/file3 file three &&
+	git update-index --add file3 subdir/file3 &&
+	git commit -a -m "side adds file3 and removes file2" &&
 
 	git checkout master &&
 	echo >file2 file two is untracked on the master side &&
+	echo >subdir/file2 file two is untracked on the master side &&
 
 	git-read-tree -m -u branch-point master side
 '
 
+test_expect_success 'three-way not cloberring a working tree file' '
+
+	git reset --hard &&
+	rm -f file2 subdir/file2 file3 subdir/file3 &&
+	git checkout master &&
+	echo >file3 file three created in master, untracked &&
+	echo >subdir/file3 file three created in master, untracked &&
+	if err=`git read-tree -m -u branch-point master side 2>&1`
+	then
+		echo should have complained
+		false
+	else
+		echo "happy to see $err"
+	fi
+'
+
+echo >.gitignore file3
+
+test_expect_success 'three-way not complaining on an untracked file' '
+
+	git reset --hard &&
+	rm -f file2 subdir/file2 file3 subdir/file3 &&
+	git checkout master &&
+	echo >file3 file three created in master, untracked &&
+	echo >subdir/file3 file three created in master, untracked &&
+
+	git read-tree -m -u --ignore=.gitignore branch-point master side
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 7cfd628..79d21e2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1,6 +1,7 @@
 #include <signal.h>
 #include <sys/time.h>
 #include "cache.h"
+#include "dir.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "cache-tree.h"
@@ -77,6 +78,12 @@ static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 {
 	int baselen = strlen(base);
 	int src_size = len + 1;
+	int i_stk = i_stk;
+	int retval = 0;
+
+	if (o->dir)
+		i_stk = push_exclude_per_directory(o->dir, base, strlen(base));
+
 	do {
 		int i;
 		const char *first;
@@ -143,7 +150,7 @@ static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 		}
 		/* No name means we're done */
 		if (!first)
-			return 0;
+			goto leave_directory;
 
 		pathlen = strlen(first);
 		ce_size = cache_entry_size(baselen + pathlen);
@@ -240,13 +247,20 @@ static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 			newbase[baselen + pathlen] = '/';
 			newbase[baselen + pathlen + 1] = '\0';
 			if (unpack_trees_rec(subposns, len, newbase, o,
-					     indpos, df_conflict_list))
-				return -1;
+					     indpos, df_conflict_list)) {
+				retval = -1;
+				goto leave_directory;
+			}
 			free(newbase);
 		}
 		free(subposns);
 		free(src);
 	} while (1);
+
+ leave_directory:
+	if (o->dir)
+		pop_exclude_per_directory(o->dir, i_stk);
+	return retval;
 }
 
 /* Unlink the last component and attempt to remove leading
@@ -456,7 +470,7 @@ static void invalidate_ce_path(struct cache_entry *ce)
 
 /*
  * We do not want to remove or overwrite a working tree file that
- * is not tracked.
+ * is not tracked, unless it is ignored.
  */
 static void verify_absent(const char *path, const char *action,
 		struct unpack_trees_options *o)
@@ -465,7 +479,7 @@ static void verify_absent(const char *path, const char *action,
 
 	if (o->index_only || o->reset || !o->update)
 		return;
-	if (!lstat(path, &st))
+	if (!lstat(path, &st) && !(o->dir && excluded(o->dir, path)))
 		die("Untracked working tree file '%s' "
 		    "would be %s by merge.", path, action);
 }
diff --git a/unpack-trees.h b/unpack-trees.h
index c460162..191f744 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -16,6 +16,7 @@ struct unpack_trees_options {
 	int verbose_update;
 	int aggressive;
 	const char *prefix;
+	struct dir_struct *dir;
 	merge_fn_t fn;
 
 	int head_idx;
-- 
1.4.4.1.ga37e

