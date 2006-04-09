From: Linus Torvalds <torvalds@osdl.org>
Subject: Make "--parents" logs also be incremental
Date: Sat, 8 Apr 2006 17:05:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604081658110.9504@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Apr 09 02:06:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSNRb-0006pc-4R
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 02:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbWDIAGF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 20:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbWDIAGF
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 20:06:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12454 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965047AbWDIAGE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Apr 2006 20:06:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3905xtH027078
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 8 Apr 2006 17:06:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3905w7t017103;
	Sat, 8 Apr 2006 17:05:59 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18536>


The parent rewriting feature caused us to create the whole history in one 
go, and then simplify it later, because of how rewrite_parents() had been 
written. However, with a little tweaking, it's perfectly possible to do 
even that one incrementally.

Right now, this doesn't really much matter, because every user of 
"--parents" will probably generally _also_ use "--topo-order", which will 
cause the old non-incremental behaviour anyway. However, I'm hopeful that 
we could make even the topological sort incremental, or at least 
_partially_ so (for example, make it incremental up to the first merge).

In the meantime, this at least moves things in the right direction, and 
removes a strange special case.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/http-push.c b/http-push.c
index b60fa8d..57cefde 100644
--- a/http-push.c
+++ b/http-push.c
@@ -59,12 +59,12 @@ #define LOCK_REQUEST "<?xml version=\"1.
 #define LOCK_TIME 600
 #define LOCK_REFRESH 30
 
-/* bits #0-4 in revision.h */
+/* bits #0-6 in revision.h */
 
-#define LOCAL    (1u << 5)
-#define REMOTE   (1u << 6)
-#define FETCHING (1u << 7)
-#define PUSHING  (1u << 8)
+#define LOCAL    (1u << 7)
+#define REMOTE   (1u << 8)
+#define FETCHING (1u << 9)
+#define PUSHING  (1u << 10)
 
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define MAXDEPTH 5
diff --git a/rev-list.c b/rev-list.c
index 1301502..359195b 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -7,9 +7,9 @@ #include "blob.h"
 #include "tree-walk.h"
 #include "revision.h"
 
-/* bits #0-5 in revision.h */
+/* bits #0-6 in revision.h */
 
-#define COUNTED		(1u<<6)
+#define COUNTED		(1u<<7)
 
 static const char rev_list_usage[] =
 "git-rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
diff --git a/revision.c b/revision.c
index ce35b5a..fe26562 100644
--- a/revision.c
+++ b/revision.c
@@ -340,6 +340,10 @@ static void add_parents_to_list(struct r
 {
 	struct commit_list *parent = commit->parents;
 
+	if (commit->object.flags & ADDED)
+		return;
+	commit->object.flags |= ADDED;
+
 	/*
 	 * If the commit is uninteresting, don't try to
 	 * prune parents - we want the maximal uninteresting
@@ -705,13 +709,6 @@ int setup_revisions(int argc, const char
 	if (revs->prune_data) {
 		diff_tree_setup_paths(revs->prune_data);
 		revs->prune_fn = try_to_simplify_commit;
-
-		/*
-		 * If we fix up parent data, we currently cannot
-		 * do that on-the-fly.
-		 */
-		if (revs->parents)
-			revs->limited = 1;
 	}
 
 	return left;
@@ -728,10 +725,12 @@ void prepare_revision_walk(struct rev_in
 					     revs->topo_getter);
 }
 
-static int rewrite_one(struct commit **pp)
+static int rewrite_one(struct rev_info *revs, struct commit **pp)
 {
 	for (;;) {
 		struct commit *p = *pp;
+		if (!revs->limited)
+			add_parents_to_list(revs, p, &revs->commits);
 		if (p->object.flags & (TREECHANGE | UNINTERESTING))
 			return 0;
 		if (!p->parents)
@@ -740,12 +739,12 @@ static int rewrite_one(struct commit **p
 	}
 }
 
-static void rewrite_parents(struct commit *commit)
+static void rewrite_parents(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_list **pp = &commit->parents;
 	while (*pp) {
 		struct commit_list *parent = *pp;
-		if (rewrite_one(&parent->item) < 0) {
+		if (rewrite_one(revs, &parent->item) < 0) {
 			*pp = parent->next;
 			continue;
 		}
@@ -802,7 +801,7 @@ struct commit *get_revision(struct rev_i
 			if (!(commit->object.flags & TREECHANGE))
 				continue;
 			if (revs->parents)
-				rewrite_parents(commit);
+				rewrite_parents(revs, commit);
 		}
 		commit->object.flags |= SHOWN;
 		return commit;
diff --git a/revision.h b/revision.h
index 0caeecf..83d28d5 100644
--- a/revision.h
+++ b/revision.h
@@ -7,6 +7,7 @@ #define TREECHANGE	(1u<<2)
 #define SHOWN		(1u<<3)
 #define TMP_MARK	(1u<<4) /* for isolated cases; clean after use */
 #define BOUNDARY	(1u<<5)
+#define ADDED		(1u<<6)	/* Parents already parsed and added? */
 
 struct rev_info;
 
