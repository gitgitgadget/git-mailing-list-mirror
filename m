Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1FAC636D7
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 10:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjBWKvj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 05:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjBWKvi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 05:51:38 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095A84DE07
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 02:51:36 -0800 (PST)
Received: (qmail 24780 invoked by uid 109); 23 Feb 2023 10:51:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Feb 2023 10:51:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20113 invoked by uid 111); 23 Feb 2023 10:51:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 05:51:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 05:51:35 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 03/16] t5541: simplify and move "no empty path components"
 test
Message-ID: <Y/dFN4GuCjqpIi2O@coredump.intra.peff.net>
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 9ee6bcd398 (t5541-http-push: add test for URLs with trailing
slash, 2010-04-08) added a test that clones a URL with a trailing slash,
and confirms that we don't send a doubled slash (like "$url//info/refs")
to the server.

But this test makes no sense in t5541, which is about pushing. It should
have been added in t5551. Let's move it there.

But putting it at the end is tricky, since it checks the entire contents
of the Apache access log. We could get around this by clearing the log
before our test. But there's an even simpler solution: just make sure no
doubled slashes appear in the log (fortunately, "http://" does not
appear in the log itself).

As a bonus, this also lets us drop the check for the v0 protocol (which
is otherwise necessary since v2 makes multiple requests, and
check_access_log insists on exactly matching the number of requests,
even though we don't care about that here).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5541-http-push-smart.sh  | 18 ------------------
 t/t5551-http-fetch-smart.sh |  9 +++++++++
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index f8bf533c33..d0211cd8be 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -36,24 +36,6 @@ test_expect_success 'setup remote repository' '
 
 setup_askpass_helper
 
-cat >exp <<EOF
-GET  /smart/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
-POST /smart/test_repo.git/git-upload-pack HTTP/1.1 200
-EOF
-test_expect_success 'no empty path components' '
-	# In the URL, add a trailing slash, and see if git appends yet another
-	# slash.
-	cd "$ROOT_PATH" &&
-	git clone $HTTPD_URL/smart/test_repo.git/ test_repo_clone &&
-
-	# NEEDSWORK: If the overspecification of the expected result is reduced, we
-	# might be able to run this test in all protocol versions.
-	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
-	then
-		check_access_log exp
-	fi
-'
-
 test_expect_success 'clone remote repository' '
 	rm -rf test_repo_clone &&
 	git clone $HTTPD_URL/smart/test_repo.git test_repo_clone &&
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index bc0719a4fc..10b7e7cda2 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -666,4 +666,13 @@ test_expect_success 'push warns or fails when using username:password' '
 	test_line_count -ge 1 warnings
 '
 
+test_expect_success 'no empty path components' '
+	# In the URL, add a trailing slash, and see if git appends yet another
+	# slash.
+	git clone $HTTPD_URL/smart/repo.git/ clone-with-slash &&
+
+	strip_access_log >log &&
+	! grep "//" log
+'
+
 test_done
-- 
2.39.2.981.g6157336f25

