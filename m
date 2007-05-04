From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Handle return code of parse_commit in revision machinery
Date: Fri, 4 May 2007 23:54:57 +0200
Message-ID: <20070504215457.GE4033@steel.home>
References: <81b0412b0705040225p26679dbib6a1261a1a43ee67@mail.gmail.com> <7vy7k4ud3d.fsf@assigned-by-dhcp.cox.net> <81b0412b0705040342p4fed3a4bnee92cce6b5fb6b9@mail.gmail.com> <7vslacttij.fsf@assigned-by-dhcp.cox.net> <81b0412b0705041024i43d7fc5ah1967d6a6192dc6ee@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 04 23:55:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk5jz-0007dC-SJ
	for gcvg-git@gmane.org; Fri, 04 May 2007 23:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767718AbXEDVzA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 17:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161930AbXEDVzA
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 17:55:00 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:48443 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161560AbXEDVy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 17:54:59 -0400
Received: from tigra.home (195.4.202.37)
	by post.webmailer.de (fruni mo39) (RZmta 5.9)
	with ESMTP id I0497ej44L95gl ; Fri, 4 May 2007 23:54:57 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 88C2B277BD;
	Fri,  4 May 2007 23:54:57 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 5206ED171; Fri,  4 May 2007 23:54:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81b0412b0705041024i43d7fc5ah1967d6a6192dc6ee@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTl9Ag==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46221>

This fixes a crash in broken repositories where random commits
suddenly disappear.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

... For example when loosing one of the packs by renaming it into a
random name while trying to figure out how to protect it from deletion
by "git-repack -a -d". Lesson learned, code fixed, tests passed.

 revision.c |   75 +++++++++++++++++++++++++++++++++++++++++------------------
 revision.h |    2 +-
 2 files changed, 53 insertions(+), 24 deletions(-)

diff --git a/revision.c b/revision.c
index e60a26c..b4c494d 100644
--- a/revision.c
+++ b/revision.c
@@ -318,7 +318,10 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 	while ((parent = *pp) != NULL) {
 		struct commit *p = parent->item;
 
-		parse_commit(p);
+		if (parse_commit(p) < 0)
+			die("cannot simplify commit %s (because of %s)",
+			    sha1_to_hex(commit->object.sha1),
+			    sha1_to_hex(p->object.sha1));
 		switch (rev_compare_tree(revs, p->tree, commit->tree)) {
 		case REV_TREE_SAME:
 			tree_same = 1;
@@ -347,7 +350,10 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 				 * IOW, we pretend this parent is a
 				 * "root" commit.
 				 */
-				parse_commit(p);
+				if(parse_commit(p) < 0)
+					die("cannot simplify commit %s (invalid %s)",
+					    sha1_to_hex(commit->object.sha1),
+					    sha1_to_hex(p->object.sha1));
 				p->parents = NULL;
 			}
 		/* fallthrough */
@@ -362,14 +368,14 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		commit->object.flags |= TREECHANGE;
 }
 
-static void add_parents_to_list(struct rev_info *revs, struct commit *commit, struct commit_list **list)
+static int add_parents_to_list(struct rev_info *revs, struct commit *commit, struct commit_list **list)
 {
 	struct commit_list *parent = commit->parents;
 	unsigned left_flag;
 	int add, rest;
 
 	if (commit->object.flags & ADDED)
-		return;
+		return 0;
 	commit->object.flags |= ADDED;
 
 	/*
@@ -388,7 +394,8 @@ static void add_parents_to_list(struct rev_info *revs, struct commit *commit, st
 		while (parent) {
 			struct commit *p = parent->item;
 			parent = parent->next;
-			parse_commit(p);
+			if (parse_commit(p) < 0)
+				return -1;
 			p->object.flags |= UNINTERESTING;
 			if (p->parents)
 				mark_parents_uninteresting(p);
@@ -397,7 +404,7 @@ static void add_parents_to_list(struct rev_info *revs, struct commit *commit, st
 			p->object.flags |= SEEN;
 			insert_by_date(p, list);
 		}
-		return;
+		return 0;
 	}
 
 	/*
@@ -409,7 +416,7 @@ static void add_parents_to_list(struct rev_info *revs, struct commit *commit, st
 		revs->prune_fn(revs, commit);
 
 	if (revs->no_walk)
-		return;
+		return 0;
 
 	left_flag = (commit->object.flags & SYMMETRIC_LEFT);
 
@@ -418,7 +425,8 @@ static void add_parents_to_list(struct rev_info *revs, struct commit *commit, st
 		struct commit *p = parent->item;
 
 		parent = parent->next;
-		parse_commit(p);
+		if (parse_commit(p) < 0)
+			return -1;
 		p->object.flags |= left_flag;
 		if (p->object.flags & SEEN)
 			continue;
@@ -426,6 +434,7 @@ static void add_parents_to_list(struct rev_info *revs, struct commit *commit, st
 		if (add)
 			insert_by_date(p, list);
 	}
+	return 0;
 }
 
 static void cherry_pick_list(struct commit_list *list)
@@ -508,7 +517,7 @@ static void cherry_pick_list(struct commit_list *list)
 	free_patch_ids(&ids);
 }
 
-static void limit_list(struct rev_info *revs)
+static int limit_list(struct rev_info *revs)
 {
 	struct commit_list *list = revs->commits;
 	struct commit_list *newlist = NULL;
@@ -524,7 +533,8 @@ static void limit_list(struct rev_info *revs)
 
 		if (revs->max_age != -1 && (commit->date < revs->max_age))
 			obj->flags |= UNINTERESTING;
-		add_parents_to_list(revs, commit, &list);
+		if (add_parents_to_list(revs, commit, &list) < 0)
+			return -1;
 		if (obj->flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
 			if (everybody_uninteresting(list))
@@ -539,6 +549,7 @@ static void limit_list(struct rev_info *revs)
 		cherry_pick_list(newlist);
 
 	revs->commits = newlist;
+	return 0;
 }
 
 struct all_refs_cb {
@@ -1227,7 +1238,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 	return left;
 }
 
-void prepare_revision_walk(struct rev_info *revs)
+int prepare_revision_walk(struct rev_info *revs)
 {
 	int nr = revs->pending.nr;
 	struct object_array_entry *e, *list;
@@ -1249,42 +1260,59 @@ void prepare_revision_walk(struct rev_info *revs)
 	free(list);
 
 	if (revs->no_walk)
-		return;
+		return 0;
 	if (revs->limited)
-		limit_list(revs);
+		if (limit_list(revs) < 0)
+			return -1;
 	if (revs->topo_order)
 		sort_in_topological_order_fn(&revs->commits, revs->lifo,
 					     revs->topo_setter,
 					     revs->topo_getter);
+	return 0;
 }
 
-static int rewrite_one(struct rev_info *revs, struct commit **pp)
+enum rewrite_result
+{
+	rewrite_one_ok,
+	rewrite_one_noparents,
+	rewrite_one_error,
+};
+
+static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp)
 {
 	for (;;) {
 		struct commit *p = *pp;
 		if (!revs->limited)
-			add_parents_to_list(revs, p, &revs->commits);
+			if (add_parents_to_list(revs, p, &revs->commits) < 0)
+				return rewrite_one_error;
 		if (p->parents && p->parents->next)
-			return 0;
+			return rewrite_one_ok;
 		if (p->object.flags & (TREECHANGE | UNINTERESTING))
-			return 0;
+			return rewrite_one_ok;
 		if (!p->parents)
-			return -1;
+			return rewrite_one_noparents;
 		*pp = p->parents->item;
 	}
 }
 
-static void rewrite_parents(struct rev_info *revs, struct commit *commit)
+static int rewrite_parents(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_list **pp = &commit->parents;
 	while (*pp) {
 		struct commit_list *parent = *pp;
-		if (rewrite_one(revs, &parent->item) < 0) {
+		switch (rewrite_one(revs, &parent->item))
+		{
+		case rewrite_one_ok:
+			break;
+		case rewrite_one_noparents:
 			*pp = parent->next;
 			continue;
+		case rewrite_one_error:
+			return -1;
 		}
 		pp = &parent->next;
 	}
+	return 0;
 }
 
 static int commit_match(struct commit *commit, struct rev_info *opt)
@@ -1320,7 +1348,8 @@ static struct commit *get_revision_1(struct rev_info *revs)
 			if (revs->max_age != -1 &&
 			    (commit->date < revs->max_age))
 				continue;
-			add_parents_to_list(revs, commit, &revs->commits);
+			if (add_parents_to_list(revs, commit, &revs->commits) < 0)
+				return NULL;
 		}
 		if (commit->object.flags & SHOWN)
 			continue;
@@ -1348,8 +1377,8 @@ static struct commit *get_revision_1(struct rev_info *revs)
 				if (!commit->parents || !commit->parents->next)
 					continue;
 			}
-			if (revs->parents)
-				rewrite_parents(revs, commit);
+			if (revs->parents && rewrite_parents(revs, commit) < 0)
+				return NULL;
 		}
 		return commit;
 	} while (revs->commits);
diff --git a/revision.h b/revision.h
index cdf94ad..2845167 100644
--- a/revision.h
+++ b/revision.h
@@ -113,7 +113,7 @@ extern void init_revisions(struct rev_info *revs, const char *prefix);
 extern int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def);
 extern int handle_revision_arg(const char *arg, struct rev_info *revs,int flags,int cant_be_filename);
 
-extern void prepare_revision_walk(struct rev_info *revs);
+extern int prepare_revision_walk(struct rev_info *revs);
 extern struct commit *get_revision(struct rev_info *revs);
 
 extern void mark_parents_uninteresting(struct commit *commit);
-- 
1.5.2.rc1.21.g80e79
