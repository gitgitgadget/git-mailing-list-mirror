Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6D751F461
	for <e@80x24.org>; Mon, 20 May 2019 12:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbfETMLP (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 08:11:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:33828 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730921AbfETMLP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 08:11:15 -0400
Received: (qmail 23382 invoked by uid 109); 20 May 2019 12:11:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 May 2019 12:11:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3704 invoked by uid 111); 20 May 2019 12:11:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 20 May 2019 08:11:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 May 2019 08:11:13 -0400
Date:   Mon, 20 May 2019 08:11:13 -0400
From:   Jeff King <peff@peff.net>
To:     Alejandro Sanchez <asanchez1987@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 3/4] am: drop tty requirement for --interactive
Message-ID: <20190520121113.GC11212@sigill.intra.peff.net>
References: <20190520120636.GA12634@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190520120636.GA12634@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have required that the stdin of "am --interactive" be a tty since
a1451104ac (git-am: interactive should fail gracefully., 2005-10-12).
However, this isn't strictly necessary, and makes the tool harder to
test (and is unlike all of our other --interactive commands).

The goal of that commit was to make sure that somebody does not do:

  git am --interactive <mbox

and cause us to read commands from the mbox. But we can simply check
up front for this case and complain before entering the interactive
loop.

Technically this disallows:

  git am --interactive </dev/null

where our lack of patches means we would never prompt for anything, and
so the old code would not notice our lack of tty (and now we'd die
early). But since such a command is totally pointless, it's no loss.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/am.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 47ad7a5a70..ea16b844f1 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1643,9 +1643,6 @@ static int do_interactive(struct am_state *state)
 {
 	assert(state->msg);
 
-	if (!isatty(0))
-		die(_("cannot be interactive without stdin connected to a terminal."));
-
 	for (;;) {
 		char reply[64];
 
@@ -2334,6 +2331,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 				argv_array_push(&paths, mkpath("%s/%s", prefix, argv[i]));
 		}
 
+		if (state.interactive && !paths.argc)
+			die(_("interactive mode requires patches on the command line"));
+
 		am_setup(&state, patch_format, paths.argv, keep_cr);
 
 		argv_array_clear(&paths);
-- 
2.22.0.rc1.539.g7bfcdfe86d

