Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 707011FF6D
	for <e@80x24.org>; Thu,  1 Dec 2016 09:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758528AbcLAJEu (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 04:04:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:49667 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758201AbcLAJEm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 04:04:42 -0500
Received: (qmail 4986 invoked by uid 109); 1 Dec 2016 09:04:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 09:04:24 +0000
Received: (qmail 30688 invoked by uid 111); 1 Dec 2016 09:05:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 04:05:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 04:04:22 -0500
Date:   Thu, 1 Dec 2016 04:04:22 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>
Subject: [PATCH 3/6] remote-curl: rename shadowed options variable
Message-ID: <20161201090422.wzyquf4swsv33ti6@sigill.intra.peff.net>
References: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The discover_refs() function has a local "options" variable
to hold the http_get_options we pass to http_get_strbuf().
But this shadows the global "struct options" that holds our
program-level options, which cannot be accessed from this
function.

Let's give the local one a more descriptive name so we can
tell the two apart.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index f14c41f4c..f4145fd5c 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -274,7 +274,7 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	struct strbuf effective_url = STRBUF_INIT;
 	struct discovery *last = last_discovery;
 	int http_ret, maybe_smart = 0;
-	struct http_get_options options;
+	struct http_get_options http_options;
 
 	if (last && !strcmp(service, last->service))
 		return last;
@@ -291,15 +291,15 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		strbuf_addf(&refs_url, "service=%s", service);
 	}
 
-	memset(&options, 0, sizeof(options));
-	options.content_type = &type;
-	options.charset = &charset;
-	options.effective_url = &effective_url;
-	options.base_url = &url;
-	options.no_cache = 1;
-	options.keep_error = 1;
+	memset(&http_options, 0, sizeof(http_options));
+	http_options.content_type = &type;
+	http_options.charset = &charset;
+	http_options.effective_url = &effective_url;
+	http_options.base_url = &url;
+	http_options.no_cache = 1;
+	http_options.keep_error = 1;
 
-	http_ret = http_get_strbuf(refs_url.buf, &buffer, &options);
+	http_ret = http_get_strbuf(refs_url.buf, &buffer, &http_options);
 	switch (http_ret) {
 	case HTTP_OK:
 		break;
-- 
2.11.0.319.g1f4e1e0

