Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85600C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE706192E
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhC2VTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 17:19:52 -0400
Received: from ikke.info ([178.21.113.177]:45100 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230161AbhC2VTs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 17:19:48 -0400
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Mar 2021 17:19:48 EDT
Received: by vps892.directvps.nl (Postfix, from userid 182)
        id 088D044014A; Mon, 29 Mar 2021 23:09:56 +0200 (CEST)
Received: from localhost.localdomain (epsilon [10.8.0.2])
        by vps892.directvps.nl (Postfix) with ESMTP id 95C77440139;
        Mon, 29 Mar 2021 23:09:55 +0200 (CEST)
From:   Kevin Daudt <me@ikke.info>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Kevin Daudt <me@ikke.info>
Subject: [PATCH] maintenance: specify explicit stdin for crontab
Date:   Mon, 29 Mar 2021 23:09:28 +0200
Message-Id: <20210329210928.561586-1-me@ikke.info>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are multiple crontab implementations that require stdin for
editing a crontab to be explicitly specified as '-'.

BusyBox crontab just shows usage when executed without arguments.
[man 1 crontab][0] from openbsd states:

> The pseudo-filename '-' must be specified to read from standard
> input.

Other implementations might not require it, but accept '-', so
explicitly specify that crontab should read from stdin by passing the
'-' pseudo-filename.

[0]: https://www.unix.com/man-page/freebsd/1/crontab/

Signed-off-by: Kevin Daudt <me@ikke.info>
---
The `git maintenance start` command is currently broken on the default
alpine setup. This would fix it. I've tested `echo '* * * * * echo test'
| crontab -` on the different platforms I have access to, and it worked
without issues..
 builtin/gc.c            | 1 +
 t/helper/test-crontab.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index ef7226d7b..dfdb5bce9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1904,6 +1904,7 @@ static int crontab_update_schedule(int run_maintenance, int fd, const char *cmd)
 	rewind(cron_list);
 
 	strvec_split(&crontab_edit.args, cmd);
+	strvec_push(&crontab_edit.args, "-");
 	crontab_edit.in = -1;
 	crontab_edit.git_cmd = 0;
 
diff --git a/t/helper/test-crontab.c b/t/helper/test-crontab.c
index e7c0137a4..525cb318a 100644
--- a/t/helper/test-crontab.c
+++ b/t/helper/test-crontab.c
@@ -17,7 +17,7 @@ int cmd__crontab(int argc, const char **argv)
 		if (!from)
 			return 0;
 		to = stdout;
-	} else if (argc == 2) {
+	} else if ((argc == 3 && !strcmp(argv[2], "-")) || argc == 2) {
 		from = stdin;
 		to = fopen(argv[1], "w");
 	} else
-- 
2.30.1

