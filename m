From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Joining Repositories
Date: Wed, 18 Jan 2006 12:09:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601181128060.3240@g5.osdl.org>
References: <200601181325.59832.Mathias.Waack@rantzau.de>
 <20060118125158.GN28365@pasky.or.cz> <20060118140917.GA15438@mythryan2.michonline.com>
 <Pine.LNX.4.64.0601180813170.3240@g5.osdl.org> <7vbqy9xx2r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0601181010410.3240@g5.osdl.org> <7vslrluze6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 21:10:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzJcs-0005bT-Gi
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 21:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbWARUJr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 15:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbWARUJr
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 15:09:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61326 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030406AbWARUJq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 15:09:46 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0IK9gDZ024466
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Jan 2006 12:09:42 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0IK9fHr027593;
	Wed, 18 Jan 2006 12:09:42 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslrluze6.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0.224 required=5 tests=REMOVE_REMOVAL_NEAR
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.66__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14864>



On Wed, 18 Jan 2006, Junio C Hamano wrote:
> 
> Sorry for having brought up the issue again.  I personally do
> not disagree with you.  Because I did not want to waste your
> time rehashing it, I attempted to make it absolutely clear that
> I was talking about an _optional_ way to tell the tool to do so,
> when somebody so used to "annotate" wants to.  Obviously my
> attempt did not work well X-<.

Well, the main reason I did the "limit git-rev-list with pathnames" was 
literally to try to help the "annotate one file".

So I don't think file following has anything to do with "git-whatchanged". 
It's literally an op we don't have yet - and that we should have. It 
really should be pretty straighforward to do a "git annotate" these days. 
It will never be as fast as git-whatchanged, but it shouldn't be horribly 
inefficient either.

The one thing I've considered doing (I really should) is to add a "stop 
when you don't find the file" option to "git-rev-list". This patch does 
some of the work towards that: it removes the "parent" thing when the 
file disappears, so a "git annotate" could do do something like

	git-rev-list --remove-empty --parents HEAD -- "$filename"

and it would get a good graph that stops when the filename disappears 
(it's not perfect though: it won't remove all the unintersting commits).

		Linus

----
diff --git a/rev-list.c b/rev-list.c
index d060966..3906674 100644
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
@@ -474,26 +498,38 @@ static int same_tree_as_empty(struct tre
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
+static struct commit *try_to_simplify_merge(struct commit *commit)
 {
+	struct commit_list **pp, *parent;
+
 	if (!commit->tree)
 		return NULL;
 
-	while (parent) {
+	pp = &commit->parents;
+	while ((parent = *pp) != NULL) {
 		struct commit *p = parent->item;
-		parent = parent->next;
 		parse_commit(p);
-		if (!p->tree)
-			continue;
-		if (same_tree(commit->tree, p->tree))
+		switch (compare_tree(p->tree, commit->tree)) {
+		case TREE_SAME:
 			return p;
+		case TREE_NEW:
+			if (remove_empty_trees) {
+				*pp = parent->next;
+				continue;
+			}
+		/* fallthrough */
+		case TREE_DIFFERENT:
+			pp = &parent->next;
+			continue;
+		}
+		die("bad tree compare for commit %s", sha1_to_hex(commit->object.sha1));
 	}
 	return NULL;
 }
@@ -538,7 +574,7 @@ static void add_parents_to_list(struct c
 	if (paths && parent && parent->next) {
 		struct commit *preferred;
 
-		preferred = try_to_simplify_merge(commit, parent);
+		preferred = try_to_simplify_merge(commit);
 		if (preferred) {
 			parent->item = preferred;
 			parent->next = NULL;
@@ -576,10 +612,18 @@ static void compress_list(struct commit_
 		 * unchanged
 		 */
 		if (!parent->next) {
-			struct tree *t1 = commit->tree;
-			struct tree *t2 = parent->item->tree;
-			if (!t1 || !t2 || same_tree(t1, t2))
+			struct tree *t1 = parent->item->tree;
+			struct tree *t2 = commit->tree;
+			switch (compare_tree(t1, t2)) {
+			case TREE_SAME:
 				continue;
+			case TREE_NEW:
+				if (remove_empty_trees)
+					commit->parents = NULL;
+				break;
+			case TREE_DIFFERENT:
+				break;
+			}
 		}
 		commit->object.flags |= TREECHANGE;
 	}
@@ -808,6 +852,10 @@ int main(int argc, const char **argv)
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
