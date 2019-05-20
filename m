Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9670B1F461
	for <e@80x24.org>; Mon, 20 May 2019 12:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732617AbfETMJ2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 08:09:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:33818 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730921AbfETMJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 08:09:28 -0400
Received: (qmail 23300 invoked by uid 109); 20 May 2019 12:09:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 May 2019 12:09:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3671 invoked by uid 111); 20 May 2019 12:10:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 20 May 2019 08:10:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 May 2019 08:09:26 -0400
Date:   Mon, 20 May 2019 08:09:26 -0400
From:   Jeff King <peff@peff.net>
To:     Alejandro Sanchez <asanchez1987@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 2/4] am: read interactive input from stdin
Message-ID: <20190520120926.GB11212@sigill.intra.peff.net>
References: <20190520120636.GA12634@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190520120636.GA12634@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the conversion of git-am from shell script to C, we switched to using
git_prompt(). Unlike the original shell command "read reply", this
doesn't read from stdin at all, but rather from /dev/tty.

In most cases this distinction wouldn't matter. We require (as the shell
script did) that stdin is a tty, so they would generally be the same
thing. But one important exception is our test suite: even with
test_terminal, we cannot test "am --interactive" because it insists on
reading from /dev/tty, not the pseudo-tty we've set up in the test
script.

Fixing this clears the way to adding tests in a future patch.

Signed-off-by: Jeff King <peff@peff.net>
---
Part of me dies inside when I look at adding the magical "64". But we
expect this input to be single-line (or at most, somebody might actually
type out "edit", etc), and avoiding strbuf_getline() saves us from
having to free the strbuf in the many early return paths. I dunno. If
it's too ugly it would not be too hard to switch it over.

 builtin/am.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 644bb11f6c..47ad7a5a70 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1647,7 +1647,7 @@ static int do_interactive(struct am_state *state)
 		die(_("cannot be interactive without stdin connected to a terminal."));
 
 	for (;;) {
-		const char *reply;
+		char reply[64];
 
 		puts(_("Commit Body is:"));
 		puts("--------------------------");
@@ -1659,7 +1659,9 @@ static int do_interactive(struct am_state *state)
 		 * in your translation. The program will only accept English
 		 * input at this point.
 		 */
-		reply = git_prompt(_("Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all: "), PROMPT_ECHO);
+		printf(_("Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all: "));
+		if (!fgets(reply, sizeof(reply), stdin))
+			die("unable to read from stdin; aborting");
 
 		if (*reply == 'y' || *reply == 'Y') {
 			return 0;
-- 
2.22.0.rc1.539.g7bfcdfe86d

