From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/5] builtin-prune: make file-scope static struct to an argument.
Date: Sat, 06 Jan 2007 02:16:10 -0800
Message-ID: <7v64bk795h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jan 06 11:16:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H38b6-0001Rd-8h
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 11:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbXAFKQN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 05:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbXAFKQN
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 05:16:13 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:54625 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbXAFKQM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 05:16:12 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070106101611.ZNWW25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Sat, 6 Jan 2007 05:16:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7mGS1W00P1kojtg0000000; Sat, 06 Jan 2007 05:16:26 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36081>

I want to make the first part of 'git prune' that marks the
reachable objects callable as a library, so this starts the
first step toward the goal by making the callchain to pass
rev_info structure as an argument.

No functionality change should be in this step.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-prune.c |   33 ++++++++++++++++++---------------
 1 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/builtin-prune.c b/builtin-prune.c
index b469c43..9522864 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -12,7 +12,6 @@
 
 static const char prune_usage[] = "git-prune [-n]";
 static int show_only;
-static struct rev_info revs;
 
 static int prune_object(char *path, const char *filename, const unsigned char *sha1)
 {
@@ -184,45 +183,48 @@ static void walk_commit_list(struct rev_info *revs)
 static int add_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1, char *datail, void *cb_data)
 {
 	struct object *object;
+	struct rev_info *revs = (struct rev_info *)cb_data;
 
 	object = parse_object(osha1);
 	if (object)
-		add_pending_object(&revs, object, "");
+		add_pending_object(revs, object, "");
 	object = parse_object(nsha1);
 	if (object)
-		add_pending_object(&revs, object, "");
+		add_pending_object(revs, object, "");
 	return 0;
 }
 
 static int add_one_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct object *object = parse_object(sha1);
+	struct rev_info *revs = (struct rev_info *)cb_data;
+
 	if (!object)
 		die("bad object ref: %s:%s", path, sha1_to_hex(sha1));
-	add_pending_object(&revs, object, "");
+	add_pending_object(revs, object, "");
 
-	for_each_reflog_ent(path, add_one_reflog_ent, NULL);
+	for_each_reflog_ent(path, add_one_reflog_ent, cb_data);
 
 	return 0;
 }
 
-static void add_one_tree(const unsigned char *sha1)
+static void add_one_tree(const unsigned char *sha1, struct rev_info *revs)
 {
 	struct tree *tree = lookup_tree(sha1);
-	add_pending_object(&revs, &tree->object, "");
+	add_pending_object(revs, &tree->object, "");
 }
 
-static void add_cache_tree(struct cache_tree *it)
+static void add_cache_tree(struct cache_tree *it, struct rev_info *revs)
 {
 	int i;
 
 	if (it->entry_count >= 0)
-		add_one_tree(it->sha1);
+		add_one_tree(it->sha1, revs);
 	for (i = 0; i < it->subtree_nr; i++)
-		add_cache_tree(it->down[i]->cache_tree);
+		add_cache_tree(it->down[i]->cache_tree, revs);
 }
 
-static void add_cache_refs(void)
+static void add_cache_refs(struct rev_info *revs)
 {
 	int i;
 
@@ -237,12 +239,13 @@ static void add_cache_refs(void)
 		 */
 	}
 	if (active_cache_tree)
-		add_cache_tree(active_cache_tree);
+		add_cache_tree(active_cache_tree, revs);
 }
 
 int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	int i;
+	struct rev_info revs;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -264,11 +267,11 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	revs.blob_objects = 1;
 	revs.tree_objects = 1;
 
-	/* Add all external refs */
-	for_each_ref(add_one_ref, NULL);
+	/* Add all external refs, along with its reflog info */
+	for_each_ref(add_one_ref, &revs);
 
 	/* Add all refs from the index file */
-	add_cache_refs();
+	add_cache_refs(&revs);
 
 	/*
 	 * Set up the revision walk - this will move all commits
-- 
1.5.0.rc0.ge0f6
