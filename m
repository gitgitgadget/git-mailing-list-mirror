From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] built-in diff: assorted updates.
Date: Sat, 29 Apr 2006 02:29:34 -0700
Message-ID: <7vodyk91c1.fsf@assigned-by-dhcp.cox.net>
References: <7virosalxb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Apr 29 11:29:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZllm-0006Js-NN
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 11:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWD2J3g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 05:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWD2J3g
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 05:29:36 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:15576 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751154AbWD2J3g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Apr 2006 05:29:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060429092935.PVHD21197.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 29 Apr 2006 05:29:35 -0400
To: git@vger.kernel.org
In-Reply-To: <7virosalxb.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 29 Apr 2006 00:19:28 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19298>

"git diff(n)" without --base, --ours, etc. defaults to --cc,
which usually is the same as -p unless you are in the middle of
a conflicted merge, just like the shell script version.

"git diff(n) blobA blobB path" complains and dies.

"git diff(n) tree0 tree1 tree2...treeN" does combined diff that
shows a merge of tree1..treeN to result in tree0.

Giving "-c" option to any command that defaults to "--cc" turns
off dense-combined flag.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Comes on top of the previous "built-in diff" patch.

   Now I think this is more or less what Linus envisioned when
   he started converting the rev related option parsing to use
   setup_revisions(), including the exotic combinations the
   shell script "git diff" does not support:

   git diff(n) HEAD~10:Makefile Makefile	        ; blob vs any file
   git diff(n) HEAD~10:Makefile HEAD~20:Makefile        ; two blobs
   git diff(n) v1.0.0 v1.0.0^1 v1.0.0^2	; combine 'em

   The normal ones are also supported:

   git diff(n) -- Documentation				; index vs working
   git diff(n) --cached 				; tree vs index
   git diff(n) HEAD					; tree vs working
   git diff(n) HEAD~10 HEAD~8				; two trees
   git diff(n) HEAD:arch/i386 HEAD:arch/x86_64		; two trees

 builtin-diff.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++---------
 combine-diff.c |   47 ++++++++++++++++++++++++++++++-----------------
 diff.h         |    2 ++
 revision.c     |    1 +
 4 files changed, 79 insertions(+), 26 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index 1968212..c543105 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -47,13 +47,17 @@ static int builtin_diff_files(struct rev
 	}
 	/*
 	 * Make sure there are NO revision (i.e. pending object) parameter,
-	 * rev.max_count is reasonable (0 <= n <= 3),
-	 * there is no other revision filtering parameters.
+	 * specified rev.max_count is reasonable (0 <= n <= 3), and
+	 * there is no other revision filtering parameter.
 	 */
 	if (revs->pending_objects ||
 	    revs->min_age != -1 ||
-	    revs->max_age != -1)
+	    revs->max_age != -1 ||
+	    3 < revs->max_count)
 		usage(builtin_diff_usage);
+	if (revs->max_count < 0 &&
+	    (revs->diffopt.output_format == DIFF_FORMAT_PATCH))
+		revs->combine_merges = revs->dense_combined_merges = 1;
 	/*
 	 * Backward compatibility wart - "diff-files -s" used to
 	 * defeat the common diff option "-s" which asked for
@@ -178,9 +182,6 @@ static int builtin_diff_tree(struct rev_
 			     int argc, const char **argv,
 			     struct object_list *ent)
 {
-	/* We saw two trees, ent[0] and ent[1].
-	 * unless ent[0] is unintesting, they are swapped
-	 */
 	const unsigned char *(sha1[2]);
 	int swap = 1;
 	while (1 < argc) {
@@ -191,6 +192,10 @@ static int builtin_diff_tree(struct rev_
 			usage(builtin_diff_usage);
 		argv++; argc--;
 	}
+
+	/* We saw two trees, ent[0] and ent[1].
+	 * unless ent[0] is unintesting, they are swapped
+	 */
 	if (ent[0].item->flags & UNINTERESTING)
 		swap = 0;
 	sha1[swap] = ent[0].item->sha1;
@@ -200,6 +205,33 @@ static int builtin_diff_tree(struct rev_
 	return 0;
 }
 
+static int builtin_diff_combined(struct rev_info *revs,
+				 int argc, const char **argv,
+				 struct object_list *ent,
+				 int ents)
+{
+	const unsigned char (*parent)[20];
+	int i;
+
+	while (1 < argc) {
+		const char *arg = argv[1];
+		if (!strcmp(arg, "--raw"))
+			revs->diffopt.output_format = DIFF_FORMAT_RAW;
+		else
+			usage(builtin_diff_usage);
+		argv++; argc--;
+	}
+	if (!revs->dense_combined_merges && !revs->combine_merges)
+		revs->dense_combined_merges = revs->combine_merges = 1;
+	parent = xmalloc(ents * sizeof(*parent));
+	/* Again, the revs are all reverse */
+	for (i = 0; i < ents; i++)
+		memcpy(parent + i, ent[ents - 1 - i].item->sha1, 20);
+	diff_tree_combined(parent[0], parent + 1, ents - 1,
+			   revs->dense_combined_merges, revs);
+	return 0;
+}
+
 static void add_head(struct rev_info *revs)
 {
 	unsigned char sha1[20];
@@ -215,7 +247,7 @@ static void add_head(struct rev_info *re
 int cmd_diff(int argc, const char **argv, char **envp)
 {
 	struct rev_info rev;
-	struct object_list *list, ent[2];
+	struct object_list *list, ent[100];
 	int ents = 0, blobs = 0, paths = 0;
 	const char *path = NULL;
 	struct blobinfo blob[2];
@@ -273,8 +305,9 @@ int cmd_diff(int argc, const char **argv
 		if (!strcmp(obj->type, commit_type))
 			obj = &((struct commit *)obj)->tree->object;
 		if (!strcmp(obj->type, tree_type)) {
-			if (2 <= ents)
-				die("more than two trees given: '%s'", name);
+			if (ARRAY_SIZE(ent) <= ents)
+				die("more than %d trees given: '%s'",
+				    ARRAY_SIZE(ent), name);
 			obj->flags |= flags;
 			ent[ents].item = obj;
 			ent[ents].name = name;
@@ -316,6 +349,8 @@ int cmd_diff(int argc, const char **argv
 			return builtin_diff_b_f(&rev, argc, argv, blob, path);
 			break;
 		case 2:
+			if (paths)
+				usage(builtin_diff_usage);
 			return builtin_diff_blobs(&rev, argc, argv, blob);
 			break;
 		default:
@@ -328,5 +363,7 @@ int cmd_diff(int argc, const char **argv
 		return builtin_diff_index(&rev, argc, argv);
 	else if (ents == 2)
 		return builtin_diff_tree(&rev, argc, argv, ent);
+	else
+		return builtin_diff_combined(&rev, argc, argv, ent, ents);
 	usage(builtin_diff_usage);
 }
diff --git a/combine-diff.c b/combine-diff.c
index ca36f5d..8a8fe38 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -831,15 +831,16 @@ void show_combined_diff(struct combine_d
 	}
 }
 
-void diff_tree_combined_merge(const unsigned char *sha1,
-			     int dense, struct rev_info *rev)
+void diff_tree_combined(const unsigned char *sha1,
+			const unsigned char parent[][20],
+			int num_parent,
+			int dense,
+			struct rev_info *rev)
 {
 	struct diff_options *opt = &rev->diffopt;
-	struct commit *commit = lookup_commit(sha1);
 	struct diff_options diffopts;
-	struct commit_list *parents;
 	struct combine_diff_path *p, *paths = NULL;
-	int num_parent, i, num_paths;
+	int i, num_paths;
 	int do_diffstat;
 
 	do_diffstat = (opt->output_format == DIFF_FORMAT_DIFFSTAT ||
@@ -849,17 +850,8 @@ void diff_tree_combined_merge(const unsi
 	diffopts.with_stat = 0;
 	diffopts.recursive = 1;
 
-	/* count parents */
-	for (parents = commit->parents, num_parent = 0;
-	     parents;
-	     parents = parents->next, num_parent++)
-		; /* nothing */
-
 	/* find set of paths that everybody touches */
-	for (parents = commit->parents, i = 0;
-	     parents;
-	     parents = parents->next, i++) {
-		struct commit *parent = parents->item;
+	for (i = 0; i < num_parent; i++) {
 		/* show stat against the first parent even
 		 * when doing combined diff.
 		 */
@@ -867,8 +859,7 @@ void diff_tree_combined_merge(const unsi
 			diffopts.output_format = DIFF_FORMAT_DIFFSTAT;
 		else
 			diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
-		diff_tree_sha1(parent->object.sha1, commit->object.sha1, "",
-			       &diffopts);
+		diff_tree_sha1(parent[i], sha1, "", &diffopts);
 		diffcore_std(&diffopts);
 		paths = intersect_paths(paths, i, num_parent);
 
@@ -907,3 +898,25 @@ void diff_tree_combined_merge(const unsi
 		free(tmp);
 	}
 }
+
+void diff_tree_combined_merge(const unsigned char *sha1,
+			     int dense, struct rev_info *rev)
+{
+	int num_parent;
+	const unsigned char (*parent)[20];
+	struct commit *commit = lookup_commit(sha1);
+	struct commit_list *parents;
+
+	/* count parents */
+	for (parents = commit->parents, num_parent = 0;
+	     parents;
+	     parents = parents->next, num_parent++)
+		; /* nothing */
+
+	parent = xmalloc(num_parent * sizeof(*parent));
+	for (parents = commit->parents, num_parent = 0;
+	     parents;
+	     parents = parents->next, num_parent++)
+		memcpy(parent + num_parent, parents->item->object.sha1, 20);
+	diff_tree_combined(sha1, parent, num_parent, dense, rev);
+}
diff --git a/diff.h b/diff.h
index 7150b90..b3b2c4d 100644
--- a/diff.h
+++ b/diff.h
@@ -75,6 +75,8 @@ #define combine_diff_path_size(n, l) \
 extern void show_combined_diff(struct combine_diff_path *elem, int num_parent,
 			      int dense, struct rev_info *);
 
+extern void diff_tree_combined(const unsigned char *sha1, const unsigned char parent[][20], int num_parent, int dense, struct rev_info *rev);
+
 extern void diff_tree_combined_merge(const unsigned char *sha1, int, struct rev_info *);
 
 extern void diff_addremove(struct diff_options *,
diff --git a/revision.c b/revision.c
index f2a9f25..4381d45 100644
--- a/revision.c
+++ b/revision.c
@@ -664,6 +664,7 @@ int setup_revisions(int argc, const char
 			}
 			if (!strcmp(arg, "-c")) {
 				revs->diff = 1;
+				revs->dense_combined_merges = 0;
 				revs->combine_merges = 1;
 				continue;
 			}
-- 
1.3.1.ga0c5
