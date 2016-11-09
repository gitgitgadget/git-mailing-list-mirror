Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E3872035F
	for <e@80x24.org>; Wed,  9 Nov 2016 03:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbcKID5b (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 22:57:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:40501 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750967AbcKID5b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 22:57:31 -0500
Received: (qmail 21626 invoked by uid 109); 9 Nov 2016 03:57:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Nov 2016 03:57:30 +0000
Received: (qmail 26578 invoked by uid 111); 9 Nov 2016 03:57:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Nov 2016 22:57:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Nov 2016 22:57:28 -0500
Date:   Tue, 8 Nov 2016 22:57:28 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH] sequencer: silence
 -Wtautological-constant-out-of-range-compare
Message-ID: <20161109035728.v2mqvtj4ep4dj74j@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When clang compiles sequencer.c, it complains:

  sequencer.c:632:14: warning: comparison of constant 2 with
    expression of type 'const enum todo_command' is always
    true [-Wtautological-constant-out-of-range-compare]
          if (command < ARRAY_SIZE(todo_command_strings))

This is because "command" is an enum that may only have two
values (0 and 1) and the array in question has two elements.

As it turns out, clang is actually wrong here, at least
according to its own bug tracker:

  https://llvm.org/bugs/show_bug.cgi?id=16154

But it's still worth working around this, as the warning is
present with -Wall, meaning we fail compilation with "make
DEVELOPER=1".

Casting the enum to size_t sufficiently unconfuses clang. As
a bonus, it also catches any possible out-of-bounds access
if the enum takes on a negative value (which shouldn't
happen either, but again, this is a defensive check).

Signed-off-by: Jeff King <peff@peff.net>
---
I know that a different fix is coming in a follow-on series, but I think
it's worth doing this to un-break clang on master (and v2.11) in the
meantime.

 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 5fd75f30d..6f0ff9e41 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -629,7 +629,7 @@ static const char *todo_command_strings[] = {
 
 static const char *command_to_string(const enum todo_command command)
 {
-	if (command < ARRAY_SIZE(todo_command_strings))
+	if ((size_t)command < ARRAY_SIZE(todo_command_strings))
 		return todo_command_strings[command];
 	die("Unknown command: %d", command);
 }
-- 
2.11.0.rc0.263.g6f44bc3
