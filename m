From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH] Fix filter-branch to eliminate duplicate mapped parents
Date: Mon, 30 Jun 2014 22:20:27 +0100
Message-ID: <1404163227-30962-1-git-send-email-charles@hashpling.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 30 23:28:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1j7N-0008Ey-FO
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 23:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962AbaF3V2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 17:28:00 -0400
Received: from avasout05.plus.net ([84.93.230.250]:55114 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755939AbaF3V17 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 17:27:59 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jun 2014 17:27:58 EDT
Received: from turing.int.hashpling.org ([212.159.69.125])
	by avasout05 with smtp
	id LlMs1o00B2iA9hg01lMtJb; Mon, 30 Jun 2014 22:21:53 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=DIIB4k9b c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=Ew9TdX-QAAAA:8
 a=0Bzu9jTXAAAA:8 a=VdcC7f4BjmcA:10 a=mSBy96HJJ2wA:10 a=BHUvooL90DcA:10
 a=BNFp--SqAAAA:8 a=aTS61HEP5OskZEEzb38A:9 a=92rhvNbd_XgA:10
Received: from charles by turing.int.hashpling.org with local (Exim 4.82)
	(envelope-from <charles@hashpling.org>)
	id 1X1izz-00084T-2L
	for git@vger.kernel.org; Mon, 30 Jun 2014 22:20:27 +0100
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252701>

From: Charles Bailey <cbailey32@bloomberg.net>

When multiple parents of a merge commit get mapped to the same commit,
filter-branch used to pass all instances of the parent commit to the
parent and commit filters and to "git commit-tree" or
"git_commit_non_empty_tree".

This can often happen when extracting a small project from a large
repository; merges can join history with no commits on any branch which
affect the paths being retained. Once the intermediate commits have been
filtered out, all the immediate parents of the merge commit can end up
being mapped to the same commit - either the original merge-base or an
ancestor of it.

"git commit-tree" would display an error but write the commit with the
normalized parents in any case. "git_commit_non_empty_tree" would fail
to notice that the commit being made was in fact a non-merge commit and
would retain it even if a further pass with --prune-empty would discard
the commit as empty.

This change ensure that duplicate parents are pruned before the parent
filter and ensures that --prune-empty is idempotent, removing all
empty non-merge commits in a singe pass.

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
---

I worked on this after discovering that --prune-empty often left some
apparently empty commits that I was wasn't expecting it to leave and
that running filter-branch --prune-empty in a loop would often do many
passes where it was still pruning empty former merge commits.

The test is a simple example of such a case. A non-ff merge of a commit
that only changes a file that is to be pruned gets squashed into an
empty non-merge commit that should be pruned.

 git-filter-branch.sh     |  8 +++++++-
 t/t7003-filter-branch.sh | 11 +++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 86d6994..c5b82a8 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -332,7 +332,13 @@ while read commit parents; do
 	parentstr=
 	for parent in $parents; do
 		for reparent in $(map "$parent"); do
-			parentstr="$parentstr -p $reparent"
+			case "$parentstr" in
+				*" -p $reparent"*)
+					;;
+				*)
+					parentstr="$parentstr -p $reparent"
+					;;
+			esac
 		done
 	done
 	if [ "$filter_parent" ]; then
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 9496736..3741f51 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -308,6 +308,17 @@ test_expect_success 'Prune empty commits' '
 	test_cmp expect actual
 '
 
+test_expect_success 'Prune empty collapsed merges' '
+	test_config merge.ff false &&
+	git rev-list HEAD > expect &&
+	test_commit to_remove_2 &&
+	git reset --hard HEAD^ &&
+	test_merge non-ff to_remove_2 &&
+	git filter-branch -f --index-filter "git update-index --remove to_remove_2.t" --prune-empty HEAD &&
+	git rev-list HEAD > actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--remap-to-ancestor with filename filters' '
 	git checkout master &&
 	git reset --hard A &&
-- 
1.9.0
