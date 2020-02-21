Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EECC35640
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 06:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D507724680
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 06:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="fujq8ibT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgBUGL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 01:11:57 -0500
Received: from 28dayslater.mr.itd.umich.edu ([141.211.125.104]:59240 "EHLO
        28dayslater.mr.itd.umich.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726045AbgBUGL4 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 21 Feb 2020 01:11:56 -0500
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Feb 2020 01:11:56 EST
Received: FROM maleficent.mr.itd.umich.edu (smtp.mail.umich.edu [141.211.125.12])
        By 28dayslater.mr.itd.umich.edu ID 5E4F737D.28EAA.20770;
        Fri, 21 Feb 2020 01:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
        s=relay-2016-05-12; t=1582265210;
        bh=/N/btRe+dG8MRZwStAHczRvoUQvg0scFOicCoSoMkoY=;
        h=From:To:Cc:Subject:Date;
        b=fujq8ibTWuoblVM9rLKvG6RCH1W/5smQm9UUGB0YG/QO2Lg3HU4q7kyxtgm8cmDmr
         MFUYBLRJSwl97xxLvW/NvBycyR2zPIjGebkwoTLFhUR44SoRDgebHeaECcKUKgi2wy
         Tii+0wc0D1Xknz9x/43a2wVkLFGUxboLBR0OtYcbPqt6pwamST3CStNAN0u+GKcaIa
         ThiZt3sZSzpmvRlL4F3xYt2fugYvcIKTHIxpziXfwXUjjbPom7Kdqm0daD2mPtipx/
         FCJvkCIDFNnqlY9dHLd+s6ISpWdCvO8VU1K3dVWYnVoiDBnfoO4SN+OBZB3Z4WYdtL
         r26x17d/A2etw==
Authentication-Results: maleficent.mr.itd.umich.edu;
        iprev=fail policy.iprev=76.14.26.166 (Mismatch);
        auth=pass smtp.auth=asottile
Received: FROM localhost.localdomain (Mismatch [76.14.26.166])
        By maleficent.mr.itd.umich.edu ID 5E4F737A.6FD68.22178;
        Authuser asottile;
        Fri, 21 Feb 2020 01:06:50 -0500
From:   Anthony Sottile <asottile@umich.edu>
To:     git@vger.kernel.org
Cc:     Anthony Sottile <asottile@umich.edu>
Subject: [PATCH] run-command.c: ensure signaled hook scripts are waited upon
Date:   Thu, 20 Feb 2020 22:06:36 -0800
Message-Id: <20200221060636.4507-1-asottile@umich.edu>
X-Mailer: git-send-email 2.25.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the event of a `^C` while hook scripts are running, ensure that the
hook processes are cleaned up and do not become zombies.  This also ensures
that upon `^C` execution is not handed back to the terminal until the
processes have been waited upon.

Signed-off-by: Anthony Sottile <asottile@umich.edu>
---
 run-command.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/run-command.c b/run-command.c
index f5e1149..75d3b73 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1358,6 +1358,8 @@ int run_hook_ve(const char *const *env, const char *name, va_list args)
 	hook.no_stdin = 1;
 	hook.stdout_to_stderr = 1;
 	hook.trace2_hook_name = name;
+	hook.clean_on_exit = 1;
+	hook.wait_after_clean = 1;
 
 	return run_command(&hook);
 }
-- 
2.25.GIT

