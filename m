Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F3B9205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756393AbdABP2w (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:28:52 -0500
Received: from mout.gmx.net ([212.227.15.19]:58611 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755577AbdABP2v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:28:51 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mdren-1c9yTG18cH-00PeCI; Mon, 02
 Jan 2017 16:28:35 +0100
Date:   Mon, 2 Jan 2017 16:28:34 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 28/38] sequencer (rebase -i): allow rescheduling
 commands
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <6fadd5543520c06f2329bd3051922dbb01534fc5.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ITDmt+4kpMnlEUFIMQBAy+gip2Gx6UzQiTSg+diY5UcuZU4XH65
 FGmiTmI5V/ObFAljtHE3cs3Re7CzZfXEBLXvYxsZr3pOQXsUgRBL6LIBq4e1v2xPUDCGDs5
 KSSBupI0wmq9gp+Nzrl2rWcmWyWu3jjwBEmYEKr+RLI/hBQZps0mkSeB8qlgRNtBBOo4iY8
 +vkdjPY75IkfTsibUUYVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Df2+3fCGT8o=:VhGNn7CHxJfMItM64kaqS6
 /nbL+gOyJFhdJ9Pl1l6HIcQl6FVl/UT7EFiPtQKhjROt8fuR3tqV+vGYDPhb4rKvCwr9C77BS
 xlueJrzBvCOvw7MAMK22u3EQ9zOUupD0UPJhgVtkI/JlM6Y4l/hI7zwWVvmrlZipzed4dlo/S
 SXsd/DSvliUL+QwwHq2nnDGbTHRItZgIJ1igLcyq6vO/7DrdS3uvEodd4Ih0De3AhQbllrtJM
 GUp11sC5UOE0sSE5aymn27ilmhrETcejLErP1nU3/vb9agaWBlPq6fmsKDnVVIkoJeT05pCD9
 Tptkto/w/wk08oJmT3wMv4LSuzY7uWiEsp3BEYc//aa45yrpXN4LEWT/V5YBAzOWnfhb3ZmnH
 GCTvj33nPYcp/GOCV6fH+ju6KMekj/pmpjeLZgAPkOQq9VNmuL3IZLafSwpXTIMV2cML3Keu1
 qtgVRJxs1TFOqvtrvPVBtuteDPpAMQlm1xXyeEd8dTrfmhFf4t0yv4odR6vCyBXmnUSK8BCdP
 O2ZpybL7jgcJzdH4MRJlFwjjbgRZpCTEpQMUQ/9X4JHgyiYpg9h+AcWW7SreQoRAkDE0ICutl
 3jymIJRnbz7ZXN8I84St2TsY3IEH0fmAj938GYxCCZ8jjUyhFsE7/EmVcRE07crMmP0SfkQVH
 oq0knVGA9OIp2DdVmSwkfJRgJgi6xHnt86zyLioR757zXly9kjDBtAStV9evUkgadETsRc3Vm
 XeSGHiTIeD5wkEvyUqzNzs9uDAVaJZGsT4tkid2py/IqpOLHH99MffmG5lLiGu3rKjOv3v1VK
 AowVntF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The interactive rebase has the very special magic that a cherry-pick
that exits with a status different from 0 and 1 signifies a failure to
even record that a cherry-pick was started.

This can happen e.g. when a fast-forward fails because it would
overwrite untracked files.

In that case, we must reschedule the command that we thought we already
had at least started successfully.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 04a64cf0dc..dd5b843a84 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1915,6 +1915,12 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 					1);
 			res = do_pick_commit(item->command, item->commit,
 					opts, is_final_fixup(todo_list));
+			if (is_rebase_i(opts) && res < 0) {
+				/* Reschedule */
+				todo_list->current--;
+				if (save_todo(todo_list, opts))
+					return -1;
+			}
 			if (item->command == TODO_EDIT) {
 				struct commit *commit = item->commit;
 				if (!res)
-- 
2.11.0.rc3.windows.1


