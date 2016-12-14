Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B21131FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 15:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756336AbcLNPKa (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 10:10:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:56420 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756286AbcLNPKN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 10:10:13 -0500
Received: (qmail 1361 invoked by uid 109); 14 Dec 2016 15:10:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 15:10:12 +0000
Received: (qmail 25503 invoked by uid 111); 14 Dec 2016 15:10:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 10:10:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2016 10:10:10 -0500
Date:   Wed, 14 Dec 2016 10:10:10 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] parse-options: print "fatal:" before usage_msg_opt()
Message-ID: <20161214151009.4wdzjb44f6aki5ug@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Programs may use usage_msg_opt() to print a brief message
followed by the program usage, and then exit. The message
isn't prefixed at all, though, so it doesn't match our usual
error output and is easy to overlook:

    $ git clone 1 2 3
    Too many arguments.

    usage: git clone [<options>] [--] <repo> [<dir>]

    -v, --verbose         be more verbose
    -q, --quiet           be more quiet
    --progress            force progress reporting
    -n, --no-checkout     don't create a checkout
    --bare                create a bare repository
    [...and so on for another 31 lines...]

It looks especially bad when the message starts with an
option, like:

    $ git replace -e
    -e needs exactly one argument

    usage: git replace [-f] <object> <replacement>
       or: git replace [-f] --edit <object>
    [...etc...]

Let's put our usual "fatal:" prefix in front of it.

Signed-off-by: Jeff King <peff@peff.net>
---
Some of the message in git-clone could stand to be rewritten to match
our usual style, too (no capitals, no trailing period), but that's
obviously out of scope for this patch. I don't think this change makes
them look any worse.

 parse-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index 312a85dbd..4fbe924a5 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -661,7 +661,7 @@ void NORETURN usage_msg_opt(const char *msg,
 		   const char * const *usagestr,
 		   const struct option *options)
 {
-	fprintf(stderr, "%s\n\n", msg);
+	fprintf(stderr, "fatal: %s\n\n", msg);
 	usage_with_options(usagestr, options);
 }
 
-- 
2.11.0.341.g202cd3142
