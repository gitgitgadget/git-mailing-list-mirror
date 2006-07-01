From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Enable tree (directory) history display
Date: Fri, 30 Jun 2006 20:21:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606301954140.12404@g5.osdl.org>
References: <20060701024309.63001.qmail@web31805.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 05:22:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwW3g-0005S2-Kb
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 05:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbWGADWI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 23:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbWGADWI
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 23:22:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60387 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751727AbWGADWG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 23:22:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k613M0nW023902
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 30 Jun 2006 20:22:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k613Lxhq008547;
	Fri, 30 Jun 2006 20:21:59 -0700
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20060701024309.63001.qmail@web31805.mail.mud.yahoo.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23037>



On Fri, 30 Jun 2006, Luben Tuikov wrote:
> 
> I took a comparative look with and without "--full-history",
> and FWIW, enabling full history just clobbers the output with a lot
> of unnecessary information.  I.e. it shows merges which do not have
> direct consequence or change to the files in the path spec specified
> after the "--".

Oh, you're right - "--full-history" right now is literally geared solely 
towards the graphical kind, which needs all the merges (regardless of 
whether they change a file or not) to make sense of the history.

> I.e. no new, relevant information is being shown when "--full-history"
> is enabled.  In fact the default git-rev-list case, simplify_history=1,
> still shows a merge here and there which doesn't have any direct
> changes into what is being sought, but the difference is
> about 48% less clobber.

Well, with history simplification, we still show merges that are required 
to make the history _complete_, ie say that you had

	  a
	  |
	  b
	 / \
	c   d
	|   |

and neither "a" nor "b" actually changed the file, but both "c" and "d" 
did: in this case we have to leave "b" around just because otherwise there 
would be no way to show the _relationship_, even if "b" itself doesn't 
actually change the tree in any way what-so-ever.

> Can you consider the default case to be simplify_history=1,
> which is currently the default behaviour of git-rev-list.

Actually, for your case, you don't want _any_ merges, unless those merges 
literally changed the tree from all of the parents.

I think it would make sense to make that further simplification if the 
"--parents" flag wasn't present. 

Hmm. Maybe something like this..

BTW! Junio, I think this patch actually fixes a real bug.

Without this patch, the "--parents --full-history" combination (which 
you'd get if you do something like

	gitk --full-history Makefile

or similar) will actually _drop_ merges where all children are identical. 
That's wrong in the --full-history case, because it measn that the graph 
ends up missing lots of entries.

In the process, this also should make

	git-rev-list --full-history Makefile

give just the _true_ list of all commits that changed Makefile (and 
properly ignore merges that were identical in one parent), because now 
we're not asking for "--parent", so we don't need the unnecessary merge 
commits to keep the history together.

Luben, does this fix the problem for you?

		Linus

----
diff --git a/revision.c b/revision.c
index b963f2a..1cf6276 100644
--- a/revision.c
+++ b/revision.c
@@ -280,7 +280,7 @@ int rev_same_tree_as_empty(struct rev_in
 static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_list **pp, *parent;
-	int tree_changed = 0;
+	int tree_changed = 0, tree_same = 0;
 
 	if (!commit->tree)
 		return;
@@ -298,6 +298,7 @@ static void try_to_simplify_commit(struc
 		parse_commit(p);
 		switch (rev_compare_tree(revs, p->tree, commit->tree)) {
 		case REV_TREE_SAME:
+			tree_same = 1;
 			if (!revs->simplify_history || (p->object.flags & UNINTERESTING)) {
 				/* Even if a merge with an uninteresting
 				 * side branch brought the entire change
@@ -334,7 +335,7 @@ static void try_to_simplify_commit(struc
 		}
 		die("bad tree compare for commit %s", sha1_to_hex(commit->object.sha1));
 	}
-	if (tree_changed)
+	if (tree_changed && !tree_same)
 		commit->object.flags |= TREECHANGE;
 }
 
@@ -896,6 +897,8 @@ static int rewrite_one(struct rev_info *
 		struct commit *p = *pp;
 		if (!revs->limited)
 			add_parents_to_list(revs, p, &revs->commits);
+		if (p->parents && p->parents->next)
+			return 0;
 		if (p->object.flags & (TREECHANGE | UNINTERESTING))
 			return 0;
 		if (!p->parents)
@@ -988,8 +991,15 @@ struct commit *get_revision(struct rev_i
 		    commit->parents && commit->parents->next)
 			continue;
 		if (revs->prune_fn && revs->dense) {
-			if (!(commit->object.flags & TREECHANGE))
-				continue;
+			/* Commit without changes? */
+			if (!(commit->object.flags & TREECHANGE)) {
+				/* drop merges unless we want parenthood */
+				if (!revs->parents)
+					continue;
+				/* non-merge - always ignore it */
+				if (commit->parents && !commit->parents->next)
+					continue;
+			}
 			if (revs->parents)
 				rewrite_parents(revs, commit);
 		}
