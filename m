From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/3] Tie it all together: "git log"
Date: Tue, 28 Feb 2006 15:07:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602281504280.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0602281115110.22647@g5.osdl.org>
 <Pine.LNX.4.64.0602281126340.22647@g5.osdl.org> <Pine.LNX.4.64.0602281251390.22647@g5.osdl.org>
 <7vr75nm8cl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 00:07:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEDwM-0006Vl-Kf
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 00:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbWB1XH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 18:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932711AbWB1XH3
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 18:07:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63394 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932710AbWB1XH2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2006 18:07:28 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1SN7NDZ019379
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Feb 2006 15:07:24 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1SN7KPP003454;
	Tue, 28 Feb 2006 15:07:21 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr75nm8cl.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16958>



On Tue, 28 Feb 2006, Junio C Hamano wrote:
> 
> I would say we should just rip merge-order out.  Who uses it,
> and why does it not work with topo-order, again?

Well, assuming breaking --merge-order is fine, here's a patch (on top of 
the other ones) that makes

	git log <filename>

actually work, as far as I can tell. 

I didn't add the logic for --before/--after flags, but that should be 
pretty trivial, and is independent of this anyway.

Perhaps more importantly, I didn't remove the tests that now start 
failing, nor did I remove the actual code to do --merge-order ;/

		Linus

----
diff --git a/rev-list.c b/rev-list.c
index 94f22dd..6993b1a 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -8,10 +8,9 @@
 #include "diff.h"
 #include "revision.h"
 
-/* bits #0-2 in revision.h */
+/* bits #0-3 in revision.h */
 
-#define COUNTED		(1u << 3)
-#define SHOWN		(1u << 4)
+#define COUNTED		(1u << 4)
 #define TMP_MARK	(1u << 5) /* for isolated cases; clean after use */
 
 static const char rev_list_usage[] =
@@ -25,7 +24,6 @@ static const char rev_list_usage[] =
 "    --remove-empty\n"
 "    --all\n"
 "  ordering output:\n"
-"    --merge-order [ --show-breaks ]\n"
 "    --topo-order\n"
 "    --date-order\n"
 "  formatting output:\n"
@@ -47,22 +45,9 @@ static int show_parents = 0;
 static int hdr_termination = 0;
 static const char *commit_prefix = "";
 static enum cmit_fmt commit_format = CMIT_FMT_RAW;
-static int merge_order = 0;
-static int show_breaks = 0;
-static int stop_traversal = 0;
-static int no_merges = 0;
 
 static void show_commit(struct commit *commit)
 {
-	commit->object.flags |= SHOWN;
-	if (show_breaks) {
-		commit_prefix = "| ";
-		if (commit->object.flags & DISCONTINUITY) {
-			commit_prefix = "^ ";     
-		} else if (commit->object.flags & BOUNDARY) {
-			commit_prefix = "= ";
-		} 
-        }        		
 	printf("%s%s", commit_prefix, sha1_to_hex(commit->object.sha1));
 	if (show_parents) {
 		struct commit_list *parents = commit->parents;
@@ -96,73 +81,6 @@ static void show_commit(struct commit *c
 	fflush(stdout);
 }
 
-static int rewrite_one(struct commit **pp)
-{
-	for (;;) {
-		struct commit *p = *pp;
-		if (p->object.flags & (TREECHANGE | UNINTERESTING))
-			return 0;
-		if (!p->parents)
-			return -1;
-		*pp = p->parents->item;
-	}
-}
-
-static void rewrite_parents(struct commit *commit)
-{
-	struct commit_list **pp = &commit->parents;
-	while (*pp) {
-		struct commit_list *parent = *pp;
-		if (rewrite_one(&parent->item) < 0) {
-			*pp = parent->next;
-			continue;
-		}
-		pp = &parent->next;
-	}
-}
-
-static int filter_commit(struct commit * commit)
-{
-	if (stop_traversal && (commit->object.flags & BOUNDARY))
-		return STOP;
-	if (commit->object.flags & (UNINTERESTING|SHOWN))
-		return CONTINUE;
-	if (revs.min_age != -1 && (commit->date > revs.min_age))
-		return CONTINUE;
-	if (revs.max_age != -1 && (commit->date < revs.max_age)) {
-		stop_traversal=1;
-		return CONTINUE;
-	}
-	if (no_merges && (commit->parents && commit->parents->next))
-		return CONTINUE;
-	if (revs.paths && revs.dense) {
-		if (!(commit->object.flags & TREECHANGE))
-			return CONTINUE;
-		rewrite_parents(commit);
-	}
-	return DO;
-}
-
-static int process_commit(struct commit * commit)
-{
-	int action=filter_commit(commit);
-
-	if (action == STOP) {
-		return STOP;
-	}
-
-	if (action == CONTINUE) {
-		return CONTINUE;
-	}
-
-	if (revs.max_count != -1 && !revs.max_count--)
-		return STOP;
-
-	show_commit(commit);
-
-	return CONTINUE;
-}
-
 static struct object_list **process_blob(struct blob *blob,
 					 struct object_list **p,
 					 struct name_path *path,
@@ -219,8 +137,7 @@ static void show_commit_list(struct rev_
 
 	while ((commit = get_revision(revs)) != NULL) {
 		p = process_tree(commit->tree, p, NULL, "");
-		if (process_commit(commit) == STOP)
-			break;
+		show_commit(commit);
 	}
 	for (pending = revs->pending_objects; pending; pending = pending->next) {
 		struct object *obj = pending->item;
@@ -416,10 +333,6 @@ int main(int argc, const char **argv)
 				commit_prefix = "commit ";
 			continue;
 		}
-		if (!strncmp(arg, "--no-merges", 11)) {
-			no_merges = 1;
-			continue;
-		}
 		if (!strcmp(arg, "--parents")) {
 			show_parents = 1;
 			continue;
@@ -428,14 +341,6 @@ int main(int argc, const char **argv)
 			bisect_list = 1;
 			continue;
 		}
-		if (!strcmp(arg, "--merge-order")) {
-		        merge_order = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--show-breaks")) {
-			show_breaks = 1;
-			continue;
-		}
 		usage(rev_list_usage);
 
 	}
@@ -456,17 +361,7 @@ int main(int argc, const char **argv)
 	save_commit_buffer = verbose_header;
 	track_object_refs = 0;
 
-	if (!merge_order) {
-		show_commit_list(&revs);
-	} else {
-#ifndef NO_OPENSSL
-		if (sort_list_in_merge_order(list, &process_commit)) {
-			die("merge order sort failed\n");
-		}
-#else
-		die("merge order sort unsupported, OpenSSL not linked");
-#endif
-	}
+	show_commit_list(&revs);
 
 	return 0;
 }
diff --git a/revision.c b/revision.c
index fb728c1..f98fae9 100644
--- a/revision.c
+++ b/revision.c
@@ -381,6 +381,9 @@ static void limit_list(struct rev_info *
 	struct commit_list *newlist = NULL;
 	struct commit_list **p = &newlist;
 
+	if (revs->paths)
+		diff_tree_setup_paths(revs->paths);
+
 	while (list) {
 		struct commit_list *entry = list;
 		struct commit *commit = list->item;
@@ -436,12 +439,13 @@ static void handle_all(struct rev_info *
  * Parse revision information, filling in the "rev_info" structure,
  * and removing the used arguments from the argument list.
  *
- * Returns the number of arguments left ("new argc").
+ * Returns the number of arguments left that weren't recognized
+ * (which are also moved to the head of the argument list)
  */
 int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def)
 {
 	int i, flags, seen_dashdash;
-	const char **unrecognized = argv+1;
+	const char **unrecognized = argv + 1;
 	int left = 1;
 
 	memset(revs, 0, sizeof(*revs));
@@ -525,6 +529,10 @@ int setup_revisions(int argc, const char
 				revs->remove_empty_trees = 1;
 				continue;
 			}
+			if (!strncmp(arg, "--no-merges", 11)) {
+				revs->no_merges = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--objects")) {
 				revs->tag_objects = 1;
 				revs->tree_objects = 1;
@@ -601,14 +609,11 @@ int setup_revisions(int argc, const char
 	}
 	if (revs->paths)
 		revs->limited = 1;
-	*unrecognized = NULL;
 	return left;
 }
 
 void prepare_revision_walk(struct rev_info *revs)
 {
-	if (revs->paths)
-		diff_tree_setup_paths(revs->paths);
 	sort_by_date(&revs->commits);
 	if (revs->limited)
 		limit_list(revs);
@@ -616,11 +621,67 @@ void prepare_revision_walk(struct rev_in
 		sort_in_topological_order(&revs->commits, revs->lifo);
 }
 
+static int rewrite_one(struct commit **pp)
+{
+	for (;;) {
+		struct commit *p = *pp;
+		if (p->object.flags & (TREECHANGE | UNINTERESTING))
+			return 0;
+		if (!p->parents)
+			return -1;
+		*pp = p->parents->item;
+	}
+}
+
+static void rewrite_parents(struct commit *commit)
+{
+	struct commit_list **pp = &commit->parents;
+	while (*pp) {
+		struct commit_list *parent = *pp;
+		if (rewrite_one(&parent->item) < 0) {
+			*pp = parent->next;
+			continue;
+		}
+		pp = &parent->next;
+	}
+}
+
 struct commit *get_revision(struct rev_info *revs)
 {
-	if (!revs->commits)
+	struct commit_list *list = revs->commits;
+	struct commit *commit;
+
+	if (!list)
 		return NULL;
-	return pop_most_recent_commit(&revs->commits, SEEN);
-}
 
+	/* Check the max_count ... */
+	commit = list->item;
+	switch (revs->max_count) {
+	case -1:
+		break;
+	case 0:
+		return NULL;
+	default:
+		revs->max_count--;
+	}
 
+	do {
+		commit = pop_most_recent_commit(&revs->commits, SEEN);
+		if (commit->object.flags & (UNINTERESTING|SHOWN))
+			continue;
+		if (revs->min_age != -1 && (commit->date > revs->min_age))
+			continue;
+		if (revs->max_age != -1 && (commit->date < revs->max_age))
+			return NULL;
+		if (revs->no_merges && commit->parents && commit->parents->next)
+			continue;
+		if (revs->paths && revs->dense) {
+			if (!(commit->object.flags & TREECHANGE))
+				continue;
+			rewrite_parents(commit);
+		}
+		commit->object.flags |= SHOWN;
+		return commit;
+	} while (revs->commits);
+	return NULL;
+}
diff --git a/revision.h b/revision.h
index 0bed3c0..0043c16 100644
--- a/revision.h
+++ b/revision.h
@@ -4,6 +4,7 @@
 #define SEEN		(1u<<0)
 #define UNINTERESTING   (1u<<1)
 #define TREECHANGE	(1u<<2)
+#define SHOWN		(1u<<3)
 
 struct rev_info {
 	/* Starting list */
@@ -16,6 +17,7 @@ struct rev_info {
 
 	/* Traversal flags */
 	unsigned int	dense:1,
+			no_merges:1,
 			remove_empty_trees:1,
 			lifo:1,
 			topo_order:1,
