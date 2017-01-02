Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22707205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756295AbdABP1k (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:27:40 -0500
Received: from mout.gmx.net ([212.227.17.20]:57850 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756286AbdABP1j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:27:39 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ld4xA-1coZdL0yRc-00iBpl; Mon, 02
 Jan 2017 16:27:31 +0100
Date:   Mon, 2 Jan 2017 16:27:30 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 15/38] sequencer (rebase -i): skip some revert/cherry-pick
 specific code path
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <8bd1f486c810836b0d7622163d3be0907607af92.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Rf+3co35L3jHmn57VXHTmYCVESm7Xp1HRFGMizSr9YRYy1/LnBd
 RXnQnk1uMoMBtFWWRS7SyxACSyW0SrY0uBQwXogiFnqQezJcLAIr9OSamDiUqcltbaYIzAc
 a8DbSx7GrLmRRlGfvMfePfwu5Qni1HTqVSR4Vf14j7nzMNvHiHdBz8FsHJB+t2MRQihRtop
 TEBNf2jRBNXXvO5dRouUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vuTebnVznss=:mvJgVZEg59Qw/w8UhP56QM
 m1Z6qmQK0hc8eUUdWFodGLFRYQKcM1g7qtdizec6r6sQ+Rnb9g5NwupnAO+WheJ7CsbuvUYk9
 PGou/1VexZRtR+3yys1OuZRaMpLArK7xY/u7QMQ7k6UFL0uD49wk3tbxml6OrEUCNcDvrwCWi
 rWBdoPa0MJV7bKRln+H5OYlA5GD8gsFQn/15wiCllqkMkrQinHWE50gk/yVWX8qgDw+HfBdjg
 0CJHsdwncWzHB0uqaADRvEV53jH8V5T8rcxImyuvoZT5eqCxMtsdOj9dEFdnLVEhConfBBxj+
 ixS/lZKOuc0JZ0OvC1VfBOTx8vNCAUYMTEatiI9ikK9F/MpCF8DVGJeG3g21l1/lWvNnvi33W
 BO4S9yBS3NkZTQSWdgPz7HdYtQayandK3Ac+Iuv6JOJchbUU3rKLmwo8J2DINTInzgYzSbG3Q
 0i/H6xnWv+/AmxkyyBWoXNkIgUWbOL09ThernZ+M5ngJCdZSCfCT4FGoQnln8OYGIDKoIvTS5
 lprKWSUHgzOvjiD/mj42witJd08EaoubaHrhH1vTLU/3E/iTQqCIeI6+q/3R8s61rJZ7GTNGq
 8xfM/5gN7+mkvs1eFASM2BqUrwPZtY4QGKiJ8YWjHjaN8T9iwNGfT5FBKzrVk29OMixcUNjGE
 9hFBj4kpccJYnCC9FooT4ck6pBXQQLkZbKQsFHiwH//d9yFzYuINRz8ECOPylnbmp1wJqesve
 UaAEoO74Hnag1U9q54d5TqPWNNfyG9UX1k6U+CVrx86oOvMHYnyw/cYRyAR1rX5MZBSiyk9+5
 Yg8NBpF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a cherry-pick continues without a "todo script", the intention is
simply to pick a single commit.

However, when an interactive rebase is continued without a "todo
script", it means that the last command has been completed and that we
now need to clean up.

This commit guards the revert/cherry-pick specific steps so that they
are not executed in rebase -i mode.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 52e17c8887..a7b9ee0d04 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1878,26 +1878,28 @@ int sequencer_continue(struct replay_opts *opts)
 	if (is_rebase_i(opts)) {
 		if (commit_staged_changes(opts))
 			return -1;
-	}
-	if (!file_exists(get_todo_path(opts)))
+	} else if (!file_exists(get_todo_path(opts)))
 		return continue_single_pick();
 	if (read_populate_opts(opts))
 		return -1;
 	if ((res = read_populate_todo(&todo_list, opts)))
 		goto release_todo_list;
 
-	/* Verify that the conflict has been resolved */
-	if (file_exists(git_path_cherry_pick_head()) ||
-	    file_exists(git_path_revert_head())) {
-		res = continue_single_pick();
-		if (res)
+	if (!is_rebase_i(opts)) {
+		/* Verify that the conflict has been resolved */
+		if (file_exists(git_path_cherry_pick_head()) ||
+		    file_exists(git_path_revert_head())) {
+			res = continue_single_pick();
+			if (res)
+				goto release_todo_list;
+		}
+		if (index_differs_from("HEAD", 0, 0)) {
+			res = error_dirty_index(opts);
 			goto release_todo_list;
+		}
+		todo_list.current++;
 	}
-	if (index_differs_from("HEAD", 0, 0)) {
-		res = error_dirty_index(opts);
-		goto release_todo_list;
-	}
-	todo_list.current++;
+
 	res = pick_commits(&todo_list, opts);
 release_todo_list:
 	todo_list_release(&todo_list);
-- 
2.11.0.rc3.windows.1


