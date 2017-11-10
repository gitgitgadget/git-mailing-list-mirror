Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BAF81F43C
	for <e@80x24.org>; Fri, 10 Nov 2017 11:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752873AbdKJLK0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 06:10:26 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:50718 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752724AbdKJLKI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 06:10:08 -0500
Received: from lindisfarne.localdomain ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id D7C7etmv6mITaD7CJeDJlT; Fri, 10 Nov 2017 11:10:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510312207;
        bh=KsSYb5SLgW/9YCPffBA+nWm/sd2fbVsTfHeICNRySn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=Mym5zCoyvS3bJIyCu3wiboyVk3DB6gN+3sGTBe/ob2ljruzbB1PUfydw0YDwQiQYC
         MADtp72m+l8GyGMiNhn4S5RyR/Emf6VzRsW+eByXGjeTDfFIBE8FwQ+WvlctnHzhAx
         Y4E3HLtFRDaG6IfXKhyDVUpmG3HbQdroUHmCaXcY=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=evINK-nbAAAA:8 a=qo_IBofmjA8VuP4PJYkA:9
 a=FTkRqzf3F1kRNC0N:21 a=x326BpXhDvg8PScu:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 7/9] sequencer: simplify adding Signed-off-by: trailer
Date:   Fri, 10 Nov 2017 11:09:47 +0000
Message-Id: <20171110110949.328-8-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171110110949.328-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171110110949.328-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfBsyC58hcmn+DGG0IREPT1kNow+inMJv0elQBjFI4U+D+2tIeSLbikOpxTDlTOwND4NqJ+BZh+DOQSfGZ521D4wkoAUJolk3B6I9kkvAg4pvEEOjqg4h
 3JlawtO3a+oBmtCBolPW+tuZXWoa0mMJXxHTYYuFA7kv/AOUTeb6dD4OjkyLCQV/xLBUXtMXAV/d103pqbjRnRfutn+DiGhheFQWzs8Cit0slxLSMHLlrJKY
 hdc+8L0DAMfne6V+2pL7nfEdpjMzTVjz/lgP3vxDhe7yk4Lx7I+zZAjiOoHq73DA
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
index 61bb75352202cf896ffec41e972f366e94d569c1..497764ea5db3a3ba2802387316c1d5024d47d7eb 100644
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
@@ -1350,6 +1345,9 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
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

