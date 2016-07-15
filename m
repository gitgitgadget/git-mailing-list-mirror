Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44DB52018F
	for <e@80x24.org>; Fri, 15 Jul 2016 10:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbcGOKdX (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 06:33:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:45314 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932187AbcGOKdV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 06:33:21 -0400
Received: (qmail 18195 invoked by uid 102); 15 Jul 2016 10:33:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:33:21 -0400
Received: (qmail 14361 invoked by uid 107); 15 Jul 2016 10:33:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:33:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2016 06:33:18 -0400
Date:	Fri, 15 Jul 2016 06:33:18 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH 07/12] clone: use a real progress meter for connectivity check
Message-ID: <20160715103318.GG19271@sigill.intra.peff.net>
References: <20160715102506.GA23164@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160715102506.GA23164@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Because the initial connectivity check for a cloned
repository can be slow, 0781aa4 (clone: let the user know
when check_everything_connected is run, 2013-05-03) added a
"fake" progress meter; we simply say "Checking connectivity"
when it starts, and "done" at the end, with nothing between.

Since check_connected() now knows how to do a real progress
meter, we can drop our fake one and use that one instead.

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously not related to the receive-pack bits, but we get this for
free because of the earlier refactoring.

 builtin/clone.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 32fe606..f044a8c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -627,13 +627,10 @@ static void update_remote_refs(const struct ref *refs,
 		struct check_connected_options opt = CHECK_CONNECTED_INIT;
 
 		opt.transport = transport;
+		opt.progress = transport->progress;
 
-		if (transport->progress)
-			fprintf(stderr, _("Checking connectivity... "));
 		if (check_connected(iterate_ref_map, &rm, &opt))
 			die(_("remote did not send all necessary objects"));
-		if (transport->progress)
-			fprintf(stderr, _("done.\n"));
 	}
 
 	if (refs) {
-- 
2.9.1.434.g748be50

