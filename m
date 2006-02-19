From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] rev-list --objects-edge
Date: Sun, 19 Feb 2006 15:28:02 -0800
Message-ID: <7virrbexod.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 00:28:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAxyK-0005MV-EA
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 00:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWBSX2F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 18:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWBSX2F
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 18:28:05 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:40100 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932342AbWBSX2E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2006 18:28:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060219232637.JSBY20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 19 Feb 2006 18:26:37 -0500
To: "Martin Langhoff" <martin.langhoff@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16458>

This new flag is similar to --objects, but causes rev-list to
show list of "uninteresting" commits that appear on the edge
commit prefixed with '-'.

Downstream pack-objects will be changed to take these as hints
to use the trees and blobs contained with them as base objects
of resulting pack, producing an incomplete (not self-contained)
pack.

Such a pack cannot be used in .git/objects/pack (it is prevented
by git-index-pack erroring out if it is fed to git-fetch-pack -k
or git-clone-pack), but would be useful when transferring only
small changes to huge blobs.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Together with "thin-pack" patch I'll send next, this will
   allow you to do the "delta transfer" we discussed on the #git
   channel last night (eh, *my* last night anyway).

 rev-list.c  |   34 ++++++++++++++++++++++++++++------
 rev-parse.c |    1 +
 2 files changed, 29 insertions(+), 6 deletions(-)

52de788e6094b31be218f0f69576cbbfb310205f
diff --git a/rev-list.c b/rev-list.c
index f2d1105..373549e 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -30,7 +30,7 @@ static const char rev_list_usage[] =
 "    --date-order\n"
 "  formatting output:\n"
 "    --parents\n"
-"    --objects\n"
+"    --objects | --objects-edge\n"
 "    --unpacked\n"
 "    --header | --pretty\n"
 "    --abbrev=nr | --no-abbrev\n"
@@ -44,6 +44,7 @@ static int bisect_list = 0;
 static int tag_objects = 0;
 static int tree_objects = 0;
 static int blob_objects = 0;
+static int edge_hint = 0;
 static int verbose_header = 0;
 static int abbrev = DEFAULT_ABBREV;
 static int show_parents = 0;
@@ -430,16 +431,30 @@ static struct commit_list *find_bisectio
 	return best;
 }
 
+static void mark_edge_parents_uninteresting(struct commit *commit)
+{
+	struct commit_list *parents;
+
+	for (parents = commit->parents; parents; parents = parents->next) {
+		struct commit *parent = parents->item;
+		if (!(parent->object.flags & UNINTERESTING))
+			continue;
+		mark_tree_uninteresting(parent->tree);
+		if (edge_hint)
+			printf("-%s\n", sha1_to_hex(parent->object.sha1));
+	}
+}
+
 static void mark_edges_uninteresting(struct commit_list *list)
 {
 	for ( ; list; list = list->next) {
-		struct commit_list *parents = list->item->parents;
+		struct commit *commit = list->item;
 
-		for ( ; parents; parents = parents->next) {
-			struct commit *commit = parents->item;
-			if (commit->object.flags & UNINTERESTING)
-				mark_tree_uninteresting(commit->tree);
+		if (commit->object.flags & UNINTERESTING) {
+			mark_tree_uninteresting(commit->tree);
+			continue;
 		}
+		mark_edge_parents_uninteresting(commit);
 	}
 }
 
@@ -843,6 +858,13 @@ int main(int argc, const char **argv)
 			blob_objects = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--objects-edge")) {
+			tag_objects = 1;
+			tree_objects = 1;
+			blob_objects = 1;
+			edge_hint = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--unpacked")) {
 			unpacked = 1;
 			limited = 1;
diff --git a/rev-parse.c b/rev-parse.c
index a5fb93c..610eacb 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -43,6 +43,7 @@ static int is_rev_argument(const char *a
 		"--min-age=",
 		"--no-merges",
 		"--objects",
+		"--objects-edge",
 		"--parents",
 		"--pretty",
 		"--show-breaks",
-- 
1.2.2.g0d27
