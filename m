From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v3 0/4] implement automatic submodule merge strategy when possible
Date: Wed,  7 Jul 2010 15:39:09 +0200
Message-ID: <cover.1278508352.git.hvoigt@hvoigt.net>
Cc: git@vger.kernel.org, jens.lehmann@web.de, jherland@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 07 15:39:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWUqS-0007sH-K0
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 15:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755598Ab0GGNjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 09:39:16 -0400
Received: from darksea.de ([83.133.111.250]:52760 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754312Ab0GGNjP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 09:39:15 -0400
Received: (qmail 17305 invoked from network); 7 Jul 2010 15:39:13 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 7 Jul 2010 15:39:13 +0200
X-Mailer: git-send-email 1.7.2.rc1.13.g513fa.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150475>

Hi,

Johan and Junio thank you very much for the review. Here is a new
iteration with your comments incorporated.

Further below you can find the changes between the last iteration as
interdiff.

Heiko Voigt (4):
  add missing && to submodule-merge testcase
  teach ref iteration module about submodules
  setup_revisions(): allow walking history in a submodule
  implement automatic fast-forward merge for submodules

 cache.h                    |    3 +
 merge-recursive.c          |    9 ++-
 path.c                     |   38 ++++++++++
 refs.c                     |  149 +++++++++++++++++++++++++++++++---------
 refs.h                     |    8 ++
 revision.c                 |   32 +++++----
 revision.h                 |    1 +
 submodule.c                |  162 ++++++++++++++++++++++++++++++++++++++++++++
 submodule.h                |    2 +
 t/t7405-submodule-merge.sh |  130 +++++++++++++++++++++++++++++++++--
 10 files changed, 478 insertions(+), 56 deletions(-)

-- 
1.7.2.rc1.13.g513fa.dirty

diff --git a/submodule.c b/submodule.c
index 62dcabe..9bc4b80 100644
--- a/submodule.c
+++ b/submodule.c
@@ -240,7 +240,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 
 	/* get all revisions that merge commit a */
 	snprintf(merged_revision, sizeof(merged_revision), "^%s",
-			find_unique_abbrev(a->object.sha1, 40));
+			sha1_to_hex(a->object.sha1));
 	init_revisions(&revs, NULL);
 	rev_opts.submodule = path;
 	setup_revisions(sizeof(rev_args)/sizeof(char *)-1, rev_args, &revs, &rev_opts);
@@ -250,14 +250,15 @@ static int find_first_merges(struct object_array *result, const char *path,
 		die("revision walk setup failed");
 	while ((commit = get_revision(&revs)) != NULL) {
 		struct object *o = &(commit->object);
-		if (in_merge_bases(b, (struct commit **) &o, 1)) {
+		if (in_merge_bases(b, &commit, 1)) {
 			add_object_array(o, NULL, &merges);
 		}
 	}
 
 	/* Now we've got all merges that contain a and b. Prune all
 	 * merges that contain another found merge and save them in
-	 * result. */
+	 * result.
+	 */
 	for (i = 0; i < merges.nr; i++) {
 		struct commit *m1 = (struct commit *) merges.objects[i].item;
 
@@ -281,17 +282,19 @@ static int find_first_merges(struct object_array *result, const char *path,
 
 static void print_commit(struct commit *commit)
 {
-	static const char *format = " %h: %m %s";
 	struct strbuf sb = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
 	ctx.date_mode = DATE_NORMAL;
-	format_commit_message(commit, format, &sb, &ctx);
-	strbuf_addstr(&sb, "\n");
-	fprintf(stderr, "%s", sb.buf);
+	format_commit_message(commit, " %h: %m %s", &sb, &ctx);
+	fprintf(stderr, "%s\n", sb.buf);
 }
 
-int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
-		    const unsigned char a[20], const unsigned char b[20])
+#define MERGE_WARNING(path, msg) \
+	warning("Failed to merge submodule %s (%s)", path, msg);
+
+int merge_submodule(unsigned char result[20], const char *path,
+		    const unsigned char base[20], const unsigned char a[20],
+		    const unsigned char b[20])
 {
 	struct commit *commit_base, *commit_a, *commit_b;
 	int parent_count;
@@ -311,7 +314,7 @@ int merge_submodule(unsigned char result[20], const char *path, const unsigned c
 		return 0;
 
 	if (add_submodule_odb(path)) {
-		warning("Failed to merge submodule %s (not checked out)", path);
+		MERGE_WARNING(path, "not checked out");
 		return 0;
 	}
 
@@ -319,7 +322,7 @@ int merge_submodule(unsigned char result[20], const char *path, const unsigned c
 	    !(commit_a = lookup_commit_reference(a)) ||
 	    !(commit_b = lookup_commit_reference(b)))
 	{
-		warning("Failed to merge submodule %s (commits not present)", path);
+		MERGE_WARNING(path, "commits not present");
 		return 0;
 	}
 
@@ -327,11 +330,11 @@ int merge_submodule(unsigned char result[20], const char *path, const unsigned c
 	if (!in_merge_bases(commit_base, &commit_a, 1) ||
 	    !in_merge_bases(commit_base, &commit_b, 1))
 	{
-		warning("Submodule rewound can not merge");
+		MERGE_WARNING(path, "commits don't follow merge-base");
 		return 0;
 	}
 
-	/* 1. case a is contained in b or vice versa */
+	/* Case #1: a is contained in b or vice versa */
 	if (in_merge_bases(commit_a, &commit_b, 1)) {
 		hashcpy(result, b);
 		return 1;
@@ -341,35 +344,39 @@ int merge_submodule(unsigned char result[20], const char *path, const unsigned c
 		return 1;
 	}
 
-	/* 2. case there are one ore more merges that contain a and b the
-	 * submodule. If there is a single one check it out but leave it
-	 * marked unmerged so the user needs to confirm the resolution */
+	/* Case #2: There are one or more merges that contain a and b in
+	 * the submodule. If there is only one, then present it as a
+	 * suggestion to the user, but leave it marked unmerged so the
+	 * user needs to confirm the resolution.
+	 */
 
 	/* find commit which merges them */
 	parent_count = find_first_merges(&merges, path, commit_a, commit_b);
-	if (!parent_count) {
-		warning("Failed to merge submodule %s (merge not found)", path);
-		goto finish;
-	}
+	switch (parent_count) {
+		case 0:
+			MERGE_WARNING(path, "merge following commits not found");
+			break;
 
-	if (parent_count != 1) {
-		warning("Failed to merge submodule %s (multiple merges found):", path);
-		for (i = 0; i < merges.nr; i++) {
-			print_commit((struct commit *) merges.objects[i].item);
-		}
-		goto finish;
-	}
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
 
-	warning("Failed to merge submodule %s (not fast-forward):\n", path);
-	fprintf(stderr, "Found a possible merge resolution for the submodule:\n");
-	print_commit((struct commit *) merges.objects[0].item);
-	fprintf(stderr, "If this is correct simply add it to the index for example\n"
-			"by using:\n\n"
-			"  git update-index --cacheinfo 160000 %s \"%s\"\n\n"
-			"which will accept this suggestion.\n",
-		sha1_to_hex(merges.objects[0].item->sha1), path);
+		default:
+			MERGE_WARNING(path, "multiple merges found");
+			for (i = 0; i < merges.nr; i++)
+				print_commit((struct commit *) merges.objects[i].item);
+	}
 
-finish:
 	free(merges.objects);
 	return 0;
 }
diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 0f568ab..6ec559d 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -75,10 +75,10 @@ test_expect_success 'setup for merge search' '
 	 echo "file-a" > file-a &&
 	 git add file-a &&
 	 git commit -m "sub-a" &&
-	 git checkout -b sub-a) &&
+	 git branch sub-a) &&
 	git add sub &&
 	git commit -m "a" &&
-	git checkout -b a &&
+	git branch a &&
 
 	git checkout -b b &&
 	(cd sub &&
@@ -101,7 +101,7 @@ test_expect_success 'setup for merge search' '
 	 git checkout -b sub-d sub-b &&
 	 git merge sub-c) &&
 	git commit -a -m "d" &&
-	git checkout -b test b &&
+	git branch test b &&
 	cd ..
 '
 
@@ -109,7 +109,7 @@ test_expect_success 'merge with one side as a fast-forward of the other' '
 	(cd merge-search &&
 	 git checkout -b test-forward b &&
 	 git merge d &&
-	 git ls-tree test-forward | grep sub | cut -f1 | cut -f3 -d" " > actual &&
+	 git ls-tree test-forward sub | cut -f1 | cut -f3 -d" " > actual &&
 	 (cd sub &&
 	  git rev-parse sub-d > ../expect) &&
 	 test_cmp actual expect)
@@ -121,21 +121,21 @@ test_expect_success 'merging should conflict for non fast-forward' '
 	 (cd sub &&
 	  git rev-parse sub-d > ../expect) &&
 	 test_must_fail git merge c 2> actual  &&
-	 grep $(<expect) actual > /dev/null &&
+	 grep $(cat expect) actual > /dev/null &&
 	 git reset --hard)
 '
 
-test_expect_success 'merging should fail for ambigous common parent' '
+test_expect_success 'merging should fail for ambiguous common parent' '
 	cd merge-search &&
-	git checkout -b test-ambigous b &&
+	git checkout -b test-ambiguous b &&
 	(cd sub &&
-	 git checkout -b ambigous sub-b &&
+	 git checkout -b ambiguous sub-b &&
 	 git merge sub-c &&
 	 git rev-parse sub-d > ../expect1 &&
-	 git rev-parse ambigous > ../expect2) &&
+	 git rev-parse ambiguous > ../expect2) &&
 	test_must_fail git merge c 2> actual &&
-	grep $(<expect1) actual > /dev/null &&
-	grep $(<expect2) actual > /dev/null &&
+	grep $(cat expect1) actual > /dev/null &&
+	grep $(cat expect2) actual > /dev/null &&
 	git reset --hard &&
 	cd ..
 '
@@ -154,8 +154,9 @@ test_expect_success 'merging should fail for ambigous common parent' '
 #   \
 #    f (sub-d)
 #
-# A merge should fail because one change points backwards.
-
+# A merge between e and f should fail because one of the submodule
+# commits (sub-a) does not descend from the submodule merge-base (sub-b).
+#
 test_expect_success 'merging should fail for changes that are backwards' '
 	cd merge-search &&
 	git checkout -b bb a &&
