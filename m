Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC671C07E9B
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 16:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C964661CC3
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 16:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhGGQ0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 12:26:50 -0400
Received: from 84-20.comp.nus.edu.sg ([137.132.84.20]:53474 "EHLO
        mailgw1.comp.nus.edu.sg" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229519AbhGGQ0t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 12:26:49 -0400
Received: from localhost (avs3.comp.nus.edu.sg [192.168.49.7])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP id 3770321B76F;
        Thu,  8 Jul 2021 00:24:08 +0800 (+08)
X-Virus-Scanned: amavisd-new at comp.nus.edu.sg
Received: from mailgw1.comp.nus.edu.sg ([192.168.49.5])
        by localhost (avs.comp.nus.edu.sg [192.168.49.7]) (amavisd-new, port 10024)
        with ESMTP id RHI5I8pthCaz; Thu,  8 Jul 2021 00:24:02 +0800 (+08)
Received: from mailauth0.comp.nus.edu.sg (mailauth0.comp.nus.edu.sg [192.168.49.2])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP;
        Thu,  8 Jul 2021 00:24:02 +0800 (+08)
Received: from hujialun-ThinkPad-X240.nus.edu.sg (unknown [172.21.128.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hujialun)
        by mailauth0.comp.nus.edu.sg (Postfix) with ESMTPSA id A0F77200B0BBC;
        Thu,  8 Jul 2021 00:24:01 +0800 (+08)
From:   Hu Jialun <hujialun@comp.nus.edu.sg>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Hu Jialun <hujialun@comp.nus.edu.sg>
Subject: [PATCH v2 1/2] commit: reorganise duplicate commit prompt strings
Date:   Thu,  8 Jul 2021 00:23:07 +0800
Message-Id: <20210707162308.2438170-2-hujialun@comp.nus.edu.sg>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210707162308.2438170-1-hujialun@comp.nus.edu.sg>
References: <20210706022438.580374-1-hujialun@comp.nus.edu.sg>
 <20210707162308.2438170-1-hujialun@comp.nus.edu.sg>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the prefilled commit prompt is mostly the same for different
cleanup modes, those are separately repeated, which violates the DRY
principle and hinders maintainability.

Unify and reorder identical substrings to improve.

Signed-off-by: Hu Jialun <hujialun@comp.nus.edu.sg>
---
 builtin/commit.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 190d215d43..815b408002 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -910,21 +910,24 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		}
 
 		fprintf(s->fp, "\n");
-		if (cleanup_mode == COMMIT_MSG_CLEANUP_ALL)
-			status_printf(s, GIT_COLOR_NORMAL,
-				_("Please enter the commit message for your changes."
-				  " Lines starting\nwith '%c' will be ignored, and an empty"
-				  " message aborts the commit.\n"), comment_line_char);
+		const char *msg_enter_prompt = _("Please enter the commit message for your changes.");
+		const char *keep_char_prompt = _("Lines starting with '%c' will be kept;"
+						 " you may remove them yourself if you want to.");
+		const char *ignore_char_prompt = _("Lines starting with '%c' will be ignored.");
+		const char *empty_msg_abort_prompt = _("An empty message aborts the commit.");
+		if (cleanup_mode == COMMIT_MSG_CLEANUP_ALL) {
+			status_printf_ln(s, GIT_COLOR_NORMAL, msg_enter_prompt);
+			status_printf_ln(s, GIT_COLOR_NORMAL, ignore_char_prompt, comment_line_char);
+			status_printf_ln(s, GIT_COLOR_NORMAL, empty_msg_abort_prompt);
+		}
 		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
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
+			status_printf_ln(s, GIT_COLOR_NORMAL, msg_enter_prompt);
+			status_printf_ln(s, GIT_COLOR_NORMAL, keep_char_prompt, comment_line_char);
+			status_printf_ln(s, GIT_COLOR_NORMAL, empty_msg_abort_prompt);
+		}
 
 		/*
 		 * These should never fail because they come from our own
-- 
2.32.0

