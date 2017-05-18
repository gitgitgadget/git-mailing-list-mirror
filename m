Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15D1F2023D
	for <e@80x24.org>; Thu, 18 May 2017 10:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754804AbdERKDV (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 06:03:21 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:19718 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754508AbdERKDU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 06:03:20 -0400
Received: from lindisfarne.localdomain ([92.22.40.87])
        by smtp.talktalk.net with SMTP
        id BIGsdcxC6xR4bBIH9dCNJb; Thu, 18 May 2017 11:03:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1495101800; bh=9fptKuy21C2PSXWoJ9n1g3z8XM5612TKGNKx5+sKrrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=PzpteSD+nhHoKIShivbTa7N+YbcYuRqDLrnp5Y7m80LJSLaugwrFgS8rrVorxhZ17
         XKUpjlHGL5Ik0I1zsCu5+Yer2JG512tmBrTKuflr79CaCBUybkAdInsmWkvEm67ICk
         ryDYztvDTUjqWW5+wCxxhLE5gGagDzVp00jmG+XY=
X-Originating-IP: [92.22.40.87]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=Uk7VDCfhaeB8IHNEy8al/Q==:117
 a=Uk7VDCfhaeB8IHNEy8al/Q==:17 a=evINK-nbAAAA:8 a=9hQPv-o3MsGTVpBYq9MA:9
 a=Lh6OlDesjlCDYSKB:21 a=GaCYswMSJ7FcS7pY:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/2] rebase -i: silence stash apply
Date:   Thu, 18 May 2017 11:02:33 +0100
Message-Id: <20170518100233.30559-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170518100233.30559-1-phillip.wood@talktalk.net>
References: <20170518100233.30559-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfLWZBNSKwX8KezpK5LdOPtPT6FBN58xBLWV3Y692EXqwVclrsuP9dD9cHnUUheXZeeqbr82fuwHNYI4yZ17D7nP+enmaW+iZnCuOHX1OK0uqo9H39+lf
 sS0Qg2hEWP2rfxIPAh+0JzrTC7I499YSo9CQ3j4cjsEw9684v4Uvd1IZobbkiKHdRq9IOukY+tJmR8R6APbGvps58nB+6/lOjWfmme2th89CqdG5SdMq9PZA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The shell version of rebase -i silences the status output from 'git
stash apply' when restoring the autostashed changes. The C version
does not.

Having the output from git stash apply on the screen is
distracting as it makes it difficult to find the message from git
rebase saying that the rebase succeeded. Also the status information
that git stash prints talks about looking in .git/rebase-merge/done to
see which commits have been applied. As .git/rebase-merge is removed
shortly after the message is printed before rebase -i exits this is
confusing.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index f8bc18badf1a3fb1b39656501c5a316e229968d2..311728a145dfc66e230334221a2610468239932d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1914,6 +1914,8 @@ static int apply_autostash(struct replay_opts *opts)
 	strbuf_trim(&stash_sha1);
 
 	child.git_cmd = 1;
+	child.no_stdout = 1;
+	child.no_stderr = 1;
 	argv_array_push(&child.args, "stash");
 	argv_array_push(&child.args, "apply");
 	argv_array_push(&child.args, stash_sha1.buf);
-- 
2.13.0

