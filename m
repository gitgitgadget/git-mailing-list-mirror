From: "Bernhard R. Link" <brlink@debian.org>
Subject: [PATCH 2/7] add option to only visit the first parent of a equal
	tree merge
Date: Mon, 30 Nov 2009 15:44:18 +0100
Message-ID: <590501c88c7a7b4a7c0c29543775060d4b0e2316.1259524136.git.brlink@debian.org>
References: <cover.1259524136.git.brlink@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 15:44:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF7UG-000705-Ld
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 15:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbZK3OoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 09:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbZK3OoN
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 09:44:13 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:33530
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752154AbZK3OoM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 09:44:12 -0500
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NF7UA-000109-IY
	for git@vger.kernel.org; Mon, 30 Nov 2009 15:44:18 +0100
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NF7UA-0000ql-Gl
	for git@vger.kernel.org; Mon, 30 Nov 2009 15:44:18 +0100
Content-Disposition: inline
In-Reply-To: <cover.1259524136.git.brlink@debian.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134105>

rev_info gets a new flag first_equal_tree_only that causes
revision walks to ignore all but the first parent of equal tree
merges.
The default is off and there are options --first-equal-tree-only
and --all-equal-trees to switch it on/off respectively.

TODO:
 - manpage updates
 - check interaction with some of the other options
---
 revision.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++---------
 revision.h |    1 +
 2 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/revision.c b/revision.c
index a8a3c3a..fb019d6 100644
--- a/revision.c
+++ b/revision.c
@@ -452,6 +452,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 	struct commit_list *parent = commit->parents;
 	unsigned left_flag;
 	struct commit_list *cached_base = cache_ptr ? *cache_ptr : NULL;
+	int first_parent_only;
 
 	if (commit->object.flags & ADDED)
 		return 0;
@@ -499,6 +500,21 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 
 	left_flag = (commit->object.flags & SYMMETRIC_LEFT);
 
+	if (revs->first_parent_only)
+		first_parent_only = 1;
+	else if (revs->first_equal_tree_only && commit->parents) {
+		for (parent = commit->parents; parent; parent = parent->next) {
+			struct commit *p = parent->item;
+
+			if (parse_commit(p) < 0)
+				return -1;
+			if (p->tree != commit->tree)
+				break;
+		}
+		first_parent_only = !parent;
+	} else
+		first_parent_only = 0;
+
 	for (parent = commit->parents; parent; parent = parent->next) {
 		struct commit *p = parent->item;
 
@@ -511,7 +527,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 			p->object.flags |= SEEN;
 			insert_by_date_cached(p, list, cached_base, cache_ptr);
 		}
-		if (revs->first_parent_only)
+		if (first_parent_only)
 			break;
 	}
 	return 0;
@@ -1067,6 +1083,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->min_age = approxidate(arg + 8);
 	} else if (!strcmp(arg, "--first-parent")) {
 		revs->first_parent_only = 1;
+	} else if (!strcmp(arg, "--first-equal-tree-only")) {
+		revs->first_equal_tree_only = 1;
+	} else if (!strcmp(arg, "--all-equal-trees")) {
+		revs->first_equal_tree_only = 0;
 	} else if (!strcmp(arg, "-g") || !strcmp(arg, "--walk-reflogs")) {
 		init_reflog_walk(&revs->reflog_info);
 	} else if (!strcmp(arg, "--default")) {
@@ -1912,6 +1932,16 @@ static void create_boundary_commit_list(struct rev_info *revs)
 	sort_in_topological_order(&revs->commits, revs->lifo);
 }
 
+static inline void add_boundary_commit(struct rev_info *revs, struct commit *c) {
+	struct object *p = &c->object;
+
+	if (p->flags & (CHILD_SHOWN | SHOWN))
+		return;
+	p->flags |= CHILD_SHOWN;
+	gc_boundary(&revs->boundary_commits);
+	add_object_array(p, NULL, &revs->boundary_commits);
+}
+
 static struct commit *get_revision_internal(struct rev_info *revs)
 {
 	struct commit *c = NULL;
@@ -1987,16 +2017,25 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 	 * 'c', we need to mark its parents that they could be boundaries.
 	 */
 
-	for (l = c->parents; l; l = l->next) {
-		struct object *p;
-		p = &(l->item->object);
-		if (p->flags & (CHILD_SHOWN | SHOWN))
-			continue;
-		p->flags |= CHILD_SHOWN;
-		gc_boundary(&revs->boundary_commits);
-		add_object_array(p, NULL, &revs->boundary_commits);
+	if (revs->first_equal_tree_only && c->parents) {
+		for (l = c->parents; l; l = l->next) {
+			struct commit *p = l->item;
+			parse_commit(p);
+			if (c->tree != p->tree)
+				break;
+		}
+		/* if all parents have the same tree as this node,
+		 * it's an equal tree merge, so ignore all but the
+		 * first parent */
+		if (!l) {
+			add_boundary_commit(revs, c->parents->item);
+			return c;
+		}
 	}
 
+	for (l = c->parents; l; l = l->next) {
+		add_boundary_commit(revs, l->item);
+	}
 	return c;
 }
 
diff --git a/revision.h b/revision.h
index d368003..7ac263c 100644
--- a/revision.h
+++ b/revision.h
@@ -64,6 +64,7 @@ struct rev_info {
 			reverse_output_stage:1,
 			cherry_pick:1,
 			bisect:1,
+			first_equal_tree_only:1,
 			first_parent_only:1;
 
 	/* Diff flags */
