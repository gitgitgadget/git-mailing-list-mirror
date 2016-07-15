Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B74EE2018F
	for <e@80x24.org>; Fri, 15 Jul 2016 10:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbcGOKfc (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 06:35:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:45321 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932187AbcGOKfb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 06:35:31 -0400
Received: (qmail 18289 invoked by uid 102); 15 Jul 2016 10:35:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:35:30 -0400
Received: (qmail 14395 invoked by uid 107); 15 Jul 2016 10:35:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:35:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2016 06:35:28 -0400
Date:	Fri, 15 Jul 2016 06:35:28 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH 09/12] receive-pack: turn on index-pack resolving progress
Message-ID: <20160715103527.GI19271@sigill.intra.peff.net>
References: <20160715102506.GA23164@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160715102506.GA23164@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When we receive a large push, the server side may have to
spend a lot of CPU processing the incoming packfile.

During the "receiving" phase, we are typically network
bound, and the client is writing its own progress to the
user. But during the delta resolution phase, we may spend
minutes (e.g., for a full push of linux.git) without
making any indication to the user that the connection has
not hung.

Let's ask index-pack to produce progress output for this
phase (unless the client asked us to be quiet, of course).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ce81920..de322bc 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1547,6 +1547,8 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 				 (uintmax_t)getpid(),
 				 hostname);
 
+		if (!quiet && err_fd)
+			argv_array_push(&child.args, "--show-resolving-progress");
 		if (fsck_objects)
 			argv_array_pushf(&child.args, "--strict%s",
 				fsck_msg_types.buf);
-- 
2.9.1.434.g748be50

