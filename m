From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 02/23] rebase -i: allow squashing empty commits without complaints
Date: Thu,  7 Aug 2014 01:59:09 +0200
Message-ID: <16751a4402233b6c2925bf00d7ecebdccedd0eef.1407368621.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Phil Hord <phil.hord@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 02:00:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB89-0003Og-21
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182AbaHGAAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:00:24 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:55725 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbaHGAAX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:00:23 -0400
Received: by mail-qg0-f48.google.com with SMTP id i50so3588315qgf.35
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VBCoF6ub9krro5lHea4ncf3ZDowTYljKD0yn6BsFc00=;
        b=FsJd3TZ1bCKa9t3vW5Wpomgewr5W4CdV1s+DSH2xcgCIbOSlCf8YHeKkrkA0sqPE3g
         3Q66BWmuVWOYL+oEqh9oVX8rdrZ6oNq82zHVL9PyRangRD1J5uERVwC5G7CukA2DznLv
         730ayEEXNiWaeFvFch3E98ThWftLKlECUbFTLbZbrN6yAhNBksuaK75TSviucZEPeXus
         JDdZ9Sgx9fUoE/T36YlpYp0Ze40A02g8cQnKIf5xoPXCwdZeXQs/wuunzkaoTx++H8cY
         BxD3JlEq5L2GH6ziFptVlEFRBqyUqEuq/pk1EtFr77Ujxhp0hheiZDnCmalgsnxHRlwl
         vPBA==
X-Received: by 10.224.137.65 with SMTP id v1mr21799487qat.53.1407369622271;
        Wed, 06 Aug 2014 17:00:22 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.17.00.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 17:00:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1407368621.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254919>

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

   Once you are down, run

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
Hi,

Peter Krefting is cc'd as the author of the bug report "Confusing
error message in rebase when commit becomes empty" discussed on the
mailing list in June. Phil Hord and Jeff King both participated in
the problem discussion which ended with two proposals by Jeff.

Jeff King writes:
>   1. Always keep such empty commits. A user who is surprised by them
>      being empty can then revisit them. Or drop them by doing another
>      rebase without --keep-empty.
> 
>   2. Notice ourselves that the end-result of the whole squash is an
>      empty commit, and stop to let the user deal with it.

This patch chooses the second alternative. Either way seems OK. The
crucial consensus of the discussion was to silently throw away empty
interim commits.

   Fabian

 git-rebase--interactive.sh    | 20 +++++++++++---
 t/t3404-rebase-interactive.sh | 62 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3222bf6..8820eac 100644
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
+				warn "Once you are down, run"
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
