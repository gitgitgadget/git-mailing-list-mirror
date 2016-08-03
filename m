Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 300261F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 23:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758398AbcHCXC4 (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 19:02:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:54418 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751867AbcHCXCy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 19:02:54 -0400
Received: (qmail 22854 invoked by uid 102); 3 Aug 2016 23:01:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 19:01:07 -0400
Received: (qmail 8016 invoked by uid 107); 3 Aug 2016 23:01:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 19:01:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 19:01:04 -0400
Date:	Wed, 3 Aug 2016 19:01:04 -0400
From:	Jeff King <peff@peff.net>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org
Subject: [PATCH 6/7] trace: disable key after write error
Message-ID: <20160803230103.daexq233ufrttnmn@sigill.intra.peff.net>
References: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

If we get a write error writing to a trace descriptor, the
error isn't likely to go away if we keep writing. Instead,
you'll just get the same error over and over. E.g., try:

  GIT_TRACE_PACKET=42 git ls-remote >/dev/null

You don't really need to see:

  warning: unable to write trace for GIT_TRACE_PACKET: Bad file descriptor

hundreds of times. We could fallback to tracing to stderr,
as we do in the error code-path for open(), but there's not
much point. If the user fed us a bogus descriptor, they're
probably better off fixing their invocation. And if they
didn't, and we saw a transient error (e.g., ENOSPC writing
to a file), it probably doesn't help anybody to have half of
the trace in a file, and half on stderr.

Signed-off-by: Jeff King <peff@peff.net>
---
 trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/trace.c b/trace.c
index 4efb256..083eb98 100644
--- a/trace.c
+++ b/trace.c
@@ -134,6 +134,7 @@ static void trace_write(struct trace_key *key, const void *buf, unsigned len)
 		normalize_trace_key(&key);
 		warning("unable to write trace for %s: %s",
 			key->key, strerror(errno));
+		trace_disable(key);
 	}
 }
 
-- 
2.9.2.670.g42e63de

