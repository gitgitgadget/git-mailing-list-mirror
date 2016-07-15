Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B51892018F
	for <e@80x24.org>; Fri, 15 Jul 2016 10:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbcGOK2h (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 06:28:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:45302 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932082AbcGOK2g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 06:28:36 -0400
Received: (qmail 17964 invoked by uid 102); 15 Jul 2016 10:28:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:28:35 -0400
Received: (qmail 14159 invoked by uid 107); 15 Jul 2016 10:28:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:28:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2016 06:28:32 -0400
Date:	Fri, 15 Jul 2016 06:28:32 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH 03/12] check_everything_connected: convert to argv_array
Message-ID: <20160715102832.GC19271@sigill.intra.peff.net>
References: <20160715102506.GA23164@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160715102506.GA23164@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This avoids the magic "9" array-size which we must avoid
overflowing, making further patches simpler.

Signed-off-by: Jeff King <peff@peff.net>
---
 connected.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/connected.c b/connected.c
index 7560a31..a3bfc4e 100644
--- a/connected.c
+++ b/connected.c
@@ -26,10 +26,9 @@ static int check_everything_connected_real(sha1_iterate_fn fn,
 					   const char *shallow_file)
 {
 	struct child_process rev_list = CHILD_PROCESS_INIT;
-	const char *argv[9];
 	char commit[41];
 	unsigned char sha1[20];
-	int err = 0, ac = 0;
+	int err = 0;
 	struct packed_git *new_pack = NULL;
 	size_t base_len;
 
@@ -48,18 +47,16 @@ static int check_everything_connected_real(sha1_iterate_fn fn,
 	}
 
 	if (shallow_file) {
-		argv[ac++] = "--shallow-file";
-		argv[ac++] = shallow_file;
+		argv_array_push(&rev_list.args, "--shallow-file");
+		argv_array_push(&rev_list.args, shallow_file);
 	}
-	argv[ac++] = "rev-list";
-	argv[ac++] = "--objects";
-	argv[ac++] = "--stdin";
-	argv[ac++] = "--not";
-	argv[ac++] = "--all";
-	argv[ac++] = "--quiet";
-	argv[ac] = NULL;
+	argv_array_push(&rev_list.args,"rev-list");
+	argv_array_push(&rev_list.args, "--objects");
+	argv_array_push(&rev_list.args, "--stdin");
+	argv_array_push(&rev_list.args, "--not");
+	argv_array_push(&rev_list.args, "--all");
+	argv_array_push(&rev_list.args, "--quiet");
 
-	rev_list.argv = argv;
 	rev_list.git_cmd = 1;
 	rev_list.in = -1;
 	rev_list.no_stdout = 1;
-- 
2.9.1.434.g748be50

