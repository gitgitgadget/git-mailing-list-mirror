Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16AAE202A0
	for <e@80x24.org>; Mon,  6 Nov 2017 11:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbdKFL3j (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 06:29:39 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:15362 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932186AbdKFL3h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 06:29:37 -0500
Received: from lindisfarne.localdomain ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id BfYqeiZ2C3CyHBfaYewtxT; Mon, 06 Nov 2017 11:29:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1509967771; bh=atRwJjEtOjtVm6Ix3RtZ9Aubgl+wBtSWKDIppLL6Adw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=dlgwZAW39aYtMKBKpkLlCMjQg+snhcSjC5bdP4CBjQUvA8RwXfj4boNs0gN+ia968
         Sy6vDXbQ04EzPyl3Pil/aXYq6TG9i2sQU75/uchIyctiUpgNH/G2W0n8TQ/hVH00pX
         Us9rJAmsj4jFugw/5y0TeOnUPv/e4ykWDj0JxRW8=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=Zo+dE5zG c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=evINK-nbAAAA:8 a=qo_IBofmjA8VuP4PJYkA:9
 a=boGxNzeRQ_6-pxMY:21 a=x326BpXhDvg8PScu:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 6/8] sequencer: simplify adding Signed-off-by: trailer
Date:   Mon,  6 Nov 2017 11:27:07 +0000
Message-Id: <20171106112709.2121-7-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171106112709.2121-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171106112709.2121-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfEWhVHPBZMx4unjpyTSwf8FJcLhoy0Q5+ivnsXa5/GqHUfLM8AObV+0OVQ9yFbMexX0kjPAX+J6AhTRWupx+4/XnxBy/Mrr9Cn3KnSJh9atu2ozEteNT
 tsD1lHW8p3Ryku3kYOqHsVfKW7GdqCvvT7uLSUzOHlv7YaA8+37CoyePPfy9HH+Ao+T1fey5UlsZoQX/by/6vd54EReDs7BPHxXKk5MuRx2Oava27nAgaXmF
 9pfSIIARQEYNCyH8Lv8B8bTxUoga3lptZdTWqkahI1w+BSFf9zjMSKv8YR6jt+6Q
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
index ae24405c23d021ed7916e5e2d9df6de27f867a2e..3e4c3bbb265db58df22cfcb5a321fb74d822327e 100644
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
2.14.3

