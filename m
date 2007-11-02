From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/2] Support "history replay" for git log commands
Date: Fri, 2 Nov 2007 13:35:17 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0711021333050.3342@woody.linux-foundation.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org> 
 <18212.13862.637991.30536@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org> 
 <18217.41899.54812.227152@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org> 
 <18218.63946.772767.179841@cargo.ozlabs.ibm.com>
 <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
 <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 21:36:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io3FM-0002oN-73
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 21:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbXKBUfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 16:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753707AbXKBUfu
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 16:35:50 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37730 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753055AbXKBUft (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2007 16:35:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA2KZHIU028937
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Nov 2007 13:35:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA2KZHBA009808;
	Fri, 2 Nov 2007 13:35:17 -0700
In-Reply-To: <alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
X-Spam-Status: No, hits=-6.232 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63173>


This notices if we aren't in topological order, and replays the history. 
Thus avoiding the need to sort history up front.
    
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

See the code and the more complete explanations in [PATCH 0/2]. In 
particular, see the last section there about the downsides of this: the 
50x expansion of output on the kernel is unacceptable, but if somebody can 
make a graphical viewer that can react correctly to the "Replay" thing, 
I'm sure I can make the replays themselves happen much more rarely.

 builtin-blame.c |    2 +-
 builtin-log.c   |   35 +++++++++++++++++++++++++++++++++++
 log-tree.c      |   10 +++++++---
 revision.c      |   29 ++++++++++++++++++++++-------
 revision.h      |    6 +++++-
 5 files changed, 70 insertions(+), 12 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 8432b82..7b6af8c 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1502,7 +1502,7 @@ static void assign_blame(struct scoreboard *sb, struct rev_info *revs, int opt)
 		else {
 			commit->object.flags |= UNINTERESTING;
 			if (commit->object.parsed)
-				mark_parents_uninteresting(commit);
+				mark_parents_uninteresting(revs, commit);
 		}
 		/* treat root commit as boundary */
 		if (!commit->parents && !show_root)
diff --git a/builtin-log.c b/builtin-log.c
index e8b982d..10e0821 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -77,6 +77,35 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	}
 }
 
+static void replay_history(struct rev_info *revs)
+{
+	struct commit_list *entry;
+
+	revs->trigger_replay = 0;
+	while ((entry = revs->shown) != NULL) {
+		struct commit *commit = entry->item;
+		unsigned flags = commit->object.flags;
+
+		/* Undo the SHOWN and FORCE_REPLAY bits */
+		commit->object.flags = flags & ~(SHOWN | FORCE_REPLAY);
+		commit->indegree = 0;
+
+		/* Remove it from the shown list, put it on the commit list */
+		revs->shown = entry->next;
+		entry->next = revs->commits;
+		revs->commits = entry;
+
+		printf("Replay %s\n", sha1_to_hex(commit->object.sha1));
+
+		/* Was this the one that caused us to replay? */
+		if (flags & FORCE_REPLAY)
+			break;
+	}
+
+	/* Ok, sort the list to be replayed properly now.. */
+	sort_in_topological_order(&revs->commits, revs->lifo);
+}
+
 static int cmd_log_walk(struct rev_info *rev)
 {
 	struct commit *commit;
@@ -84,6 +113,12 @@ static int cmd_log_walk(struct rev_info *rev)
 	prepare_revision_walk(rev);
 	while ((commit = get_revision(rev)) != NULL) {
 		log_tree_commit(rev, commit);
+
+		if (rev->replay_history) {
+			if (rev->trigger_replay)
+				replay_history(rev);
+			continue;
+		}
 		if (!rev->reflog_info) {
 			/* we allow cycles in reflog ancestry */
 			free(commit->buffer);
diff --git a/log-tree.c b/log-tree.c
index 3763ce9..ce9b887 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -6,12 +6,16 @@
 
 struct decoration name_decoration = { "object names" };
 
-static void show_parents(struct commit *commit, int abbrev)
+static void show_parents(struct rev_info *opt, struct commit *commit, int abbrev)
 {
 	struct commit_list *p;
 	for (p = commit->parents; p ; p = p->next) {
 		struct commit *parent = p->item;
 		printf(" %s", diff_unique_abbrev(parent->object.sha1, abbrev));
+		if (parent->object.flags & SHOWN) {
+			opt->trigger_replay = 1;
+			parent->object.flags |= FORCE_REPLAY;
+		}
 	}
 }
 
@@ -147,7 +151,7 @@ void show_log(struct rev_info *opt, const char *sep)
 		}
 		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
 		if (opt->parents)
-			show_parents(commit, abbrev_commit);
+			show_parents(opt, commit, abbrev_commit);
 		show_decorations(commit);
 		putchar(opt->diffopt.line_termination);
 		return;
@@ -248,7 +252,7 @@ void show_log(struct rev_info *opt, const char *sep)
 		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit),
 		      stdout);
 		if (opt->parents)
-			show_parents(commit, abbrev_commit);
+			show_parents(opt, commit, abbrev_commit);
 		if (parent)
 			printf(" (from %s)",
 			       diff_unique_abbrev(parent->object.sha1,
diff --git a/revision.c b/revision.c
index e85b4af..e40bc1c 100644
--- a/revision.c
+++ b/revision.c
@@ -79,7 +79,7 @@ void mark_tree_uninteresting(struct tree *tree)
 	tree->buffer = NULL;
 }
 
-void mark_parents_uninteresting(struct commit *commit)
+void mark_parents_uninteresting(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_list *parents = commit->parents;
 
@@ -87,6 +87,10 @@ void mark_parents_uninteresting(struct commit *commit)
 		struct commit *commit = parents->item;
 		if (!(commit->object.flags & UNINTERESTING)) {
 			commit->object.flags |= UNINTERESTING;
+			if (commit->object.flags & SHOWN) {
+				revs->trigger_replay = 1;
+				commit->object.flags |= FORCE_REPLAY;
+			}
 
 			/*
 			 * Normally we haven't parsed the parent
@@ -97,7 +101,7 @@ void mark_parents_uninteresting(struct commit *commit)
 			 * to mark its parents recursively too..
 			 */
 			if (commit->parents)
-				mark_parents_uninteresting(commit);
+				mark_parents_uninteresting(revs, commit);
 		}
 
 		/*
@@ -167,8 +171,9 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
 			die("unable to parse commit %s", name);
 		if (flags & UNINTERESTING) {
 			commit->object.flags |= UNINTERESTING;
-			mark_parents_uninteresting(commit);
-			revs->limited = 1;
+			mark_parents_uninteresting(revs, commit);
+			if (!revs->replay_history)
+				revs->limited = 1;
 		}
 		return commit;
 	}
@@ -399,7 +404,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit, str
 				return -1;
 			p->object.flags |= UNINTERESTING;
 			if (p->parents)
-				mark_parents_uninteresting(p);
+				mark_parents_uninteresting(revs, p);
 			if (p->object.flags & SEEN)
 				continue;
 			p->object.flags |= SEEN;
@@ -542,7 +547,7 @@ static int limit_list(struct rev_info *revs)
 		if (add_parents_to_list(revs, commit, &list) < 0)
 			return -1;
 		if (obj->flags & UNINTERESTING) {
-			mark_parents_uninteresting(commit);
+			mark_parents_uninteresting(revs, commit);
 			if (everybody_uninteresting(list))
 				break;
 			continue;
@@ -995,6 +1000,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->parents = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--replay")) {
+				revs->replay_history = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--dense")) {
 				revs->dense = 1;
 				continue;
@@ -1386,7 +1395,13 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		struct commit *commit = entry->item;
 
 		revs->commits = entry->next;
-		free(entry);
+
+		/* Are we going to potentially replay? */
+		if (revs->replay_history) {
+			entry->next = revs->shown;
+			revs->shown = entry;
+		} else
+			free(entry);
 
 		if (revs->reflog_info)
 			fake_reflog_parent(revs->reflog_info, commit);
diff --git a/revision.h b/revision.h
index 1f64576..75b320d 100644
--- a/revision.h
+++ b/revision.h
@@ -11,6 +11,7 @@
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
 #define SYMMETRIC_LEFT	(1u<<8)
 #define TOPOSORT	(1u<<9)	/* In the active toposort list.. */
+#define FORCE_REPLAY	(1u<<10)	/* This commit was wrong somehow */
 
 struct rev_info;
 struct log_info;
@@ -20,6 +21,7 @@ typedef void (prune_fn_t)(struct rev_info *revs, struct commit *commit);
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
+	struct commit_list *shown;
 	struct object_array pending;
 
 	/* Parents of shown commits */
@@ -36,6 +38,8 @@ struct rev_info {
 			no_walk:1,
 			remove_empty_trees:1,
 			simplify_history:1,
+			replay_history:1,
+			trigger_replay:1,
 			lifo:1,
 			topo_order:1,
 			tag_objects:1,
@@ -113,7 +117,7 @@ extern int handle_revision_arg(const char *arg, struct rev_info *revs,int flags,
 extern int prepare_revision_walk(struct rev_info *revs);
 extern struct commit *get_revision(struct rev_info *revs);
 
-extern void mark_parents_uninteresting(struct commit *commit);
+extern void mark_parents_uninteresting(struct rev_info *revs, struct commit *commit);
 extern void mark_tree_uninteresting(struct tree *tree);
 
 struct name_path {
