From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [RFC PATCH] Why doesn't git rebase --interactive --preserve-merges continue past known conflicts?
Date: Sat,  1 Jan 2011 17:20:02 -0800
Message-ID: <1293931202-88931-1-git-send-email-ddkilzer@kilzer.net>
References: <282560.39741.qm@web30004.mail.mud.yahoo.com>
Cc: "David D. Kilzer" <ddkilzer@kilzer.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 02 02:32:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZCob-0005wz-WE
	for gcvg-git-2@lo.gmane.org; Sun, 02 Jan 2011 02:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349Ab1ABBbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jan 2011 20:31:07 -0500
Received: from mail-out.apple.com ([17.254.13.23]:53971 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753Ab1ABBbG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jan 2011 20:31:06 -0500
X-Greylist: delayed 641 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Jan 2011 20:31:06 EST
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out4.apple.com (Postfix) with ESMTP id 43658C872218;
	Sat,  1 Jan 2011 17:20:23 -0800 (PST)
X-AuditID: 1180711d-b7c30ae0000055b4-68-4d1fd2d742bb
Received: from pwmerge.apple.com (pwmerge.apple.com [17.202.36.35])
	by relay13.apple.com (Apple SCV relay) with SMTP id F0.9D.21940.7D2DF1D4; Sat,  1 Jan 2011 17:20:23 -0800 (PST)
X-Mailer: git-send-email 1.7.2.1.103.g48452
In-Reply-To: <282560.39741.qm@web30004.mail.mud.yahoo.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164407>

On 2010-12-31, David Kilzer wrote:
> When I run "git rebase --interactive --preserve-merges" on a sequence of 
> commits, edit an earlier commit, then run "git rebase --continue", the rebase 
> operation always stops on a merge commit with a known conflict (in the rr-cache) 
> instead of resolving it and continuing.
> 
> As long as I'm not rearranging commits, I expect git-rebase to resolve the known 
> merge commit conflict and continue.  Why does it always stop?

Here's a very rough patch that fixes my original test case so that an interactive
rebase won't stop when git-rerere knows how to resolve all conflicts during a
merge.

However, if there are any changes to a non-conflicted file during the original
merge commit, they will be lost when rebasing, even with --preserve-merges.
Note that this occurs even without this patch applied.  You must compare the
current commit with original being rebased to make sure they're not lost.

Why doesn't an interactive rebase serialize to disk all of the changes in a merge
commit like it does for non-merge commits?

Dave
---
 git-rebase--interactive.sh                    |   11 ++++-
 t/t3404-rebase-interactive-preserve-merges.sh |   64 +++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 2 deletions(-)
 create mode 100755 t/t3404-rebase-interactive-preserve-merges.sh

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a5ffd9a..32375bc 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -338,11 +338,18 @@ pick_one_preserving_merges () {
 			msg="$(commit_message $sha1)"
 			# No point in merging the first parent, that's HEAD
 			new_parents=${new_parents# $first_parent}
+			# If rerere is enabled, pass the --rerere-autoupdate flag
+			test "$(git config --bool rerere.enabled)" = "true" &&
+				rerere_autoupdate=--rerere-autoupdate || rerere_autoupdate=
 			if ! do_with_author output \
-				git merge $STRATEGY -m "$msg" $new_parents
+				git merge $STRATEGY $rerere_autoupdate -m "$msg" $new_parents
 			then
 				printf "%s\n" "$msg" > "$GIT_DIR"/MERGE_MSG
-				die_with_patch $sha1 "Error redoing merge $sha1"
+				# Commit the result if rerere resolved all the conflicts.
+				git update-index -q --refresh &&
+					printf "Resolved all conflicts using rerere.\n"  &&
+					do_with_author git commit --no-verify -F "$GIT_DIR"/MERGE_MSG ||
+					die_with_patch $sha1 "Error redoing merge $sha1"
 			fi
 			echo "$sha1 $(git rev-parse HEAD^0)" >> "$REWRITTEN_LIST"
 			;;
diff --git a/t/t3404-rebase-interactive-preserve-merges.sh b/t/t3404-rebase-interactive-preserve-merges.sh
new file mode 100755
index 0000000..3479f38
--- /dev/null
+++ b/t/t3404-rebase-interactive-preserve-merges.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes E. Schindelin
+# Copyright (c) 2010 David D. Kilzer
+#
+
+test_description='git rebase --interactive --preserve-matches does not automatically resolve known conflicts in merge commits'
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+set_fake_editor
+
+test_expect_success 'setup' '
+	test_commit A file1 &&
+	test_commit AA file2 &&
+	test_commit B file1 &&
+	git checkout -b topic1 HEAD^ &&
+	test_commit C file1 &&
+	git checkout master
+'
+
+test_expect_success 'rebase --interactive --preserve-merges should use rerere to resolve conflicts' '
+	git config rerere.enabled 1 &&
+	git rerere clear &&
+
+	git checkout -b merge1 master &&
+	test_must_fail git merge topic1 &&
+	printf "B\nC\n" > file1 &&
+	git add file1 &&
+	git commit -m "Merged." &&
+	git branch merge1-baseline &&
+
+	FAKE_LINES="edit 1 2" git rebase -i -p HEAD~2 &&
+	echo BB >> file2 &&
+	git add file2 &&
+	git commit --amend &&
+	git rebase --continue &&
+	git diff --exit-code merge1-baseline..merge1 file1
+'
+
+test_expect_success 'rebase --interactive --preserve-merges should not lose changes in merge commits' '
+	git config rerere.enabled 1 &&
+	git rerere clear &&
+
+	git checkout -b merge2 master &&
+	test_must_fail git merge topic1 &&
+	printf "B\nC\n" > file1 &&
+	git add file1 &&
+	echo BB >> file2 &&
+	git add file2 &&
+	git commit -m "Merged with change to non-conflicted file." &&
+	git branch merge2-baseline &&
+
+	FAKE_LINES="edit 1 2" git rebase -i -p HEAD~2 &&
+	echo AAA > file3 &&
+	git add file3 &&
+	git commit --amend &&
+	git rebase --continue &&
+	git diff --exit-code merge2-baseline..merge2 file1 &&
+	git diff --exit-code merge2-baseline..merge2 file2
+'
+
+test_done
-- 
1.7.2.1.103.g48452
