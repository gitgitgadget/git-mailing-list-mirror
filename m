Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B7BC433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 20:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346406AbiD1VB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 17:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241199AbiD1VB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 17:01:28 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AFAC0E5C
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 13:58:13 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f7d4addafdso57171997b3.6
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 13:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to;
        bh=QGfgdH4S5iq3/YIdH1DBzDxATO3ewl9tdS/V5zMZ4P0=;
        b=sk8E9mKmjW5GljjZu8BqLU+1rwXE1ptIeB0wTYw+qZfTxZCsxtM/0w0Mrr8SewOA2K
         N4HssvApUhGzTZlpdbdcbyGcC6+whsZBXFAY1dqEKfS3FFMn71i3N71Y2KStZFkcN/Lz
         ivTQz54waQFJdDHC/BtMqK1GXO46MZE+0D5m7olqH1c5LRptexr7SsO0yFUAjVi0PBtW
         vYwpP07cddhpjfMtwBG9mvRYkN3t0dui7rCYPEY1sHXep2rBZB13ffbMWvylVGZGOKZs
         l9jb/hp1tTPWKq1uJDYcjjLGadJZTcDYzcfO225cum7XUO+kr3qrfRYSZbaH44yjpGBK
         X64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=QGfgdH4S5iq3/YIdH1DBzDxATO3ewl9tdS/V5zMZ4P0=;
        b=74V6itaVzwXtHQpNnBrbeb/hUoXcernsRuj3JO7iwnkItXogITbyPbzdLRAVkcu3lW
         akRuNEdVAcMTa5jIvOFPeodpYTC6rSyD8dWOrrC5ggXHlt2Hic+rq5X/gt54yDMqbtYH
         Fbd7rDi4Cnl/0bDZw8LiRvOj+X42ORgOzqrCcsXEZG8KYfPrZpHhgp7BgHY+R9AoTguY
         b0bP+iM7FU1K2V3G+BJL4T2ZtUb72u76bFeyO86UbhmlF0D58HFzbT8Jn9n19NQbr9Wx
         +VBqaiwvmjOATxENBi9uYl03FRQLyE3k/pwMt50kzn0spWZzEDidYGx03CzQC7L73XcR
         9PIQ==
X-Gm-Message-State: AOAM533ZmaJYNrw+Spuy1wT5r5wi/i8fNchNnBMj4Ue0TWTST31SNXqI
        nEolawWfZXYg6dR6hFaAjoRcZ+QZ/yQioxnf93Wr4ioNylBLLPttu0xKGTfjmm1LEviZLud/oky
        yQb7k90jo+0fqCN+L4EuHnKtTq1+an+unrJt+Z6RktDY8Gj4k+hcldvnJgMEv3h8=
X-Google-Smtp-Source: ABdhPJxMGSe1TUQGRQqYJEWIx+K4Zvy6Fzo6B9H9ShSZ0BNk69DPEL+FcVPwKHpof7B321jqoDudlmpPld2zOQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:4b3d:36d0:ff5:c1a6])
 (user=steadmon job=sendgmr) by 2002:a05:6902:34f:b0:645:463a:b824 with SMTP
 id e15-20020a056902034f00b00645463ab824mr32370614ybs.39.1651179492185; Thu,
 28 Apr 2022 13:58:12 -0700 (PDT)
Date:   Thu, 28 Apr 2022 13:58:10 -0700
Message-Id: <4616d09ffa632bd2c9e308a713c4bdf2a1328c3c.1651179450.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH] run-command: don't spam trace2_child_exit()
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In rare cases, wait_or_whine() cannot determine a child process's exit
status (and will return -1 in this case). This can cause Git to issue
trace2 child_exit events despite the fact that the child is still
running. In pathological cases, we've seen > 80 million exit events in
our trace logs for a single child process.

Fix this by only issuing trace2 events in finish_command_in_signal() if
we get a value other than -1 from wait_or_whine().

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 run-command.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index a8501e38ce..e0fe2418a2 100644
--- a/run-command.c
+++ b/run-command.c
@@ -983,7 +983,8 @@ int finish_command(struct child_process *cmd)
 int finish_command_in_signal(struct child_process *cmd)
 {
 	int ret = wait_or_whine(cmd->pid, cmd->args.v[0], 1);
-	trace2_child_exit(cmd, ret);
+	if (ret != -1)
+		trace2_child_exit(cmd, ret);
 	return ret;
 }
 

base-commit: faa21c10d44184f616d391c158dcbb13b9c72ef3
-- 
2.36.0.464.gb9c8b46e94-goog

