Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBCAE1F4B6
	for <e@80x24.org>; Mon, 20 May 2019 12:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732559AbfETMHT (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 08:07:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:33806 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730534AbfETMHS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 08:07:18 -0400
Received: (qmail 23166 invoked by uid 109); 20 May 2019 12:07:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 May 2019 12:07:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3604 invoked by uid 111); 20 May 2019 12:07:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 20 May 2019 08:07:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 May 2019 08:07:15 -0400
Date:   Mon, 20 May 2019 08:07:15 -0400
From:   Jeff King <peff@peff.net>
To:     Alejandro Sanchez <asanchez1987@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 1/4] am: simplify prompt response handling
Message-ID: <20190520120715.GA11212@sigill.intra.peff.net>
References: <20190520120636.GA12634@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190520120636.GA12634@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We'll never see a NULL returned from git_prompt(); if it can't produce
any input for us (e.g., because the terminal got EOF) then it will just
die().

So there's no need for us to handle NULL here. And even if there was, it
doesn't make sense to continue; on a true terminal hangup we'd just loop
infinitely trying to get input that will never come.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/am.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 912d9821b1..644bb11f6c 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1661,9 +1661,7 @@ static int do_interactive(struct am_state *state)
 		 */
 		reply = git_prompt(_("Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all: "), PROMPT_ECHO);
 
-		if (!reply) {
-			continue;
-		} else if (*reply == 'y' || *reply == 'Y') {
+		if (*reply == 'y' || *reply == 'Y') {
 			return 0;
 		} else if (*reply == 'a' || *reply == 'A') {
 			state->interactive = 0;
-- 
2.22.0.rc1.539.g7bfcdfe86d

