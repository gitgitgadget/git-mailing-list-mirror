Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8512520958
	for <e@80x24.org>; Tue, 21 Mar 2017 01:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755352AbdCUBcN (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 21:32:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:48325 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755478AbdCUBcM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 21:32:12 -0400
Received: (qmail 10973 invoked by uid 109); 21 Mar 2017 01:30:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 01:30:45 +0000
Received: (qmail 9937 invoked by uid 111); 21 Mar 2017 01:30:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 21:30:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 21:30:41 -0400
Date:   Mon, 20 Mar 2017 21:30:41 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/6] prefix_filename: simplify windows #ifdef
Message-ID: <20170321013040.cl42hlrtwix6qa23@sigill.intra.peff.net>
References: <20170321011838.rdhnbfwbigm4s4e3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170321011838.rdhnbfwbigm4s4e3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The prefix_filename function used to do an early return when
there was no prefix on non-Windows platforms, but always
allocated on Windows so that it could call convert_slashes().

Now that the function always allocates, we can unify the
logic and make convert_slashes() the only conditional part.

Signed-off-by: Jeff King <peff@peff.net>
---
I wondered here if a compiler might complain about the dead assignment
to pfx_len in the is_absolute_path() conditional. On Windows, that's
used as an offset for calling into convert_slashes(), but on other
platforms we never look at it again.

However, neither gcc nor clang complained, so I'm inclined to go with
what I have here.

 abspath.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/abspath.c b/abspath.c
index 4addd1fde..7f1cfe979 100644
--- a/abspath.c
+++ b/abspath.c
@@ -251,18 +251,15 @@ char *prefix_filename(const char *pfx, const char *arg)
 	struct strbuf path = STRBUF_INIT;
 	size_t pfx_len = pfx ? strlen(pfx) : 0;
 
-#ifndef GIT_WINDOWS_NATIVE
-	if (!pfx_len || is_absolute_path(arg))
-		return xstrdup(arg);
-	strbuf_add(&path, pfx, pfx_len);
-	strbuf_addstr(&path, arg);
-#else
-	/* don't add prefix to absolute paths, but still replace '\' by '/' */
-	if (is_absolute_path(arg))
+	if (!pfx_len)
+		; /* nothing to prefix */
+	else if (is_absolute_path(arg))
 		pfx_len = 0;
-	else if (pfx_len)
+	else
 		strbuf_add(&path, pfx, pfx_len);
+
 	strbuf_addstr(&path, arg);
+#ifdef GIT_WINDOWS_NATIVE
 	convert_slashes(path.buf + pfx_len);
 #endif
 	return strbuf_detach(&path, NULL);
-- 
2.12.1.683.gcd02edfec

