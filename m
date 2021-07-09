Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CBFC07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 18:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B974613D6
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 18:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhGISK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 14:10:57 -0400
Received: from 84-20.comp.nus.edu.sg ([137.132.84.20]:44252 "EHLO
        mailgw1.comp.nus.edu.sg" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229735AbhGISKy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 14:10:54 -0400
Received: from localhost (avs2.comp.nus.edu.sg [192.168.49.6])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP id 453C1285904;
        Sat, 10 Jul 2021 02:08:09 +0800 (+08)
X-Virus-Scanned: amavisd-new at comp.nus.edu.sg
Received: from mailgw1.comp.nus.edu.sg ([192.168.49.5])
        by localhost (avs.comp.nus.edu.sg [192.168.49.6]) (amavisd-new, port 10024)
        with ESMTP id z6IynyyrLfpf; Sat, 10 Jul 2021 02:07:52 +0800 (+08)
Received: from mailauth0.comp.nus.edu.sg (mailauth0.comp.nus.edu.sg [192.168.49.2])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP;
        Sat, 10 Jul 2021 02:07:52 +0800 (+08)
Received: from hujialun-ThinkPad-X240.nus.edu.sg (unknown [172.21.128.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hujialun)
        by mailauth0.comp.nus.edu.sg (Postfix) with ESMTPSA id 62754201AAFEB;
        Sat, 10 Jul 2021 02:07:51 +0800 (+08)
From:   Hu Jialun <hujialun@comp.nus.edu.sg>
To:     git@vger.kernel.org
Cc:     Hu Jialun <hujialun@comp.nus.edu.sg>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 2/2] commit: remove irrelavent prompt on `--allow-empty-message`
Date:   Sat, 10 Jul 2021 02:07:32 +0800
Message-Id: <20210709180732.2678818-2-hujialun@comp.nus.edu.sg>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210707162308.2438170-1-hujialun@comp.nus.edu.sg>
References: <20210707162308.2438170-1-hujialun@comp.nus.edu.sg>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even when the `--allow-empty-message` option is given, "git commit"
offers an interactive editor session with prefilled message that says
the commit will be aborted if the buffer is emptied, which is wrong.

Remove the "an empty message aborts" part from the message when the
option is given to fix it.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
Helped-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Hu Jialun <hujialun@comp.nus.edu.sg>
---
 builtin/commit.c                          | 25 +++++++++++++++--------
 t/t7500-commit-template-squash-signoff.sh |  2 +-
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e68d139dee..cfbc83751a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -889,15 +889,22 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		int ident_shown = 0;
 		int saved_color_setting;
 		struct ident_split ci, ai;
-		const char *hint_cleanup_all = _("Please enter the commit message for your changes."
-						 " Lines starting\nwith '%c' will be ignored,"
-						 " and an empty message aborts the commit.\n");
-		const char *hint_cleanup_space = _("Please enter the commit message for your changes."
-						   " Lines starting\n"
-						   "with '%c' will be kept; you may remove them"
-						   " yourself if you want to.\n"
-						   "An empty message aborts the commit.\n");
-
+		const char *hint_cleanup_all = allow_empty_message ?
+			_("Please enter the commit message for your changes."
+			  " Lines starting\nwith '%c' will be ignored.\n") :
+			_("Please enter the commit message for your changes."
+			  " Lines starting\nwith '%c' will be ignored, and an empty"
+			  " message aborts the commit.\n");
+		const char *hint_cleanup_space = allow_empty_message ?
+			_("Please enter the commit message for your changes."
+			  " Lines starting\n"
+			  "with '%c' will be kept; you may remove them"
+			  " yourself if you want to.\n") :
+			_("Please enter the commit message for your changes."
+			  " Lines starting\n"
+			  "with '%c' will be kept; you may remove them"
+			  " yourself if you want to.\n"
+			  "An empty message aborts the commit.\n");
 		if (whence != FROM_COMMIT) {
 			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
 				!merge_contains_scissors)
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 7d02f79c0d..54c2082acb 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -498,7 +498,7 @@ test_expect_success 'invalid message options when using --fixup' '
 cat >expected-template <<EOF
 
 # Please enter the commit message for your changes. Lines starting
-# with '#' will be ignored, and an empty message aborts the commit.
+# with '#' will be ignored.
 #
 # Author:    A U Thor <author@example.com>
 #
-- 
2.32.0

