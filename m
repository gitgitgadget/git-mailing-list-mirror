Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9EA51F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 16:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbfKPQTE (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Nov 2019 11:19:04 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:58661 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731082AbfKPQTA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Nov 2019 11:19:00 -0500
X-Originating-IP: 1.186.12.29
Received: from localhost.localdomain (unknown [1.186.12.29])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 418752000D
        for <git@vger.kernel.org>; Sat, 16 Nov 2019 16:18:58 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Subject: [RFC PATCH] wt-status: show amended content when verbose
Date:   Sat, 16 Nov 2019 21:48:56 +0530
Message-Id: <20191116161856.28883-1-me@yadavpratyush.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am working on a simple little feature which shows the "amended
content" when running 'git-commit -v'. Currently, only the changes in
the _entire_ commit are shown. In a large commit, it is difficult to
spot a line or two that were amended. So, show just the amended content
in a different section.

I'm having trouble working with the internal diff API. 'rev' in the
function here is used to diff against HEAD^1. I want to do the exact
same thing, but against HEAD instead.

The diff below works, but it is obviously an ugly hack that just resets
'rev' and duplicates all the initialization code. I added it here as a
"proof of concept". What would be the cleaner way to do it?

I tried a bunch of things, but they either end up in me hitting

  BUG("run_diff_index must be passed exactly one tree");

in 'run_diff_index', or just doing something completely
unexpected/useless.

Some help/pointers would be appreciated. Thanks.

Regards,
Pratyush Yadav

-- 8< --

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
 wt-status.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/wt-status.c b/wt-status.c
index cc6f94504d..efa01c7ed6 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1086,6 +1086,27 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 		rev.diffopt.b_prefix = "w/";
 		run_diff_files(&rev, 0);
 	}
+
+	if (s->amend) {
+		repo_init_revisions(s->repo, &rev, NULL);
+		rev.diffopt.flags.allow_textconv = 1;
+		rev.diffopt.ita_invisible_in_index = 1;
+
+		memset(&opt, 0, sizeof(opt));
+		opt.def = "HEAD";
+		setup_revisions(0, NULL, &rev, &opt);
+
+		rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
+		rev.diffopt.detect_rename = s->detect_rename >= 0 ? s->detect_rename : rev.diffopt.detect_rename;
+		rev.diffopt.rename_limit = s->rename_limit >= 0 ? s->rename_limit : rev.diffopt.rename_limit;
+		rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
+		rev.diffopt.file = s->fp;
+		rev.diffopt.close_file = 0;
+		rev.diffopt.use_color = 0;
+		status_printf_ln(s, c, "Changes to amend:\n");
+
+		run_diff_index(&rev, 1);
+	}
 }

 static void wt_longstatus_print_tracking(struct wt_status *s)
--
2.24.0

