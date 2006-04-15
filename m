From: Linus Torvalds <torvalds@osdl.org>
Subject: Tentative built-in "git show"
Date: Sat, 15 Apr 2006 12:09:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604151203060.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Apr 15 21:10:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUq9u-00032Q-UY
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 21:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWDOTKD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 15:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWDOTKD
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 15:10:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20367 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751110AbWDOTKA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Apr 2006 15:10:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3FJ9vtH016612
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 15 Apr 2006 12:09:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3FJ9uMv012105;
	Sat, 15 Apr 2006 12:09:56 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18758>


This uses the "--no-walk" flag that I never actually implemented (but I'm 
sure I mentioned it) to make "git show" be essentially the same thing as 
"git whatchanged --no-walk".

It just refuses to add more interesting parents to the revision walking 
history, so you don't actually get any history, you just get the commit 
you asked for.

I was going to add "--no-walk" as a real argument flag to git-rev-list 
too, but I'm not sure anybody actually needs it. Although it might be 
useful for porcelain, so I left the door open.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This is obviously against Junio's current "next" branch, which has the 
log/whatchanged unification.

That special-case of

	if (!strcmp(av[0], "show"...

is truly ugly, but it needs to happen after setup_revisions(), for all the 
same reasons that I suggested it might be a good idea to split up 
"init_revisions()" out of setup_revisions().

diff --git a/git.c b/git.c
index 939a34c..c87accf 100644
--- a/git.c
+++ b/git.c
@@ -363,6 +363,20 @@ static int cmd_whatchanged(int ac, const
 	return cmd_log_wc(ac, av, ep, &wcopt);
 }
 
+static int cmd_show(int ac, const char **av, char **ep)
+{
+	struct whatchanged_opt wcopt;
+
+	memset(&wcopt, 0, sizeof(wcopt));
+	wcopt.do_diff = 1;
+	init_log_tree_opt(&wcopt.logopt);
+	wcopt.logopt.ignore_merges = 0;
+	wcopt.logopt.combine_merges = 1;
+	wcopt.logopt.dense_combined_merges = 1;
+	wcopt.logopt.diffopt.recursive = 1;
+	return cmd_log_wc(ac, av, ep, &wcopt);
+}
+
 static void handle_internal_command(int argc, const char **argv, char **envp)
 {
 	const char *cmd = argv[0];
@@ -373,6 +387,7 @@ static void handle_internal_command(int 
 		{ "version", cmd_version },
 		{ "help", cmd_help },
 		{ "log", cmd_log },
+		{ "show", cmd_show },
 		{ "whatchanged", cmd_whatchanged },
 	};
 	int i;
diff --git a/log-tree.c b/log-tree.c
index cb0d0b1..17e976a 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -182,6 +182,8 @@ int parse_whatchanged_opt(int ac, const 
 	int left = 1;
 
 	ac = setup_revisions(ac, av, rev, "HEAD");
+	if (!strcmp(av[0], "show"))
+		rev->no_walk = 1;
 	while (1 < ac) {
 		const char *arg = av[1];
 		if (!strncmp(arg, "--pretty", 8)) {
diff --git a/log-tree.h b/log-tree.h
diff --git a/revision.c b/revision.c
index 0505f3f..0c3c392 100644
--- a/revision.c
+++ b/revision.c
@@ -375,6 +375,9 @@ static void add_parents_to_list(struct r
 	if (revs->prune_fn)
 		revs->prune_fn(revs, commit);
 
+	if (revs->no_walk)
+		return;
+
 	parent = commit->parents;
 	while (parent) {
 		struct commit *p = parent->item;
@@ -714,6 +717,8 @@ int setup_revisions(int argc, const char
 
 void prepare_revision_walk(struct rev_info *revs)
 {
+	if (revs->no_walk)
+		return;
 	sort_by_date(&revs->commits);
 	if (revs->limited)
 		limit_list(revs);
diff --git a/revision.h b/revision.h
index 8970b57..ff2a13e 100644
--- a/revision.h
+++ b/revision.h
@@ -26,6 +26,7 @@ struct rev_info {
 	/* Traversal flags */
 	unsigned int	dense:1,
 			no_merges:1,
+			no_walk:1,
 			remove_empty_trees:1,
 			lifo:1,
 			topo_order:1,
