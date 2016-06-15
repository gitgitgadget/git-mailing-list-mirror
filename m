From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v3 4/4] implement automatic fast-forward merge for submodules
Date: Wed,  7 Jul 2010 15:39:13 +0200
Message-ID: <3cff3f0b6b859180556ab5ef5345179e603609a9.1278508352.git.hvoigt@hvoigt.net>
References: <cover.1278508352.git.hvoigt@hvoigt.net>
Cc: git@vger.kernel.org, jens.lehmann@web.de, jherland@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 07 15:39:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWUqR-0007sH-QG
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 15:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891Ab0GGNjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 09:39:19 -0400
Received: from darksea.de ([83.133.111.250]:52780 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754312Ab0GGNjR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 09:39:17 -0400
Received: (qmail 17329 invoked from network); 7 Jul 2010 15:39:15 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 7 Jul 2010 15:39:15 +0200
X-Mailer: git-send-email 1.7.2.rc1.13.g513fa.dirty
In-Reply-To: <cover.1278508352.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1278508352.git.hvoigt@hvoigt.net>
References: <cover.1278508352.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150474>

This implements a simple merge strategy for submodule hashes. We check
whether one side of the merge candidates is already contained in the
other and then merge automatically.

If both sides contain changes we search for a merge in the submodule.
In case a single one exists we check that out and suggest it as the
merge resolution. A list of candidates is returned when we find multiple
merges that contain both sides of the changes.

This is useful for a workflow in which the developers can publish topic
branches in submodules and a separate maintainer merges them. In case
the developers always wait until their branch gets merged before tracking
them in the superproject all merges of branches that contain submodule
changes will be resolved automatically. If developers choose to track
their feature branch the maintainer might get a conflict but git will
search the submodule for a merge and suggest it/them as a resolution.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 merge-recursive.c          |    9 ++-
 submodule.c                |  162 ++++++++++++++++++++++++++++++++++++++++++++
 submodule.h                |    2 +
 t/t7405-submodule-merge.sh |  128 +++++++++++++++++++++++++++++++++--
 4 files changed, 292 insertions(+), 9 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 856e98c..4dcf417 100644
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
index 61cb6e2..9bc4b80 100644
--- a/submodule.c
+++ b/submodule.c
@@ -6,6 +6,7 @@
 #include "revision.h"
 #include "run-command.h"
 #include "diffcore.h"
+#include "refs.h"
 
 static int add_submodule_odb(const char *path)
 {
@@ -218,3 +219,164 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	strbuf_release(&buf);
 	return dirty_submodule;
 }
+
+static int find_first_merges(struct object_array *result, const char *path,
+		struct commit *a, struct commit *b)
+{
+	int i, j;
+	struct object_array merges;
+	struct commit *commit;
+	int contains_another;
+
+	char merged_revision[42];
+	const char *rev_args[] = { "rev-list", "--merges", "--ancestry-path",
+				   "--all", merged_revision, NULL };
+	struct rev_info revs;
+	struct setup_revision_opt rev_opts;
+
+	memset(&merges, 0, sizeof(merges));
+	memset(result, 0, sizeof(struct object_array));
+	memset(&rev_opts, 0, sizeof(rev_opts));
+
+	/* get all revisions that merge commit a */
+	snprintf(merged_revision, sizeof(merged_revision), "^%s",
+			sha1_to_hex(a->object.sha1));
+	init_revisions(&revs, NULL);
+	rev_opts.submodule = path;
+	setup_revisions(sizeof(rev_args)/sizeof(char *)-1, rev_args, &revs, &rev_opts);
+
+	/* save all revisions from the above list that contain b */
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
+	while ((commit = get_revision(&revs)) != NULL) {
+		struct object *o = &(commit->object);
+		if (in_merge_bases(b, &commit, 1)) {
+			add_object_array(o, NULL, &merges);
+		}
+	}
+
+	/* Now we've got all merges that contain a and b. Prune all
+	 * merges that contain another found merge and save them in
+	 * result.
+	 */
+	for (i = 0; i < merges.nr; i++) {
+		struct commit *m1 = (struct commit *) merges.objects[i].item;
+
+		contains_another = 0;
+		for (j = 0; j < merges.nr; j++) {
+			struct commit *m2 = (struct commit *) merges.objects[j].item;
+			if (i != j && in_merge_bases(m2, &m1, 1)) {
+				contains_another = 1;
+				break;
+			}
+		}
+
+		if (!contains_another)
+			add_object_array(merges.objects[i].item,
+					 merges.objects[i].name, result);
+	}
+
+	free(merges.objects);
+	return result->nr;
+}
+
+static void print_commit(struct commit *commit)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct pretty_print_context ctx = {0};
+	ctx.date_mode = DATE_NORMAL;
+	format_commit_message(commit, " %h: %m %s", &sb, &ctx);
+	fprintf(stderr, "%s\n", sb.buf);
+}
+
+#define MERGE_WARNING(path, msg) \
+	warning("Failed to merge submodule %s (%s)", path, msg);
+
+int merge_submodule(unsigned char result[20], const char *path,
+		    const unsigned char base[20], const unsigned char a[20],
+		    const unsigned char b[20])
+{
+	struct commit *commit_base, *commit_a, *commit_b;
+	int parent_count;
+	struct object_array merges;
+
+	int i;
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
+		MERGE_WARNING(path, "not checked out");
+		return 0;
+	}
+
+	if (!(commit_base = lookup_commit_reference(base)) ||
+	    !(commit_a = lookup_commit_reference(a)) ||
+	    !(commit_b = lookup_commit_reference(b)))
+	{
+		MERGE_WARNING(path, "commits not present");
+		return 0;
+	}
+
+	/* check whether both changes are forward */
+	if (!in_merge_bases(commit_base, &commit_a, 1) ||
+	    !in_merge_bases(commit_base, &commit_b, 1))
+	{
+		MERGE_WARNING(path, "commits don't follow merge-base");
+		return 0;
+	}
+
+	/* Case #1: a is contained in b or vice versa */
+	if (in_merge_bases(commit_a, &commit_b, 1)) {
+		hashcpy(result, b);
+		return 1;
+	}
+	if (in_merge_bases(commit_b, &commit_a, 1)) {
+		hashcpy(result, a);
+		return 1;
+	}
+
+	/* Case #2: There are one or more merges that contain a and b in
+	 * the submodule. If there is only one, then present it as a
+	 * suggestion to the user, but leave it marked unmerged so the
+	 * user needs to confirm the resolution.
+	 */
+
+	/* find commit which merges them */
+	parent_count = find_first_merges(&merges, path, commit_a, commit_b);
+	switch (parent_count) {
+		case 0:
+			MERGE_WARNING(path, "merge following commits not found");
+			break;
+
+		case 1:
+			MERGE_WARNING(path,"not fast-forward");
+			fprintf(stderr, "Found a possible merge resolution "
+					"for the submodule:\n");
+			print_commit((struct commit *) merges.objects[0].item);
+			fprintf(stderr,
+				"If this is correct simply add it to the index "
+				"for example\n"
+				"by using:\n\n"
+				"  git update-index --cacheinfo 160000 %s \"%s\"\n\n"
+				"which will accept this suggestion.\n",
+				sha1_to_hex(merges.objects[0].item->sha1), path);
+			break;
+
+		default:
+			MERGE_WARNING(path, "multiple merges found");
+			for (i = 0; i < merges.nr; i++)
+				print_commit((struct commit *) merges.objects[i].item);
+	}
+
+	free(merges.objects);
+	return 0;
+}
diff --git a/submodule.h b/submodule.h
index 6fd3bb4..b0a571c 100644
--- a/submodule.h
+++ b/submodule.h
@@ -9,5 +9,7 @@ void show_submodule_summary(FILE *f, const char *path,
 		unsigned dirty_submodule,
 		const char *del, const char *add, const char *reset);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
+int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
+		    const unsigned char a[20], const unsigned char b[20]);
 
 #endif
diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 4a7b893..6ec559d 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -54,13 +54,129 @@ test_expect_success setup '
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
+	 git branch sub-a) &&
+	git add sub &&
+	git commit -m "a" &&
+	git branch a &&
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
+	git checkout -b d a &&
+	(cd sub &&
+	 git checkout -b sub-d sub-b &&
+	 git merge sub-c) &&
+	git commit -a -m "d" &&
+	git branch test b &&
+	cd ..
+'
+
+test_expect_success 'merge with one side as a fast-forward of the other' '
+	(cd merge-search &&
+	 git checkout -b test-forward b &&
+	 git merge d &&
+	 git ls-tree test-forward sub | cut -f1 | cut -f3 -d" " > actual &&
+	 (cd sub &&
+	  git rev-parse sub-d > ../expect) &&
+	 test_cmp actual expect)
+'
+
+test_expect_success 'merging should conflict for non fast-forward' '
+	(cd merge-search &&
+	 git checkout -b test-nonforward b &&
+	 (cd sub &&
+	  git rev-parse sub-d > ../expect) &&
+	 test_must_fail git merge c 2> actual  &&
+	 grep $(cat expect) actual > /dev/null &&
+	 git reset --hard)
+'
+
+test_expect_success 'merging should fail for ambiguous common parent' '
+	cd merge-search &&
+	git checkout -b test-ambiguous b &&
+	(cd sub &&
+	 git checkout -b ambiguous sub-b &&
+	 git merge sub-c &&
+	 git rev-parse sub-d > ../expect1 &&
+	 git rev-parse ambiguous > ../expect2) &&
+	test_must_fail git merge c 2> actual &&
+	grep $(cat expect1) actual > /dev/null &&
+	grep $(cat expect2) actual > /dev/null &&
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
+#  bb (sub-b)
+#   \
+#    f (sub-d)
+#
+# A merge between e and f should fail because one of the submodule
+# commits (sub-a) does not descend from the submodule merge-base (sub-b).
+#
+test_expect_success 'merging should fail for changes that are backwards' '
+	cd merge-search &&
+	git checkout -b bb a &&
+	(cd sub &&
+	 git checkout sub-b) &&
+	git commit -a -m "bb" &&
+
+	git checkout -b e bb &&
+	(cd sub &&
+	 git checkout sub-a) &&
+	git commit -a -m "e" &&
+
+	git checkout -b f bb &&
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
1.7.2.rc1.13.g513fa.dirty
