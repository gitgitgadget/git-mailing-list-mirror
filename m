From: Linus Torvalds <torvalds@osdl.org>
Subject: Teach git-rev-list to follow just a specified set of files
Date: Thu, 20 Oct 2005 21:25:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510202105140.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Oct 21 06:27:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESoT4-000370-JI
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 06:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbVJUEZR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 00:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbVJUEZR
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 00:25:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7817 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964865AbVJUEZP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 00:25:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9L4PAFC011450
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 20 Oct 2005 21:25:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9L4P9kX023172;
	Thu, 20 Oct 2005 21:25:10 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0.224 required=5 tests=REMOVE_REMOVAL_NEAR
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10419>


This is the first cut at a git-rev-list that knows to ignore commits that 
don't change a certain file (or set of files).

NOTE! For now it only prunes _merge_ commits, and follows the parent where 
there are no differences in the set of files specified. In the long run, 
I'd like to make it re-write the straight-line history too, but for now 
the merge simplification is much more fundamentally important (the 
rewriting of straight-line history is largely a separate simplification 
phase, but the merge simplification needs to happen early if we want to 
optimize away unnecessary commit parsing).

If all parents of a merge change some of the files, the merge is left as 
is, so the end result is in no way guaranteed to be a linear history, but 
it will often be a lot /more/ linear than the full tree, since it prunes 
out parents that didn't matter for that set of files.

As an example from the current kernel:

	[torvalds@g5 linux]$ git-rev-list HEAD | wc -l
	9885
	[torvalds@g5 linux]$ git-rev-list HEAD -- Makefile | wc -l
	4084
	[torvalds@g5 linux]$ git-rev-list HEAD -- drivers/usb | wc -l
	5206

and you can also use 'gitk' to more visually see the pruning of the 
history tree, with something like

	gitk -- drivers/usb

showing a simplified history that tries to follow the first parent in a 
merge that is the parent that fully defines drivers/usb/.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This should make it much more efficient to do something like a 
git-annotate. The merges are the expensive part. Normal straigh-line 
commits that don't change something is pretty easy.

NOTE! For that "gitk" command line to work, you need to have applied both 
of my rev-list.c patches from earlier today..

NOTE 2! At least for now, git-rev-list requires the "--" between the revs 
and the filenames. That's actually very inconsistent: all the other git 
tools that take filenames will just assume that something that isn't a rev 
and isn't a flag must be a filename.

I'd actually like to make git-rev-list work that way too (it would make 
the syntax for gitk etc much more natural), but I chickened out 
(git-rev-list used to error out when it didn't recognize a rev, and this 
ugly syntax keeps that as an error case. Whether it's for a good reason or 
not, I don't know).

NOTE 3! I've tested this, and it all _seems_ to work. But hey, this is 
even more "core" than git-diff-tree, so buyer beware!

diff --git a/rev-list.c b/rev-list.c
index 3a32e40..b5dbb9f 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -5,6 +5,7 @@
 #include "tree.h"
 #include "blob.h"
 #include "epoch.h"
+#include "diff.h"
 
 #define SEEN		(1u << 0)
 #define INTERESTING	(1u << 1)
@@ -44,6 +45,7 @@ static int show_breaks = 0;
 static int stop_traversal = 0;
 static int topo_order = 0;
 static int no_merges = 0;
+static const char **paths = NULL;
 
 static void show_commit(struct commit *commit)
 {
@@ -377,18 +379,129 @@ static void mark_edges_uninteresting(str
 	}
 }
 
+static int is_different = 0;
+
+static void file_add_remove(struct diff_options *options,
+		    int addremove, unsigned mode,
+		    const unsigned char *sha1,
+		    const char *base, const char *path)
+{
+	is_different = 1;
+}
+
+static void file_change(struct diff_options *options,
+		 unsigned old_mode, unsigned new_mode,
+		 const unsigned char *old_sha1,
+		 const unsigned char *new_sha1,
+		 const char *base, const char *path)
+{
+	is_different = 1;
+}
+
+static struct diff_options diff_opt = {
+	.recursive = 1,
+	.add_remove = file_add_remove,
+	.change = file_change,
+};
+
+static struct commit *try_to_simplify_merge(struct commit *commit, struct commit_list *parent)
+{
+	if (!commit->tree)
+		return NULL;
+
+	while (parent) {
+		struct commit *p = parent->item;
+		parent = parent->next;
+		parse_commit(p);
+		if (!p->tree)
+			continue;
+		is_different = 0;
+		if (diff_tree_sha1(commit->tree->object.sha1,
+				   p->tree->object.sha1, "", &diff_opt) < 0)
+			continue;
+		if (!is_different)
+			return p;
+	}
+	return NULL;
+}
+
+static void add_parents_to_list(struct commit *commit, struct commit_list **list)
+{
+	struct commit_list *parent = commit->parents;
+
+	/*
+	 * If the commit is uninteresting, don't try to
+	 * prune parents - we want the maximal uninteresting
+	 * set.
+	 *
+	 * Normally we haven't parsed the parent
+	 * yet, so we won't have a parent of a parent
+	 * here. However, it may turn out that we've
+	 * reached this commit some other way (where it
+	 * wasn't uninteresting), in which case we need
+	 * to mark its parents recursively too..
+	 */
+	if (commit->object.flags & UNINTERESTING) {
+		while (parent) {
+			struct commit *p = parent->item;
+			parent = parent->next;
+			parse_commit(p);
+			p->object.flags |= UNINTERESTING;
+			if (p->parents)
+				mark_parents_uninteresting(p);
+			if (p->object.flags & SEEN)
+				continue;
+			p->object.flags |= SEEN;
+			insert_by_date(p, list);
+		}
+		return;
+	}
+
+	/*
+	 * Ok, the commit wasn't uninteresting. If it
+	 * is a merge, try to find the parent that has
+	 * no differences in the path set if one exists.
+	 */
+	if (paths && parent && parent->next) {
+		struct commit *preferred;
+
+		preferred = try_to_simplify_merge(commit, parent);
+		if (preferred) {
+			parent->item = preferred;
+			parent->next = NULL;
+		}
+	}
+
+	while (parent) {
+		struct commit *p = parent->item;
+
+		parent = parent->next;
+
+		parse_commit(p);
+		if (p->object.flags & SEEN)
+			continue;
+		p->object.flags |= SEEN;
+		insert_by_date(p, list);
+	}
+}
+
 static struct commit_list *limit_list(struct commit_list *list)
 {
 	struct commit_list *newlist = NULL;
 	struct commit_list **p = &newlist;
 	while (list) {
-		struct commit *commit = pop_most_recent_commit(&list, SEEN);
+		struct commit_list *entry = list;
+		struct commit *commit = list->item;
 		struct object *obj = &commit->object;
 
+		list = list->next;
+		free(entry);
+
 		if (max_age != -1 && (commit->date < max_age))
 			obj->flags |= UNINTERESTING;
 		if (unpacked && has_sha1_pack(obj->sha1))
 			obj->flags |= UNINTERESTING;
+		add_parents_to_list(commit, &list);
 		if (obj->flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
 			if (everybody_uninteresting(list))
@@ -507,15 +620,15 @@ static void handle_all(struct commit_lis
 	global_lst = NULL;
 }
 
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
+	const char *prefix = setup_git_directory();
 	struct commit_list *list = NULL;
 	int i, limited = 0;
 
-	setup_git_directory();
 	for (i = 1 ; i < argc; i++) {
 		int flags;
-		char *arg = argv[i];
+		const char *arg = argv[i];
 		char *dotdot;
 		struct commit *commit;
 
@@ -587,6 +700,14 @@ int main(int argc, char **argv)
 		        limited = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--")) {
+			paths = get_pathspec(prefix, argv + i + 1);
+			if (paths) {
+				limited = 1;
+				diff_tree_setup_paths(paths);
+			}
+			break;
+		}
 
 		if (show_breaks && !merge_order)
 			usage(rev_list_usage);
