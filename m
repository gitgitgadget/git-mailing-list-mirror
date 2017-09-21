Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7328220281
	for <e@80x24.org>; Thu, 21 Sep 2017 06:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbdIUGX1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 02:23:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:45718 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751484AbdIUGX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 02:23:26 -0400
Received: (qmail 6047 invoked by uid 109); 21 Sep 2017 06:23:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 06:23:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20058 invoked by uid 111); 21 Sep 2017 06:24:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 02:24:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Sep 2017 02:23:24 -0400
Date:   Thu, 21 Sep 2017 02:23:24 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/4] curl_trace(): eliminate switch fallthrough
Message-ID: <20170921062324.ehlfvyng7e62eoti@sigill.intra.peff.net>
References: <20170921062043.la2f3pjsnojirzyw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170921062043.la2f3pjsnojirzyw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our trace handler is called by curl with a curl_infotype
variable to interpret its data field. For most types we
print the data and then break out of the switch. But for
CURLINFO_TEXT, we print data and then fall through to the
"default" case, which does the exact same thing (nothing!)
that breaking out of the switch would.

This is probably a leftover from an early iteration of the
patch where the code after the switch _did_ do something
interesting that was unique to the non-text case arms.
But in its current form, this fallthrough is merely
confusing (and causes gcc's -Wimplicit-fallthrough to
complain).

Let's make CURLINFO_TEXT like the other case arms, and push
the default arm to the end where it's more obviously a
catch-all.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index 9e40a465fd..713525f38e 100644
--- a/http.c
+++ b/http.c
@@ -638,9 +638,7 @@ static int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size,
 	switch (type) {
 	case CURLINFO_TEXT:
 		trace_printf_key(&trace_curl, "== Info: %s", data);
-	default:		/* we ignore unknown types by default */
-		return 0;
-
+		break;
 	case CURLINFO_HEADER_OUT:
 		text = "=> Send header";
 		curl_dump_header(text, (unsigned char *)data, size, DO_FILTER);
@@ -665,6 +663,9 @@ static int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size,
 		text = "<= Recv SSL data";
 		curl_dump_data(text, (unsigned char *)data, size);
 		break;
+
+	default:		/* we ignore unknown types by default */
+		return 0;
 	}
 	return 0;
 }
-- 
2.14.1.1051.g8c9143ec35

