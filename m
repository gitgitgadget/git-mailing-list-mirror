From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 05/11] Bulk allocate struct commit_list, as we do for struct commit
Date: Fri, 9 Nov 2007 06:06:24 -0500
Message-ID: <20071109110623.GE19368@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 12:07:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqRhI-0007XS-7O
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 12:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758242AbXKILGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 06:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756118AbXKILGa
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 06:06:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34095 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbXKILG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 06:06:27 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IqRgs-0003CV-Lc; Fri, 09 Nov 2007 06:06:22 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1122120FBAE; Fri,  9 Nov 2007 06:06:24 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64157>

Typically every commit has at least one struct commit_list allocated
for its parent.  It is also not uncommon for there to be more than
one allocated per commit, especially if merges are common in this
repository.

Running `git rev-list --all` doesn't usually wind up requiring many
commit_list items (about 1024 for git.git right now) as the commits
are output as soon as they are first seen and then the parent list
is freed as it is no longer necessary for traversal.  However when
we add --topo-order or --date-order and request sorting the lists
are not deallocated until after sorting is complete.  Any memory
they consume during that time just increases our footprint.

In git.git for 15865 commits we need 50354 commit_lists to complete
a --topo-order sort.  That's an average of 3 commit_list items per
commit (I blame my local reflogs of Junio's pu branch for the high
ratio of commits to their parents).  With that kind of allocation
individually mallocing them is wasting a lot of memory for these
very small and otherwise lightwight objects.

Aside from reducing our memory usage during the --topo-order
sorting case a major benefit from allocating these by blocks is we
can release them enmass when we release the other objects in the
object pool.  This reduces the cost of the scrub_commit() function
as it no longer needs to free each parent entry individually.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 alloc.c               |    5 ++++-
 builtin-diff-tree.c   |    8 ++------
 builtin-rev-parse.c   |    2 +-
 builtin-send-pack.c   |    2 +-
 builtin-show-branch.c |    2 +-
 cache.h               |    2 ++
 commit.c              |   13 ++++++-------
 http-push.c           |    2 +-
 reflog-walk.c         |    2 +-
 revision.c            |    6 +++---
 upload-pack.c         |    2 +-
 11 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/alloc.c b/alloc.c
index 5737a73..b69f613 100644
--- a/alloc.c
+++ b/alloc.c
@@ -51,7 +51,7 @@ static void report(const char* name, struct node_pool *p, size_t sz)
 	count -= p->nr;
 
 	sz = (count * sz) >> 10;
-	fprintf(stderr, "%10s: %8u (" SZ_FMT " kB)", name, count, sz);
+	fprintf(stderr, "%15s: %8u (" SZ_FMT " kB)", name, count, sz);
 	if (free)
 		fprintf(stderr, ", %8u on free list", free);
 	fputc('\n', stderr);
@@ -144,6 +144,7 @@ static void scrub_any_object(union any_object *o)
 	}
 }
 
+DEFINE_ALLOCATOR(commit_list, struct commit_list)
 DEFINE_ALLOCATOR(blob, struct blob)
 DEFINE_SCRUBBING_ALLOCATOR(tree, struct tree, scrub_tree)
 DEFINE_SCRUBBING_ALLOCATOR(commit, struct commit, scrub_commit)
@@ -155,6 +156,7 @@ void alloc_report(void)
 	report_blob();
 	report_tree();
 	report_commit();
+	report_commit_list();
 	report_tag();
 	report_object();
 }
@@ -164,6 +166,7 @@ void alloc_free_everything(void)
 	free_all_blob();
 	free_all_tree();
 	free_all_commit();
+	free_all_commit_list();
 	free_all_tag();
 	free_all_object();
 }
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 0b591c8..eb340d2 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -31,14 +31,10 @@ static int diff_tree_stdin(char *line)
 	if (isspace(line[40]) && !get_sha1_hex(line+41, sha1)) {
 		/* Graft the fake parents locally to the commit */
 		int pos = 41;
-		struct commit_list **pptr, *parents;
+		struct commit_list **pptr;
 
 		/* Free the real parent list */
-		for (parents = commit->parents; parents; ) {
-			struct commit_list *tmp = parents->next;
-			free(parents);
-			parents = tmp;
-		}
+		free_commit_list(commit->parents);
 		commit->parents = NULL;
 		pptr = &(commit->parents);
 		while (line[pos] && !get_sha1_hex(line + pos, sha1)) {
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index d1038a0..7500814 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -200,7 +200,7 @@ static int try_difference(const char *arg)
 				struct commit_list *n = exclude->next;
 				show_rev(REVERSED,
 					 exclude->item->object.sha1,NULL);
-				free(exclude);
+				free_commit_list_node(exclude);
 				exclude = n;
 			}
 		}
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 5a0f5c6..818519e 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -82,7 +82,7 @@ static void unmark_and_free(struct commit_list *list, unsigned int mark)
 		struct commit_list *temp = list;
 		temp->item->object.flags &= ~mark;
 		list = temp->next;
-		free(temp);
+		free_commit_list_node(temp);
 	}
 }
 
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 6dc835d..f10377c 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -38,7 +38,7 @@ static struct commit *pop_one_commit(struct commit_list **list_p)
 	list = *list_p;
 	commit = list->item;
 	*list_p = list->next;
-	free(list);
+	free_commit_list_node(list);
 	return commit;
 }
 
diff --git a/cache.h b/cache.h
index 8289de1..a33c8ee 100644
--- a/cache.h
+++ b/cache.h
@@ -586,6 +586,8 @@ extern void *alloc_tree_node(void);
 extern void *alloc_commit_node(void);
 extern void *alloc_tag_node(void);
 extern void *alloc_object_node(void);
+extern void *alloc_commit_list_node(void);
+extern void free_commit_list_node(void *);
 extern void alloc_report(void);
 extern void alloc_free_everything(void);
 
diff --git a/commit.c b/commit.c
index 05f3cd6..796fc59 100644
--- a/commit.c
+++ b/commit.c
@@ -320,13 +320,12 @@ int parse_commit(struct commit *item)
 
 void scrub_commit(struct commit *item)
 {
-	free_commit_list(item->parents);
 	free(item->buffer);
 }
 
 struct commit_list *commit_list_insert(struct commit *item, struct commit_list **list_p)
 {
-	struct commit_list *new_list = xmalloc(sizeof(struct commit_list));
+	struct commit_list *new_list = alloc_commit_list_node();
 	new_list->item = item;
 	new_list->next = *list_p;
 	*list_p = new_list;
@@ -338,7 +337,7 @@ void free_commit_list(struct commit_list *list)
 	while (list) {
 		struct commit_list *temp = list;
 		list = temp->next;
-		free(temp);
+		free_commit_list_node(temp);
 	}
 }
 
@@ -374,7 +373,7 @@ struct commit *pop_most_recent_commit(struct commit_list **list,
 	struct commit_list *old = *list;
 
 	*list = (*list)->next;
-	free(old);
+	free_commit_list_node(old);
 
 	while (parents) {
 		struct commit *commit = parents->item;
@@ -416,7 +415,7 @@ struct commit *pop_commit(struct commit_list **stack)
 
 	if (top) {
 		*stack = top->next;
-		free(top);
+		free_commit_list_node(top);
 	}
 	return item;
 }
@@ -561,7 +560,7 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
 
 		commit = list->item;
 		n = list->next;
-		free(list);
+		free_commit_list_node(list);
 		list = n;
 
 		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
@@ -592,7 +591,7 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
 		struct commit_list *n = list->next;
 		if (!(list->item->object.flags & STALE))
 			insert_by_date(list->item, &result);
-		free(list);
+		free_commit_list_node(list);
 		list = n;
 	}
 	return result;
diff --git a/http-push.c b/http-push.c
index 99328f5..75f1664 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1931,7 +1931,7 @@ static void unmark_and_free(struct commit_list *list, unsigned int mark)
 		struct commit_list *temp = list;
 		temp->item->object.flags &= ~mark;
 		list = temp->next;
-		free(temp);
+		free_commit_list_node(temp);
 	}
 }
 
diff --git a/reflog-walk.c b/reflog-walk.c
index ee1456b..a6cc6ca 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -236,7 +236,7 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 		return;
 	}
 
-	commit->parents = xcalloc(sizeof(struct commit_list), 1);
+	commit->parents = alloc_commit_list_node();
 	commit->parents->item = commit_info->commit;
 	commit->object.flags &= ~(ADDED | SEEN | SHOWN);
 }
diff --git a/revision.c b/revision.c
index 931f978..d9c3998 100644
--- a/revision.c
+++ b/revision.c
@@ -554,7 +554,7 @@ static int limit_list(struct rev_info *revs)
 		show_early_output_fn_t show;
 
 		list = list->next;
-		free(entry);
+		free_commit_list_node(entry);
 
 		if (revs->max_age != -1 && (commit->date < revs->max_age))
 			obj->flags |= UNINTERESTING;
@@ -735,7 +735,7 @@ static void prepare_show_merge(struct rev_info *revs)
 	while (bases) {
 		struct commit *it = bases->item;
 		struct commit_list *n = bases->next;
-		free(bases);
+		free_commit_list_node(bases);
 		bases = n;
 		it->object.flags |= UNINTERESTING;
 		add_pending_object(revs, &it->object, "(merge-base)");
@@ -1451,7 +1451,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		struct commit *commit = entry->item;
 
 		revs->commits = entry->next;
-		free(entry);
+		free_commit_list_node(entry);
 
 		if (revs->reflog_info)
 			fake_reflog_parent(revs->reflog_info, commit);
diff --git a/upload-pack.c b/upload-pack.c
index 7e04311..51796dc 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -331,7 +331,7 @@ static int reachable(struct commit *want)
 	while (work) {
 		struct commit_list *list = work->next;
 		struct commit *commit = work->item;
-		free(work);
+		free_commit_list_node(work);
 		work = list;
 
 		if (commit->object.flags & THEY_HAVE) {
-- 
1.5.3.5.1622.g41d10
