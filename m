From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] show-branch --upstream: add upstream branches to the list of branches to display
Date: Wed, 11 Feb 2015 10:16:14 +0900
Message-ID: <1423617374-31408-1-git-send-email-mh@glandium.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 02:16:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLLuq-0005hy-6d
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 02:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbbBKBQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 20:16:28 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:55070 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813AbbBKBQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 20:16:27 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YLLuY-0008BF-OB; Wed, 11 Feb 2015 10:16:14 +0900
X-Mailer: git-send-email 2.3.0.2.g4d8711e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263668>

`git show-branch` is a useful tool to display topics, but when you have
several local topic branches based on different upstream branches, it
can get cumbersome to use the right upstream branch with the right set
of topic branches.

The --upstream flag automatically adds the upstream branch for every
topic branch given, such that:

`git show-branch --upstream` is equivalent to `git show-branch
$(git for-each-ref refs/heads --format '%(refname:short)')
$(git for-each-ref refs/heads --format '%(upstream:short)')`

`git show-branch --upstream foo bar` is equivalent to `git show-branch
foo bar $(git for-each-ref refs/heads/foo refs/heads/bar
--format '%(upstream:short)')`

Furthermore, the --topics argument only takes one "upstream" ref. However,
when combined with --upstream, all the upstream branches are considered,
and show-branch only shows commits that are NOT on ANY of those upstream
branches.

Signed-off-by: Mike Hommey <mh@glandium.org>
---

Refreshed against current "next".


 Documentation/git-show-branch.txt |  6 ++++++
 builtin/show-branch.c             | 44 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index b91d4e5..fd29c8d 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -53,6 +53,10 @@ OPTIONS
 	branch to the list of revs to be shown when it is not
 	given on the command line.
 
+--upstream::
+	With this option, the command includes the upstream
+	branch of each rev to be shown.
+
 --topo-order::
         By default, the branches and their commits are shown in
         reverse chronological order.  This option makes them
@@ -102,6 +106,8 @@ OPTIONS
 
 --topics::
 	Shows only commits that are NOT on the first branch given.
+	When used with `--upstream`, shows only commits that are NOT
+	on any upstream branch.
 	This helps track topic branches by hiding any commit that
 	is already in the main line of development.  When given
 	"git show-branch --topics master topic1 topic2", this
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index f3fb5fb..140e88c 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -4,11 +4,12 @@
 #include "builtin.h"
 #include "color.h"
 #include "parse-options.h"
+#include "remote.h"
 
 static const char* show_branch_usage[] = {
     N_("git show-branch [-a | --all] [-r | --remotes] [--topo-order | --date-order]\n"
-       "		[--current] [--color[=<when>] | --no-color] [--sparse]\n"
-       "		[--more=<n> | --list | --independent | --merge-base]\n"
+       "		[--current] [--upstream] [--color[=<when>] | --no-color]\n"
+       "		[--sparse] [--more=<n> | --list | --independent | --merge-base]\n"
        "		[--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"),
     N_("git show-branch (-g | --reflog)[=<n>[,<base>]] [--list] [<ref>]"),
     NULL
@@ -643,6 +644,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	int sha1_name = 0;
 	int shown_merge_point = 0;
 	int with_current_branch = 0;
+	int with_upstream_branches = 0;
 	int head_at = -1;
 	int topics = 0;
 	int dense = 1;
@@ -661,6 +663,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		OPT_BOOL(0, "no-name", &no_name, N_("suppress naming strings")),
 		OPT_BOOL(0, "current", &with_current_branch,
 			 N_("include the current branch")),
+		OPT_BOOL(0, "upstream", &with_upstream_branches,
+			 N_("include upstream branches")),
 		OPT_BOOL(0, "sha1-name", &sha1_name,
 			 N_("name commits with their object names")),
 		OPT_BOOL(0, "merge-base", &merge_base,
@@ -851,7 +855,41 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		if (commit->object.flags == flag)
 			commit_list_insert_by_date(commit, &list);
 		rev[num_rev] = commit;
+
+		if (with_upstream_branches) {
+			unsigned char branch_sha1[20];
+			struct branch *branch;
+			int current_ref_name_cnt = ref_name_cnt;
+
+			/* If this ref is already marked as an upstream, skip */
+			if (topics & flag)
+				continue;
+
+			branch = branch_get(ref_name[num_rev]);
+
+			if (!branch || !branch->merge || !branch->merge[0] ||
+			    !branch->merge[0]->dst)
+				continue;
+			if (get_sha1(branch->merge[0]->dst, branch_sha1))
+				continue;
+			append_remote_ref(branch->merge[0]->dst, branch_sha1, 0, 0);
+			/* If append_remote_ref didn't add a ref, it's either
+			 * because it's an upstream of a previous ref, or because
+			 * it was given on the command line. In neither case we
+			 * want the bit being set. */
+			if (topics && current_ref_name_cnt != ref_name_cnt)
+				topics |= 1u << (ref_name_cnt + REV_SHIFT - 1);
+		} else if (topics && num_rev == 0) {
+			topics |= flag;
+		}
 	}
+	/* topics is filled above with a mask of refs corresponding to
+	 * upstream branches, or the first given ref. It also still contains
+	 * the original bool value, which may match some bookkeeping flags,
+	 * so filter that out.
+	 */
+	topics &= ~0u << REV_SHIFT;
+
 	for (i = 0; i < num_rev; i++)
 		rev_mask[i] = rev[i]->object.flags;
 
@@ -928,7 +966,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 					  commit->parents->next);
 			if (topics &&
 			    !is_merge_point &&
-			    (this_flag & (1u << REV_SHIFT)))
+			    (this_flag & topics))
 				continue;
 			if (dense && is_merge &&
 			    omit_in_dense(commit, rev, num_rev))
-- 
2.3.0.2.g4d8711e
