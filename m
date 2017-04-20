Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CF95207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 20:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033587AbdDTUWG (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 16:22:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:37176 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033546AbdDTUWD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 16:22:03 -0400
Received: (qmail 31528 invoked by uid 109); 20 Apr 2017 20:22:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 20:22:01 +0000
Received: (qmail 8770 invoked by uid 111); 20 Apr 2017 20:22:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 16:22:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 16:21:58 -0400
Date:   Thu, 20 Apr 2017 16:21:58 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH] connect.c: fix leak in handle_ssh_variant
Message-ID: <20170420202157.l2un35omz4vhffny@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we see an error from split_cmdline(), we exit the
function without freeing the copy of the command string we
made.

This was sort-of introduced by 22e5ae5c8 (connect.c: handle
errors from split_cmdline, 2017-04-10). The leak existed
before that, but before that commit fixed the bug, we could
never trigger this else clause in the first place.

Signed-off-by: Jeff King <peff@peff.net>
---
This was meant to be part of the original patch in:

  http://public-inbox.org/git/20170411003554.2tjnn65vfco376kj@sigill.intra.peff.net/

but I posted two versions in quick succession and Junio picked up the
first one. :)

 connect.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/connect.c b/connect.c
index 568a35f75..cd21a1b6f 100644
--- a/connect.c
+++ b/connect.c
@@ -738,8 +738,10 @@ static void handle_ssh_variant(const char *ssh_command, int is_cmdline,
 			 * any longer.
 			 */
 			free(ssh_argv);
-		} else
+		} else {
+			free(p);
 			return;
+		}
 	}
 
 	if (!strcasecmp(variant, "plink") ||
-- 
2.13.0.rc0.363.g8726c260e
