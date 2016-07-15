Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8319C2018F
	for <e@80x24.org>; Fri, 15 Jul 2016 10:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbcGOKcc (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 06:32:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:45311 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932187AbcGOKcb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 06:32:31 -0400
Received: (qmail 18154 invoked by uid 102); 15 Jul 2016 10:32:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:32:30 -0400
Received: (qmail 14344 invoked by uid 107); 15 Jul 2016 10:32:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:32:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2016 06:32:28 -0400
Date:	Fri, 15 Jul 2016 06:32:28 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH 06/12] check_connected: add progress flag
Message-ID: <20160715103228.GF19271@sigill.intra.peff.net>
References: <20160715102506.GA23164@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160715102506.GA23164@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Connectivity checks have to traverse the entire object graph
in the worst case (e.g., a full clone or a full push). For
large repositories like linux.git, this can take 30-60
seconds, during which time git may produce little or no
output.

Let's add the option of showing progress, which is taken
care of by rev-list.

Signed-off-by: Jeff King <peff@peff.net>
---
 connected.c | 3 +++
 connected.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/connected.c b/connected.c
index 5f5c8bd..8e3e4b1 100644
--- a/connected.c
+++ b/connected.c
@@ -58,6 +58,9 @@ int check_connected(sha1_iterate_fn fn, void *cb_data,
 	argv_array_push(&rev_list.args, "--not");
 	argv_array_push(&rev_list.args, "--all");
 	argv_array_push(&rev_list.args, "--quiet");
+	if (opt->progress)
+		argv_array_pushf(&rev_list.args, "--progress=%s",
+				 _("Checking connectivity"));
 
 	rev_list.git_cmd = 1;
 	rev_list.in = -1;
diff --git a/connected.h b/connected.h
index 5d88e26..afa48cc 100644
--- a/connected.h
+++ b/connected.h
@@ -30,6 +30,9 @@ struct check_connected_options {
 	 * returns.
 	 */
 	int err_fd;
+
+	/* If non-zero, show progress as we traverse the objects. */
+	int progress;
 };
 
 #define CHECK_CONNECTED_INIT { 0 }
-- 
2.9.1.434.g748be50

