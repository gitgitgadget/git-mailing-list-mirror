From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 2/2] get_revision(): honor the topo_order flag for boundary commits
Date: Sat, 24 May 2008 16:02:05 -0700
Message-ID: <1211670125-10215-3-git-send-email-adam@adamsimpkins.net>
References: <1211670125-10215-1-git-send-email-adam@adamsimpkins.net>
 <1211670125-10215-2-git-send-email-adam@adamsimpkins.net>
Cc: Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 25 01:03:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K02lb-0006Ow-Me
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 01:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbYEXXCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 19:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbYEXXCO
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 19:02:14 -0400
Received: from smtp132.iad.emailsrvr.com ([207.97.245.132]:47922 "EHLO
	smtp132.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbYEXXCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 19:02:09 -0400
Received: from relay3.r3.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay3.r3.iad.emailsrvr.com (SMTP Server) with ESMTP id 1F58A44C118;
	Sat, 24 May 2008 19:02:07 -0400 (EDT)
Received: by relay3.r3.iad.emailsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id BA41C44C08E;
	Sat, 24 May 2008 19:02:06 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id C72CE14100C9; Sat, 24 May 2008 16:02:05 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.389.g35a9d
In-Reply-To: <1211670125-10215-2-git-send-email-adam@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82838>

Now get_revision() sorts the boundary commits when topo_order is set.
Since sort_in_topological_order() takes a struct commit_list, it first
places the boundary commits into revs->commits.

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---
 graph.c    |    9 +------
 revision.c |   73 ++++++++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 58 insertions(+), 24 deletions(-)

diff --git a/graph.c b/graph.c
index ce1abc0..412b5ec 100644
--- a/graph.c
+++ b/graph.c
@@ -197,16 +197,9 @@ static int graph_is_interesting(struct git_graph *graph, struct commit *commit)
 	 * If revs->boundary is set, commits whose children have
 	 * been shown are always interesting, even if they have the
 	 * UNINTERESTING or TREESAME flags set.
-	 *
-	 * However, ignore the commit if SHOWN is set.  If SHOWN is set,
-	 * the commit is interesting, but it has already been printed.
-	 * This can happen because get_revision() doesn't return the
-	 * boundary commits in topological order, even when
-	 * revs->topo_order is set.
 	 */
 	if (graph->revs && graph->revs->boundary) {
-		if ((commit->object.flags & (SHOWN | CHILD_SHOWN)) ==
-		    CHILD_SHOWN)
+		if (commit->object.flags & CHILD_SHOWN)
 			return 1;
 	}
 
diff --git a/revision.c b/revision.c
index 181fb0b..fb9924e 100644
--- a/revision.c
+++ b/revision.c
@@ -1612,28 +1612,62 @@ static void gc_boundary(struct object_array *array)
 	}
 }
 
+static void create_boundary_commit_list(struct rev_info *revs)
+{
+	unsigned i;
+	struct commit *c;
+	struct object_array *array = &revs->boundary_commits;
+	struct object_array_entry *objects = array->objects;
+
+	/*
+	 * If revs->commits is non-NULL at this point, an error occurred in
+	 * get_revision_1().  Ignore the error and continue printing the
+	 * boundary commits anyway.  (This is what the code has always
+	 * done.)
+	 */
+	if (revs->commits) {
+		free_commit_list(revs->commits);
+		revs->commits = NULL;
+	}
+
+	/*
+	 * Put all of the actual boundary commits from revs->boundary_commits
+	 * into revs->commits
+	 */
+	for (i = 0; i < array->nr; i++) {
+		c = (struct commit *)(objects[i].item);
+		if (!c)
+			continue;
+		if (!(c->object.flags & CHILD_SHOWN))
+			continue;
+		if (c->object.flags & (SHOWN | BOUNDARY))
+			continue;
+		c->object.flags |= BOUNDARY;
+		commit_list_insert(c, &revs->commits);
+	}
+
+	/*
+	 * If revs->topo_order is set, sort the boundary commits
+	 * in topological order
+	 */
+	sort_in_topological_order(&revs->commits, revs->lifo);
+}
+
 static struct commit *get_revision_internal(struct rev_info *revs)
 {
 	struct commit *c = NULL;
 	struct commit_list *l;
 
 	if (revs->boundary == 2) {
-		unsigned i;
-		struct object_array *array = &revs->boundary_commits;
-		struct object_array_entry *objects = array->objects;
-		for (i = 0; i < array->nr; i++) {
-			c = (struct commit *)(objects[i].item);
-			if (!c)
-				continue;
-			if (!(c->object.flags & CHILD_SHOWN))
-				continue;
-			if (!(c->object.flags & SHOWN))
-				break;
-		}
-		if (array->nr <= i)
-			return NULL;
-
-		c->object.flags |= SHOWN | BOUNDARY;
+		/*
+		 * All of the normal commits have already been returned,
+		 * and we are now returning boundary commits.
+		 * create_boundary_commit_list() has populated
+		 * revs->commits with the remaining commits to return.
+		 */
+		c = pop_commit(&revs->commits);
+		if (c)
+			c->object.flags |= SHOWN;
 		return c;
 	}
 
@@ -1697,6 +1731,13 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 		 * switch to boundary commits output mode.
 		 */
 		revs->boundary = 2;
+
+		/*
+		 * Update revs->commits to contain the list of
+		 * boundary commits.
+		 */
+		create_boundary_commit_list(revs);
+
 		return get_revision_internal(revs);
 	}
 
-- 
1.5.5.1.389.g35a9d
