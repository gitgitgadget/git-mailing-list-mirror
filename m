Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779CEC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4822320719
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgCZIGq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:06:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:51840 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726590AbgCZIGq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 04:06:46 -0400
Received: (qmail 647 invoked by uid 109); 26 Mar 2020 08:06:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Mar 2020 08:06:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12042 invoked by uid 111); 26 Mar 2020 08:16:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2020 04:16:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Mar 2020 04:06:45 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] Makefile: avoid running curl-config multiple times
Message-ID: <20200326080645.GA2200716@coredump.intra.peff.net>
References: <20200326080540.GA2200522@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200326080540.GA2200522@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the user hasn't set the CURL_LDFLAGS Makefile variable, we invoke
curl-config like this:

  CURL_LIBCURL += $(shell $(CURL_CONFIG) --libs)

Because the shell function is run when the value is expanded, we invoke
curl-config each time we need to link something (which generally ends up
being four times for a full build).

Instead, let's use an immediate Makefile variable, which only needs
expanding once. We can't combine that with the existing "+=", but since
we only do this when CURL_LDFLAGS is undefined, we can just set that
variable.

That also allows us to simplify our conditional a bit, since both sides
will then put the result into CURL_LIBCURL. While we're touching it,
let's fix the indentation to match the nearby code (we're inside an
outer conditional, so everything else is indented one level).

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index a5961113d8..93a8ef3a72 100644
--- a/Makefile
+++ b/Makefile
@@ -1365,11 +1365,10 @@ else
 		CURL_LIBCURL =
 	endif
 
-ifdef CURL_LDFLAGS
+	ifndef CURL_LDFLAGS
+		CURL_LDFLAGS := $(shell $(CURL_CONFIG) --libs)
+	endif
 	CURL_LIBCURL += $(CURL_LDFLAGS)
-else
-	CURL_LIBCURL += $(shell $(CURL_CONFIG) --libs)
-endif
 
 	REMOTE_CURL_PRIMARY = git-remote-http$X
 	REMOTE_CURL_ALIASES = git-remote-https$X git-remote-ftp$X git-remote-ftps$X
-- 
2.26.0.576.gb87790c3c1

