Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAB6C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 10:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjBWKt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 05:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjBWKtv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 05:49:51 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A68F4BE98
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 02:49:49 -0800 (PST)
Received: (qmail 24738 invoked by uid 109); 23 Feb 2023 10:49:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Feb 2023 10:49:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20078 invoked by uid 111); 23 Feb 2023 10:49:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 05:49:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 05:49:47 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 01/16] t5541: run "used receive-pack service" test earlier
Message-ID: <Y/dEy0m6gUgI3Bzn@coredump.intra.peff.net>
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's a test in t5541 that confirms that "git push" makes two requests
(a GET to /info/refs, and a POST to /git-receive-pack). However, it's a
noop unless GIT_TEST_PROTOCOL_VERSION is set to "0", due to 8a1b0978ab
(test: request GIT_TEST_PROTOCOL_VERSION=0 when appropriate,
2019-12-23).

This means that almost nobody runs it. And indeed, it has been broken
since b0c4adcdd7 (remote-curl: send Accept-Language header to server,
2022-07-11). But the fault is not in that commit, but in how brittle the
test is. It runs after several operations have been performed, which
means that it expects to see the complete set of requests made so far in
the script. Commit b0c4adcdd7 added a new test, which means that the
"used receive-pack service" test must be updated, too.

Let's fix this by making the test less brittle. We'll move it higher in
the script, right after the first push has completed. And we'll clear
the access log right before doing the push, so we'll see only the
requests from that command.

This is technically testing less, in that we won't check that all of
those other requests also correctly used smart http. But there's no
particular reason think that if the first one did, the others wouldn't.

After this patch, running:

  GIT_TEST_PROTOCOL_VERSION=0 ./t5541-http-push-smart.sh

passes, whereas it did not before.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5541-http-push-smart.sh | 44 ++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index fbad2d5ff5..ef39d14ed2 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -41,10 +41,6 @@ GET  /smart/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 POST /smart/test_repo.git/git-upload-pack HTTP/1.1 200
 EOF
 test_expect_success 'no empty path components' '
-	# Clear the log, so that it does not affect the "used receive-pack
-	# service" test which reads the log too.
-	test_when_finished ">\"\$HTTPD_ROOT_PATH\"/access.log" &&
-
 	# In the URL, add a trailing slash, and see if git appends yet another
 	# slash.
 	cd "$ROOT_PATH" &&
@@ -67,6 +63,10 @@ test_expect_success 'clone remote repository' '
 '
 
 test_expect_success 'push to remote repository (standard)' '
+	# Clear the log, so that the "used receive-pack service" test below
+	# sees just what we did here.
+	>"$HTTPD_ROOT_PATH"/access.log &&
+
 	cd "$ROOT_PATH"/test_repo_clone &&
 	: >path2 &&
 	git add path2 &&
@@ -80,6 +80,20 @@ test_expect_success 'push to remote repository (standard)' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
+test_expect_success 'used receive-pack service' '
+	cat >exp <<-\EOF &&
+	GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
+	POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
+	EOF
+
+	# NEEDSWORK: If the overspecification of the expected result is reduced, we
+	# might be able to run this test in all protocol versions.
+	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
+	then
+		check_access_log exp
+	fi
+'
+
 test_expect_success 'push to remote repository (standard) with sending Accept-Language' '
 	cat >exp <<-\EOF &&
 	=> Send header: Accept-Language: ko-KR, *;q=0.9
@@ -141,28 +155,6 @@ test_expect_success 'rejected update prints status' '
 '
 rm -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
 
-cat >exp <<EOF
-GET  /smart/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
-POST /smart/test_repo.git/git-upload-pack HTTP/1.1 200
-GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
-GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
-GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
-GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
-EOF
-test_expect_success 'used receive-pack service' '
-	# NEEDSWORK: If the overspecification of the expected result is reduced, we
-	# might be able to run this test in all protocol versions.
-	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
-	then
-		check_access_log exp
-	fi
-'
-
 test_http_push_nonff "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
 	"$ROOT_PATH"/test_repo_clone main 		success
 
-- 
2.39.2.981.g6157336f25

