Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86316C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 11:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjBWLIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 06:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbjBWLIo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 06:08:44 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F16E3755A
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 03:08:42 -0800 (PST)
Received: (qmail 25113 invoked by uid 109); 23 Feb 2023 11:08:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Feb 2023 11:08:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20291 invoked by uid 111); 23 Feb 2023 11:08:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 06:08:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 06:08:41 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 16/16] t5559: make SSL/TLS the default
Message-ID: <Y/dJOa2k6HEIq6oD@coredump.intra.peff.net>
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The point of t5559 is run the regular t5551 tests with HTTP/2. But it
does so with the "h2c" protocol, which uses cleartext upgrades from
HTTP/1.1 to HTTP/2 (rather than learning about HTTP/2 support during the
TLS negotiation).

This has a few problems:

 - it's not very indicative of the real world. In practice, most servers
   that support HTTP/2 will also support TLS.

 - support for upgrading does not seem as robust. In particular, we've
   run into bugs in some versions of Apache's mod_http2 that trigger
   only with the upgrade mode. See:

     https://lore.kernel.org/git/Y8ztIqYgVCPILJlO@coredump.intra.peff.net/

So the upside is that this change makes our HTTP/2 tests more robust and
more realistic. The downside is that if we can't set up SSL for any
reason, we'll skip the tests (even though you _might_ have been able to
run the HTTP/2 tests the old way). We could probably have a conditional
fallback, but it would be complicated for little gain, and it's not even
clear it would help (i.e., would any test environment even have HTTP/2
but not SSL support?).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5559-http-fetch-smart-http2.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5559-http-fetch-smart-http2.sh b/t/t5559-http-fetch-smart-http2.sh
index 9eece71c2c..54aa9d3bff 100755
--- a/t/t5559-http-fetch-smart-http2.sh
+++ b/t/t5559-http-fetch-smart-http2.sh
@@ -1,4 +1,5 @@
 #!/bin/sh
 
 HTTP_PROTO=HTTP/2
+LIB_HTTPD_SSL=1
 . ./t5551-http-fetch-smart.sh
-- 
2.39.2.981.g6157336f25
