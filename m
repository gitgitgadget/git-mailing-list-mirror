Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C24F1FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 14:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755511AbdCGOGT (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 09:06:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:39737 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755412AbdCGOGC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 09:06:02 -0500
Received: (qmail 19961 invoked by uid 109); 7 Mar 2017 13:38:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Mar 2017 13:38:53 +0000
Received: (qmail 25631 invoked by uid 111); 7 Mar 2017 13:39:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Mar 2017 08:39:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Mar 2017 08:38:51 -0500
Date:   Tue, 7 Mar 2017 08:38:51 -0500
From:   Jeff King <peff@peff.net>
To:     Horst Schirmeier <horst@schirmeier.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 5/6] send-pack: read "unpack" status even on pack-objects
 failure
Message-ID: <20170307133850.aaykcpuzlzqecz7x@sigill.intra.peff.net>
References: <20170307133437.qee2jtynbiwf6uzr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170307133437.qee2jtynbiwf6uzr@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the local pack-objects of a push fails, we'll tell the
user about it. But one likely cause is that the remote
index-pack stopped reading for some reason (because it
didn't like our input, or encountered another error). In
that case we'd expect the remote to report more details to
us via the "unpack ..." status line. However, the current
code just hangs up completely, and the user never sees it.

Instead, let's call receive_unpack_status(), which will
complain on stderr with whatever reason the remote told us.
Note that if our pack-objects fails because the connection
was severed or the remote just crashed entirely, then our
packet_read_line() call may fail with "the remote end hung
up unexpectedly". That's OK. It's a more accurate
description than what we get now (which is just "some refs
failed to push").

This should be safe from any deadlocks. At the point we make
this call we'll have closed the writing end of the
connection to the server (either by handing it off to
a pack-objects which exited, explicitly in the stateless_rpc
case, or by doing a half-duplex shutdown for a socket). So
there should be no chance that the other side is waiting
for the rest of our pack-objects input.

Signed-off-by: Jeff King <peff@peff.net>
---
 send-pack.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/send-pack.c b/send-pack.c
index 83c23aef6..e15232739 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -562,6 +562,14 @@ int send_pack(struct send_pack_args *args,
 				close(out);
 			if (git_connection_is_socket(conn))
 				shutdown(fd[0], SHUT_WR);
+
+			/*
+			 * Do not even bother with the return value; we know we
+			 * are failing, and just want the error() side effects.
+			 */
+			if (status_report)
+				receive_unpack_status(in);
+
 			if (use_sideband) {
 				close(demux.out);
 				finish_async(&demux);
-- 
2.12.0.429.gde83c8049

