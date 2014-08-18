From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 02/27] rebase -i: allow squashing empty commits without complaints
Date: Mon, 18 Aug 2014 23:22:45 +0200
Message-ID: <c6c1060f8f646b9e2dd0966370dde9ed70361194.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:23:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUPF-0000N5-0n
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbaHRVXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:23:45 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:64534 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbaHRVXp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:23:45 -0400
Received: by mail-lb0-f178.google.com with SMTP id c11so4763202lbj.9
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ax1qtAxxbukzEOvMUUaWS4caFi6EKLIi825utRRVqF0=;
        b=FwYspooncONmWFcLhKJx8sxJI4dbp58j+WRBg2WRN6D2lAP7Mo2hteedHMQP/hj4Be
         5L8a1K0bfDVzF+6yFoIaQ3it/vZ4j5TfWPLCQO8hMsNzqptd0NJzvoXrikipME4Bl4LC
         Ltt9XbpVOSHGiBoN6ByP8UULDzcfezYprpSN/p9HjeLJudXx52OQTzJo+OKtNwlJ2sSd
         ffpM/lpx+l0NT5wDSu2iGcus2OLvBcnkaDPvU/EE0y+oEQbukJnu5dU1NBarMfP/kGKY
         5TLzg8xsA+u9aaYmsv1EzswMYlKRYVZeZxxDRPCgb3Vl829+Va3wY9u8nSmMf3sQymyq
         weGQ==
X-Received: by 10.112.173.136 with SMTP id bk8mr28995115lbc.88.1408397023395;
        Mon, 18 Aug 2014 14:23:43 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.23.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:23:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255412>

The to-do list commands `squash` and `fixup` apply the changes
introduced by the named commit to the tree but instead of creating
a new commit on top of the current head it replaces the previous
commit with a new commit that records the updated tree. If the
result is an empty commit git-rebase stops with the error message

   You asked to amend the most recent commit, but doing so would make
   it empty. You can repeat your command with --allow-empty, or you can
   remove the commit entirely with "git reset HEAD^".

This message is not very helpful because neither does git-rebase
support an option `--allow-empty` nor does the messages say how to
resume the rebase. Firstly, change the error message to

   The squash result is empty and --keep-empty was not specified.

   You can remove the squash commit now with

     git reset HEAD^

   Once you are done, run

     git rebase --continue

If the user wishes to squash a sequence of commits into one
commit, f. i.

   pick A
   squash Revert "A"
   squash A'

, it does not matter for the end result that the first squash
result, or any sub-sequence in general, is going to be empty. The
squash message is not affected at all by which commits are created
and only the commit created by the last line in the sequence will
end up in the final history. Secondly, print the error message
only if the whole squash sequence produced an empty commit.

Lastly, since an empty squash commit is not a failure to rewrite
the history as planned, issue the message above as a mere warning
and interrupt the rebase with the return value zero. The
interruption should be considered as a notification with the
chance to undo it on the spot. Specifying the `--keep-empty`
option tells git-rebase to keep empty squash commits in the
rebased history without notification.

Add tests.

Reported-by: Peter Krefting <peter@softwolves.pp.se>
Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh    | 20 +++++++++++---
 t/t3404-rebase-interactive.sh | 62 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3222bf6..ada340c 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -549,7 +549,7 @@ do_next () {
 		squash|s|fixup|f)
 			# This is an intermediate commit; its message will only be
 			# used in case of trouble.  So use the long version:
-			do_with_author output git commit --allow-empty-message \
+			do_with_author output git commit --allow-empty-message --allow-empty \
 				--amend --no-verify -F "$squash_msg" \
 				${gpg_sign_opt:+"$gpg_sign_opt"} ||
 				die_failed_squash $sha1 "$rest"
@@ -558,18 +558,32 @@ do_next () {
 			# This is the final command of this squash/fixup group
 			if test -f "$fixup_msg"
 			then
-				do_with_author git commit --allow-empty-message \
+				do_with_author git commit --allow-empty-message --allow-empty \
 					--amend --no-verify -F "$fixup_msg" \
 					${gpg_sign_opt:+"$gpg_sign_opt"} ||
 					die_failed_squash $sha1 "$rest"
 			else
 				cp "$squash_msg" "$GIT_DIR"/SQUASH_MSG || exit
 				rm -f "$GIT_DIR"/MERGE_MSG
-				do_with_author git commit --amend --no-verify -F "$GIT_DIR"/SQUASH_MSG -e \
+				do_with_author git commit --allow-empty --amend --no-verify -F "$GIT_DIR"/SQUASH_MSG -e \
 					${gpg_sign_opt:+"$gpg_sign_opt"} ||
 					die_failed_squash $sha1 "$rest"
 			fi
 			rm -f "$squash_msg" "$fixup_msg"
+			if test -z "$keep_empty" && is_empty_commit HEAD
+			then
+				echo "$sha1" >"$state_dir"/stopped-sha
+				warn "The squash result is empty and --keep-empty was not specified."
+				warn
+				warn "You can remove the squash commit now with"
+				warn
+				warn "  git reset HEAD^"
+				warn
+				warn "Once you are done, run"
+				warn
+				warn "  git rebase --continue"
+				exit 0
+			fi
 			;;
 		esac
 		record_in_rewritten $sha1
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 9c71835..a95cb2a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -237,6 +237,68 @@ test_expect_success 'retain authorship' '
 	git show HEAD | grep "^Author: Twerp Snog"
 '
 
+test_expect_success 'setup squash/fixup reverted and fixed feature' '
+	git checkout -b reverted-feature master &&
+	test_commit feature &&
+	git revert feature &&
+	git checkout -b fixed-feature reverted-feature &&
+	test_commit featurev2
+'
+
+test_expect_success 'fixup fixed feature (empty interim commit)' '
+	git checkout -b fixup-fixed-feature fixed-feature &&
+	set_fake_editor &&
+	FAKE_LINES="1 fixup 2 fixup 3" git rebase -i master &&
+	git log --oneline master.. >actual &&
+	test_line_count = 1 actual &&
+	git diff --exit-code featurev2
+'
+
+test_expect_success 'squash fixed feature (empty interim commit)' '
+	git checkout -b squash-fixed-feature fixed-feature &&
+	set_fake_editor &&
+	FAKE_LINES="1 squash 2 squash 3" git rebase -i master &&
+	git log --oneline master.. >actual &&
+	test_line_count = 1 actual &&
+	git diff --exit-code featurev2
+'
+
+test_expect_success 'fixup reverted feature (empty final commit)' '
+	git checkout -b fixup-reverted-feature reverted-feature &&
+	set_fake_editor &&
+	FAKE_LINES="1 fixup 2" git rebase -i master &&
+	git reset HEAD^ &&
+	git rebase --continue &&
+	test_cmp_rev master HEAD
+'
+
+test_expect_success 'squash reverted feature (empty final commit)' '
+	git checkout -b squash-reverted-feature reverted-feature &&
+	set_fake_editor &&
+	FAKE_LINES="1 squash 2" git rebase -i master &&
+	git reset HEAD^ &&
+	git rebase --continue &&
+	test_cmp_rev master HEAD
+'
+
+test_expect_success 'fixup reverted feature (empty final commit with --keep-empty)' '
+	git checkout -b fixup-keep-reverted-feature reverted-feature &&
+	set_fake_editor &&
+	FAKE_LINES="1 fixup 2" git rebase -i --keep-empty master &&
+	git log --oneline master.. >actual &&
+	test_line_count = 1 actual &&
+	git diff --exit-code master
+'
+
+test_expect_success 'squash reverted feature (empty final commit with --keep-empty)' '
+	git checkout -b squash-keep-reverted-feature reverted-feature &&
+	set_fake_editor &&
+	FAKE_LINES="1 squash 2" git rebase -i --keep-empty master &&
+	git log --oneline master.. >actual &&
+	test_line_count = 1 actual &&
+	git diff --exit-code master
+'
+
 test_expect_success 'squash' '
 	git reset --hard twerp &&
 	echo B > file7 &&
-- 
2.0.1
