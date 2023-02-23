Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D7BC61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 10:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjBWK7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 05:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjBWK7D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 05:59:03 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059DBA5FB
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 02:59:01 -0800 (PST)
Received: (qmail 24921 invoked by uid 109); 23 Feb 2023 10:59:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Feb 2023 10:59:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20168 invoked by uid 111); 23 Feb 2023 10:59:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 05:59:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 05:59:00 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 08/16] t5551: handle v2 protocol when checking curl trace
Message-ID: <Y/dG9D0wNuvA9ryK@coredump.intra.peff.net>
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After cloning an http repository, we check the curl trace to make sure
the expected requests were made. But since the expected trace was never
updated to handle v2, it is only run when you ask the test suite to run
in v0 mode (which hardly anybody does).

Let's update it to handle both protocols. This isn't too hard since v2
just sends an extra header and an extra request. So we can just annotate
those extra lines and strip them out for v0 (and drop the annotations
for v2). I didn't bother handling v1 here, as it's not really of
practical interest (it would drop the extra v2 request, but still have
the "git-protocol" lines).

There's a similar tweak needed at the end. Since we check the
"accept-encoding" value loosely, we grep for it rather than finding it
in the verbatim trace. This grep insists that there are exactly 2
matches, but of course in v2 with the extra request there are 3. We
could tweak the number, but it's simpler still to just check that we saw
at least one match. The verbatim check already confirmed how many
instances of the header we have; we're really just checking here that
"gzip" is in the value (it's possible, of course, that the headers could
have different values, but that seems like an unlikely bug).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5551-http-fetch-smart.sh | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 4191174584..9d99cefb92 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -33,12 +33,13 @@ test_expect_success 'create http-accessible bare repository' '
 setup_askpass_helper
 
 test_expect_success 'clone http repository' '
-	cat >exp <<-EOF &&
+	cat >exp.raw <<-EOF &&
 	> GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
 	> accept: */*
 	> accept-encoding: ENCODINGS
 	> accept-language: ko-KR, *;q=0.9
 	> pragma: no-cache
+	{V2} > git-protocol: version=2
 	< $HTTP_PROTO 200 OK
 	< pragma: no-cache
 	< cache-control: no-cache, max-age=0, must-revalidate
@@ -48,13 +49,32 @@ test_expect_success 'clone http repository' '
 	> content-type: application/x-git-upload-pack-request
 	> accept: application/x-git-upload-pack-result
 	> accept-language: ko-KR, *;q=0.9
+	{V2} > git-protocol: version=2
 	> content-length: xxx
 	< HTTP/1.1 200 OK
 	< pragma: no-cache
 	< cache-control: no-cache, max-age=0, must-revalidate
 	< content-type: application/x-git-upload-pack-result
+	{V2} > POST /smart/repo.git/git-upload-pack HTTP/1.1
+	{V2} > accept-encoding: ENCODINGS
+	{V2} > content-type: application/x-git-upload-pack-request
+	{V2} > accept: application/x-git-upload-pack-result
+	{V2} > accept-language: ko-KR, *;q=0.9
+	{V2} > git-protocol: version=2
+	{V2} > content-length: xxx
+	{V2} < HTTP/1.1 200 OK
+	{V2} < pragma: no-cache
+	{V2} < cache-control: no-cache, max-age=0, must-revalidate
+	{V2} < content-type: application/x-git-upload-pack-result
 	EOF
 
+	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
+	then
+		sed "/^{V2}/d" <exp.raw >exp
+	else
+		sed "s/^{V2} //" <exp.raw >exp
+	fi &&
+
 	GIT_TRACE_CURL=true LANGUAGE="ko_KR.UTF-8" \
 		git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
 	test_cmp file clone/file &&
@@ -107,17 +127,11 @@ test_expect_success 'clone http repository' '
 		/^< transfer-encoding: /d
 	" >actual &&
 
-	# NEEDSWORK: If the overspecification of the expected result is reduced, we
-	# might be able to run this test in all protocol versions.
-	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
-	then
-		sed -e "s/^> accept-encoding: .*/> accept-encoding: ENCODINGS/" \
-				actual >actual.smudged &&
-		test_cmp exp actual.smudged &&
+	sed -e "s/^> accept-encoding: .*/> accept-encoding: ENCODINGS/" \
+			actual >actual.smudged &&
+	test_cmp exp actual.smudged &&
 
-		grep "accept-encoding:.*gzip" actual >actual.gzip &&
-		test_line_count = 2 actual.gzip
-	fi
+	grep "accept-encoding:.*gzip" actual >actual.gzip
 '
 
 test_expect_success 'fetch changes via http' '
-- 
2.39.2.981.g6157336f25

