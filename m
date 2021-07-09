Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172D4C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 18:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE1C7613D6
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 18:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhGISKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 14:10:51 -0400
Received: from 84-20.comp.nus.edu.sg ([137.132.84.20]:44230 "EHLO
        mailgw1.comp.nus.edu.sg" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229459AbhGISKu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 14:10:50 -0400
Received: from localhost (avs2.comp.nus.edu.sg [192.168.49.6])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP id 88037256E39;
        Sat, 10 Jul 2021 02:08:02 +0800 (+08)
X-Virus-Scanned: amavisd-new at comp.nus.edu.sg
Received: from mailgw1.comp.nus.edu.sg ([192.168.49.5])
        by localhost (avs.comp.nus.edu.sg [192.168.49.6]) (amavisd-new, port 10024)
        with ESMTP id 8Rt_IEi05_O6; Sat, 10 Jul 2021 02:07:51 +0800 (+08)
Received: from mailauth0.comp.nus.edu.sg (mailauth0.comp.nus.edu.sg [192.168.49.2])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP;
        Sat, 10 Jul 2021 02:07:51 +0800 (+08)
Received: from hujialun-ThinkPad-X240.nus.edu.sg (unknown [172.21.128.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hujialun)
        by mailauth0.comp.nus.edu.sg (Postfix) with ESMTPSA id 5C29F200EFC3E;
        Sat, 10 Jul 2021 02:07:50 +0800 (+08)
From:   Hu Jialun <hujialun@comp.nus.edu.sg>
To:     git@vger.kernel.org
Cc:     Hu Jialun <hujialun@comp.nus.edu.sg>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/2] commit: reorganise commit hint strings
Date:   Sat, 10 Jul 2021 02:07:31 +0800
Message-Id: <20210709180732.2678818-1-hujialun@comp.nus.edu.sg>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210707162308.2438170-1-hujialun@comp.nus.edu.sg>
References: <20210707162308.2438170-1-hujialun@comp.nus.edu.sg>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Strings of hint messages inserted into editor on interactive commit was
scattered in-line, rendering the code harder to understand at first
glance.

Extract those messages out into separate variables to make the code
outline easier to follow.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
Signed-off-by: Hu Jialun <hujialun@comp.nus.edu.sg>
---
 builtin/commit.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 190d215d43..e68d139dee 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -889,6 +889,14 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		int ident_shown = 0;
 		int saved_color_setting;
 		struct ident_split ci, ai;
+		const char *hint_cleanup_all = _("Please enter the commit message for your changes."
+						 " Lines starting\nwith '%c' will be ignored,"
+						 " and an empty message aborts the commit.\n");
+		const char *hint_cleanup_space = _("Please enter the commit message for your changes."
+						   " Lines starting\n"
+						   "with '%c' will be kept; you may remove them"
+						   " yourself if you want to.\n"
+						   "An empty message aborts the commit.\n");
 
 		if (whence != FROM_COMMIT) {
 			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
@@ -911,20 +919,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 		fprintf(s->fp, "\n");
 		if (cleanup_mode == COMMIT_MSG_CLEANUP_ALL)
-			status_printf(s, GIT_COLOR_NORMAL,
-				_("Please enter the commit message for your changes."
-				  " Lines starting\nwith '%c' will be ignored, and an empty"
-				  " message aborts the commit.\n"), comment_line_char);
+			status_printf(s, GIT_COLOR_NORMAL, hint_cleanup_all, comment_line_char);
 		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
 			if (whence == FROM_COMMIT && !merge_contains_scissors)
 				wt_status_add_cut_line(s->fp);
 		} else /* COMMIT_MSG_CLEANUP_SPACE, that is. */
-			status_printf(s, GIT_COLOR_NORMAL,
-				_("Please enter the commit message for your changes."
-				  " Lines starting\n"
-				  "with '%c' will be kept; you may remove them"
-				  " yourself if you want to.\n"
-				  "An empty message aborts the commit.\n"), comment_line_char);
+			status_printf(s, GIT_COLOR_NORMAL, hint_cleanup_space, comment_line_char);
 
 		/*
 		 * These should never fail because they come from our own
-- 
2.32.0

