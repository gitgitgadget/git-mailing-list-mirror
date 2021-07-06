Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D94C07E99
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 02:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AFFA6196A
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 02:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhGFCgw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 22:36:52 -0400
Received: from 84-20.comp.nus.edu.sg ([137.132.84.20]:51258 "EHLO
        mailgw1.comp.nus.edu.sg" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229891AbhGFCgw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 22:36:52 -0400
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Jul 2021 22:36:51 EDT
Received: from localhost (avs3.comp.nus.edu.sg [192.168.49.7])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP id B82382A4CFA
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 10:25:56 +0800 (+08)
X-Virus-Scanned: amavisd-new at comp.nus.edu.sg
Received: from mailgw1.comp.nus.edu.sg ([192.168.49.5])
        by localhost (avs.comp.nus.edu.sg [192.168.49.7]) (amavisd-new, port 10024)
        with ESMTP id 5wZtDDRSERvV; Tue,  6 Jul 2021 10:25:51 +0800 (+08)
Received: from mailauth1.comp.nus.edu.sg (mailauth1.comp.nus.edu.sg [192.168.49.3])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP;
        Tue,  6 Jul 2021 10:25:51 +0800 (+08)
Received: from hujialun-ThinkPad-X240.nus.edu.sg (unknown [172.21.160.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hujialun)
        by mailauth1.comp.nus.edu.sg (Postfix) with ESMTPSA id AC1A960170577;
        Tue,  6 Jul 2021 10:25:50 +0800 (+08)
From:   Hu Jialun <hujialun@comp.nus.edu.sg>
To:     git@vger.kernel.org
Cc:     Hu Jialun <hujialun@comp.nus.edu.sg>
Subject: [PATCH] commit: remove irrelavent prompt on `--allow-empty-message`
Date:   Tue,  6 Jul 2021 10:24:38 +0800
Message-Id: <20210706022438.580374-1-hujialun@comp.nus.edu.sg>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, COMMIT_EDITMSG contains "...and an empty message aborts the
commit", regardless of whether the --allow-empty-message option is
specified or not. This is deemed confusing and unintended.

Signed-off-by: Hu Jialun <hujialun@comp.nus.edu.sg>
---
 builtin/commit.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 190d215d43..61e3382db9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -910,21 +910,36 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		}
 
 		fprintf(s->fp, "\n");
-		if (cleanup_mode == COMMIT_MSG_CLEANUP_ALL)
-			status_printf(s, GIT_COLOR_NORMAL,
-				_("Please enter the commit message for your changes."
-				  " Lines starting\nwith '%c' will be ignored, and an empty"
-				  " message aborts the commit.\n"), comment_line_char);
-		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
+		if (cleanup_mode == COMMIT_MSG_CLEANUP_ALL) {
+			if (allow_empty_message) {
+				status_printf(s, GIT_COLOR_NORMAL,
+					_("Please enter the commit message for your changes."
+					" Lines starting\nwith '%c' will be ignored.\n"), comment_line_char);
+			} else {
+				status_printf(s, GIT_COLOR_NORMAL,
+					_("Please enter the commit message for your changes."
+					" Lines starting\nwith '%c' will be ignored, and an empty"
+					" message aborts the commit.\n"), comment_line_char);
+			}
+		} else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
 			if (whence == FROM_COMMIT && !merge_contains_scissors)
 				wt_status_add_cut_line(s->fp);
-		} else /* COMMIT_MSG_CLEANUP_SPACE, that is. */
-			status_printf(s, GIT_COLOR_NORMAL,
-				_("Please enter the commit message for your changes."
-				  " Lines starting\n"
-				  "with '%c' will be kept; you may remove them"
-				  " yourself if you want to.\n"
-				  "An empty message aborts the commit.\n"), comment_line_char);
+		} else { /* COMMIT_MSG_CLEANUP_SPACE, that is. */
+			if (allow_empty_message) {
+				status_printf(s, GIT_COLOR_NORMAL,
+					_("Please enter the commit message for your changes."
+					" Lines starting\n"
+					"with '%c' will be kept; you may remove them"
+					" yourself if you want to.\n"), comment_line_char);
+			} else {
+				status_printf(s, GIT_COLOR_NORMAL,
+					_("Please enter the commit message for your changes."
+					" Lines starting\n"
+					"with '%c' will be kept; you may remove them"
+					" yourself if you want to.\n"
+					"An empty message aborts the commit.\n"), comment_line_char);
+			}
+		}
 
 		/*
 		 * These should never fail because they come from our own
-- 
2.32.0

