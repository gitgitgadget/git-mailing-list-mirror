Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ADAD1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 19:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfBFTTB (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 14:19:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:34956 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726792AbfBFTTB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 14:19:01 -0500
Received: (qmail 12857 invoked by uid 109); 6 Feb 2019 19:19:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Feb 2019 19:19:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4584 invoked by uid 111); 6 Feb 2019 19:19:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Feb 2019 14:19:09 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2019 14:18:58 -0500
Date:   Wed, 6 Feb 2019 14:18:58 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: [PATCH 2/3] remote-curl: tighten "version 2" check for smart-http
Message-ID: <20190206191858.GB10893@sigill.intra.peff.net>
References: <20190206191657.GE10231@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190206191657.GE10231@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a v2 smart-http conversation, the server should reply to our initial
request with a pkt-line saying "version 2". We check that with
starts_with(), but really that should be the only thing in that packet.
A response of "version 20" should not match.

Let's tighten this check to use strcmp(). Note that we don't need to
worry about a trailing newline here, because the ptk-line code will have
chomped it for us already.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index c78ba83744..bb7421023b 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -374,7 +374,7 @@ static void check_smart_http(struct discovery *d, const char *service,
 		d->len = reader.src_len;
 		d->proto_git = 1;
 
-	} else if (starts_with(reader.line, "version 2")) {
+	} else if (!strcmp(reader.line, "version 2")) {
 		/*
 		 * v2 smart http; do not consume version packet, which will
 		 * be handled elsewhere.
-- 
2.20.1.1122.g2972e48916

