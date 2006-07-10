From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] read-tree --rename (WIP)
Date: Mon, 10 Jul 2006 05:18:26 -0700
Message-ID: <7v1wstd565.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 10 14:18:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzuig-0008C8-Tg
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 14:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbWGJMS2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 08:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbWGJMS2
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 08:18:28 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:56714 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030310AbWGJMS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 08:18:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060710121827.VGBA27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Jul 2006 08:18:27 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23613>

This adds '--rename' flag to 3-way merge done by "read-tree -m".
Currently it detects the case where one branch renamed but the
other branch didn't.  It should be taught to notice that both
branches renamed the same old path to the same new path.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * To use this, you would copy git-merge-resolve.sh to create
   git-merge-rename.sh, replace "git-read-tree --aggressive"
   call with "git-read-tree --rename", or something like that.

   I wanted to avoid the changes to threeway_merge().  They were
   to force the code to leave "only one side added" cases
   unmerged.

 builtin-read-tree.c |  150 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 150 insertions(+), 0 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 6df5d7c..e7aba0e 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -11,6 +11,8 @@ #include "object.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "cache-tree.h"
+#include "diff.h"
+#include "diffcore.h"
 #include <sys/time.h>
 #include <signal.h>
 #include "builtin.h"
@@ -22,6 +24,7 @@ static int index_only = 0;
 static int nontrivial_merge = 0;
 static int trivial_merges_only = 0;
 static int aggressive = 0;
+static int do_renames = 0;
 static int verbose_update = 0;
 static volatile int progress_update = 0;
 static const char *prefix = NULL;
@@ -389,6 +392,130 @@ static void check_updates(struct cache_e
 	}
 }
 
+static struct cache_entry *renamed_entry(const char *new_name, int namelen, struct cache_entry *old)
+{
+	struct cache_entry *renamed;
+
+	renamed = xcalloc(1, cache_entry_size(namelen));
+	renamed->ce_mode = old->ce_mode;
+	renamed->ce_flags = create_ce_flags(namelen, ce_stage(old));
+	strcpy(renamed->name, new_name);
+	memcpy(renamed->sha1, old->sha1, 20);
+	return renamed;
+}
+
+static void handle_renames(void)
+{
+	/* Find entries that have stages #1 and #2 (but not #3)
+	 * and then entries that have stage #3 only.
+	 * If #1 of the former and #3 of the latter are similar,
+	 * that means we did not rename it but they did.
+	 * Similarly, entries that have stages #1 and #3 can be
+	 * matched up with entries that have only stage #2, in
+	 * which case they did not rename but we did.
+	 * In either case, move the #1 and unmoved stage to the
+	 * path of the moved stage.
+	 */
+	struct diff_options opt;
+	int i;
+
+	diff_setup(&opt);
+	opt.detect_rename = DIFF_DETECT_RENAME;
+	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
+	opt.recursive = 1;
+	diff_setup_done(&opt);
+
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		int j;
+		if (!ce_stage(ce))
+			continue; /* fully merged */
+
+		for (j = i + 1; j < active_nr; j++) {
+			if (strcmp(ce->name, active_cache[j]->name))
+				break;
+		}
+
+		if (ce_stage(ce) == 1 && (j - i) == 2)
+			/* This entry has stage #1 and another one
+			 * i.e. either #2 or #3 but not both.
+			 */
+			diff_addremove(&opt, '-', ntohl(ce->ce_mode), ce->sha1,
+				       ce->name, NULL);
+
+		if (1 < ce_stage(ce) && (j - i) == 1)
+			/* This entry has only stage #2 or #3 */
+			diff_addremove(&opt, '+', ntohl(ce->ce_mode), ce->sha1,
+				       ce->name, NULL);
+
+		i = j - 1;
+	}
+	diffcore_std(&opt);
+
+	if (diff_queued_diff.nr) {
+		/* We have found the renames and stuff */
+		for (i = 0; i < diff_queued_diff.nr; i++) {
+			struct diff_filepair *p = diff_queued_diff.queue[i];
+			const char *old_name, *new_name;
+			int namelen;
+			struct cache_entry *e, *e_one, *e_kept, *e_moved;
+			int pos, kept;
+
+			if (p->status != DIFF_STATUS_RENAMED)
+				continue;
+
+			/* one->path has stage #1 and either stage #2
+			 * or #3 that was kept on one branch, and
+			 * two->path is where it was moved on the other
+			 * branch, either stage #2 or stage #3.
+			 */
+			old_name = p->one->path;
+			new_name = p->two->path;
+			namelen = strlen(new_name);
+			pos = cache_name_pos(old_name, strlen(old_name));
+			if (0 <= pos)
+				die("oops %s:%d", __FILE__, __LINE__);
+			pos = -pos - 1;
+			e = active_cache[pos++];
+			if (strcmp(e->name, old_name))
+				die("oops %s:%d", __FILE__, __LINE__);
+			if (ce_stage(e) != 1)
+				die("oops %s:%d", __FILE__, __LINE__);
+			e_one = renamed_entry(new_name, namelen, e);
+			if (active_nr <= pos)
+				die("oops %s:%d", __FILE__, __LINE__);
+			e = active_cache[pos];
+			if (strcmp(e->name, old_name))
+				die("oops %s:%d", __FILE__, __LINE__);
+			kept = ce_stage(e);
+			if (kept < 2)
+				die("oops %s:%d", __FILE__, __LINE__);
+			e_kept = renamed_entry(new_name, namelen, e);
+
+			pos = cache_name_pos(new_name, namelen);
+			if (0 <= pos)
+				die("oops %s:%d", __FILE__, __LINE__);
+			pos = -pos - 1;
+			e = active_cache[pos];
+			if (strcmp(e->name, new_name))
+				die("oops %s:%d", __FILE__, __LINE__);
+			if (ce_stage(e) + kept != 5)
+				/* If kept was #2 this must be #3 and
+				 * vice versa.
+				 */
+				die("oops %s:%d", __FILE__, __LINE__);
+			e_moved = renamed_entry(new_name, namelen, e);
+
+			remove_file_from_cache(old_name);
+			remove_file_from_cache(new_name);
+			add_cache_entry(e_one, ADD_CACHE_OK_TO_ADD);
+			add_cache_entry(e_kept, ADD_CACHE_OK_TO_ADD);
+			add_cache_entry(e_moved, ADD_CACHE_OK_TO_ADD);
+		}
+	}
+	diff_flush(&opt);
+}
+
 static int unpack_trees(merge_fn_t fn)
 {
 	int indpos = 0;
@@ -412,6 +539,9 @@ static int unpack_trees(merge_fn_t fn)
 	if (trivial_merges_only && nontrivial_merge)
 		die("Merge requires file-level merging");
 
+	if (merge_size == 3 && do_renames)
+		handle_renames();
+
 	check_updates(active_cache, active_nr);
 	return 0;
 }
@@ -606,6 +736,10 @@ static int threeway_merge(struct cache_e
 		}
 	}
 
+	if (do_renames && remote && !head && !index && any_anc_missing)
+		/* they created, we didn't -- maybe they renamed */
+		return keep_entry(remote);
+
 	/* We start with cases where the index is allowed to match
 	 * something other than the head: #14(ALT) and #2ALT, where it
 	 * is permitted to match the result instead.
@@ -625,6 +759,10 @@ static int threeway_merge(struct cache_e
 	}
 
 	if (head) {
+		if (do_renames && !remote && any_anc_missing)
+			/* we created, they didn't -- maybe we renamed */
+			return keep_entry(head);
+
 		/* #5ALT, #15 */
 		if (same(head, remote))
 			return merged_entry(head, index);
@@ -868,6 +1006,9 @@ static void prime_cache_tree(void)
 
 static const char read_tree_usage[] = "git-read-tree (<sha> | [[-m [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] <sha1> [<sha2> [<sha3>]])";
 
+static const char err_aggressive_rename[] =
+"--aggressive and --rename are mutually exclusive";
+
 static struct lock_file lock_file;
 
 int cmd_read_tree(int argc, const char **argv, char **envp)
@@ -952,10 +1093,19 @@ int cmd_read_tree(int argc, const char *
 		}
 
 		if (!strcmp(arg, "--aggressive")) {
+			if (do_renames)
+				die(err_aggressive_rename);
 			aggressive = 1;
 			continue;
 		}
 
+		if (!strcmp(arg, "--rename")) {
+			if (aggressive)
+				die(err_aggressive_rename);
+			do_renames = 1;
+			continue;
+		}
+
 		/* "-m" stands for "merge", meaning we start in stage 1 */
 		if (!strcmp(arg, "-m")) {
 			if (stage || merge || prefix)
-- 
1.4.1.gf157
