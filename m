Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0324F205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756384AbdABP2h (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:28:37 -0500
Received: from mout.gmx.net ([212.227.17.20]:60573 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756374AbdABP2e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:28:34 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MarAM-1c3fKj30xO-00KRbH; Mon, 02
 Jan 2017 16:28:27 +0100
Date:   Mon, 2 Jan 2017 16:28:27 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 26/38] sequencer (rebase -i): respect the rebase.autostash
 setting
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <af4cb86a6db311a4f18ce476ac27a5a982ff7482.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WaY4PKMvbpKgE3wIJJQk+PdGuA5bFCqEsop9KZ/n3tUri0TCLT/
 s2J3zyQEWFSXW5w5xrPUAeSn22zXeY+UkvdcYFHkU1OaeNUgrWv8cCkqj3KFhKyWqG1yQju
 AkCuQNelCqrgIlZX/KzBFVd7fkDw7qT78ULS7tHq6AYjrSBMvTVCID/xrgzyHf/cIKRkLVx
 RxT4x2/CINprqoT1LPwmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zp37Jrfbl6E=:tQlmie2Kjyyfl7WDdzuWND
 ifJSv3mRnQ2bi1rqkgHFB0f6wbZDVWH7wiCEzJnIwhImzZK8BNBImAI3+TuAfIWh9GP0cw4Xc
 t9dokG04rS2sC6eYpV8Spi3aZfOPx8IwcS7WXIzJ21ZszBKN3NNTHnaktnp1W36fXEQSy138O
 zxP1T5xs0lGuIFH5xGWM8fvUCVzHNA63CgdJtfYuHSu/VllqJCl4eKY4adlu9b1pnp6/g8f2X
 zpQgaTk9DX1ZmQvuqGlV++aB1WTWPSVGEAht4fQzAYGi7ez7GAI4kSubCWhP5EAM+lt1c1JOS
 VeFPKYSSUhyk3HuDEyv/XRZvQmMGkjQqeKORfUTPIn4EQ8vKJRQuHgXxC8yd+eJ/8h7NW11tZ
 OK/a1cNHvHxjeqYkmRPc3uKYkYcC6EoRc1U1RcTSGAicN+K8bizpuVcRk2P5D0kgbGjUPsrzZ
 Wc8nsmr6kf+Vl88GiV9B4wM08Z7SwuNBNRHQV1yXTJxOQFfUK65r6MzPDqIMT5/m75y6QLhf+
 AtmpovO+N4DMUopaBBb1AyjwGI2gfvlFcB7Y/1Wip8KrEPVcA3zUueNujYbzOXx9V2QTSeJ/7
 p3U+NoHBzRcM+KWR6SnpQf7rleknGyn7sXTLt2U19uofl6f6vUrg0FDOIZ7hvzWBHsFMGnc9X
 ou3nqN4dQBbM48Ma2uvLFId0OWpbmCNg1ZItUSpHgedAlYFWJbhpr3FTijtk/SN27V7QhkJWu
 rlXIMEgckjypi1yEt74PfFT8HqjS03MTxguRJrZDeK6bADu8yvIzI8Wm7nFHD14Crtwzpo6rr
 SVwlt+8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git's `rebase` command inspects the `rebase.autostash` config setting
to determine whether it should stash any uncommitted changes before
rebasing and re-apply them afterwards.

As we introduce more bits and pieces to let the sequencer act as
interactive rebase's backend, here is the part that adds support for
the autostash feature.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 43ced8db31..06f7cebe48 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -113,6 +113,7 @@ static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
 static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
 static GIT_PATH_FUNC(rebase_path_head_name, "rebase-merge/head-name")
 static GIT_PATH_FUNC(rebase_path_onto, "rebase-merge/onto")
+static GIT_PATH_FUNC(rebase_path_autostash, "rebase-merge/autostash")
 
 static inline int is_rebase_i(const struct replay_opts *opts)
 {
@@ -1801,6 +1802,47 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 	return -1;
 }
 
+static int apply_autostash(struct replay_opts *opts)
+{
+	struct strbuf stash_sha1 = STRBUF_INIT;
+	struct child_process child = CHILD_PROCESS_INIT;
+	int ret = 0;
+
+	if (!read_oneliner(&stash_sha1, rebase_path_autostash(), 1)) {
+		strbuf_release(&stash_sha1);
+		return 0;
+	}
+	strbuf_trim(&stash_sha1);
+
+	child.git_cmd = 1;
+	argv_array_push(&child.args, "stash");
+	argv_array_push(&child.args, "apply");
+	argv_array_push(&child.args, stash_sha1.buf);
+	if (!run_command(&child))
+		printf(_("Applied autostash."));
+	else {
+		struct child_process store = CHILD_PROCESS_INIT;
+
+		store.git_cmd = 1;
+		argv_array_push(&store.args, "stash");
+		argv_array_push(&store.args, "store");
+		argv_array_push(&store.args, "-m");
+		argv_array_push(&store.args, "autostash");
+		argv_array_push(&store.args, "-q");
+		argv_array_push(&store.args, stash_sha1.buf);
+		if (run_command(&store))
+			ret = error(_("cannot store %s"), stash_sha1.buf);
+		else
+			printf(_("Applying autostash resulted in conflicts.\n"
+				"Your changes are safe in the stash.\n"
+				"You can run \"git stash pop\" or"
+				" \"git stash drop\" at any time.\n"));
+	}
+
+	strbuf_release(&stash_sha1);
+	return ret;
+}
+
 static const char *reflog_message(struct replay_opts *opts,
 	const char *sub_action, const char *fmt, ...)
 {
@@ -1980,6 +2022,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 				run_command(&hook);
 			}
 		}
+		apply_autostash(opts);
 
 		strbuf_release(&buf);
 		strbuf_release(&head_ref);
-- 
2.11.0.rc3.windows.1


