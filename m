Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2115B2018F
	for <e@80x24.org>; Fri, 15 Jul 2016 10:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbcGOKcI (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 06:32:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:45308 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932275AbcGOKcH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 06:32:07 -0400
Received: (qmail 18147 invoked by uid 102); 15 Jul 2016 10:32:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:32:05 -0400
Received: (qmail 14328 invoked by uid 107); 15 Jul 2016 10:32:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:32:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2016 06:32:03 -0400
Date:	Fri, 15 Jul 2016 06:32:03 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH 05/12] check_connected: relay errors to alternate descriptor
Message-ID: <20160715103203.GE19271@sigill.intra.peff.net>
References: <20160715102506.GA23164@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160715102506.GA23164@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Unless the "quiet" flag is given, check_connected sends any
errors to the stderr of the caller (because the child
rev-list inherits that descriptor). However, server-side
callers may want to send these over a sideband channel
instead.  Let's make that possible.

Signed-off-by: Jeff King <peff@peff.net>
---
 connected.c | 11 +++++++++--
 connected.h |  7 +++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/connected.c b/connected.c
index 2a51eac..5f5c8bd 100644
--- a/connected.c
+++ b/connected.c
@@ -31,8 +31,11 @@ int check_connected(sha1_iterate_fn fn, void *cb_data,
 		opt = &defaults;
 	transport = opt->transport;
 
-	if (fn(cb_data, sha1))
+	if (fn(cb_data, sha1)) {
+		if (opt->err_fd)
+			close(opt->err_fd);
 		return err;
+	}
 
 	if (transport && transport->smart_options &&
 	    transport->smart_options->self_contained_and_connected &&
@@ -59,7 +62,11 @@ int check_connected(sha1_iterate_fn fn, void *cb_data,
 	rev_list.git_cmd = 1;
 	rev_list.in = -1;
 	rev_list.no_stdout = 1;
-	rev_list.no_stderr = opt->quiet;
+	if (opt->err_fd)
+		rev_list.err = opt->err_fd;
+	else
+		rev_list.no_stderr = opt->quiet;
+
 	if (start_command(&rev_list))
 		return error(_("Could not run 'git rev-list'"));
 
diff --git a/connected.h b/connected.h
index 12594ef..5d88e26 100644
--- a/connected.h
+++ b/connected.h
@@ -23,6 +23,13 @@ struct check_connected_options {
 
 	/* Transport whose objects we are checking, if available. */
 	struct transport *transport;
+
+	/*
+	 * If non-zero, send error messages to this descriptor rather
+	 * than stderr. The descriptor is closed before check_connected
+	 * returns.
+	 */
+	int err_fd;
 };
 
 #define CHECK_CONNECTED_INIT { 0 }
-- 
2.9.1.434.g748be50

