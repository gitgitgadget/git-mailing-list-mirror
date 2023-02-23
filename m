Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D28C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 11:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjBWLCl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 06:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjBWLCg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 06:02:36 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D155D5457F
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 03:02:32 -0800 (PST)
Received: (qmail 24999 invoked by uid 109); 23 Feb 2023 11:02:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Feb 2023 11:02:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20235 invoked by uid 111); 23 Feb 2023 11:02:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 06:02:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 06:02:31 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 11/16] t5551: handle v2 protocol in cookie test
Message-ID: <Y/dHx146qUjob2oX@coredump.intra.peff.net>
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After making a request, we check that it stored the expected cookies.
This depends on the protocol version, because the cookies we store
depend on the exact requests we made (and for ls-remote, v2 will always
hit /git-upload-pack to get the refs, whereas v0 is happy with the
initial ref advertisement).

As a result, hardly anybody runs this test, as you'd have to manually
set GIT_TEST_PROTOCOL_VERSION=0 to do so.

Let's teach it to handle both protocol versions. One way to do this
would be to make the expectation conditional on the protocol used. But
there's a simpler solution. The reason that v0 doesn't hit
/git-upload-pack is that ls-remote doesn't fetch any objects. If we
instead do a fetch (making sure there's an actual object to grab), then
both v0 and v2 will hit the same endpoints and set the same cookies.

Note that we do have to clean up our new tag here; otherwise it confuses
the later "clone 2,000 tags" test.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5551-http-fetch-smart.sh | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 2f15a707d4..2e42271cb8 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -295,19 +295,22 @@ test_expect_success 'cookies stored in http.cookiefile when http.savecookies set
 	EOF
 	sort >expect_cookies.txt <<-\EOF &&
 	127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
+	127.0.0.1	FALSE	/smart_cookies/repo.git/	FALSE	0	name	value
 	127.0.0.1	FALSE	/smart_cookies/repo.git/info/	FALSE	0	name	value
 	EOF
 	git config http.cookiefile cookies.txt &&
 	git config http.savecookies true &&
-	git ls-remote $HTTPD_URL/smart_cookies/repo.git main &&
 
-	# NEEDSWORK: If the overspecification of the expected result is reduced, we
-	# might be able to run this test in all protocol versions.
-	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
-	then
-		grep "^[^#]" cookies.txt | sort >cookies_stripped.txt &&
-		test_cmp expect_cookies.txt cookies_stripped.txt
-	fi
+	test_when_finished "
+		git --git-dir=\"\$HTTPD_DOCUMENT_ROOT_PATH/repo.git\" \
+			tag -d cookie-tag
+	" &&
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
+		tag -m "foo" cookie-tag &&
+	git fetch $HTTPD_URL/smart_cookies/repo.git cookie-tag &&
+
+	grep "^[^#]" cookies.txt | sort >cookies_stripped.txt &&
+	test_cmp expect_cookies.txt cookies_stripped.txt
 '
 
 test_expect_success 'transfer.hiderefs works over smart-http' '
-- 
2.39.2.981.g6157336f25

