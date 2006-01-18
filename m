From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Joining Repositories
Date: Wed, 18 Jan 2006 14:47:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601181414530.3240@g5.osdl.org>
References: <200601181325.59832.Mathias.Waack@rantzau.de>
 <20060118125158.GN28365@pasky.or.cz> <20060118140917.GA15438@mythryan2.michonline.com>
 <Pine.LNX.4.64.0601180813170.3240@g5.osdl.org> <7vbqy9xx2r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0601181010410.3240@g5.osdl.org> <7vslrluze6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0601181128060.3240@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 23:48:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzM5h-00039S-Gu
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 23:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbWARWrj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 17:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWARWrj
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 17:47:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45506 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932570AbWARWri (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 17:47:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0IMlVDZ001380
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Jan 2006 14:47:32 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0IMlUsb003952;
	Wed, 18 Jan 2006 14:47:31 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0601181128060.3240@g5.osdl.org>
X-Spam-Status: No, hits=0.224 required=5 tests=REMOVE_REMOVAL_NEAR
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.66__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14867>



On Wed, 18 Jan 2006, Linus Torvalds wrote:
> 
> The one thing I've considered doing (I really should) is to add a "stop 
> when you don't find the file" option to "git-rev-list". This patch does 
> some of the work towards that: it removes the "parent" thing when the 
> file disappears, so a "git annotate" could do do something like
> 
> 	git-rev-list --remove-empty --parents HEAD -- "$filename"
> 
> and it would get a good graph that stops when the filename disappears 
> (it's not perfect though: it won't remove all the unintersting commits).

Here is a somewhat better version of this patch.

It also simplifies the logic of finding tree differences a bit, at the 
cost of making it a tad less efficient.

The old logic was two-phase: it would first simplify _only_ merges tree as 
it traversed the tree, and then simplify the linear parts of the remainder 
independently. That was pretty optimal from an efficiency standpoint 
because it avoids doing any comparisons that we can see are unnecessary, 
but it made it much harder to understand than it really needed to be.

The new logic is a lot more straightforward, and compares the trees as it 
traverses the graph (ie everything is a single phase). That makes it much 
easier to stop graph traversal at any point where a file disappears.

As an example, let's say that you have a git repository that has had a 
file called "A" some time in the past. That file gets renamed to B, and 
then gets renamed back again to A. The old "git-rev-list" would show two 
commits commits: the commit that renames B to A (because it changes A) 
_and_ as its parent the commit that renames A to B (because it changes A).

With the new --remove-empty flag, git-rev-list will show just the commit 
that renames B to A as the "root" commit, and stop traversal there 
(because that's what you want for "annotate" - you want to stop there, and 
for every "root" commit you then separately see if it really is a new 
file, or if the paths history disappeared because it was renamed from some 
other file).

With this patch, you should be able to basically do a "poor mans 'git 
annotate'" with a fairly simple loop:

	push("HEAD", "$filename")
	while (revision,filename = pop()) {
		for each i in $(git-rev-list --parents --remove-empty $revision -- "$filename")

		pseudo-parents($i) = git-rev-list parents for that line

		if (pseudo-parents($i) is non-empty) {
			show diff of $i against pseudo-parents
			continue
		}

		/* See if the _real_ parents of $i had a rename */
		parent($i) = real-parent($i)
		if (find-rename in $parent($i)->$i)
			push $parent($i), "old-name"
	}

which should be doable in perl or something (doing stacks in shell is just 
too painful to be worth it, so I'm not going to do this).

Anybody want to try?

		Linus

---
diff --git a/rev-list.c b/rev-list.c
index d060966..912071d 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -54,6 +54,7 @@ static int stop_traversal = 0;
 static int topo_order = 0;
 static int no_merges = 0;
 static const char **paths = NULL;
+static int remove_empty_trees = 0;
 
 static void show_commit(struct commit *commit)
 {
@@ -424,14 +425,33 @@ static void mark_edges_uninteresting(str
 	}
 }
 
-static int is_different = 0;
+#define TREE_SAME	0
+#define TREE_NEW	1
+#define TREE_DIFFERENT	2
+static int tree_difference = TREE_SAME;
 
 static void file_add_remove(struct diff_options *options,
 		    int addremove, unsigned mode,
 		    const unsigned char *sha1,
 		    const char *base, const char *path)
 {
-	is_different = 1;
+	int diff = TREE_DIFFERENT;
+
+	/*
+	 * Is it an add of a new file? It means that
+	 * the old tree didn't have it at all, so we
+	 * will turn "TREE_SAME" -> "TREE_NEW", but
+	 * leave any "TREE_DIFFERENT" alone (and if
+	 * it already was "TREE_NEW", we'll keep it
+	 * "TREE_NEW" of course).
+	 */
+	if (addremove == '+') {
+		diff = tree_difference;
+		if (diff != TREE_SAME)
+			return;
+		diff = TREE_NEW;
+	}
+	tree_difference = diff;
 }
 
 static void file_change(struct diff_options *options,
@@ -440,7 +460,7 @@ static void file_change(struct diff_opti
 		 const unsigned char *new_sha1,
 		 const char *base, const char *path)
 {
-	is_different = 1;
+	tree_difference = TREE_DIFFERENT;
 }
 
 static struct diff_options diff_opt = {
@@ -449,12 +469,16 @@ static struct diff_options diff_opt = {
 	.change = file_change,
 };
 
-static int same_tree(struct tree *t1, struct tree *t2)
+static int compare_tree(struct tree *t1, struct tree *t2)
 {
-	is_different = 0;
+	if (!t1)
+		return TREE_NEW;
+	if (!t2)
+		return TREE_DIFFERENT;
+	tree_difference = TREE_SAME;
 	if (diff_tree_sha1(t1->object.sha1, t2->object.sha1, "", &diff_opt) < 0)
-		return 0;
-	return !is_different;
+		return TREE_DIFFERENT;
+	return tree_difference;
 }
 
 static int same_tree_as_empty(struct tree *t1)
@@ -474,28 +498,55 @@ static int same_tree_as_empty(struct tre
 	empty.buf = "";
 	empty.size = 0;
 
-	is_different = 0;
+	tree_difference = 0;
 	retval = diff_tree(&empty, &real, "", &diff_opt);
 	free(tree);
 
-	return retval >= 0 && !is_different;
+	return retval >= 0 && !tree_difference;
 }
 
-static struct commit *try_to_simplify_merge(struct commit *commit, struct commit_list *parent)
+static void try_to_simplify_commit(struct commit *commit)
 {
+	struct commit_list **pp, *parent;
+
 	if (!commit->tree)
-		return NULL;
+		return;
 
-	while (parent) {
+	if (!commit->parents) {
+		if (!same_tree_as_empty(commit->tree))
+			commit->object.flags |= TREECHANGE;
+		return;
+	}
+
+	pp = &commit->parents;
+	while ((parent = *pp) != NULL) {
 		struct commit *p = parent->item;
-		parent = parent->next;
+
+		if (p->object.flags & UNINTERESTING) {
+			pp = &parent->next;
+			continue;
+		}
+
 		parse_commit(p);
-		if (!p->tree)
+		switch (compare_tree(p->tree, commit->tree)) {
+		case TREE_SAME:
+			parent->next = NULL;
+			commit->parents = parent;
+			return;
+
+		case TREE_NEW:
+			if (remove_empty_trees && same_tree_as_empty(p->tree)) {
+				*pp = parent->next;
+				continue;
+			}
+		/* fallthrough */
+		case TREE_DIFFERENT:
+			pp = &parent->next;
 			continue;
-		if (same_tree(commit->tree, p->tree))
-			return p;
+		}
+		die("bad tree compare for commit %s", sha1_to_hex(commit->object.sha1));
 	}
-	return NULL;
+	commit->object.flags |= TREECHANGE;
 }
 
 static void add_parents_to_list(struct commit *commit, struct commit_list **list)
@@ -531,20 +582,14 @@ static void add_parents_to_list(struct c
 	}
 
 	/*
-	 * Ok, the commit wasn't uninteresting. If it
-	 * is a merge, try to find the parent that has
-	 * no differences in the path set if one exists.
+	 * Ok, the commit wasn't uninteresting. Try to
+	 * simplify the commit history and find the parent
+	 * that has no differences in the path set if one exists.
 	 */
-	if (paths && parent && parent->next) {
-		struct commit *preferred;
-
-		preferred = try_to_simplify_merge(commit, parent);
-		if (preferred) {
-			parent->item = preferred;
-			parent->next = NULL;
-		}
-	}
+	if (paths)
+		try_to_simplify_commit(commit);
 
+	parent = commit->parents;
 	while (parent) {
 		struct commit *p = parent->item;
 
@@ -558,33 +603,6 @@ static void add_parents_to_list(struct c
 	}
 }
 
-static void compress_list(struct commit_list *list)
-{
-	while (list) {
-		struct commit *commit = list->item;
-		struct commit_list *parent = commit->parents;
-		list = list->next;
-
-		if (!parent) {
-			if (!same_tree_as_empty(commit->tree))
-				commit->object.flags |= TREECHANGE;
-			continue;
-		}
-
-		/*
-		 * Exactly one parent? Check if it leaves the tree
-		 * unchanged
-		 */
-		if (!parent->next) {
-			struct tree *t1 = commit->tree;
-			struct tree *t2 = parent->item->tree;
-			if (!t1 || !t2 || same_tree(t1, t2))
-				continue;
-		}
-		commit->object.flags |= TREECHANGE;
-	}
-}
-
 static struct commit_list *limit_list(struct commit_list *list)
 {
 	struct commit_list *newlist = NULL;
@@ -614,8 +632,6 @@ static struct commit_list *limit_list(st
 	}
 	if (tree_objects)
 		mark_edges_uninteresting(newlist);
-	if (paths && dense)
-		compress_list(newlist);
 	if (bisect_list)
 		newlist = find_bisection(newlist);
 	return newlist;
@@ -808,6 +824,10 @@ int main(int argc, const char **argv)
 			dense = 0;
 			continue;
 		}
+		if (!strcmp(arg, "--remove-empty")) {
+			remove_empty_trees = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			i++;
 			break;
