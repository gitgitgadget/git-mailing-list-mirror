Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE8FC61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 11:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjBWLHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 06:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjBWLHl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 06:07:41 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C749D532B1
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 03:07:30 -0800 (PST)
Received: (qmail 25095 invoked by uid 109); 23 Feb 2023 11:07:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Feb 2023 11:07:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20284 invoked by uid 111); 23 Feb 2023 11:07:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 06:07:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 06:07:29 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 15/16] t5559: fix test failures with LIB_HTTPD_SSL
Message-ID: <Y/dI8UEP0DFqqB1Q@coredump.intra.peff.net>
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One test needs to be tweaked in order for t5559 to pass with SSL/TLS set
up. When we make our initial clone, we check that the curl trace of
requests is what we expected. But we need to fix two things:

  - along with ignoring "data" lines from the trace, we need to ignore
    "SSL data" lines

  - when TLS is used, the server is able to tell the client (via ALPN)
    that it supports HTTP/2 before the first HTTP request is made. So
    rather than request an upgrade using an HTTP header, it can just
    speak HTTP/2 immediately

With this patch, running:

  LIB_HTTPD_SSL=1 ./t5559-http-fetch-smart-http2.sh

works, whereas it did not before.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5551-http-fetch-smart.sh | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 13b38c7ef5..0908534f25 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -33,8 +33,19 @@ test_expect_success 'create http-accessible bare repository' '
 setup_askpass_helper
 
 test_expect_success 'clone http repository' '
+	if test_have_prereq HTTP2 && test "$HTTPD_PROTO" = "https"
+	then
+		# ALPN lets us immediately use HTTP/2; likewise, POSTs with
+		# bodies can use it because they do not need to upgrade
+		INITIAL_PROTO=HTTP/2
+	else
+		# either we are not using HTTP/2, or the initial
+		# request is sent via HTTP/1.1 and asks for upgrade
+		INITIAL_PROTO=HTTP/1.1
+	fi &&
+
 	cat >exp.raw <<-EOF &&
-	> GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
+	> GET /smart/repo.git/info/refs?service=git-upload-pack $INITIAL_PROTO
 	> accept: */*
 	> accept-encoding: ENCODINGS
 	> accept-language: ko-KR, *;q=0.9
@@ -44,25 +55,25 @@ test_expect_success 'clone http repository' '
 	< pragma: no-cache
 	< cache-control: no-cache, max-age=0, must-revalidate
 	< content-type: application/x-git-upload-pack-advertisement
-	> POST /smart/repo.git/git-upload-pack HTTP/1.1
+	> POST /smart/repo.git/git-upload-pack $INITIAL_PROTO
 	> accept-encoding: ENCODINGS
 	> content-type: application/x-git-upload-pack-request
 	> accept: application/x-git-upload-pack-result
 	> accept-language: ko-KR, *;q=0.9
 	{V2} > git-protocol: version=2
 	> content-length: xxx
-	< HTTP/1.1 200 OK
+	< $INITIAL_PROTO 200 OK
 	< pragma: no-cache
 	< cache-control: no-cache, max-age=0, must-revalidate
 	< content-type: application/x-git-upload-pack-result
-	{V2} > POST /smart/repo.git/git-upload-pack HTTP/1.1
+	{V2} > POST /smart/repo.git/git-upload-pack $INITIAL_PROTO
 	{V2} > accept-encoding: ENCODINGS
 	{V2} > content-type: application/x-git-upload-pack-request
 	{V2} > accept: application/x-git-upload-pack-result
 	{V2} > accept-language: ko-KR, *;q=0.9
 	{V2} > git-protocol: version=2
 	{V2} > content-length: xxx
-	{V2} < HTTP/1.1 200 OK
+	{V2} < $INITIAL_PROTO 200 OK
 	{V2} < pragma: no-cache
 	{V2} < cache-control: no-cache, max-age=0, must-revalidate
 	{V2} < content-type: application/x-git-upload-pack-result
@@ -96,6 +107,8 @@ test_expect_success 'clone http repository' '
 		s/= Recv header://
 		/^<= Recv data/d
 		/^=> Send data/d
+		/^<= Recv SSL data/d
+		/^=> Send SSL data/d
 		/^$/d
 		/^< $/d
 
-- 
2.39.2.981.g6157336f25

