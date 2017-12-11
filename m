Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D09191F404
	for <e@80x24.org>; Mon, 11 Dec 2017 14:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbdLKOOM (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 09:14:12 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:25076 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752938AbdLKONt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 09:13:49 -0500
Received: from lindisfarne.localdomain ([92.22.30.250])
        by smtp.talktalk.net with SMTP
        id OOpteDPs4CbAZOOq3eBiw0; Mon, 11 Dec 2017 14:13:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1513001628;
        bh=1Q4oyIJ+IbA8fGKvn/ekVwpFTyl+DiOSL867Xx0N1/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=pICoaU3ywofJ1Bs4+3YenzWRDSdDemI8FkgYis89bWQo5g/8eopZ0BSVdQco7a2Pd
         9//yhJZBFFoo2loHl7HMvCqPRnaFK75nANu+0YCxzbHYBZr+drcs5C58duv0HBlxTx
         IAB/+Rx2I0U9zCef/B6DMVexjvj6B/5lsU9LerXE=
X-Originating-IP: [92.22.30.250]
X-Spam: 0
X-OAuthority: v=2.2 cv=JvuBlIwC c=1 sm=1 tr=0 a=hCO86xb6nvxPok+3LE1svw==:117
 a=hCO86xb6nvxPok+3LE1svw==:17 a=evINK-nbAAAA:8 a=qo_IBofmjA8VuP4PJYkA:9
 a=thI04XVJ8FcZUJgH:21 a=x326BpXhDvg8PScu:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 6/9] sequencer: simplify adding Signed-off-by: trailer
Date:   Mon, 11 Dec 2017 14:13:27 +0000
Message-Id: <20171211141330.23566-7-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171211141330.23566-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171211141330.23566-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfMgaPtxxjpvOSKbrzJrtarpT561UvwcY/Sp8qT1ogGO9vEQjTzKh2oD4SE1AEhTDhojnGJJHwBKond5WjM9Mr2/5wiBy01bH9R/9dCnQw5jaznG8iHPd
 cw9xBk6Ds52LxpxyJO02tVge1ZwXKAJ2MgEyQDU+n5aVhP9ptbgr6jNfeYAdONAsJfsZw8nxmRHvBQUw3KYaprS8uGoWoG7sbxKLFLzoLtwm96PLeJ+74ZLO
 sTHRLZjjV6uTyoukbKjzy5V36VYcg9aS6RRRfE90QmSedAGK/0aks//X7tacYFsKYLvLG9/oCWlvbg6fu/W0WJh0AoHBZkk204o7iCSCvEHJ3mp0dEKsSmPY
 agVI5srRpkSTgZMzptJJ7x1SO/5M0SjvvhinaPuZjVxn3U4MW7M=
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
index b4ff2a4a973b2733cca7bb65fcb7947cb8d08988..4966dd1b9359aaa82064608c05a7f5b18cea2d7a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -478,9 +478,6 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 			_(action_name(opts)));
 	rollback_lock_file(&index_lock);
 
-	if (opts->signoff)
-		append_signoff(msgbuf, 0, 0);
-
 	if (!clean)
 		append_conflicts_hint(msgbuf);
 
@@ -658,8 +655,6 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		argv_array_push(&cmd.args, "--amend");
 	if (opts->gpg_sign)
 		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
-	if (opts->signoff)
-		argv_array_push(&cmd.args, "-s");
 	if (defmsg)
 		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
 	if ((flags & CLEANUP_MSG))
@@ -1348,6 +1343,9 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		}
 	}
 
+	if (opts->signoff)
+		append_signoff(&msgbuf, 0, 0);
+
 	if (is_rebase_i(opts) && write_author_script(msg.message) < 0)
 		res = -1;
 	else if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
-- 
2.15.1

