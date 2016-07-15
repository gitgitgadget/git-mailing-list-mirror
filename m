Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D8A92018F
	for <e@80x24.org>; Fri, 15 Jul 2016 10:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbcGOK0d (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 06:26:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:45296 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932187AbcGOK0c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 06:26:32 -0400
Received: (qmail 17853 invoked by uid 102); 15 Jul 2016 10:26:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:26:31 -0400
Received: (qmail 14125 invoked by uid 107); 15 Jul 2016 10:26:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:26:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2016 06:26:29 -0400
Date:	Fri, 15 Jul 2016 06:26:29 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH 01/12] check_everything_connected: always pass --quiet to
 rev-list
Message-ID: <20160715102628.GA19271@sigill.intra.peff.net>
References: <20160715102506.GA23164@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160715102506.GA23164@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The check_everything_connected function takes a "quiet"
parameter which does two things if non-zero:

  1. redirect rev-list's stderr to /dev/null to avoid
     showing errors to the user

  2. pass "--quiet" to rev-list

Item (1) is obviously useful. But item (2) is
surprisingly not. For rev-list, "--quiet" does not have
anything to do with chattiness on stderr; it tells rev-list
not to bother writing the list of traversed objects to
stdout, for efficiency.  And since we always redirect
rev-list's stdout to /dev/null in this function, there is no
point in asking it to ever write anything to stdout.

The efficiency gains are modest; a best-of-five run of "git
rev-list --objects --all" on linux.git dropped from 32.013s
to 30.502s when adding "--quiet". That's only about 5%, but
given how easy it is, it's worth doing.

Signed-off-by: Jeff King <peff@peff.net>
---
 connected.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/connected.c b/connected.c
index bf1b12e..7560a31 100644
--- a/connected.c
+++ b/connected.c
@@ -56,8 +56,7 @@ static int check_everything_connected_real(sha1_iterate_fn fn,
 	argv[ac++] = "--stdin";
 	argv[ac++] = "--not";
 	argv[ac++] = "--all";
-	if (quiet)
-		argv[ac++] = "--quiet";
+	argv[ac++] = "--quiet";
 	argv[ac] = NULL;
 
 	rev_list.argv = argv;
-- 
2.9.1.434.g748be50

