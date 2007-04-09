From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] git-log --cherry-pick
Date: Mon, 09 Apr 2007 04:07:46 -0700
Message-ID: <7virc524cd.fsf_-_@assigned-by-dhcp.cox.net>
References: <1175686583.19898.68.camel@okra.transitives.com>
	<Pine.LNX.4.64.0704040744160.6730@woody.linux-foundation.org>
	<7vircbwfym.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 09 13:07:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Harix-0002nB-Km
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 13:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbXDILHs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 07:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752784AbXDILHs
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 07:07:48 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:37387 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbXDILHr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 07:07:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070409110747.OQQN25613.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Apr 2007 07:07:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id kz7m1W0041kojtg0000000; Mon, 09 Apr 2007 07:07:46 -0400
In-Reply-To: <7vircbwfym.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 04 Apr 2007 22:25:05 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44048>

This is meant to be a saner replacement for "git-cherry".

When used with "A...B", this filters out commits whose patch
text has the same patch-id as a commit on the other side.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

  Junio C Hamano <junkio@cox.net> writes:

  > Funny.
  >
  > Last night I was thinking about git-cherry, as it is one of the
  > few commands that have "funny parameter semantics that do not
  > mesh well with git-log family" (others are format-patch and
  > rebase).
  >
  > I think we should be able to use --left-right and ... operator
  > to express what the above cherry does with something like:
  >
  >     $ git log --left-right --ignore-common-patch cvs-upstream...my-branch
  >
  > The --ignore-common-patch option does not exist yet, but the
  > basic code to implement it should already be accessible from the
  > log family, as that is what format-patch needs to do.

 revision.c |  141 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 revision.h |    1 +
 2 files changed, 142 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 486393c..0903f19 100644
--- a/revision.c
+++ b/revision.c
@@ -422,6 +422,139 @@ static void add_parents_to_list(struct rev_info *revs, struct commit *commit, st
 	}
 }
 
+/*
+ * This needs to be moved from builtin-log -- its get_patch_ids() implementation
+ * is horrible -- it pollutes the object array with non objects!
+ */
+static int get_patch_id(struct commit *commit, struct diff_options *options,
+		unsigned char *sha1)
+{
+	if (commit->parents)
+		diff_tree_sha1(commit->parents->item->object.sha1,
+		               commit->object.sha1, "", options);
+	else
+		diff_root_tree_sha1(commit->object.sha1, "", options);
+	diffcore_std(options);
+	return diff_flush_patch_id(options, sha1);
+}
+
+struct patch_id_ent {
+	unsigned char patch_id[20];
+	char seen;
+};
+
+static int compare_patch_id(const void *a_, const void *b_)
+{
+	struct patch_id_ent *a = *((struct patch_id_ent **)a_);
+	struct patch_id_ent *b = *((struct patch_id_ent **)b_);
+	return hashcmp(a->patch_id, b->patch_id);
+}
+
+static void cherry_pick_list(struct commit_list *list)
+{
+	struct commit_list *p;
+	int left_count = 0, right_count = 0, nr;
+	struct patch_id_ent *patches, **table;
+	int left_first, table_size;
+	struct diff_options opts;
+
+	/* First count the commits on the left and on the right */
+	for (p = list; p; p = p->next) {
+		struct commit *commit = p->item;
+		unsigned flags = commit->object.flags;
+		if (flags & BOUNDARY)
+			;
+		else if (flags & SYMMETRIC_LEFT)
+			left_count++;
+		else
+			right_count++;
+	}
+
+	left_first = left_count < right_count;
+	table_size = left_first ? left_count : right_count;
+
+	/* Allocate a look-up table to help matching up */
+	patches = xcalloc(table_size, sizeof(struct patch_id_ent));
+	table = xcalloc(table_size, sizeof(struct patch_id_ent *));
+	nr = 0;
+
+	diff_setup(&opts);
+	opts.recursive = 1;
+	if (diff_setup_done(&opts) < 0)
+		die("diff_setup_done failed");
+
+	/* Compute patch-ids for one side */
+	for (p = list; p; p = p->next) {
+		struct commit *commit = p->item;
+		unsigned flags = commit->object.flags;
+
+		if (flags & BOUNDARY)
+			continue;
+		/*
+		 * If we have fewer left, left_first is set and we omit
+		 * commits on the right branch in this loop.  If we have
+		 * fewer right, we skip the left ones.
+		 */
+		if (left_first != !!(flags & SYMMETRIC_LEFT))
+			continue;
+		if (get_patch_id(commit, &opts, patches[nr].patch_id))
+			continue;
+		/*
+		 * FIXME: this does not really work if the side
+		 * we are dealing with have two commits with the same
+		 * patch id, as we end up having two entries in the
+		 * patch table.
+		 */
+		table[nr] = &(patches[nr]);
+		commit->util = table[nr];
+		nr++;
+	}
+	qsort(table, nr, sizeof(table[0]), compare_patch_id);
+
+	/* Check the other side */
+	for (p = list; p; p = p->next) {
+		struct commit *commit = p->item;
+		unsigned flags = commit->object.flags;
+		struct patch_id_ent ent, *entp = &ent, **found;
+
+		if (flags & BOUNDARY)
+			continue;
+		/*
+		 * If we have fewer left, left_first is set and we omit
+		 * commits on the left branch in this loop.
+		 */
+		if (left_first == !!(flags & SYMMETRIC_LEFT))
+			continue;
+		if (get_patch_id(commit, &opts, ent.patch_id))
+			continue;
+		/*
+		 * Have we seen the same patch id?
+		 */
+		found = bsearch(&entp, table, nr, sizeof(table[0]),
+				compare_patch_id);
+		if (!found)
+			continue;
+		(*found)->seen = 1;
+		commit->object.flags |= SHOWN; /* exclude this from the output set */
+	}
+
+	/* Now check the original side for seen ones */
+	for (p = list; p; p = p->next) {
+		struct commit *commit = p->item;
+		struct patch_id_ent *ent;
+
+		ent = commit->util;
+		if (!ent)
+			continue;
+		if (ent->seen)
+			commit->object.flags |= SHOWN;
+		commit->util = NULL;
+	}
+
+	free(table);
+	free(patches);
+}
+
 static void limit_list(struct rev_info *revs)
 {
 	struct commit_list *list = revs->commits;
@@ -449,6 +582,9 @@ static void limit_list(struct rev_info *revs)
 			continue;
 		p = &commit_list_insert(commit, p)->next;
 	}
+	if (revs->cherry_pick)
+		cherry_pick_list(newlist);
+
 	revs->commits = newlist;
 }
 
@@ -913,6 +1049,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->left_right = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--cherry-pick")) {
+				revs->cherry_pick = 1;
+				revs->left_right = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--objects")) {
 				revs->tag_objects = 1;
 				revs->tree_objects = 1;
diff --git a/revision.h b/revision.h
index 55e6b53..b69624a 100644
--- a/revision.h
+++ b/revision.h
@@ -47,6 +47,7 @@ struct rev_info {
 			left_right:1,
 			parents:1,
 			reverse:1,
+			cherry_pick:1,
 			first_parent_only:1;
 
 	/* Diff flags */
