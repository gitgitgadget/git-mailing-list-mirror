From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: [PATCH 6/8] Make "subtree" part more orthogonal to the rest of merge-recursive.
Date: Wed, 25 Nov 2009 21:23:58 -0500
Message-ID: <c78d4c177f470e0f2f64314321df12e1a59077bf.1259201377.git.apenwarr@gmail.com>
References: <cover.1259201377.git.apenwarr@gmail.com> <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com> <905749faf5ccb2c7c54d3318dbc662d69daf8d0e.1259201377.git.apenwarr@gmail.com> <7e1f1179fc5fe2f568e2c75f75366fa40d7bbbfb.1259201377.git.apenwarr@gmail.com> <73a42e99b4a083c74b017caf2970d1bbf5886b96.1259201377.git.apenwarr@gmail.com> <1ff0b2f7e3fae4cc6c7610c92711f33df9a3d07c.1259201377.git.apenwarr@gmail.com>
Cc: <gitster@pobox.com>, "Avery Pennarun" <apenwarr@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 26 03:43:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDUKL-0004ry-Bk
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 03:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576AbZKZCmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 21:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754795AbZKZCmp
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 21:42:45 -0500
Received: from mailhost.pwcorp.com ([216.13.111.70]:4746 "EHLO
	mailhost.pwcorp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbZKZCmd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 21:42:33 -0500
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2009 21:42:31 EST
X-Language-Identified: TRUE
X-Brightmail-Tracker: AAAAAQAAA+k=
thread-index: AcpuP/gvNUrLy+ISRsCNMaBNHUwS1g==
Received: from weaver.open.versabanq.com ([10.65.1.2]) by mailhost.pwcorp.com with Microsoft SMTPSVC(6.0.3790.3959); Wed, 25 Nov 2009 21:26:43 -0500
Content-Class: urn:content-classes:message
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4325
Received: (qmail 5667 invoked from network); 26 Nov 2009 02:25:45 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)  by weaver.open.versabanq.com with SMTP; 26 Nov 2009 02:25:45 -0000
Received: (qmail 5614 invoked from network); 26 Nov 2009 02:25:44 -0000
Received: from unknown (HELO harmony.mtl.versabanq.com) (10.65.1.133)  by weaver.open.versabanq.com with SMTP; 26 Nov 2009 02:25:44 -0000
Received: by harmony.mtl.versabanq.com (sSMTP sendmail emulation); Wed, 25 Nov 2009 21:24:19 -0500
X-Mailer: git-send-email 1.6.6.rc0.62.gaccf
In-Reply-To: <1ff0b2f7e3fae4cc6c7610c92711f33df9a3d07c.1259201377.git.apenwarr@gmail.com>
In-Reply-To: <cover.1259201377.git.apenwarr@gmail.com>
References: <cover.1259201377.git.apenwarr@gmail.com>
X-OriginalArrivalTime: 26 Nov 2009 02:26:43.0809 (UTC) FILETIME=[E509A510:01CA6E3F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133756>

This makes "subtree" more orthogonal to the rest of recursive merge, so
that you can use subtree and ours/theirs features at the same time.  For
example, you can now say:

	git merge -s subtree -Xtheirs other

to merge with "other" branch while shifting it up or down to match the
shape of the tree of the current branch, and resolving conflicts favoring
the changes "other" branch made over changes made in the current branch.

It also allows the prefix used to shift the trees to be specified using
the "-Xsubtree=$prefix" option.  Giving an empty prefix tells the command
to figure out how much to shift trees automatically as we have always
done.  "merge -s subtree" is the same as "merge -s recursive -Xsubtree="
(or "merge -s recursive -Xsubtree").

(Patch originally by Junio Hamano <gitster@pobox.com>.)

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 builtin-merge-recursive.c |    6 ++-
 builtin-merge.c           |    6 ++-
 cache.h                   |    1 +
 match-trees.c             |   69 ++++++++++++++++++++++++++++++++++++++++++++-
 merge-recursive.c         |   16 +++++++---
 merge-recursive.h         |    3 +-
 6 files changed, 90 insertions(+), 11 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 53f8f05..d9404e1 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -28,7 +28,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	if (argv[0]) {
 		int namelen = strlen(argv[0]);
 		if (!suffixcmp(argv[0], "-subtree"))
-			o.recursive_variant = MERGE_RECURSIVE_SUBTREE;
+			o.subtree_shift = "";
 	}
 
 	if (argc < 4)
@@ -45,7 +45,9 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 			else if (!strcmp(arg+2, "theirs"))
 				o.recursive_variant = MERGE_RECURSIVE_THEIRS;
 			else if (!strcmp(arg+2, "subtree"))
-				o.recursive_variant = MERGE_RECURSIVE_SUBTREE;
+				o.subtree_shift = "";
+			else if (!prefixcmp(arg+2, "subtree="))
+				o.subtree_shift = arg + 10;
 			else
 				die("Unknown option %s", arg);
 			continue;
diff --git a/builtin-merge.c b/builtin-merge.c
index 9a95bc8..a64b8f2 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -578,7 +578,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 
 		init_merge_options(&o);
 		if (!strcmp(strategy, "subtree"))
-			o.recursive_variant = MERGE_RECURSIVE_SUBTREE;
+			o.subtree_shift = "";
 			
 		for (x = 0; x < xopts_nr; x++) {
 			if (!strcmp(xopts[x], "ours"))
@@ -586,7 +586,9 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			else if (!strcmp(xopts[x], "theirs"))
 				o.recursive_variant = MERGE_RECURSIVE_THEIRS;
 			else if (!strcmp(xopts[x], "subtree"))
-				o.recursive_variant = MERGE_RECURSIVE_SUBTREE;
+                        	o.subtree_shift = "";
+			else if (!prefixcmp(xopts[x], "subtree="))
+				o.subtree_shift = xopts[x]+8;
 			else
 				die("Unknown option for merge-recursive: -X%s", xopts[x]);
 		}
diff --git a/cache.h b/cache.h
index bf468e5..c6902d2 100644
--- a/cache.h
+++ b/cache.h
@@ -993,6 +993,7 @@ extern int diff_auto_refresh_index;
 
 /* match-trees.c */
 void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, int);
+void shift_tree_by(const unsigned char *, const unsigned char *, unsigned char *, const char *);
 
 /*
  * whitespace rules.
diff --git a/match-trees.c b/match-trees.c
index 0fd6df7..26f7ed1 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -185,7 +185,7 @@ static void match_trees(const unsigned char *hash1,
  * tree object by replacing it with another tree "hash2".
  */
 static int splice_tree(const unsigned char *hash1,
-		       char *prefix,
+		       const char *prefix,
 		       const unsigned char *hash2,
 		       unsigned char *result)
 {
@@ -264,6 +264,13 @@ void shift_tree(const unsigned char *hash1,
 	char *del_prefix;
 	int add_score, del_score;
 
+	/*
+	 * NEEDSWORK: this limits the recursion depth to hardcoded
+	 * value '2' to avoid excessive overhead.
+	 */
+	if (!depth_limit)
+		depth_limit = 2;
+
 	add_score = del_score = score_trees(hash1, hash2);
 	add_prefix = xcalloc(1, 1);
 	del_prefix = xcalloc(1, 1);
@@ -301,3 +308,63 @@ void shift_tree(const unsigned char *hash1,
 
 	splice_tree(hash1, add_prefix, hash2, shifted);
 }
+
+/*
+ * The user says the trees will be shifted by this much.
+ * Unfortunately we cannot fundamentally tell which one to
+ * be prefixed, as recursive merge can work in either direction.
+ */
+void shift_tree_by(const unsigned char *hash1,
+		   const unsigned char *hash2,
+		   unsigned char *shifted,
+		   const char *shift_prefix)
+{
+	unsigned char sub1[20], sub2[20];
+	unsigned mode1, mode2;
+	unsigned candidate = 0;
+
+	/* Can hash2 be a tree at shift_prefix in tree hash1? */
+	if (!get_tree_entry(hash1, shift_prefix, sub1, &mode1) &&
+	    S_ISDIR(mode1))
+		candidate |= 1;
+
+	/* Can hash1 be a tree at shift_prefix in tree hash2? */
+	if (!get_tree_entry(hash2, shift_prefix, sub2, &mode2) &&
+	    S_ISDIR(mode2))
+		candidate |= 2;
+
+	if (candidate == 3) {
+		/* Both are plausible -- we need to evaluate the score */
+		int best_score = score_trees(hash1, hash2);
+		int score;
+
+		candidate = 0;
+		score = score_trees(sub1, hash2);
+		if (score > best_score) {
+			candidate = 1;
+			best_score = score;
+		}
+		score = score_trees(sub2, hash1);
+		if (score > best_score)
+			candidate = 2;
+	}
+
+	if (!candidate) {
+		/* Neither is plausible -- do not shift */
+		hashcpy(shifted, hash2);
+		return;
+	}
+
+	if (candidate == 1)
+		/*
+		 * shift tree2 down by adding shift_prefix above it
+		 * to match tree1.
+		 */
+		splice_tree(hash1, shift_prefix, hash2, shifted);
+	else
+		/*
+		 * shift tree2 up by removing shift_prefix from it
+		 * to match tree1.
+		 */
+		hashcpy(shifted, sub2);
+}
diff --git a/merge-recursive.c b/merge-recursive.c
index 257bf8f..79b45ed 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -21,7 +21,8 @@
 #include "merge-recursive.h"
 #include "dir.h"
 
-static struct tree *shift_tree_object(struct tree *one, struct tree *two)
+static struct tree *shift_tree_object(struct tree *one, struct tree *two,
+				      const char *subtree_shift)
 {
 	unsigned char shifted[20];
 
@@ -29,7 +30,12 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two)
 	 * NEEDSWORK: this limits the recursion depth to hardcoded
 	 * value '2' to avoid excessive overhead.
 	 */
-	shift_tree(one->object.sha1, two->object.sha1, shifted, 2);
+	if (!*subtree_shift) {
+		shift_tree(one->object.sha1, two->object.sha1, shifted, 0);
+	} else {
+		shift_tree_by(one->object.sha1, two->object.sha1, shifted,
+			      subtree_shift);
+	}
 	if (!hashcmp(two->object.sha1, shifted))
 		return two;
 	return lookup_tree(shifted);
@@ -1213,9 +1219,9 @@ int merge_trees(struct merge_options *o,
 {
 	int code, clean;
 
-	if (o->recursive_variant == MERGE_RECURSIVE_SUBTREE) {
-		merge = shift_tree_object(head, merge);
-		common = shift_tree_object(head, common);
+	if (o->subtree_shift) {
+		merge = shift_tree_object(head, merge, o->subtree_shift);
+		common = shift_tree_object(head, common, o->subtree_shift);
 	}
 
 	if (sha_eq(common->object.sha1, merge->object.sha1)) {
diff --git a/merge-recursive.h b/merge-recursive.h
index 9d54219..d9347ce 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -7,10 +7,11 @@ struct merge_options {
 	const char *branch1;
 	const char *branch2;
 	enum {
-        	MERGE_RECURSIVE_SUBTREE = 1,
+		MERGE_RECURSIVE_NORMAL = 0,
         	MERGE_RECURSIVE_OURS,
         	MERGE_RECURSIVE_THEIRS,
 	} recursive_variant;
+	const char *subtree_shift;
 	unsigned buffer_output : 1;
 	int verbosity;
 	int diff_rename_limit;
-- 
1.6.6.rc0.62.gaccf
