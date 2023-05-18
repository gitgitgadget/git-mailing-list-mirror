Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6022C77B7D
	for <git@archiver.kernel.org>; Thu, 18 May 2023 19:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjERTVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 15:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjERTVH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 15:21:07 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE71FE51
        for <git@vger.kernel.org>; Thu, 18 May 2023 12:21:03 -0700 (PDT)
Received: (qmail 2132 invoked by uid 109); 18 May 2023 19:21:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 May 2023 19:21:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23823 invoked by uid 111); 18 May 2023 19:21:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 May 2023 15:21:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 May 2023 15:21:02 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [BUG 2.41.0] t/lib-httpd/apache.conf incompatible with
 RHEL/CentOS 7
Message-ID: <20230518192102.GA1514485@coredump.intra.peff.net>
References: <ZGUlqu7sP7yxbaTI@pobox.com>
 <20230518184532.GC557383@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230518184532.GC557383@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2023 at 02:45:32PM -0400, Jeff King wrote:

>   2. We do some kind of version check in enable_cgipassauth(),
>      and skip tests manually if it doesn't pass.
> [...]
> Obviously (1) and (3) are the least work for us upstream, but I don't
> think (2) would be too hard to do.

It indeed was pretty easy. So here's a patch. I'm adding Junio to the cc
before any review, as this is a change in the v2.41 cycle. So I think
we'd want to address this before the release.

-- >8 --
Subject: [PATCH] t/lib-httpd: make CGIPassAuth support conditional

Commit 988aad99b4 (t5563: add tests for basic and anoymous HTTP access,
2023-02-27) added tests that require Apache to support the CGIPassAuth
directive, which was added in Apache 2.4.13. This is fairly old (~8
years), but recent enough that we still encounter it in the wild (e.g.,
RHEL/CentOS 7, which is not EOL until June 2024).

We can live with skipping the new tests on such a platform. But
unfortunately, since the directive is used unconditionally in our
apache.conf, it means the web server fails to start entirely, and we
cannot run other HTTP tests at all (e.g., the basic ones in t5551).

We can fix that by making the config conditional, and only triggering it
for t5563. That solves the problem for t5551 (which then ignores the
directive entirely). For t5563, we'd see apache complain in start_httpd;
with the default setting of GIT_TEST_HTTPD, we'd then skip the whole
script.

But that leaves one small problem: people may set GIT_TEST_HTTPD=1
explicitly, which instructs the tests to fail (rather than skip) when we
can't start the webserver (to avoid accidentally missing some tests).

This could be worked around by having the user manually set
GIT_SKIP_TESTS on a platform with an older Apache. But we can be a bit
friendlier by doing the version check ourselves and setting an
appropriate prereq. We'll use the (lack of) prereq to then skip the rest
of t5563. In theory we could use the prereq to skip individual tests, but
in practice this whole script depends on it.

Reported-by: Todd Zullinger <tmz@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
---
I tested this manually by mutilating the config directive to "FooBar",
which would fail even on recent versions. And then tweaking the "13"
in the version check up to "60" to make sure it properly skips even with
recent Apache. But testing on real CentOS 7 would be very much
appreciated.

 t/lib-httpd.sh              | 14 ++++++++++++++
 t/lib-httpd/apache.conf     |  2 ++
 t/t5563-simple-http-auth.sh |  6 ++++++
 3 files changed, 22 insertions(+)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 6805229dcb..2fb1b2ae56 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -191,6 +191,20 @@ enable_http2 () {
 	test_set_prereq HTTP2
 }
 
+enable_cgipassauth () {
+	# We are looking for 2.4.13 or more recent. Since we only support
+	# 2.4 and up, no need to check for older major/minor.
+	if test "$HTTPD_VERSION_MAJOR" = 2 &&
+	   test "$HTTPD_VERSION_MINOR" = 4 &&
+	   test "$(echo $HTTPD_VERSION | cut -d. -f3)" -lt 13
+	then
+		echo >&4 "apache $HTTPD_VERSION too old for CGIPassAuth"
+		return
+	fi
+	HTTPD_PARA="$HTTPD_PARA -DUSE_CGIPASSAUTH"
+	test_set_prereq CGIPASSAUTH
+}
+
 start_httpd() {
 	prepare_httpd >&3 2>&4
 
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 9e6892970d..a22d138605 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -146,7 +146,9 @@ SetEnv PERL_PATH ${PERL_PATH}
 <LocationMatch /custom_auth/>
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
+	<IfDefine USE_CGIPASSAUTH>
 	CGIPassAuth on
+	</IfDefine>
 </LocationMatch>
 ScriptAlias /smart/incomplete_length/git-upload-pack incomplete-length-upload-pack-v2-http.sh/
 ScriptAlias /smart/incomplete_body/git-upload-pack incomplete-body-upload-pack-v2-http.sh/
diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
index f45a43b4b5..ab8a721ccc 100755
--- a/t/t5563-simple-http-auth.sh
+++ b/t/t5563-simple-http-auth.sh
@@ -5,6 +5,12 @@ test_description='test http auth header and credential helper interop'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 
+enable_cgipassauth
+if ! test_have_prereq CGIPASSAUTH
+then
+	skip_all="no CGIPassAuth support"
+	test_done
+fi
 start_httpd
 
 test_expect_success 'setup_credential_helper' '
-- 
2.41.0.rc0.359.g22664e20e7

