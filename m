Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03EEC636D6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 11:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbjBWLG6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 06:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbjBWLG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 06:06:56 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC205329E
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 03:06:45 -0800 (PST)
Received: (qmail 25076 invoked by uid 109); 23 Feb 2023 11:06:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Feb 2023 11:06:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20276 invoked by uid 111); 23 Feb 2023 11:06:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 06:06:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 06:06:44 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 14/16] t/lib-httpd: enable HTTP/2 "h2" protocol, not just h2c
Message-ID: <Y/dIxHI9iB5KGOR5@coredump.intra.peff.net>
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 73c49a4474 (t: run t5551 tests with both HTTP and HTTP/2,
2022-11-11) added Apache config to enable HTTP/2. However, it only
enabled the "h2c" protocol, which allows cleartext HTTP/2 (generally
based on an upgrade header during an HTTP/1.1 request). This is what
t5559 is generally testing, since by default we don't set up SSL/TLS.

However, it should be possible to run t5559 with LIB_HTTPD_SSL set. In
that case, Apache will advertise support for HTTP/2 via ALPN during the
TLS handshake. But we need to tell it support "h2" (the non-cleartext
version) to do so. Without that, then curl does not even try to do the
HTTP/1.1 upgrade (presumably because after seeing that we did TLS but
didn't get the ALPN indicator, it assumes it would be fruitless).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd/apache.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 51a4fbcf62..693b75e0ae 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -31,7 +31,7 @@ ErrorLog error.log
 
 <IfDefine HTTP2>
 LoadModule http2_module modules/mod_http2.so
-Protocols h2c
+Protocols h2 h2c
 </IfDefine>
 
 <IfModule !mod_auth_basic.c>
-- 
2.39.2.981.g6157336f25

