Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9468A1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 14:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753175AbcIIOhj (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:37:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:51874 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752822AbcIIOhf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:37:35 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MHXd2-1blfFg3HzQ-003NMe; Fri, 09 Sep 2016 16:37:24
 +0200
Date:   Fri, 9 Sep 2016 16:37:24 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 09/17] sequencer: lib'ify read_populate_todo()
In-Reply-To: <cover.1473431645.git.johannes.schindelin@gmx.de>
Message-ID: <107e669eb6996b8bcfed4177241550da778c6b73.1473431645.git.johannes.schindelin@gmx.de>
References: <cover.1472219214.git.johannes.schindelin@gmx.de> <cover.1473431645.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cdu00vnQQQBxnA4NJf1rj1PDFen9k6BgoqqN98Am3SfBYgCG1e7
 onzs4JD1HFC/p26lrPthUH3NOxlQFTrq6XHRHlb0zqA3z8OdYpnOzVUrGunzhBM0pJfaC7K
 guTkc4EgP/AcQI0UOYjgs0FEaIcD/btZ9ibNxV7+ffiJT9samyjEXSIWeRYCu7EFb1ypayV
 b8+APDHmAKDnfo731MsZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I8TU9iQ1yYA=:k8heYm/t3cd0xC/GoTERjt
 eB97bjxRXWTNSBov7qQdubVZjFSe2fGnxEthgBL4AOe6st2hVxl/yfkSEm938W85Zh+fHdboI
 4K5xRPxxaNWL05Uh3Ohfln0hVs5374Rs42nS9aKjdu0cJGTmeGqWCuBFWJ2L+MLyU2Tt+I0lr
 MQQTFj6+e3VLZ1OAjQJaZqlZY933VA7iDiuSw1P1blS7QWjzGJ1IxkLQ1fSqa6NxcJlrp0mrX
 ZESwwmoCfSjRURwnvg6/artfYSfuadsUWpQC7pQhTs0yyueSccaEZrPcmRrFoUrmqQgJM1TFG
 Ha0N5PpUAiDPnHDAqhj+jClgr0xKMJHvyQBGboOgB/eBdymj117/v/4oeOi1ezvXmh8CBy6Gf
 hH4gIC6hsKkrK8L2FBbD6UFETWoLh2wE9u/24n9CI9tBAgF+I9tINsuESSBlvW30W4gFTuPpe
 yolgVGdMry7rb01C0lhf53UL4zCf3IKGRwn2xtlEB17KHDF+VfLoKxI7JavLi/IajSSUYBJm7
 RZsTz5n2VzNmgMaVZcoh0Zs+E1NPP24MHXqHK8Lcq2J3jmk+hnCVeDxL2nX9GjQTdxvc85gIx
 rm/X+KODsgDePSqmXBxwMRbLmqQSbZJXLPetz30Ntcju11boGLLxE16fsAPo/fj6YnPxZexab
 8Re60CCJXrYmvaOnF0JH5g3m8SizSOY3z7u1eyRRgQtxgmZTM3b6z5mlHtn8bajWcxfMOTN+a
 T8f52JLYPjV4ypqBQcswZhMbh6grsaROWVDYbwjF/0TpBdXMXs/2E9kuu1JDTqGVwWHzDFlGj
 FHhLoqC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying there, let the caller high up in the callchain
notice the error and handle it (by dying, still).

The only caller of read_populate_todo(), sequencer_continue() can
already return errors, so its caller must be already prepared to
handle error returns, and with this step, we make it notice an
error return from this function.

So this is a safe conversion to make read_populate_todo() callable
from new callers that want it not to die, without changing the
external behaviour of anything existing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 631b75d..c73cdfd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -748,7 +748,7 @@ static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
 	return 0;
 }
 
-static void read_populate_todo(struct commit_list **todo_list,
+static int read_populate_todo(struct commit_list **todo_list,
 			struct replay_opts *opts)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -756,18 +756,21 @@ static void read_populate_todo(struct commit_list **todo_list,
 
 	fd = open(git_path_todo_file(), O_RDONLY);
 	if (fd < 0)
-		die_errno(_("Could not open %s"), git_path_todo_file());
+		return error_errno(_("Could not open %s"),
+				   git_path_todo_file());
 	if (strbuf_read(&buf, fd, 0) < 0) {
 		close(fd);
 		strbuf_release(&buf);
-		die(_("Could not read %s."), git_path_todo_file());
+		return error(_("Could not read %s."), git_path_todo_file());
 	}
 	close(fd);
 
 	res = parse_insn_buffer(buf.buf, todo_list, opts);
 	strbuf_release(&buf);
 	if (res)
-		die(_("Unusable instruction sheet: %s"), git_path_todo_file());
+		return error(_("Unusable instruction sheet: %s"),
+			git_path_todo_file());
+	return 0;
 }
 
 static int populate_opts_cb(const char *key, const char *value, void *data)
@@ -1019,7 +1022,8 @@ static int sequencer_continue(struct replay_opts *opts)
 	if (!file_exists(git_path_todo_file()))
 		return continue_single_pick();
 	read_populate_opts(&opts);
-	read_populate_todo(&todo_list, opts);
+	if (read_populate_todo(&todo_list, opts))
+		return -1;
 
 	/* Verify that the conflict has been resolved */
 	if (file_exists(git_path_cherry_pick_head()) ||
-- 
2.10.0.windows.1.10.g803177d


