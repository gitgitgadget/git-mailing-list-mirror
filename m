Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC00C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 16:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E0F661CC6
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 16:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhGGQ0w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 12:26:52 -0400
Received: from 84-20.comp.nus.edu.sg ([137.132.84.20]:53486 "EHLO
        mailgw1.comp.nus.edu.sg" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229999AbhGGQ0v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 12:26:51 -0400
Received: from localhost (avs2.comp.nus.edu.sg [192.168.49.6])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP id BCA5F29FEF5;
        Thu,  8 Jul 2021 00:24:09 +0800 (+08)
X-Virus-Scanned: amavisd-new at comp.nus.edu.sg
Received: from mailgw1.comp.nus.edu.sg ([192.168.49.5])
        by localhost (avs.comp.nus.edu.sg [192.168.49.6]) (amavisd-new, port 10024)
        with ESMTP id sxGLE58mTNxL; Thu,  8 Jul 2021 00:24:03 +0800 (+08)
Received: from mailauth0.comp.nus.edu.sg (mailauth0.comp.nus.edu.sg [192.168.49.2])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP;
        Thu,  8 Jul 2021 00:24:03 +0800 (+08)
Received: from hujialun-ThinkPad-X240.nus.edu.sg (unknown [172.21.128.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hujialun)
        by mailauth0.comp.nus.edu.sg (Postfix) with ESMTPSA id C0781200F0464;
        Thu,  8 Jul 2021 00:24:02 +0800 (+08)
From:   Hu Jialun <hujialun@comp.nus.edu.sg>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Hu Jialun <hujialun@comp.nus.edu.sg>
Subject: [PATCH v2 2/2] commit: remove irrelavent prompt on `--allow-empty-message`
Date:   Thu,  8 Jul 2021 00:23:08 +0800
Message-Id: <20210707162308.2438170-3-hujialun@comp.nus.edu.sg>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210707162308.2438170-1-hujialun@comp.nus.edu.sg>
References: <20210706022438.580374-1-hujialun@comp.nus.edu.sg>
 <20210707162308.2438170-1-hujialun@comp.nus.edu.sg>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even when the `--allow-empty-message` option is given, "git
commit" offers an interactive editor session with prefilled
message that says the commit will be aborted if the buffer is
emptied, which is wrong.

Remove the "an empty message aborts" part from the message when
the option is given to fix it.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Hu Jialun <hujialun@comp.nus.edu.sg>
---
The tests are also amended in line with the new string.

 builtin/commit.c                          | 8 ++++++--
 t/t7500-commit-template-squash-signoff.sh | 4 ++--
 t/t7502-commit-porcelain.sh               | 4 ++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 815b408002..b681dcc83c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -918,7 +918,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (cleanup_mode == COMMIT_MSG_CLEANUP_ALL) {
 			status_printf_ln(s, GIT_COLOR_NORMAL, msg_enter_prompt);
 			status_printf_ln(s, GIT_COLOR_NORMAL, ignore_char_prompt, comment_line_char);
-			status_printf_ln(s, GIT_COLOR_NORMAL, empty_msg_abort_prompt);
+			if (!allow_empty_message) {
+				status_printf_ln(s, GIT_COLOR_NORMAL, empty_msg_abort_prompt);
+			}
 		}
 		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
 			if (whence == FROM_COMMIT && !merge_contains_scissors)
@@ -926,7 +928,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		} else { /* COMMIT_MSG_CLEANUP_SPACE, that is. */
 			status_printf_ln(s, GIT_COLOR_NORMAL, msg_enter_prompt);
 			status_printf_ln(s, GIT_COLOR_NORMAL, keep_char_prompt, comment_line_char);
-			status_printf_ln(s, GIT_COLOR_NORMAL, empty_msg_abort_prompt);
+			if (!allow_empty_message) {
+				status_printf_ln(s, GIT_COLOR_NORMAL, empty_msg_abort_prompt);
+			}
 		}
 
 		/*
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 7d02f79c0d..812ca45043 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -497,8 +497,8 @@ test_expect_success 'invalid message options when using --fixup' '
 
 cat >expected-template <<EOF
 
-# Please enter the commit message for your changes. Lines starting
-# with '#' will be ignored, and an empty message aborts the commit.
+# Please enter the commit message for your changes.
+# Lines starting with '#' will be ignored.
 #
 # Author:    A U Thor <author@example.com>
 #
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 38a532d81c..a5217872ca 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -608,8 +608,8 @@ test_expect_success 'cleanup commit messages (strip option,-F,-e)' '
 
 echo "sample
 
-# Please enter the commit message for your changes. Lines starting
-# with '#' will be ignored, and an empty message aborts the commit." >expect
+# Please enter the commit message for your changes.
+# Lines starting with '#' will be ignored." >expect
 
 test_expect_success 'cleanup commit messages (strip option,-F,-e): output' '
 	test_cmp expect actual
-- 
2.32.0

