From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] rev-list --left-right
Date: Sun, 22 Oct 2006 21:47:48 -0700
Message-ID: <7v7iyrzlhn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Oct 23 06:48:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbrjD-0007Q1-Hb
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 06:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWJWErv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 00:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWJWErv
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 00:47:51 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:6088 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751487AbWJWErt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 00:47:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061023044749.HIUQ6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Oct 2006 00:47:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id dgnZ1V00Z1kojtg0000000
	Mon, 23 Oct 2006 00:47:34 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29816>

The output from "symmetric diff", i.e. A...B, does not
distinguish between commits that are reachable from A and the
ones that are reachable from B.  In this picture, such a
symmetric diff includes commits marked with a and b.

         x---b---b  branch B
        / \ /
       /   .
      /   / \
     o---x---a---a  branch A

However, you cannot tell which ones are 'a' and which ones are
'b' from the output.  Sometimes this is frustrating.  This adds
an output option, --left-right, to rev-list.

        rev-list --left-right A...B

would show ones reachable from A prefixed with '<' and the ones
reachable from B prefixed with '>'.

When combined with --boundary, boundary commits (the ones marked
with 'x' in the above picture) are shown with prefix '-', so you
would see list that looks like this:

    git rev-list --left-right --boundary --pretty=oneline A...B

    >bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb 3rd on b
    >bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb 2nd on b
    <aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 3rd on a
    <aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 2nd on a
    -xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 1st on b
    -xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 1st on a

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This lets you write something like git-cherry with a single
   invocation of rev-list instead of two.  We would need a diff
   format that gives patch-id in addition to this patch to make
   git-cherry more efficient though.

 builtin-rev-list.c |   11 +++++++++++
 commit.c           |   10 +++++-----
 revision.c         |    5 ++++-
 revision.h         |    1 +
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index fb7fc92..4364035 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -45,6 +45,7 @@ static int bisect_list;
 static int show_timestamp;
 static int hdr_termination;
 static const char *header_prefix;
+static int show_left_right;
 
 static void show_commit(struct commit *commit)
 {
@@ -54,6 +55,12 @@ static void show_commit(struct commit *c
 		fputs(header_prefix, stdout);
 	if (commit->object.flags & BOUNDARY)
 		putchar('-');
+	else if (show_left_right) {
+		if (commit->object.flags & SYMMETRIC_LEFT)
+			putchar('<');
+		else
+			putchar('>');
+	}
 	if (revs.abbrev_commit && revs.abbrev)
 		fputs(find_unique_abbrev(commit->object.sha1, revs.abbrev),
 		      stdout);
@@ -240,6 +247,10 @@ int cmd_rev_list(int argc, const char **
 			bisect_list = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--left-right")) {
+			show_left_right = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--stdin")) {
 			if (read_from_stdin++)
 				die("--stdin given twice?");
diff --git a/commit.c b/commit.c
index a6d543e..289ef65 100644
--- a/commit.c
+++ b/commit.c
@@ -868,11 +868,11 @@ void sort_in_topological_order_fn(struct
 
 /* merge-rebase stuff */
 
-/* bits #0..7 in revision.h */
-#define PARENT1		(1u<< 8)
-#define PARENT2		(1u<< 9)
-#define STALE		(1u<<10)
-#define RESULT		(1u<<11)
+/* bits #0..15 in revision.h */
+#define PARENT1		(1u<<16)
+#define PARENT2		(1u<<17)
+#define STALE		(1u<<18)
+#define RESULT		(1u<<19)
 
 static struct commit *interesting(struct commit_list *list)
 {
diff --git a/revision.c b/revision.c
index f1e0caa..26ddf09 100644
--- a/revision.c
+++ b/revision.c
@@ -344,6 +344,7 @@ static void try_to_simplify_commit(struc
 static void add_parents_to_list(struct rev_info *revs, struct commit *commit, struct commit_list **list)
 {
 	struct commit_list *parent = commit->parents;
+	unsigned left_flag;
 
 	if (commit->object.flags & ADDED)
 		return;
@@ -388,6 +389,7 @@ static void add_parents_to_list(struct r
 	if (revs->no_walk)
 		return;
 
+	left_flag = (commit->object.flags & SYMMETRIC_LEFT);
 	parent = commit->parents;
 	while (parent) {
 		struct commit *p = parent->item;
@@ -395,6 +397,7 @@ static void add_parents_to_list(struct r
 		parent = parent->next;
 
 		parse_commit(p);
+		p->object.flags |= left_flag;
 		if (p->object.flags & SEEN)
 			continue;
 		p->object.flags |= SEEN;
@@ -643,7 +646,7 @@ int handle_revision_arg(const char *arg,
 				add_pending_commit_list(revs, exclude,
 							flags_exclude);
 				free_commit_list(exclude);
-				a->object.flags |= flags;
+				a->object.flags |= flags | SYMMETRIC_LEFT;
 			} else
 				a->object.flags |= flags_exclude;
 			b->object.flags |= flags;
diff --git a/revision.h b/revision.h
index 3adab95..f92a4d4 100644
--- a/revision.h
+++ b/revision.h
@@ -9,6 +9,7 @@ #define TMP_MARK	(1u<<4) /* for isolated
 #define BOUNDARY	(1u<<5)
 #define BOUNDARY_SHOW	(1u<<6)
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
+#define SYMMETRIC_LEFT	(1u<<8)
 
 struct rev_info;
 struct log_info;
-- 
1.4.3.1.g7ad4
