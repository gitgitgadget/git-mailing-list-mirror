Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084F01F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 08:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeKPTAC (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 14:00:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:41818 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727398AbeKPTAC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 14:00:02 -0500
Received: (qmail 29201 invoked by uid 109); 16 Nov 2018 08:48:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 16 Nov 2018 08:48:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24930 invoked by uid 111); 16 Nov 2018 08:48:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 16 Nov 2018 03:48:01 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Nov 2018 03:48:38 -0500
Date:   Fri, 16 Nov 2018 03:48:38 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] remote-curl: tighten "version 2" check for smart-http
Message-ID: <20181116084838.GB31603@sigill.intra.peff.net>
References: <20181116084427.GA31493@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181116084427.GA31493@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a v2 smart-http conversation, the server should reply to our initial
request with a pkt-line saying "version 2" (this is the start of the
"capabilities advertisement"). We check for the string using
starts_with(), but that's overly permissive (it would match "version
20", for example).

Let's tighten this check to use strcmp(). Note that we don't need to
worry about a trailing newline here, because the ptk-line code will have
chomped it for us already.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index dd9bc41aa1..3c9c4a07c3 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -375,7 +375,7 @@ static void check_smart_http(struct discovery *d, const char *service,
 		d->len = src_len;
 		d->proto_git = 1;
 
-	} else if (starts_with(line, "version 2")) {
+	} else if (!strcmp(line, "version 2")) {
 		/*
 		 * v2 smart http; do not consume version packet, which will
 		 * be handled elsewhere.
-- 
2.19.1.1636.gc7a073d580

