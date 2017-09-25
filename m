Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 546DD20281
	for <e@80x24.org>; Mon, 25 Sep 2017 10:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934558AbdIYKL0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 06:11:26 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:23508 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934465AbdIYKLP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 06:11:15 -0400
Received: from lindisfarne.localdomain ([92.22.15.39])
        by smtp.talktalk.net with SMTP
        id wQLndvDfQbjdZwQM6dIVIy; Mon, 25 Sep 2017 11:11:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1506334274; bh=V4+nu+EiB3phvM5LjB+PpsfpJAc6GH7A0Yzj9og/QtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=JSQQtxw4XHLINWtx147i0QwOGa9dujnnhweUogPj0FmDopTICT8xHOQcCAT9XzIvS
         bQjegn5gao4xgJRQO56rrpvtF31b1o0Ac+p+aZa6MgZhvpu8FHN+FUL9/PTgdrVoDq
         NCrXSesuoIIifQN38RFHngpu0wbHqq234jpUfg0Q=
X-Originating-IP: [92.22.15.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=3EVUng5azuUHeJ78rNzxRg==:117
 a=3EVUng5azuUHeJ78rNzxRg==:17 a=evINK-nbAAAA:8 a=_AHF6dsU_WMRQ53tyscA:9
 a=yqzQubEjL2eLst-d:21 a=WCJPa1CQfK5wFcO_:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 6/8] sequencer: simplify adding Signed-off-by: trailer
Date:   Mon, 25 Sep 2017 11:10:39 +0100
Message-Id: <20170925101041.18344-7-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170925101041.18344-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfP04GRSgTBkwlNqmiTaeeu7CGO43b4lzVQkVTgZk1B0VioaLC+nVAA3gF5FLzU5RTRTJc2kSZxRLKu/ozpQgTqP6iUsxxh6ZwL2wifLX2I6WrpoK+ssp
 /ktoLNnon35v2rVlFvwvgXLubeExZqRfFHKOu4dOUY1XVKqj24M1orKBpoeBsKc26sIMiBCkm8M1HhuLs2sqWb8rCY1c4f0Fs6hRNDrCwN1cibS9m6RBLRTe
 Q+DhsdUV4tgxsFZyPoFIWZHxFSTppKGfcO8H+mMVuBE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add the Signed-off-by: trailer in one place rather than adding it to
the message when doing a recursive merge and then again when
committing. This means that if there are conflicts when merging with a
strategy other than 'recursive' the Signed-off-by: trailer will be
added if the user commits the resolution themselves without passing
'--signoff' to 'git commit'. It also simplifies the in-process commit
that is about to be added to the sequencer.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 65031353f01d75624951222c2de280c427e26ac5..e9060e3ca50777687c578ff09c62cd901efcfb0e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -476,9 +476,6 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 			_(action_name(opts)));
 	rollback_lock_file(&index_lock);
 
-	if (opts->signoff)
-		append_signoff(msgbuf, 0, 0);
-
 	if (!clean)
 		append_conflicts_hint(msgbuf);
 
@@ -656,8 +653,6 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		argv_array_push(&cmd.args, "--amend");
 	if (opts->gpg_sign)
 		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
-	if (opts->signoff)
-		argv_array_push(&cmd.args, "-s");
 	if (defmsg)
 		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
 	if ((flags & CLEANUP_MSG))
@@ -1339,6 +1334,9 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		}
 	}
 
+	if (opts->signoff)
+		append_signoff(&msgbuf, 0, 0);
+
 	if (is_rebase_i(opts) && write_author_script(msg.message) < 0)
 		res = -1;
 	else if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
-- 
2.14.1

