From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH/RFC] rebase -p: do not redo the merge, but cherry-pick first-parent
 changes
Date: Mon, 21 May 2012 22:19:09 +0200
Message-ID: <4FBAA33D.1080703@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Stephen Haberman <stephen@exigencecorp.com>,
	Andrew Wong <andrew.kw.w@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 21 22:19:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWZ4a-0001Ow-Bo
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 22:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758282Ab2EUUTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 16:19:15 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:7737 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752999Ab2EUUTO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 16:19:14 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7DDDFCDF86;
	Mon, 21 May 2012 22:20:13 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 247C319F30B;
	Mon, 21 May 2012 22:19:10 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198125>

When rebase -p had to replay a merge commit, it used to redo the merge.
But this has drawbacks:

- When the merge was evil, i.e., contained changes that are in neither of
  the parents, that change was not preserved.

- The 'git merge' invocation passed the commit message of the old merge
  commit, but it still obeyed the merge.log option. If it was set, the log
  ended up twice in the commit message.

Replace the 'git merge' by a cherry-pick that picks the changes that the
merge introduces with respect to the first parent.

The change in t3409 reflects the new situation after a conflicting merge
is replayed: Earlier, 'git merge' found a conflict in an add/add
situation with file B only in stage 2 and 3, now it is a regular three-way
merge conflict.

A test in  t3410 fails now with this new implementation. The branch that
is merged in by the old history and that is to be preserved is already
merged into the new upstream. In the old implementation, 'git merge'
detected this situation and succeeded with "Already up to date", but the
new implementation does not notice that it is pointless to keep the merge.
It just tries to follow instructions, but fails due to a conflicting
cherry-pick. This is a corner case whose correct solution should be that
the "pick" instruction is not generated in the first place.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This is RFC because of the new failure addressed in the last paragraph
 above (see also the art work in the patch context below), how serious
 the failure is, and what to do about it.

 See also this recent thread for further motivation:
 http://thread.gmane.org/gmane.comp.version-control.git/194434/focus=194737

 git-rebase--interactive.sh                | 12 +++++++-----
 t/t3409-rebase-preserve-merges.sh         |  2 +-
 t/t3410-rebase-preserve-dropped-merges.sh |  4 ++--
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0c19b7c..642daab 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -312,12 +312,14 @@ pick_one_preserving_merges () {
 			msg_content="$(commit_message $sha1)"
 			# No point in merging the first parent, that's HEAD
 			new_parents=${new_parents# $first_parent}
-			if ! do_with_author output \
-				git merge --no-ff ${strategy:+-s $strategy} -m \
-					"$msg_content" $new_parents
+			printf "%s\n" $new_parents >"$GIT_DIR"/MERGE_HEAD
+			printf "%s\n" "$msg_content" >"$GIT_DIR"/MERGE_MSG
+			if output git cherry-pick -m 1 -n "$sha1"
 			then
-				printf "%s\n" "$msg_content" > "$GIT_DIR"/MERGE_MSG
-				die_with_patch $sha1 "Error redoing merge $sha1"
+				do_with_author output git commit --no-verify -F "$GIT_DIR"/MERGE_MSG ||
+					die_with_patch $sha1 "Could not replay merge $sha1"
+			else
+				die_with_patch $sha1 "Could not pick merge $sha1"
 			fi
 			echo "$sha1 $(git rev-parse HEAD^0)" >> "$rewritten_list"
 			;;
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 6de4e22..7161b99 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -116,7 +116,7 @@ test_expect_success '--continue works after a conflict' '
 	cd clone2 &&
 	git fetch &&
 	test_must_fail git rebase -p origin/topic &&
-	test 2 = $(git ls-files B | wc -l) &&
+	test 3 = $(git ls-files B | wc -l) &&
 	echo Resolved again > B &&
 	test_must_fail git rebase --continue &&
 	grep "^@@@ " .git/rebase-merge/patch &&
diff --git a/t/t3410-rebase-preserve-dropped-merges.sh b/t/t3410-rebase-preserve-dropped-merges.sh
index 6f73b95..36c69b2 100755
--- a/t/t3410-rebase-preserve-dropped-merges.sh
+++ b/t/t3410-rebase-preserve-dropped-merges.sh
@@ -60,12 +60,12 @@ test_expect_success 'skip same-resolution merges with -p' '
 # A - B - C - D - E
 #   \             \ \
 #     F - G - H -- L2 \        -->   L2
 #       \             |                \
 #         I -- G3 --- J2 -- K2           I -- G3 -- K2
-# G2 = different changes as G
-test_expect_success 'keep different-resolution merges with -p' '
+# G3 = different changes as G
+test_expect_failure 'keep different-resolution merges with -p' '
 	git checkout H &&
 	test_must_fail git merge E &&
 	test_commit L2 file1 23 &&
 	git checkout I &&
 	test_commit G3 file1 4 &&
-- 
1.7.10.2.529.g0c18cfd
