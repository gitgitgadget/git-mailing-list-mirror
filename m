Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63127FA3740
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 02:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiKAC0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 22:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKAC0p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 22:26:45 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2631262A
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 19:26:43 -0700 (PDT)
Received: (qmail 3959 invoked by uid 109); 1 Nov 2022 02:26:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Nov 2022 02:26:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18124 invoked by uid 111); 1 Nov 2022 02:26:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 31 Oct 2022 22:26:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 31 Oct 2022 22:26:42 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] t5516: move plaintext-password tests from t5601 and t5516
Message-ID: <Y2CD4g9z2yVFA06l@coredump.intra.peff.net>
References: <Y2CDrZNgNZ+flJBK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2CDrZNgNZ+flJBK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 6dcbdc0d66 (remote: create fetch.credentialsInUrl config,
2022-06-06) added tests for our handling of passwords in URLs. Since the
obvious URL to be affected is git-over-http, the tests use http. However
they don't set up a test server; they just try to access
https://localhost, assuming it will fail (because the nothing is
listening there).

This causes some possible problems:

  - There might be a web server running on localhost, and we do not
    actually want to connect to that.

  - The DNS resolver, or the local firewall, might take a substantial
    amount of time (or forever, whichever comes first) to fail to
    connect, slowing down the tests cases unnecessarily.

  - Since there's no server, our tests for "allow" and "warn" still
    expect the clone/fetch/push operations to fail, even though in the
    real world we'd expect these to succeed. We scrape stderr to see
    what happened, but it's not as robust as a more realistic test.

Let's instead move these to t5551, which is all about testing http and
where we have a real server. That eliminates any issues with contacting
a strange URL, and lets the "allow" and "warn" tests confirm that the
operation actually succeeds.

It's not quite a verbatim move for a few reasons:

  - we can drop the LIBCURL dependency; it's already part of
    lib-httpd.sh

  - we'll use HTTPD_URL_USER_PASS, etc, instead of our fake URL. To
    avoid repetition, we'll add a few extra variables.

  - the "https://username:@localhost" test uses a funny URL that
    lib-httpd.sh doesn't provide. We'll similarly construct it in a
    variable. Note that we're hard-coding the lib-httpd username here,
    but t5551 already does that everywhere.

  - for the "domain:port" test, the URL provided by lib-httpd is fine,
    since our test server will always be on an exotic port. But we'll
    confirm in the test that this is so.

  - since our message-matching is done via grep, I simplified it to use
    a regex, rather than trying to massage lib-httpd's variables.
    Arguably this makes it more readable, too, while retaining the bits
    we care about: the fatal/warning distinction, the "uses plaintext"
    message, and the fact that the password was redacted.

  - we'll use the /auth/ path for the repo, which shows that we are
    indeed making use of the auth information when needed.

  - we'll also use /smart/; most of these tests could be done via /dumb/
    in t5550, but setting up pushes there requires extra effort and
    dependencies. The smart protocol is what most everyone is using
    these days anyway.

This patch is my own, but I stole the analysis and a few bits of the
commit message from a patch by Johannes Schindelin.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5516-fetch-push.sh       | 31 ---------------
 t/t5551-http-fetch-smart.sh | 77 +++++++++++++++++++++++++++++++++++++
 t/t5601-clone.sh            | 23 -----------
 3 files changed, 77 insertions(+), 54 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 79dc470c01..4f2bfaf005 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1853,37 +1853,6 @@ test_expect_success 'refuse to push a hidden ref, and make sure do not pollute t
 	test_dir_is_empty testrepo/.git/objects/pack
 '
 
-test_expect_success LIBCURL 'fetch warns or fails when using username:password' '
-	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
-	test_must_fail git -c transfer.credentialsInUrl=allow fetch https://username:password@localhost 2>err &&
-	! grep "$message" err &&
-
-	test_must_fail git -c transfer.credentialsInUrl=warn fetch https://username:password@localhost 2>err &&
-	grep "warning: $message" err >warnings &&
-	test_line_count = 3 warnings &&
-
-	test_must_fail git -c transfer.credentialsInUrl=die fetch https://username:password@localhost 2>err &&
-	grep "fatal: $message" err >warnings &&
-	test_line_count = 1 warnings &&
-
-	test_must_fail git -c transfer.credentialsInUrl=die fetch https://username:@localhost 2>err &&
-	grep "fatal: $message" err >warnings &&
-	test_line_count = 1 warnings
-'
-
-
-test_expect_success LIBCURL 'push warns or fails when using username:password' '
-	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
-	test_must_fail git -c transfer.credentialsInUrl=allow push https://username:password@localhost 2>err &&
-	! grep "$message" err &&
-
-	test_must_fail git -c transfer.credentialsInUrl=warn push https://username:password@localhost 2>err &&
-	grep "warning: $message" err >warnings &&
-	test_must_fail git -c transfer.credentialsInUrl=die push https://username:password@localhost 2>err &&
-	grep "fatal: $message" err >warnings &&
-	test_line_count = 1 warnings
-'
-
 test_expect_success 'push with config push.useBitmaps' '
 	mk_test testrepo heads/main &&
 	git checkout main &&
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 6a38294a47..bbe3d5721f 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -580,4 +580,81 @@ test_expect_success 'passing hostname resolution information works' '
 	git -c "http.curloptResolve=$BOGUS_HOST:$LIB_HTTPD_PORT:127.0.0.1" ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null
 '
 
+# here user%40host is the URL-encoded version of user@host,
+# which is our intentionally-odd username to catch parsing errors
+url_user=$HTTPD_URL_USER/auth/smart/repo.git
+url_userpass=$HTTPD_URL_USER_PASS/auth/smart/repo.git
+url_userblank=$HTTPD_PROTO://user%40host:@$HTTPD_DEST/auth/smart/repo.git
+message="URL .*:<redacted>@.* uses plaintext credentials"
+
+test_expect_success 'clone warns or fails when using username:password' '
+	test_when_finished "rm -rf attempt*" &&
+
+	git -c transfer.credentialsInUrl=allow \
+		clone $url_userpass attempt1 2>err &&
+	! grep "$message" err &&
+
+	git -c transfer.credentialsInUrl=warn \
+		clone $url_userpass attempt2 2>err &&
+	grep "warning: $message" err >warnings &&
+	test_line_count = 2 warnings &&
+
+	test_must_fail git -c transfer.credentialsInUrl=die \
+		clone $url_userpass attempt3 2>err &&
+	grep "fatal: $message" err >warnings &&
+	test_line_count = 1 warnings &&
+
+	test_must_fail git -c transfer.credentialsInUrl=die \
+		clone $url_userblank attempt4 2>err &&
+	grep "fatal: $message" err >warnings &&
+	test_line_count = 1 warnings
+'
+
+test_expect_success 'clone does not detect username:password when it is https://username@domain:port/' '
+	test_when_finished "rm -rf attempt1" &&
+
+	# we are relying on lib-httpd for url construction, so document our
+	# assumptions
+	case "$HTTPD_URL_USER" in
+	*:[0-9]*) : ok ;;
+	*) BUG "httpd url does not have port: $HTTPD_URL_USER"
+	esac &&
+
+	git -c transfer.credentialsInUrl=warn clone $url_user attempt1 2>err &&
+	! grep "uses plaintext credentials" err
+'
+
+test_expect_success 'fetch warns or fails when using username:password' '
+	git -c transfer.credentialsInUrl=allow fetch $url_userpass 2>err &&
+	! grep "$message" err &&
+
+	git -c transfer.credentialsInUrl=warn fetch $url_userpass 2>err &&
+	grep "warning: $message" err >warnings &&
+	test_line_count = 3 warnings &&
+
+	test_must_fail git -c transfer.credentialsInUrl=die \
+		fetch $url_userpass 2>err &&
+	grep "fatal: $message" err >warnings &&
+	test_line_count = 1 warnings &&
+
+	test_must_fail git -c transfer.credentialsInUrl=die \
+		fetch $url_userblank 2>err &&
+	grep "fatal: $message" err >warnings &&
+	test_line_count = 1 warnings
+'
+
+
+test_expect_success 'push warns or fails when using username:password' '
+	git -c transfer.credentialsInUrl=allow push $url_userpass 2>err &&
+	! grep "$message" err &&
+
+	git -c transfer.credentialsInUrl=warn push $url_userpass 2>err &&
+	grep "warning: $message" err >warnings &&
+
+	test_must_fail git -c transfer.credentialsInUrl=die \
+		push $url_userpass 2>err &&
+	grep "fatal: $message" err >warnings &&
+	test_line_count = 1 warnings
+'
+
 test_done
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 45f0803ed4..b2524a24c2 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -71,29 +71,6 @@ test_expect_success 'clone respects GIT_WORK_TREE' '
 
 '
 
-test_expect_success LIBCURL 'clone warns or fails when using username:password' '
-	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
-	test_must_fail git -c transfer.credentialsInUrl=allow clone https://username:password@localhost attempt1 2>err &&
-	! grep "$message" err &&
-
-	test_must_fail git -c transfer.credentialsInUrl=warn clone https://username:password@localhost attempt2 2>err &&
-	grep "warning: $message" err >warnings &&
-	test_line_count = 2 warnings &&
-
-	test_must_fail git -c transfer.credentialsInUrl=die clone https://username:password@localhost attempt3 2>err &&
-	grep "fatal: $message" err >warnings &&
-	test_line_count = 1 warnings &&
-
-	test_must_fail git -c transfer.credentialsInUrl=die clone https://username:@localhost attempt3 2>err &&
-	grep "fatal: $message" err >warnings &&
-	test_line_count = 1 warnings
-'
-
-test_expect_success LIBCURL 'clone does not detect username:password when it is https://username@domain:port/' '
-	test_must_fail git -c transfer.credentialsInUrl=warn clone https://username@localhost:8080 attempt3 2>err &&
-	! grep "uses plaintext credentials" err
-'
-
 test_expect_success 'clone from hooks' '
 
 	test_create_repo r0 &&
-- 
2.38.1.669.g2ee9a5b0e3

