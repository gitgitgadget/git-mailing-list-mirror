Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B863C61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 20:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjBPU4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 15:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjBPU4f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 15:56:35 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3BA4CCBA
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 12:56:33 -0800 (PST)
Received: (qmail 31774 invoked by uid 109); 16 Feb 2023 20:56:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Feb 2023 20:56:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9936 invoked by uid 111); 16 Feb 2023 20:56:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Feb 2023 15:56:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Feb 2023 15:56:32 -0500
From:   Jeff King <peff@peff.net>
To:     tm-uzr3z@entrap.de
Cc:     git@vger.kernel.org
Subject: [PATCH] add basic http proxy tests
Message-ID: <Y+6YgALh6L9m6rSX@coredump.intra.peff.net>
References: <c0862f86061c220af289ce812d57f9c7.squirrel@www.entrap.de>
 <Y+6WOF+OHX4u94Z2@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+6WOF+OHX4u94Z2@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 03:46:48PM -0500, Jeff King wrote:

> Hmm. We do not have any test coverage for proxies at all. I took a stab
> at adding some, and it was not too bad.

Here is that patch. Even though it didn't lead me anywhere useful in
debugging your problem, it may be worth picking up anyway just to get
better test coverage.

-- >8 --
Subject: [PATCH] add basic http proxy tests

We do not test our http proxy functionality at all in the test suite, so
this is a pretty big blind spot. Let's at least add a basic check that
we can go through an authenticating proxy to perform a clone.

A few notes on the implementation:

  - I'm using a single apache instance to proxy to itself. This seems to
    work fine in practice, and we can check with a test that this rather
    unusual setup is doing what we expect.

  - I've put the proxy tests into their own script, and it's the only
    one which loads the apache proxy config. If any platform can't
    handle this (e.g., doesn't have the right modules), the start_httpd
    step should fail and gracefully skip the rest of the script (but all
    the other http tests in existing scripts will continue to run).

  - I used a separate passwd file to make sure we don't ever get
    confused between proxy and regular auth credentials. It's using the
    antiquated crypt() format. This is a terrible choice security-wise
    in the modern age, but it's what our existing passwd file uses, and
    should be portable. It would probably be reasonable to switch both
    of these to bcrypt, but we can do that in a separate patch.

  - On the client side, we test two situations with credentials: when
    they are present in the url, and when the username is present but we
    prompt for the password. I think we should be able to handle the
    case that _neither_ is present, but an HTTP 407 causes us to prompt
    for them. However, this doesn't seem to work. That's either a bug,
    or at the very least an opportunity for a feature, but I punted on
    it for now. The point of this patch is just getting basic coverage,
    and we can explore possible deficiencies later.

  - this doesn't work with LIB_HTTPD_SSL. This probably would be
    valuable to have, as https over an http proxy is totally different
    (it uses CONNECT to tunnel the session). But adding in
    mod_proxy_connect and some basic config didn't seem to work for me,
    so I punted for now. Much of the rest of the test suite does not
    currently work with LIB_HTTPD_SSL either, so we shouldn't be making
    anything much worse here.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd.sh           |  7 +++++++
 t/lib-httpd/apache.conf  | 16 ++++++++++++++++
 t/lib-httpd/proxy-passwd |  1 +
 t/t5563-http-proxy.sh    | 41 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+)
 create mode 100644 t/lib-httpd/proxy-passwd
 create mode 100755 t/t5563-http-proxy.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 5d2d56c445..059fd74adb 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -25,6 +25,7 @@
 #    LIB_HTTPD_DAV               enable DAV
 #    LIB_HTTPD_SVN               enable SVN at given location (e.g. "svn")
 #    LIB_HTTPD_SSL               enable SSL
+#    LIB_HTTPD_PROXY             enable proxy
 #
 # Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
 #
@@ -133,6 +134,7 @@ install_script () {
 prepare_httpd() {
 	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH"
 	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
+	cp "$TEST_PATH"/proxy-passwd "$HTTPD_ROOT_PATH"
 	install_script incomplete-length-upload-pack-v2-http.sh
 	install_script incomplete-body-upload-pack-v2-http.sh
 	install_script error-no-report.sh
@@ -176,6 +178,11 @@ prepare_httpd() {
 			export LIB_HTTPD_SVN LIB_HTTPD_SVNPATH
 		fi
 	fi
+
+	if test -n "$LIB_HTTPD_PROXY"
+	then
+		HTTPD_PARA="$HTTPD_PARA -DPROXY"
+	fi
 }
 
 enable_http2 () {
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 51a4fbcf62..e31293a45f 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -47,6 +47,22 @@ Protocols h2c
 	LoadModule authz_host_module modules/mod_authz_host.so
 </IfModule>
 
+<IfDefine PROXY>
+<IfModule !mod_proxy.c>
+	LoadModule proxy_module modules/mod_proxy.so
+</IfModule>
+<IfModule !mod_proxy_http.c>
+	LoadModule proxy_http_module modules/mod_proxy_http.so
+</IfModule>
+ProxyRequests On
+<Proxy "*">
+	AuthType Basic
+	AuthName "proxy-auth"
+	AuthUserFile proxy-passwd
+	Require valid-user
+</Proxy>
+</IfDefine>
+
 <IfModule !mod_authn_core.c>
 	LoadModule authn_core_module modules/mod_authn_core.so
 </IfModule>
diff --git a/t/lib-httpd/proxy-passwd b/t/lib-httpd/proxy-passwd
new file mode 100644
index 0000000000..77c25138e0
--- /dev/null
+++ b/t/lib-httpd/proxy-passwd
@@ -0,0 +1 @@
+proxuser:2x7tAukjAED5M
diff --git a/t/t5563-http-proxy.sh b/t/t5563-http-proxy.sh
new file mode 100755
index 0000000000..9da5134614
--- /dev/null
+++ b/t/t5563-http-proxy.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description="test fetching through http proxy"
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-httpd.sh
+
+LIB_HTTPD_PROXY=1
+start_httpd
+
+test_expect_success 'setup repository' '
+	test_commit foo &&
+	git init --bare "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git push --mirror "$HTTPD_DOCUMENT_ROOT_PATH/repo.git"
+'
+
+setup_askpass_helper
+
+# sanity check that our test setup is correctly using proxy
+test_expect_success 'proxy requires password' '
+	test_config_global http.proxy $HTTPD_DEST &&
+	test_must_fail git clone $HTTPD_URL/smart/repo.git 2>err &&
+	grep "error.*407" err
+'
+
+test_expect_success 'clone through proxy with auth' '
+	test_when_finished "rm -rf clone" &&
+	test_config_global http.proxy http://proxuser:proxpass@$HTTPD_DEST &&
+	GIT_TRACE_CURL=$PWD/trace git clone $HTTPD_URL/smart/repo.git clone &&
+	grep -i "Proxy-Authorization: Basic <redacted>" trace
+'
+
+test_expect_success 'clone can prompt for proxy password' '
+	test_when_finished "rm -rf clone" &&
+	test_config_global http.proxy http://proxuser@$HTTPD_DEST &&
+	set_askpass nobody proxpass &&
+	GIT_TRACE_CURL=$PWD/trace git clone $HTTPD_URL/smart/repo.git clone &&
+	expect_askpass pass proxuser
+'
+
+test_done
-- 
2.39.2.920.gf3beb43ccf

