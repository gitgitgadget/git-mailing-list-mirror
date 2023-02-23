Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A076C636D6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 10:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjBWK4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 05:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjBWK4U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 05:56:20 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274A41BE9
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 02:56:18 -0800 (PST)
Received: (qmail 24870 invoked by uid 109); 23 Feb 2023 10:56:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Feb 2023 10:56:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20157 invoked by uid 111); 23 Feb 2023 10:56:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 05:56:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 05:56:17 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 06/16] t5551: handle HTTP/2 when checking curl trace
Message-ID: <Y/dGUXaYrp6AqMxB@coredump.intra.peff.net>
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We check that the curl trace of a clone has the lines we expect, but
this won't work when we run the test under t5559, because a few details
are different under HTTP/2 (but nobody noticed because it only happens
when you manually set GIT_TEST_PROTOCOL_VERSION to "0").

We can handle both HTTP protocols with a few tweaks:

  - we'll drop the HTTP "101 Switching Protocols" response, as well as
    various protocol upgrade headers. These details aren't interesting
    to us. We just want to make sure the correct protocol was used (and
    we do in the main request/response lines).

  - successful HTTP/2 responses just say "200" and not "200 OK"; we can
    normalize these

  - replace HTTP/1.1 with a variable in the request/response lines. We
    can use the existing $HTTP_PROTO for this, as it's already set to
    "HTTP/2" when appropriate. We do need to tweak the fallback value to
    "HTTP/1.1" to match what curl will write (prior to this patch, the
    fallback value didn't matter at all; we only checked if it was the
    literal string "HTTP/2").

Note that several lines still expect HTTP/1.1 unconditionally. The first
request does so because the client requests an upgrade during the
request. The POST request and response do so because you can't do an
upgrade if there is a request body. (This will all be different if we
trigger HTTP/2 via ALPN, but the tests aren't yet capable of that).

This is enough to let:

  GIT_TEST_PROTOCOL_VERSION=0 ./t5559-http-fetch-smart-http2.sh

pass the "clone http repository" test (but there are some other failures
later on).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5551-http-fetch-smart.sh | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index a81f852cbf..716c9dbb69 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-: ${HTTP_PROTO:=HTTP}
+: ${HTTP_PROTO:=HTTP/1.1}
 test_description="test smart fetching over http via http-backend ($HTTP_PROTO)"
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
@@ -33,13 +33,13 @@ test_expect_success 'create http-accessible bare repository' '
 setup_askpass_helper
 
 test_expect_success 'clone http repository' '
-	cat >exp <<-\EOF &&
+	cat >exp <<-EOF &&
 	> GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
 	> accept: */*
 	> accept-encoding: ENCODINGS
 	> accept-language: ko-KR, *;q=0.9
 	> pragma: no-cache
-	< HTTP/1.1 200 OK
+	< $HTTP_PROTO 200 OK
 	< pragma: no-cache
 	< cache-control: no-cache, max-age=0, must-revalidate
 	< content-type: application/x-git-upload-pack-advertisement
@@ -83,6 +83,14 @@ test_expect_success 'clone http repository' '
 			s/^/> /
 		}
 
+		/^< HTTP/ {
+			s/200$/200 OK/
+		}
+		/^< HTTP\\/1.1 101/d
+		/^[><] connection: /d
+		/^[><] upgrade: /d
+		/^> http2-settings: /d
+
 		/^> user-agent: /d
 		/^> host: /d
 		/^> POST /,$ {
-- 
2.39.2.981.g6157336f25

