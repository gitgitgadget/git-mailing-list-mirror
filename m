From: Linus Torvalds <torvalds@osdl.org>
Subject: git-rev-list: add "--dense" flag
Date: Fri, 21 Oct 2005 16:40:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510211631400.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Oct 22 01:42:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET6Vh-0005IC-35
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 01:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965194AbVJUXlF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 19:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbVJUXlF
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 19:41:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42933 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965194AbVJUXlD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 19:41:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9LNesFC023382
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 21 Oct 2005 16:40:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9LNes8S028090;
	Fri, 21 Oct 2005 16:40:54 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10453>


This is what the recent git-rev-list changes have all been gearing up for.

When we use a path filter to git-rev-list, the new "--dense" flag asks
git-rev-list to compress the history so that it _only_ contains commits
that change files in the path filter.  It also rewrites the parent
information so that tools like "gitk" will see the result as a dense
history tree.

For example, on the current kernel archive:

	[torvalds@g5 linux]$ git-rev-list HEAD | wc -l
	9904
	[torvalds@g5 linux]$ git-rev-list HEAD -- kernel | wc -l
	5442
	[torvalds@g5 linux]$ git-rev-list --dense HEAD -- kernel | wc -l
	356

which shows that while we have almost ten thousand commits, we can prune
down the work to slightly more than half by only following the merges
that are interesting. But further, we can then compress the history to
just 356 entries that actually make changes to the kernel subdirectory.

To see this in action, try something like

	gitk --dense -- gitk

to see just the history that affects gitk.  Or, to show that true
parallell development still remains parallell, do

	gitk --dense -- daemon.c

which shows some parallell commits in the current git tree.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

I'm really happy with how this turned out. It's a bit expensive to run on 
big archives, but I _really_ think it's quite spectacular. And likely very 
useful indeed.

For example, say you love gitk, but only care about networking changes. 
Easy enough, just do

	gitk --dense -- net/ include/net/

and off you go. It's not free (we do a _lot_ of tree comparisons), but 
dammit, it's fast enough that it's very very useful.  The tree comparisons 
are done very efficiently.

This is _way_ more powerful than annotate. Interested in just a single 
file? Just do

	gitk --dense -- kernel/exit.c

and it will show the 17 or so commits that change kernel/exit.c with the 
right history (it turns out that there is no parallell development at all 
in that file, so in this case it will linearize history entirely).

Damn, I'm good. 

diff --git a/rev-list.c b/rev-list.c
index b5dbb9f..5f125fd 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -11,6 +11,7 @@
 #define INTERESTING	(1u << 1)
 #define COUNTED		(1u << 2)
 #define SHOWN		(1u << 3)
+#define TREECHANGE	(1u << 4)
 
 static const char rev_list_usage[] =
 	"git-rev-list [OPTION] commit-id <commit-id>\n"
@@ -27,6 +28,7 @@ static const char rev_list_usage[] =
 		      "  --merge-order [ --show-breaks ]\n"
 		      "  --topo-order";
 
+static int dense = 0;
 static int unpacked = 0;
 static int bisect_list = 0;
 static int tag_objects = 0;
@@ -79,6 +81,26 @@ static void show_commit(struct commit *c
 	fflush(stdout);
 }
 
+static void rewrite_one(struct commit **pp)
+{
+	for (;;) {
+		struct commit *p = *pp;
+		if (p->object.flags & (TREECHANGE | UNINTERESTING))
+			return;
+		/* Only single-parent commits don't have TREECHANGE */
+		*pp = p->parents->item;
+	}
+}
+
+static void rewrite_parents(struct commit *commit)
+{
+	struct commit_list *parent = commit->parents;
+	while (parent) {
+		rewrite_one(&parent->item);
+		parent = parent->next;
+	}
+}
+
 static int filter_commit(struct commit * commit)
 {
 	if (stop_traversal && (commit->object.flags & BOUNDARY))
@@ -95,6 +117,11 @@ static int filter_commit(struct commit *
 		return STOP;
 	if (no_merges && (commit->parents && commit->parents->next))
 		return CONTINUE;
+	if (paths && dense) {
+		if (!(commit->object.flags & TREECHANGE))
+			return CONTINUE;
+		rewrite_parents(commit);
+	}
 	return DO;
 }
 
@@ -404,6 +431,14 @@ static struct diff_options diff_opt = {
 	.change = file_change,
 };
 
+static int same_tree(struct tree *t1, struct tree *t2)
+{
+	is_different = 0;
+	if (diff_tree_sha1(t1->object.sha1, t2->object.sha1, "", &diff_opt) < 0)
+		return 0;
+	return !is_different;
+}
+
 static struct commit *try_to_simplify_merge(struct commit *commit, struct commit_list *parent)
 {
 	if (!commit->tree)
@@ -415,11 +450,7 @@ static struct commit *try_to_simplify_me
 		parse_commit(p);
 		if (!p->tree)
 			continue;
-		is_different = 0;
-		if (diff_tree_sha1(commit->tree->object.sha1,
-				   p->tree->object.sha1, "", &diff_opt) < 0)
-			continue;
-		if (!is_different)
+		if (same_tree(commit->tree, p->tree))
 			return p;
 	}
 	return NULL;
@@ -485,6 +516,27 @@ static void add_parents_to_list(struct c
 	}
 }
 
+static void compress_list(struct commit_list *list)
+{
+	while (list) {
+		struct commit *commit = list->item;
+		struct commit_list *parent = commit->parents;
+		list = list->next;
+
+		/*
+		 * Exactly one parent? Check if it leaves the tree
+		 * unchanged
+		 */
+		if (parent && !parent->next) {
+			struct tree *t1 = commit->tree;
+			struct tree *t2 = parent->item->tree;
+			if (!t1 || !t2 || same_tree(t1, t2))
+				continue;
+		}
+		commit->object.flags |= TREECHANGE;
+	}
+}
+
 static struct commit_list *limit_list(struct commit_list *list)
 {
 	struct commit_list *newlist = NULL;
@@ -514,6 +566,8 @@ static struct commit_list *limit_list(st
 	}
 	if (tree_objects)
 		mark_edges_uninteresting(newlist);
+	if (paths && dense)
+		compress_list(newlist);
 	if (bisect_list)
 		newlist = find_bisection(newlist);
 	return newlist;
@@ -700,6 +754,10 @@ int main(int argc, const char **argv)
 		        limited = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--dense")) {
+			dense = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			paths = get_pathspec(prefix, argv + i + 1);
 			if (paths) {
