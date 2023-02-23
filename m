Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A52C636D6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 10:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjBWKyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 05:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjBWKym (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 05:54:42 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273F06194
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 02:54:30 -0800 (PST)
Received: (qmail 24829 invoked by uid 109); 23 Feb 2023 10:54:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Feb 2023 10:54:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20124 invoked by uid 111); 23 Feb 2023 10:54:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 05:54:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 05:54:02 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 05/16] t5551: lower-case headers in expected curl trace
Message-ID: <Y/dFyjOAliTgOHYV@coredump.intra.peff.net>
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's a test in t5551 which checks the curl trace (after simplifying
it a bit). It doesn't work with HTTP/2, because in that case curl
outputs all of the headers in lower-case. Even though this test is run
with HTTP/2 by t5559, nobody has noticed because checking the trace only
happens if GIT_TEST_PROTOCOL_VERSION is manually set to "0".

Let's fix this by lower-casing all of the header names in the trace, and
then checking for those in our expected code (this is easier than making
HTTP/2 traces look like HTTP/1.1, since HTTP/1.1 uses title-casing).

Sadly, we can't quite do this in our existing sed script. This works if
you have GNU sed:

  s/^\\([><]\\) \\([A-Za-z0-9-]*:\\)/\1 \L\2\E/

but \L is a GNU-ism, and I don't think there's a portable solution. We
could just "tr A-Z a-z" on the way in, of course, but that makes the
non-header parts harder to read (e.g., lowercase "post" requests). But
to paraphrase Baron Munchausen, I have learned from experience that a
modicum of Perl can be most efficacious.

Note that this doesn't quite get the test passing with t5559; there are
more fixes needed on top.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5551-http-fetch-smart.sh | 55 ++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 29d489768e..a81f852cbf 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -35,30 +35,35 @@ setup_askpass_helper
 test_expect_success 'clone http repository' '
 	cat >exp <<-\EOF &&
 	> GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
-	> Accept: */*
-	> Accept-Encoding: ENCODINGS
-	> Accept-Language: ko-KR, *;q=0.9
-	> Pragma: no-cache
+	> accept: */*
+	> accept-encoding: ENCODINGS
+	> accept-language: ko-KR, *;q=0.9
+	> pragma: no-cache
 	< HTTP/1.1 200 OK
-	< Pragma: no-cache
-	< Cache-Control: no-cache, max-age=0, must-revalidate
-	< Content-Type: application/x-git-upload-pack-advertisement
+	< pragma: no-cache
+	< cache-control: no-cache, max-age=0, must-revalidate
+	< content-type: application/x-git-upload-pack-advertisement
 	> POST /smart/repo.git/git-upload-pack HTTP/1.1
-	> Accept-Encoding: ENCODINGS
-	> Content-Type: application/x-git-upload-pack-request
-	> Accept: application/x-git-upload-pack-result
-	> Accept-Language: ko-KR, *;q=0.9
-	> Content-Length: xxx
+	> accept-encoding: ENCODINGS
+	> content-type: application/x-git-upload-pack-request
+	> accept: application/x-git-upload-pack-result
+	> accept-language: ko-KR, *;q=0.9
+	> content-length: xxx
 	< HTTP/1.1 200 OK
-	< Pragma: no-cache
-	< Cache-Control: no-cache, max-age=0, must-revalidate
-	< Content-Type: application/x-git-upload-pack-result
+	< pragma: no-cache
+	< cache-control: no-cache, max-age=0, must-revalidate
+	< content-type: application/x-git-upload-pack-result
 	EOF
 
 	GIT_TRACE_CURL=true GIT_TEST_PROTOCOL_VERSION=0 LANGUAGE="ko_KR.UTF-8" \
 		git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
 	test_cmp file clone/file &&
 	tr '\''\015'\'' Q <err |
+	perl -pe '\''
+		s/(Send|Recv) header: ([A-Za-z0-9-]+):/
+		"$1 header: " . lc($2) . ":"
+		/e;
+	'\'' |
 	sed -e "
 		s/Q\$//
 		/^[*] /d
@@ -78,31 +83,31 @@ test_expect_success 'clone http repository' '
 			s/^/> /
 		}
 
-		/^> User-Agent: /d
-		/^> Host: /d
+		/^> user-agent: /d
+		/^> host: /d
 		/^> POST /,$ {
 			/^> Accept: [*]\\/[*]/d
 		}
-		s/^> Content-Length: .*/> Content-Length: xxx/
+		s/^> content-length: .*/> content-length: xxx/
 		/^> 00..want /d
 		/^> 00.*done/d
 
-		/^< Server: /d
-		/^< Expires: /d
-		/^< Date: /d
-		/^< Content-Length: /d
-		/^< Transfer-Encoding: /d
+		/^< server: /d
+		/^< expires: /d
+		/^< date: /d
+		/^< content-length: /d
+		/^< transfer-encoding: /d
 	" >actual &&
 
 	# NEEDSWORK: If the overspecification of the expected result is reduced, we
 	# might be able to run this test in all protocol versions.
 	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
 	then
-		sed -e "s/^> Accept-Encoding: .*/> Accept-Encoding: ENCODINGS/" \
+		sed -e "s/^> accept-encoding: .*/> accept-encoding: ENCODINGS/" \
 				actual >actual.smudged &&
 		test_cmp exp actual.smudged &&
 
-		grep "Accept-Encoding:.*gzip" actual >actual.gzip &&
+		grep "accept-encoding:.*gzip" actual >actual.gzip &&
 		test_line_count = 2 actual.gzip
 	fi
 '
-- 
2.39.2.981.g6157336f25

