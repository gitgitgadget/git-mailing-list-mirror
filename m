From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1] rebase -p: Command line option --no-ff is ignored
Date: Mon,  7 Jul 2014 05:50:00 +0200
Message-ID: <d8a1d5015e5562a706c1e8cf574d6011f1f1ac38.1404704884.git.bafain@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 07 05:52:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3zyX-0002aG-EZ
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 05:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbaGGDu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2014 23:50:28 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:52977 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbaGGDu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2014 23:50:27 -0400
Received: by mail-wg0-f46.google.com with SMTP id l18so347962wgh.17
        for <git@vger.kernel.org>; Sun, 06 Jul 2014 20:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=90vACfIAcvJkunlXgMwVsUz5//3P8kO1xz0LwRNf4Uo=;
        b=rhbVjgqABWs+CyaJbWRFGigmyUmpSCbf/G8Yj2lZKhYLtb6/A+ypqv/bIar2DZYbye
         pWE/ABWqaLeqBM9y5+6k7f8YdO8LXzmd8X0bFlXBfJb9Q6fYF8yKCcpBgVVkAksBFscQ
         0XqPZ1q2CIKyK8W3XjGotdv77Foj9t5PDuQUoZNj9YVGSW1WfV+ecikGOoGye6urz33h
         09g95qJEUrJEW0D+ZjuwYAZ/GakBhxB3rCfKbqdOm6VwpHS3SBY7q9vXCdXW83Q375e2
         4oAN8LK94qijrFYoyJrR6bwqoOrxohLEQ80mlSs6uXAfxDHxzE1vASCvLhuMU6wobMbv
         V3lw==
X-Received: by 10.180.149.175 with SMTP id ub15mr34173233wib.53.1404705025980;
        Sun, 06 Jul 2014 20:50:25 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id nf11sm76379222wic.9.2014.07.06.20.50.24
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Jul 2014 20:50:25 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252946>

The --no-ff option instructs git-rebase to always recreate commits as
they are being replayed, even if fast-forwards are possible.

However, if git-rebase is asked to recreate merge commits (via the -p
option), it suddenly ignores the --no-ff option and fast-forwards
both normal and merge commits whenever possible.

git-rebase--interactive, which is responsible for recreating merge
commits during a rebase, maintains a variable fast_forward to decide
whether the current replay should be tried as a fast-forward.
Previously, fast_forward was on by default and would get toggled only
if a parent was rewritten or a squash was in effect. Also turn
fast_forward off if --no-ff is in use, which is signalled by
git-rebase through the variable force_rebase.

If --no-ff is not in use, try to fast-forward HEAD using git-reset as
before. In contrast, if --no-ff is in use, replay normal commits
using git-cherry-pick and merge commits using git-merge. Note that
git-rebase--interactive already provides this machinery for enabling
and disabling fast-forwards, controlled by fast_forward being
assigned either t (for boolean true) or f (for boolean false).

As mentioned above, git-rebase--interactive needs to detect when a
squash is in effect. If several commits are squashed into one, each
of them is picked using the git-cherry-pick option -n and they get
all rewritten to the same commit, the squash commit. Previously,
fast_forward was assigned f if and only if -n was specified. This no
longer holds for fast_forward might be turned off due to a use of
--no-ff. To correctly notice squashes, explicitly check for -n.

Add test.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
Hi,

The code checking force_rebase is copied from pick_one, although
using a ternary operator to initialise fast_forward might be more
readable. Moreover, the code snippet used to detect squash mode is
copied from the f arm of the fast_forward case switch, although the
code base prefers to spell out test(1).

The test recreates a topic branch that merged a second topic branch.
Therefore, the test case tests the recreation of both normal and
merge commits.

Commit b499549 first introduced the --no-ff option to git-rebase and
since then force_rebase seems to respected only by pick_one but not
by its sibling pick_one_preserving_merges. I couldn't find a reason
why. Was pick_one_preserving_merges merely overlooked?

Is it a usability issue that conflicting merges will have to be
resolved again when being replayed now? The same applies to -p and
the replay of merges with rewritten parents. Should the possibly
required resolution be mentioned alongside git-rerere in the
git-rebase manual page?

   Fabian

 git-rebase--interactive.sh        |  3 ++-
 t/t3409-rebase-preserve-merges.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f267d8b..264a768 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -266,10 +266,11 @@ pick_one_preserving_merges () {
 		;;
 	esac
 	sha1=$(git rev-parse $sha1)
+	case "$force_rebase" in '') ;; ?*) fast_forward=f ;; esac
 
 	if test -f "$state_dir"/current-commit
 	then
-		if test "$fast_forward" = t
+		if [ "$1" != "-n" ]
 		then
 			while read current_commit
 			do
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 8c251c5..838937b 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -81,6 +81,18 @@ test_expect_success 'setup for merge-preserving rebase' \
 	git commit -a -m "Modify B2"
 '
 
+test_expect_success '--no-ff records new commits' '
+	(
+	cd clone3 &&
+	test_when_finished 'cd clone3 && git checkout topic' &&
+	git checkout -b recreated-topic &&
+	# recreate topic with merged topic2 (branching-off point A1)
+	git rebase -p --no-ff HEAD~2 &&
+	test $(git rev-parse new-topic^) != $(git rev-parse topic^) &&
+	test $(git rev-parse new-topic) != $(git rev-parse topic)
+	)
+'
+
 test_expect_success '--continue works after a conflict' '
 	(
 	cd clone2 &&
-- 
2.0.0
