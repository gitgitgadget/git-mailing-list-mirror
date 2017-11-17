Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E6FA201C8
	for <e@80x24.org>; Fri, 17 Nov 2017 11:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754740AbdKQLg1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 06:36:27 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:33845 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754652AbdKQLgM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 06:36:12 -0500
Received: from lindisfarne.localdomain ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id FevAeP1Zopb8rFewNexNF3; Fri, 17 Nov 2017 11:36:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510918571;
        bh=TI4uM+1BGv6WGUUxMiImyjF4Wcsx492V3Hxvx1V4Mws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=kGZgqeG7YIF7yencMeNgL41JfooGfHhHh/QoMPIWdtPZAC0Mb/ggRVssvD6H5SlIS
         Zj+P/P2tCIZuoGaflzcMFh81MWaexIWahmbbLe8dSPtFbHmzmWDSLaudC2cn0i75iy
         cndmeq8EKkR6J/8K0YJfq+G8j8TcAw6DsY/bS3AA=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZM2noTzb c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=evINK-nbAAAA:8 a=qo_IBofmjA8VuP4PJYkA:9
 a=FTkRqzf3F1kRNC0N:21 a=x326BpXhDvg8PScu:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 6/8] sequencer: simplify adding Signed-off-by: trailer
Date:   Fri, 17 Nov 2017 11:34:50 +0000
Message-Id: <20171117113452.26597-7-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171117113452.26597-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171117113452.26597-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfByzbBKxYN9ArnsgbYfLiUXgXvJii/lAXujLOa3SWWy/NFfMebvhx6msPi9CLFUdZDm+SrfYHJvo+TWKQwq1j/nMeQyfTIwZX1tLf79Qd58RO7gNafLp
 EiOR0IbglDcfUeYUMfIPCTDQlvNKHtkrGem2SDxi/oGSv6aJ19FwBYt93cs3XVMSrvtdMZBiRm3xzq4QVW8ILgOAq7kYzJhRAP1hYe/Zc0ctPyXgO255kp3g
 1oNhbnR8TBnSDHSFqcoMmcoCmndX8WTMFi4Q6AohON1UWIn3XyocBAlrN+WUx4Dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add the Signed-off-by: trailer in one place rather than adding it to
the message when doing a recursive merge and specifying '--signoff'
when running 'git commit'. This means that if there are conflicts when
merging with a strategy other than 'recursive' the Signed-off-by:
trailer will be added if the user commits the resolution themselves
without passing '--signoff' to 'git commit'. It also simplifies the
in-process commit that is about to be added to the sequencer.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a2cf6f5e06ffec5108f0faf43d1a4cb605264c3f..7400df5522037583108534755af6f542117667c2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -477,9 +477,6 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 			_(action_name(opts)));
 	rollback_lock_file(&index_lock);
 
-	if (opts->signoff)
-		append_signoff(msgbuf, 0, 0);
-
 	if (!clean)
 		append_conflicts_hint(msgbuf);
 
@@ -657,8 +654,6 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		argv_array_push(&cmd.args, "--amend");
 	if (opts->gpg_sign)
 		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
-	if (opts->signoff)
-		argv_array_push(&cmd.args, "-s");
 	if (defmsg)
 		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
 	if ((flags & CLEANUP_MSG))
@@ -1347,6 +1342,9 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		}
 	}
 
+	if (opts->signoff)
+		append_signoff(&msgbuf, 0, 0);
+
 	if (is_rebase_i(opts) && write_author_script(msg.message) < 0)
 		res = -1;
 	else if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
-- 
2.15.0

