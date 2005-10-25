From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list: add "--dense" flag
Date: Tue, 25 Oct 2005 11:50:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510251137110.10477@g5.osdl.org>
References: <Pine.LNX.4.64.0510211631400.10477@g5.osdl.org>
 <20051025180707.GA7463@diku.dk> <Pine.LNX.4.64.0510251110050.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 25 20:53:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUTtG-0007P5-GT
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 20:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVJYSvP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 14:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbVJYSvP
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 14:51:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29163 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932299AbVJYSvO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 14:51:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9PIooFC012965
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Oct 2005 11:50:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9PIoktU023618;
	Tue, 25 Oct 2005 11:50:48 -0700
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <Pine.LNX.4.64.0510251110050.10477@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10608>



On Tue, 25 Oct 2005, Linus Torvalds wrote:
> 
> Right now --dense will _always_ show the root commit. I didn't do the 
> logic that does the diff against an empty tree. I was lazy.
> 
> This patch does that, and may or may not work.

Never mind. It's incorrect. 

It's -close- to being correct, but it will SIGSEGV because now the root 
won't necessarily have the TREECHANGED flag, so now it can follow the root 
down to its parents (which is a NULL pointer - that's the definition of a 
root commit, of course).

It needs to remove the parent pointers that become NULL.

This patch is even slightly tested, and might do a better job.

[ Sorry for sending untested crap out, but I have a fairly good track 
  record in general. Testing is for wimps ]

		Linus

---
diff --git a/rev-list.c b/rev-list.c
index 5f125fd..edf3b37 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -81,23 +81,28 @@ static void show_commit(struct commit *c
 	fflush(stdout);
 }
 
-static void rewrite_one(struct commit **pp)
+static int rewrite_one(struct commit **pp)
 {
 	for (;;) {
 		struct commit *p = *pp;
 		if (p->object.flags & (TREECHANGE | UNINTERESTING))
-			return;
-		/* Only single-parent commits don't have TREECHANGE */
+			return 0;
+		if (!p->parents)
+			return -1;
 		*pp = p->parents->item;
 	}
 }
 
 static void rewrite_parents(struct commit *commit)
 {
-	struct commit_list *parent = commit->parents;
-	while (parent) {
-		rewrite_one(&parent->item);
-		parent = parent->next;
+	struct commit_list **pp = &commit->parents;
+	while (*pp) {
+		struct commit_list *parent = *pp;
+		if (rewrite_one(&parent->item) < 0) {
+			*pp = parent->next;
+			continue;
+		}
+		pp = &parent->next;
 	}
 }
 
@@ -439,6 +444,30 @@ static int same_tree(struct tree *t1, st
 	return !is_different;
 }
 
+static int same_tree_as_empty(struct tree *t1)
+{
+	int retval;
+	void *tree;
+	struct tree_desc empty, real;
+
+	if (!t1)
+		return 0;
+
+	tree = read_object_with_reference(t1->object.sha1, "tree", &real.size, NULL);
+	if (!tree)
+		return 0;
+	real.buf = tree;
+
+	empty.buf = "";
+	empty.size = 0;
+
+	is_different = 0;
+	retval = diff_tree(&empty, &real, "", &diff_opt);
+	free(tree);
+
+	return retval >= 0 && !is_different;
+}
+
 static struct commit *try_to_simplify_merge(struct commit *commit, struct commit_list *parent)
 {
 	if (!commit->tree)
@@ -523,11 +552,17 @@ static void compress_list(struct commit_
 		struct commit_list *parent = commit->parents;
 		list = list->next;
 
+		if (!parent) {
+			if (!same_tree_as_empty(commit->tree))
+				commit->object.flags |= TREECHANGE;
+			continue;
+		}
+
 		/*
 		 * Exactly one parent? Check if it leaves the tree
 		 * unchanged
 		 */
-		if (parent && !parent->next) {
+		if (!parent->next) {
 			struct tree *t1 = commit->tree;
 			struct tree *t2 = parent->item->tree;
 			if (!t1 || !t2 || same_tree(t1, t2))
