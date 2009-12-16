From: "Bernhard R. Link" <brlink@debian.org>
Subject: [PATCH] Let format-patch and rebase ignore trivial merges.
Date: Wed, 16 Dec 2009 17:45:53 +0100
Message-ID: <20091216164553.GA22471@pcpool00.mathematik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 17:46:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKx0i-000536-TV
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 17:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757165AbZLPQp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2009 11:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757081AbZLPQp4
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 11:45:56 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:39790
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754547AbZLPQpy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2009 11:45:54 -0500
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NKx0b-0000Nu-AK
	for git@vger.kernel.org; Wed, 16 Dec 2009 17:45:53 +0100
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NKx0b-0005qd-8V
	for git@vger.kernel.org; Wed, 16 Dec 2009 17:45:53 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135333>

As git rebase and git format-patch linearize commits,
having the same change in different branches causes in the
best case duplicate patches in the produced series and in the
worst case conflicts. If there are trivial merges involved
(i.e. merges that do not change the tree), then this patch
will cause git to only look at one branch, thereby avoiding
duplicates and reducing the chance of conflicts.

There are two new options --prune-tree and --no-prune-tree
added.

--prune-tree makes rev-list without paths equivalent to
"git rev-list $options -- ." (or .. or ../.. and so on,
if you are in some subdirectory).
This is the new default for format-patch and rebase

--no-prune-tree deactivates --prune-tree.

Signed-off-by: Bernhard R. Link <brlink@debian.org>
---
 Documentation/rev-list-options.txt |   11 +++++++++++
 builtin-log.c                      |    1 +
 git-rebase--interactive.sh         |    1 +
 git-rebase.sh                      |    2 +-
 revision.c                         |   11 ++++++++++-
 revision.h                         |    1 +
 6 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 1f57aed..6c5e90c 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -328,6 +328,17 @@ The following options select the commits to be shown:
 
 	Commits modifying the given <paths> are selected.
 
+--prune-tree::
+
+	No paths is equivalent to the whole tree as path.
+	That means merges with the same tree follow only one parent.
+	(Default for format-patch and rebase).
+
+--no-prune-tree::
+
+	No paths means not doing history simplification based on paths.
+	(Default for everything but format-patch and rebase).
+
 --simplify-by-decoration::
 
 	Commits that are referred by some branch or tag are selected.
diff --git a/builtin-log.c b/builtin-log.c
index 1766349..efc2f40 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -960,6 +960,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.diff = 1;
 	rev.combine_merges = 0;
 	rev.ignore_merges = 1;
+	rev.prune_tree = 1;
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
 
 	rev.subject_prefix = fmt_patch_subject_prefix;
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0bd3bf7..ea23d9b 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -703,6 +703,7 @@ first and then run 'git rebase --continue' again."
 		fi
 		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
 			--abbrev=7 --reverse --left-right --topo-order \
+			--prune-tree \
 			$REVISIONS | \
 			sed -n "s/^>//p" | while read shortsha1 rest
 		do
diff --git a/git-rebase.sh b/git-rebase.sh
index b121f45..2186619 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -539,7 +539,7 @@ echo "$head_name" > "$dotest/head-name"
 echo "$GIT_QUIET" > "$dotest/quiet"
 
 msgnum=0
-for cmt in `git rev-list --reverse --no-merges "$revisions"`
+for cmt in `git rev-list --reverse --no-merges --prune-tree "$revisions"`
 do
 	msgnum=$(($msgnum + 1))
 	echo "$cmt" > "$dotest/cmt.$msgnum"
diff --git a/revision.c b/revision.c
index a8a3c3a..3350af6 100644
--- a/revision.c
+++ b/revision.c
@@ -1112,6 +1112,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->dense = 1;
 	} else if (!strcmp(arg, "--sparse")) {
 		revs->dense = 0;
+	} else if (!strcmp(arg, "--prune-tree")) {
+		revs->prune_tree = 1;
+	} else if (!strcmp(arg, "--no-prune-tree")) {
+		revs->prune_tree = 0;
 	} else if (!strcmp(arg, "--show-all")) {
 		revs->show_all = 1;
 	} else if (!strcmp(arg, "--remove-empty")) {
@@ -1408,8 +1412,13 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		}
 	}
 
-	if (prune_data)
+	if (prune_data) {
 		revs->prune_data = get_pathspec(revs->prefix, prune_data);
+	} else if (revs->prune_tree) {
+		/* limit whole tree (limits trivial merges to one side) */
+		static const char *whole_tree[2] = { "", NULL };
+		revs->prune_data = whole_tree;
+	}
 
 	if (revs->def == NULL)
 		revs->def = def;
diff --git a/revision.h b/revision.h
index d368003..d007aaa 100644
--- a/revision.h
+++ b/revision.h
@@ -38,6 +38,7 @@ struct rev_info {
 	/* Traversal flags */
 	unsigned int	dense:1,
 			prune:1,
+			prune_tree:1,
 			no_merges:1,
 			merges_only:1,
 			no_walk:1,
