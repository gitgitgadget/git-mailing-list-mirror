Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17EA81F404
	for <e@80x24.org>; Mon, 19 Feb 2018 19:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753869AbeBSTsr (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 14:48:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:57154 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753828AbeBSTsq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 14:48:46 -0500
Received: (qmail 32637 invoked by uid 109); 19 Feb 2018 19:48:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 19 Feb 2018 19:48:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6449 invoked by uid 111); 19 Feb 2018 19:49:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 19 Feb 2018 14:49:32 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Feb 2018 14:48:44 -0500
Date:   Mon, 19 Feb 2018 14:48:44 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Jon Simons <jon@jonsimons.org>
Subject: [PATCH 1/2] t5545: factor out http repository setup
Message-ID: <20180219194844.GA988@sigill.intra.peff.net>
References: <20180219194709.GA837@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180219194709.GA837@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We repeat many lines of setup code in the two http tests,
and further tests would need to repeat it again.  Let's
factor this out into a function.

Incidentally, this also fixes an unlikely bug: if the httpd
root path contains a double-quote, our test_when_finished
would barf due to improper quoting (we escape the embedded
quotes, but not the $, meaning we expand the variable before
the eval).

Signed-off-by: Jeff King <peff@peff.net>
---
Arguably this setup could be done once and then reused by several tests,
which would be a bit more efficient.  But the whole script is written in
this "remake repos fresh" style, so I didn't look into switching it.

 t/t5545-push-options.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index 463783789c..c64dee2127 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -220,14 +220,20 @@ test_expect_success 'invalid push option in config' '
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-test_expect_success 'push option denied properly by http server' '
+# set up http repository for fetching/pushing, with push options config
+# bool set to $1
+mk_http_pair () {
 	test_when_finished "rm -rf test_http_clone" &&
-	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH\"/upstream.git" &&
+	test_when_finished 'rm -rf "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git' &&
 	mk_repo_pair &&
-	git -C upstream config receive.advertisePushOptions false &&
+	git -C upstream config receive.advertisePushOptions "$1" &&
 	git -C upstream config http.receivepack true &&
 	cp -R upstream/.git "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git &&
-	git clone "$HTTPD_URL"/smart/upstream test_http_clone &&
+	git clone "$HTTPD_URL"/smart/upstream test_http_clone
+}
+
+test_expect_success 'push option denied properly by http server' '
+	mk_http_pair false &&
 	test_commit -C test_http_clone one &&
 	test_must_fail git -C test_http_clone push --push-option=asdf origin master 2>actual &&
 	test_i18ngrep "the receiving end does not support push options" actual &&
@@ -235,13 +241,7 @@ test_expect_success 'push option denied properly by http server' '
 '
 
 test_expect_success 'push options work properly across http' '
-	test_when_finished "rm -rf test_http_clone" &&
-	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH\"/upstream.git" &&
-	mk_repo_pair &&
-	git -C upstream config receive.advertisePushOptions true &&
-	git -C upstream config http.receivepack true &&
-	cp -R upstream/.git "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git &&
-	git clone "$HTTPD_URL"/smart/upstream test_http_clone &&
+	mk_http_pair true &&
 
 	test_commit -C test_http_clone one &&
 	git -C test_http_clone push origin master &&
-- 
2.16.2.552.gea2a3cf654

