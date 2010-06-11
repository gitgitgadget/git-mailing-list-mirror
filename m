From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [WIP PATCH 3/3] implement automatic fast forward merge for submodules
Date: Fri, 11 Jun 2010 14:23:33 +0200
Message-ID: <20859813382fcffe61d783fe561fae65998c1603.1276059473.git.hvoigt@hvoigt.net>
References: <cover.1276059473.git.hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 11 14:30:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON3Nj-0005Np-SG
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 14:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760208Ab0FKMaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 08:30:18 -0400
Received: from darksea.de ([83.133.111.250]:56929 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754789Ab0FKMaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 08:30:16 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jun 2010 08:30:16 EDT
Received: (qmail 1402 invoked from network); 11 Jun 2010 14:23:34 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 11 Jun 2010 14:23:34 +0200
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1276059473.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1276059473.git.hvoigt@hvoigt.net>
References: <cover.1276059473.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148943>

This implements a simple merge strategy for submodule hashes. We look
whether a single ref that contains both hashes exist. In case it does
and the changes on both sides point forward in the direction of that
ref we return the refs revision as the merge result.

It is useful for a workflow in which the developers can publish topic
branches in submodules. Once the topic branch has been merged
into a stable branch the developer can simply merge his branch
in the main repository even when other developers have merged their
submodule changes before them.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 merge-recursive.c          |    9 ++-
 submodule.c                |  121 ++++++++++++++++++++++++++++++++++++++++++++
 submodule.h                |    2 +
 t/t7405-submodule-merge.sh |  115 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 238 insertions(+), 9 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 206c103..a032a8b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -20,6 +20,7 @@
 #include "attr.h"
 #include "merge-recursive.h"
 #include "dir.h"
+#include "submodule.h"
 
 static struct tree *shift_tree_object(struct tree *one, struct tree *two,
 				      const char *subtree_shift)
@@ -525,13 +526,15 @@ static void update_file_flags(struct merge_options *o,
 		void *buf;
 		unsigned long size;
 
-		if (S_ISGITLINK(mode))
+		if (S_ISGITLINK(mode)) {
 			/*
 			 * We may later decide to recursively descend into
 			 * the submodule directory and update its index
 			 * and/or work tree, but we do not do that now.
 			 */
+			update_wd = 0;
 			goto update_index;
+		}
 
 		buf = read_sha1_file(sha, &type, &size);
 		if (!buf)
@@ -716,8 +719,8 @@ static struct merge_file_info merge_file(struct merge_options *o,
 			free(result_buf.ptr);
 			result.clean = (merge_status == 0);
 		} else if (S_ISGITLINK(a->mode)) {
-			result.clean = 0;
-			hashcpy(result.sha, a->sha1);
+			result.clean = merge_submodule(result.sha, one->path, one->sha1,
+						       a->sha1, b->sha1);
 		} else if (S_ISLNK(a->mode)) {
 			hashcpy(result.sha, a->sha1);
 
diff --git a/submodule.c b/submodule.c
index 676d48f..5b0313f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -6,6 +6,7 @@
 #include "revision.h"
 #include "run-command.h"
 #include "diffcore.h"
+#include "refs.h"
 
 static int add_submodule_odb(const char *path)
 {
@@ -205,3 +206,123 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	strbuf_release(&buf);
 	return dirty_submodule;
 }
+
+struct parent_data {
+	struct rev_info common_parents;
+	struct commit *a;
+	struct commit *b;
+};
+
+static int add_common_parents(const char *refname, const unsigned char *sha1,
+			     int flags, void *cb_data)
+{
+	struct parent_data *args = (struct parent_data *) cb_data;
+	struct commit *commit;
+
+	commit = lookup_commit_reference_gently(sha1, 1);
+	if (!commit)
+		return error("branch '%s' does not point at a commit", refname);
+
+	if (!in_merge_bases(args->a, &commit, 1))
+		return 0;
+	if (!in_merge_bases(args->b, &commit, 1))
+		return 0;
+
+	add_pending_object(&args->common_parents,
+			(struct object *)commit, refname);
+
+	return 0;
+}
+
+static int find_common_parent(unsigned char result[20], const char *path,
+			      struct commit *a, struct commit *b)
+{
+	struct parent_data parent_args;
+	struct commit *commit;
+	unsigned char sha1[20];
+	int i, ret = 0;
+	static const char *format = " %h: %m %s";
+	struct strbuf sb = STRBUF_INIT;
+
+	/* search for parent revs of a and b */
+	init_revisions(&parent_args.common_parents, NULL);
+	parent_args.common_parents.no_walk = 1;
+	parent_args.a = a;
+	parent_args.b = b;
+	for_each_rawref_submodule(path, add_common_parents, &parent_args);
+
+	if (prepare_revision_walk(&parent_args.common_parents))
+		return 0;
+
+	i = 0;
+	while ((commit = get_revision(&parent_args.common_parents))) {
+		struct pretty_print_context ctx = {0};
+		ctx.date_mode = parent_args.common_parents.date_mode;
+		format_commit_message(commit, format, &sb, &ctx);
+		strbuf_addstr(&sb, "\n");
+		if (i == 0)
+			hashcpy(sha1, commit->object.sha1);
+		i++;
+	}
+
+	/* we found exactly one revision */
+	if (i == 1) {
+		hashcpy(result, sha1);
+		ret = 1;
+		goto finish;
+	}
+
+	warning("Found multiple possible merge resolutions for submodule '%s':", path);
+	fprintf(stderr, "%s", sb.buf);
+
+finish:
+	strbuf_release(&sb);
+	return ret;
+}
+
+int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
+		    const unsigned char a[20], const unsigned char b[20])
+{
+	struct commit *commit_base, *commit_a, *commit_b;
+	int parent_exists;
+
+	/* store a in result in case we fail */
+	hashcpy(result, a);
+
+	/* we can not handle deletion conflicts */
+	if (is_null_sha1(base))
+		return 0;
+	if (is_null_sha1(a))
+		return 0;
+	if (is_null_sha1(b))
+		return 0;
+
+	if (add_submodule_odb(path)) {
+		warning("Failed to merge submodule %s (not checked out)", path);
+		return 0;
+	}
+
+	if (!(commit_base = lookup_commit_reference(base)) ||
+	    !(commit_a = lookup_commit_reference(a)) ||
+	    !(commit_b = lookup_commit_reference(b)))
+	{
+		warning("Failed to merge submodule %s (commits not present)", path);
+		return 0;
+	}
+
+	/* are both changes forward */
+	if (!in_merge_bases(commit_base, &commit_a, 1) ||
+	    !in_merge_bases(commit_base, &commit_b, 1))
+	{
+		warning("Submodule rewound can not merge");
+		return 0;
+	}
+
+	/* find commit which merges them */
+	parent_exists = find_common_parent(result, path, commit_a, commit_b);
+	if (!parent_exists) {
+		warning("Failed to merge submodule %s (merge not found)", path);
+		return 0;
+	}
+	return 1;
+}
diff --git a/submodule.h b/submodule.h
index dbda270..b75a704 100644
--- a/submodule.h
+++ b/submodule.h
@@ -6,5 +6,7 @@ void show_submodule_summary(FILE *f, const char *path,
 		unsigned dirty_submodule,
 		const char *del, const char *add, const char *reset);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
+int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
+		    const unsigned char a[20], const unsigned char b[20]);
 
 #endif
diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 4a7b893..04dc371 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -54,13 +54,116 @@ test_expect_success setup '
 	git merge -s ours a
 '
 
-test_expect_success 'merging with modify/modify conflict' '
+# History setup
+#
+#      b
+#    /   \
+#   a     d
+#    \   /
+#      c
+#
+# a in the main repository records to sub-a in the submodule and
+# analogous b and c. d should be automatically found by merging c into
+# b in the main repository.
+test_expect_success 'setup for merge search' '
+	mkdir merge-search &&
+	cd merge-search &&
+	git init &&
+	mkdir sub &&
+	(cd sub &&
+	 git init &&
+	 echo "file-a" > file-a &&
+	 git add file-a &&
+	 git commit -m "sub-a" &&
+	 git checkout -b sub-a) &&
+	git add sub &&
+	git commit -m "a" &&
+	git checkout -b a &&
+
+	git checkout -b b &&
+	(cd sub &&
+	 git checkout -b sub-b &&
+	 echo "file-b" > file-b &&
+	 git add file-b &&
+	 git commit -m "sub-b") &&
+	git commit -a -m "b" &&
+
+	git checkout -b c a &&
+	(cd sub &&
+	 git checkout -b sub-c sub-a &&
+	 echo "file-c" > file-c &&
+	 git add file-c &&
+	 git commit -m "sub-c") &&
+	git commit -a -m "c" &&
+
+	(cd sub &&
+	 git checkout -b sub-d sub-b &&
+	 git merge sub-c &&
+	 git checkout sub-b) &&
+	git checkout -b test b &&
+	cd ..
+'
+
+test_expect_success 'merging with common parent search' '
+	cd merge-search &&
+	git checkout -b test-parent b &&
+	git merge c &&
+	git ls-tree test-parent | grep sub | cut -f1 | cut -f3 -d" " > actual &&
+	(cd sub &&
+	 git rev-parse sub-d > ../expect) &&
+	test_cmp actual expect &&
+	cd ..
+'
+
+test_expect_success 'merging should fail for ambigous common parent' '
+	cd merge-search &&
+	git checkout -b test-ambigous b &&
+	(cd sub &&
+	 git checkout -b ambigous sub-d &&
+	 echo "ambigous-file" > ambigous-file &&
+	 git add ambigous-file &&
+	 git commit -m "ambigous") &&
+	test_must_fail git merge c &&
+	git reset --hard &&
+	cd ..
+'
+
+# in a situation like this
+#
+# submodule tree:
+#
+#    sub-a --- sub-b --- sub-d
+#
+# main tree:
+#
+#    e (sub-a)
+#   /
+#  d (sub-b)
+#   \
+#    f (sub-d)
+#
+# A merge should fail because one change points backwards.
+
+test_expect_success 'merging should fail for changes that are backwards' '
+	cd merge-search &&
+	git checkout -b d a &&
+	(cd sub &&
+	 git checkout sub-b) &&
+	git commit -a -m "d" &&
+
+	git checkout -b e d &&
+	(cd sub &&
+	 git checkout sub-a) &&
+	git commit -a -m "e" &&
+
+	git checkout -b f d &&
+	(cd sub &&
+	 git checkout sub-d) &&
+	git commit -a -m "f" &&
 
-	git checkout -b test1 a &&
-	test_must_fail git merge b &&
-	test -f .git/MERGE_MSG &&
-	git diff &&
-	test -n "$(git ls-files -u)"
+	git checkout -b test-backward e &&
+	test_must_fail git merge f &&
+	cd ..
 '
 
 test_expect_success 'merging with a modify/modify conflict between merge bases' '
-- 
1.7.1
