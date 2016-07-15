Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EEBA2018F
	for <e@80x24.org>; Fri, 15 Jul 2016 10:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbcGOKgT (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 06:36:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:45324 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932187AbcGOKgR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 06:36:17 -0400
Received: (qmail 18342 invoked by uid 102); 15 Jul 2016 10:36:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:36:17 -0400
Received: (qmail 14412 invoked by uid 107); 15 Jul 2016 10:36:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:36:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2016 06:36:14 -0400
Date:	Fri, 15 Jul 2016 06:36:14 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH 10/12] receive-pack: relay connectivity errors to sideband
Message-ID: <20160715103614.GJ19271@sigill.intra.peff.net>
References: <20160715102506.GA23164@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160715102506.GA23164@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

If the connectivity check encounters a problem when
receiving a push, the error output goes to receive-pack's
stderr, whose destination depends on the protocol used
(ssh tends to send it to the user, though without a "remote"
prefix; http will generally eat it in the server's error
log).

The information should consistently go back to the user, as
there is a reasonable chance their client is buggy and
generating a bad pack.

We can do so by muxing it over the sideband as we do with
other sub-process stderr.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index de322bc..d309109 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1317,9 +1317,12 @@ static void execute_commands(struct command *commands,
 			     const char *unpacker_error,
 			     struct shallow_info *si)
 {
+	struct check_connected_options opt = CHECK_CONNECTED_INIT;
 	struct command *cmd;
 	unsigned char sha1[20];
 	struct iterate_data data;
+	struct async muxer;
+	int err_fd = 0;
 
 	if (unpacker_error) {
 		for (cmd = commands; cmd; cmd = cmd->next)
@@ -1327,11 +1330,24 @@ static void execute_commands(struct command *commands,
 		return;
 	}
 
+	if (use_sideband) {
+		memset(&muxer, 0, sizeof(muxer));
+		muxer.proc = copy_to_sideband;
+		muxer.in = -1;
+		if (!start_async(&muxer))
+			err_fd = muxer.in;
+		/* ...else, continue without relaying sideband */
+	}
+
 	data.cmds = commands;
 	data.si = si;
-	if (check_connected(iterate_receive_command_list, &data, NULL))
+	opt.err_fd = err_fd;
+	if (check_connected(iterate_receive_command_list, &data, &opt))
 		set_connectivity_errors(commands, si);
 
+	if (use_sideband)
+		finish_async(&muxer);
+
 	reject_updates_to_hidden(commands);
 
 	if (run_receive_hook(commands, "pre-receive", 0)) {
-- 
2.9.1.434.g748be50

