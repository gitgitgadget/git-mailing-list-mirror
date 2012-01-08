From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] rebase --fix: interactive fixup mode
Date: Sun, 8 Jan 2012 22:31:34 +0100
Message-ID: <20120108213134.GA18671@ecki.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 22:40:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rk0T8-0003Lv-Ev
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 22:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754552Ab2AHVjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 16:39:53 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:50713 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754504Ab2AHVjx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 16:39:53 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 4D95510012;
	Sun,  8 Jan 2012 22:37:58 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188143>

Interactive rebase is frequently used not to rebase history, but to
manipulate recent commits. This is typically done using the following
command:

 git rebase -i HEAD~N

Where N has to be large enough such that the the range HEAD~N..HEAD
contains the desired commits. At the same time, it should be small
enough such that the range HEAD~N..HEAD does not include published
commits or a merge commit. Otherwise, the user may accidentally change
published history. Rebasing a merge commit can also have the generally
undesirable effect of linearizing the merge history.

In order to determine a suitable range automatically, it is a reasonable
heuristic to rebase onto the most recent merge commit. It does not
guarantee that published commits are not included -- indeed there is no
way to do that. But, the range is usually large enough to contain the
desired commits. Also, this mechanism works regardless of whether or not
branch tracking has been configured.

So instead of the above command, one can instead use the following:

 git rebase --fix

By default, the range is limited to a maximum of 20 commits. This can be
changed by passing a different number to --fix, e.g.:

 git rebase --fix=50

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

Also on branch cb/rebase-fix at https://github.com/drizzd/git .

 Documentation/git-rebase.txt |    9 +++++++++
 git-rebase.sh                |   37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 504945c..b1eac16 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -332,6 +332,15 @@ link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To] for details).
 	user edit that list before rebasing.  This mode can also be used to
 	split commits (see SPLITTING COMMITS below).
 
+--fix=<n>::
+	Searches commit history backwards from the current commit until the
+	most recent merge commit, or until a maximum of <n> preceding commits
+	(default: 20), and runs rebase -i <commit>^. The resulting range is
+	typically large enough to contain recent commits which the user might
+	want to edit, while avoiding the usually undesirable effects of
+	rebasing a merge commit, which obviates the need to find a suitable
+	base commit manually.
+
 -p::
 --preserve-merges::
 	Instead of ignoring merges, try to recreate them.
diff --git a/git-rebase.sh b/git-rebase.sh
index 00ca7b9..e95b57f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -38,6 +38,7 @@ git-rebase [-i] --continue | --abort | --skip
 v,verbose!         display a diffstat of what changed upstream
 q,quiet!           be quiet. implies --no-stat
 onto=!             rebase onto given branch instead of upstream
+fix?!              interactive rebase onto last merge commit
 p,preserve-merges! try to recreate merges instead of ignoring them
 s,strategy=!       use the given merge strategy
 no-ff!             cherry-pick all commits, even if unchanged
@@ -95,6 +96,7 @@ type=
 state_dir=
 # One of {'', continue, skip, abort}, as parsed from command line
 action=
+rebase_fix=
 preserve_merges=
 autosquash=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
@@ -178,6 +180,22 @@ run_pre_rebase_hook () {
 	fi
 }
 
+latest_merge_commit()
+{
+	max_nr_commits=$1
+
+	latest_merge=$(git rev-list -1 --merges HEAD)
+	if test -z "$latest_merge"
+	then
+		range=HEAD
+	else
+		range=$latest_merge..HEAD
+	fi
+
+	range_start=$(git rev-list -"$max_nr_commits" "$range" | tail -1)
+	echo $(git rev-parse $range_start^)
+}
+
 test -f "$apply_dir"/applying &&
 	die 'It looks like git-am is in progress. Cannot rebase.'
 
@@ -220,6 +238,20 @@ do
 	-i)
 		interactive_rebase=explicit
 		;;
+	--fix)
+		interactive_rebase=explicit
+		rebase_fix=20
+		# Parse optional argument.
+		if test "${2#-}" = "$2"
+		then
+			if ! expr "$2" : "^[0-9]\+$" >/dev/null
+			then
+				die "Invalid argument to rebase --fix: $2"
+			fi
+			rebase_fix=$2
+			shift
+		fi
+		;;
 	-p)
 		preserve_merges=t
 		test -z "$interactive_rebase" && interactive_rebase=implied
@@ -375,7 +407,10 @@ if test -z "$rebase_root"
 then
 	case "$#" in
 	0)
-		if ! upstream_name=$(git rev-parse --symbolic-full-name \
+		if test -n "$rebase_fix"
+		then
+			upstream_name=$(latest_merge_commit $rebase_fix)
+		elif ! upstream_name=$(git rev-parse --symbolic-full-name \
 			--verify -q @{upstream} 2>/dev/null)
 		then
 			. git-parse-remote
-- 
1.7.8
