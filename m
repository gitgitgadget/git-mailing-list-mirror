Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13D091F403
	for <e@80x24.org>; Tue, 19 Jun 2018 12:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937775AbeFSMrD (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 08:47:03 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:59604 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937705AbeFSMrB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 08:47:01 -0400
Received: from lindisfarne.localdomain ([92.22.19.223])
        by smtp.talktalk.net with SMTP
        id VG2AfUTfmVlGZVG2EfSZgx; Tue, 19 Jun 2018 13:47:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1529412420;
        bh=po0dp6dQ/7OlzUJq2F6rX7O9Tt3TChYqFcXkKc52dz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=jVTAUAJ6B9A2/JyfopzPRFTqSZdUjoJrRfhAI787ZqRIZnBaD97w+gx7cyCDUwIZG
         Gz+qLCwFP6ojIS+g09Lkv9BOdzfzSne6FjsMr+37nmj9onAbpij5xY67sn9+7ciQw6
         gzmgDWPO0RxOuwY9gaiLN5IplK7rd41EtH8fa5VM=
X-Originating-IP: [92.22.19.223]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=DH/r9e32v+C519lOzZJhbw==:117
 a=DH/r9e32v+C519lOzZJhbw==:17 a=evINK-nbAAAA:8 a=pGLkceISAAAA:8
 a=idefq0dSvNAaO8DsU0oA:9 a=jHe0uHPcI2vL9-yg:21 a=TdtHO6zES2FYHRsr:21
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, ch <cr@onlinehome.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3] sequencer: do not squash 'reword' commits when we hit conflicts
Date:   Tue, 19 Jun 2018 13:46:51 +0100
Message-Id: <20180619124651.17425-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <nycvar.QRO.7.76.6.1806182326420.77@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1806182326420.77@tvgsbejvaqbjf.bet>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfBzGF4eKlvJYm+YMJbzqLcRWeQizC5zp9iaoJ+lxKzb8jBuv8mw+GADyl35+YCmqEADwDRqAbvHTnBzeRXb1r+14JHC0a06dPLv4eNlOYnK3yeLnKx9D
 7CyjGZ2Dyo9KHvOnL2O583U2lhOPsnx1Ex8n9tTwm8Yeq4iMcRUTazHgk5HjFf1u35cWnTL0/jDI9uk2bEvv51p8oQtMj0lpQqRiS8a1YU3YIwdSn+6maCGi
 0PL1L6ltYIC+WIVb8KsoVyZoQzAno4XYkfeVdCD3FMywiXyh7j6D+N4hJyPVdh3qANvctzYjE/UE+4aSesA3guPlcDOwl5hUpvITaKbzYhn1iy0HN/pDXcXX
 +Gjcwahv1uAszGvS1kdrlhRvCqMF9A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Ever since commit 18633e1a22 ("rebase -i: use the rebase--helper builtin",
2017-02-09), when a commit marked as 'reword' in an interactive rebase
has conflicts and fails to apply, when the rebase is resumed that commit
will be squashed into its parent with its commit message taken.

The issue can be understood better by looking at commit 56dc3ab04b
("sequencer (rebase -i): implement the 'edit' command", 2017-01-02), which
introduced error_with_patch() for the edit command.  For the edit command,
it needs to stop the rebase whether or not the patch applies cleanly.  If
the patch does apply cleanly, then when it resumes it knows it needs to
amend all changes into the previous commit.  If it does not apply cleanly,
then the changes should not be amended.  Thus, it passes !res (success of
applying the 'edit' commit) to error_with_patch() for the to_amend flag.

The problematic line of code actually came from commit 04efc8b57c
("sequencer (rebase -i): implement the 'reword' command", 2017-01-02).
Note that to get to this point in the code:
  * !!res (i.e. patch application failed)
  * item->command < TODO_SQUASH
  * item->command != TODO_EDIT
  * !is_fixup(item->command) [i.e. not squash or fixup]
So that means this can only be a failed patch application that is either a
pick, revert, or reword.  We only need to amend HEAD when rewording the
root commit or a commit that has been fast-forwarded, for any of the other
cases we want a new commit, so we should not set the to_amend flag.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Original-patch-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

I wasn't really sure what to do about the authorship.  This is
Elijah's patch, with the message tweaked, fixed up with a corrected
version of Johannes' code and a couple of new tests by my for picking
and rewording the root commit when it has untracked file confilcts.

 sequencer.c                   | 23 ++++++++++++++---
 t/t3404-rebase-interactive.sh | 28 ++++++++++++++++++++
 t/t3423-rebase-reword.sh      | 48 +++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 3 deletions(-)
 create mode 100755 t/t3423-rebase-reword.sh

diff --git a/sequencer.c b/sequencer.c
index 4034c0461b..7bf2b62727 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3214,10 +3214,27 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 					intend_to_amend();
 				return error_failed_squash(item->commit, opts,
 					item->arg_len, item->arg);
-			} else if (res && is_rebase_i(opts) && item->commit)
+			} else if (res && is_rebase_i(opts) && item->commit) {
+				int to_amend = 0;
+				struct object_id oid;
+
+				/*
+				 * If we are rewording and have either
+				 * fast-forwarded already, or are about to
+				 * create a new root commit, we want to amend,
+				 * otherwise we do not.
+				 */
+				if (item->command == TODO_REWORD &&
+				    !get_oid("HEAD", &oid) &&
+				    (!oidcmp(&item->commit->object.oid, &oid) ||
+				     (opts->have_squash_onto &&
+				      !oidcmp(&opts->squash_onto, &oid))))
+					to_amend = 1;
+
 				return res | error_with_patch(item->commit,
-					item->arg, item->arg_len, opts, res,
-					item->command == TODO_REWORD);
+						item->arg, item->arg_len, opts,
+						res, to_amend);
+			}
 		} else if (item->command == TODO_EXEC) {
 			char *end_of_arg = (char *)(item->arg + item->arg_len);
 			int saved = *end_of_arg;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index e500d7c320..3786879e80 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -980,7 +980,35 @@ test_expect_success 'rebase -i --root reword root commit' '
 	git show HEAD^ | grep "A changed"
 '
 
+test_expect_success 'rebase -i --root when root has untracked file confilct' '
+	test_when_finished "reset_rebase" &&
+	git checkout -b failing-root-pick A &&
+	echo x >file2 &&
+	git rm file1 &&
+	git commit -m "remove file 1 add file 2" &&
+	echo z >file1 &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="1 2" git rebase -i --root &&
+	rm file1 &&
+	git rebase --continue &&
+	test "$(git log -1 --format=%B)" = "remove file 1 add file 2" &&
+	test "$(git rev-list --count HEAD)" = 2
+'
+
+test_expect_success 'rebase -i --root reword root when root has untracked file conflict' '
+	test_when_finished "reset_rebase" &&
+	echo z>file1 &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="reword 1 2" \
+		FAKE_COMMIT_MESSAGE="Modified A" git rebase -i --root &&
+	rm file1 &&
+	FAKE_COMMIT_MESSAGE="Reworded A" git rebase --continue &&
+	test "$(git log -1 --format=%B HEAD^)" = "Reworded A" &&
+	test "$(git rev-list --count HEAD)" = 2
+'
+
 test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on non-interactive rebase' '
+	git checkout reword-root-branch &&
 	git reset --hard &&
 	git checkout conflict-branch &&
 	set_fake_editor &&
diff --git a/t/t3423-rebase-reword.sh b/t/t3423-rebase-reword.sh
new file mode 100755
index 0000000000..6963750794
--- /dev/null
+++ b/t/t3423-rebase-reword.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+test_description='git rebase interactive with rewording'
+
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+test_expect_success 'setup' '
+	test_commit master file-1 test &&
+
+	git checkout -b stuff &&
+
+	test_commit feature_a file-2 aaa &&
+	test_commit feature_b file-2 ddd
+'
+
+test_expect_success 'reword without issues functions as intended' '
+	test_when_finished "reset_rebase" &&
+
+	git checkout stuff^0 &&
+
+	set_fake_editor &&
+	FAKE_LINES="pick 1 reword 2" FAKE_COMMIT_MESSAGE="feature_b_reworded" \
+		git rebase -i -v master &&
+
+	test "$(git log -1 --format=%B)" = "feature_b_reworded" &&
+	test $(git rev-list --count HEAD) = 3
+'
+
+test_expect_success 'reword after a conflict preserves commit' '
+	test_when_finished "reset_rebase" &&
+
+	git checkout stuff^0 &&
+
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="reword 2" \
+		git rebase -i -v master &&
+
+	git checkout --theirs file-2 &&
+	git add file-2 &&
+	FAKE_COMMIT_MESSAGE="feature_b_reworded" git rebase --continue &&
+
+	test "$(git log -1 --format=%B)" = "feature_b_reworded" &&
+	test $(git rev-list --count HEAD) = 2
+'
+
+test_done
-- 
2.17.1

