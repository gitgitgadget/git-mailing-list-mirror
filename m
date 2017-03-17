Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BD1020951
	for <e@80x24.org>; Fri, 17 Mar 2017 23:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbdCQXVq (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 19:21:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:46294 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751087AbdCQXVq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 19:21:46 -0400
Received: (qmail 7094 invoked by uid 109); 17 Mar 2017 23:20:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 23:20:08 +0000
Received: (qmail 7961 invoked by uid 111); 17 Mar 2017 23:20:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 19:20:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Mar 2017 19:20:04 -0400
Date:   Fri, 17 Mar 2017 19:20:04 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH] run-command: fix segfault when cleaning forked async process
Message-ID: <20170317232004.xqs5f2q2swa3b5bq@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Callers of the run-command API may mark a child as
"clean_on_exit"; it gets added to a list and killed when the
main process dies.  Since commit 46df6906f
(execv_dashed_external: wait for child on signal death,
2017-01-06), we respect an extra "wait_after_clean" flag,
which we expect to find in the child_process struct.

When Git is built with NO_PTHREADS, we start "struct
async" processes by forking rather than spawning a thread.
The resulting processes get added to the cleanup list but
they don't have a child_process struct, and the cleanup
function ends up dereferencing NULL.

We should notice this case and assume that the processes do
not need to be waited for (i.e., the same behavior they had
before 46df6906f).

Reported-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Jeff King <peff@peff.net>
---
This is a regression in v2.12.0, though there is no hurry to get it into
v2.12.1 unless your grep patches go in, too. Without them you can't
actually build with NO_PTHREADS anyway.

However, applied directly on top of 46df6906f (which predates the build
breakage), you can easily see the test failures with NO_PTHREADS and
that this fixes them.

 run-command.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 5227f78ae..574b81d3e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -48,7 +48,7 @@ static void cleanup_children(int sig, int in_signal)
 
 		kill(p->pid, sig);
 
-		if (p->process->wait_after_clean) {
+		if (p->process && p->process->wait_after_clean) {
 			p->next = children_to_wait_for;
 			children_to_wait_for = p;
 		} else {
-- 
2.12.0.660.gf842b44fd
