Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39AEC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 18:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2AD061186
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 18:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhIUSmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 14:42:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:51964 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233372AbhIUSmp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 14:42:45 -0400
Received: (qmail 6349 invoked by uid 109); 21 Sep 2021 18:41:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 18:41:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3254 invoked by uid 111); 21 Sep 2021 18:41:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Sep 2021 14:41:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Sep 2021 14:41:15 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Daniel Stenberg <daniel@haxx.se>
Subject: [PATCH] http: match headers case-insensitively when redacting
Message-ID: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When HTTP/2 is in use, we fail to correctly redact "Authorization" (and
other) headers in our GIT_TRACE_CURL output.

We get the headers in our CURLOPT_DEBUGFUNCTION callback, curl_trace().
It passes them along to curl_dump_header(), which in turn checks
redact_sensitive_header(). We see the headers as a text buffer like:

  Host: ...
  Authorization: Basic ...

After breaking it into lines, we match each header using skip_prefix().
This is case-insensitive, even though HTTP headers are case-insensitive.
This has worked reliably in the past because these headers are generated
by curl itself, which is predictable in what it sends.

But when HTTP/2 is in use, instead we get a lower-case "authorization:"
header, and we fail to match it. The fix is simple: we should match with
skip_iprefix().

Testing is more complicated, though. We do have a test for the redacting
feature, but we don't hit the problem case because our test Apache setup
does not understand HTTP/2. You can reproduce the issue by applying this
on top of the test change in this patch:

	diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
	index afa91e38b0..19267c7107 100644
	--- a/t/lib-httpd/apache.conf
	+++ b/t/lib-httpd/apache.conf
	@@ -29,6 +29,9 @@ ErrorLog error.log
	 	LoadModule setenvif_module modules/mod_setenvif.so
	 </IfModule>

	+LoadModule http2_module modules/mod_http2.so
	+Protocols h2c
	+
	 <IfVersion < 2.4>
	 LockFile accept.lock
	 </IfVersion>
	@@ -64,8 +67,8 @@ LockFile accept.lock
	 <IfModule !mod_access_compat.c>
	 	LoadModule access_compat_module modules/mod_access_compat.so
	 </IfModule>
	-<IfModule !mod_mpm_prefork.c>
	-	LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
	+<IfModule !mod_mpm_event.c>
	+	LoadModule mpm_event_module modules/mod_mpm_event.so
	 </IfModule>
	 <IfModule !mod_unixd.c>
	 	LoadModule unixd_module modules/mod_unixd.so
	diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
	index 1c2a444ae7..ff74f0ae8a 100755
	--- a/t/t5551-http-fetch-smart.sh
	+++ b/t/t5551-http-fetch-smart.sh
	@@ -24,6 +24,10 @@ test_expect_success 'create http-accessible bare repository' '
	 	git push public main:main
	 '

	+test_expect_success 'prefer http/2' '
	+	git config --global http.version HTTP/2
	+'
	+
	 setup_askpass_helper

	 test_expect_success 'clone http repository' '

but this has a few issues:

  - it's not necessarily portable. The http2 apache module might not be
    available on all systems. Further, the http2 module isn't compatible
    with the prefork mpm, so we have to switch to something else. But we
    don't necessarily know what's available. It would be nice if we
    could have conditional config, but IfModule only tells us if a
    module is already loaded, not whether it is available at all.

    This might be a non-issue. The http tests are already optional, and
    modern-enough systems may just have both of these. But...

  - if we do this, then we'd no longer be testing HTTP/1.1 at all. I'm
    not sure how much that matters since it's all handled by curl under
    the hood, but I'd worry that some detail leaks through. We'd
    probably want two scripts running similar tests, one with HTTP/2 and
    one with HTTP/1.1.

  - speaking of which, a later test fails with the patch above! The
    problem is that it is making sure we used a chunked
    transfer-encoding by looking for that header in the trace. But
    HTTP/2 doesn't support that, as it has its own streaming mechanisms
    (the overall operation works fine; we just don't see the header in
    the trace).

On top of that, we also need the test change that this patch _does_ do:
grepping the trace file case-insensitively. Otherwise the test continues
to pass even over HTTP/2, because it sees _both_ forms of the header
(redacted and unredacted), as we upgrade from HTTP/1.1 to HTTP/2. So our
double grep:

	# Ensure that there is no "Basic" followed by a base64 string, but that
	# the auth details are redacted
	! grep "Authorization: Basic [0-9a-zA-Z+/]" trace &&
	grep "Authorization: Basic <redacted>" trace

gets confused. It sees the "<redacted>" one from the pre-upgrade
HTTP/1.1 request, but fails to see the unredacted HTTP/2 one, because it
does not match the lower-case "authorization". Even without the rest of
the test changes, we can still make this test more robust by matching
case-insensitively. That will future-proof the test for a day when
HTTP/2 is finally enabled by default, and doesn't hurt in the meantime.

And finally, there's one other way to demonstrate the issue (and how I
actually found it originally). Looking at GIT_TRACE_CURL output against
github.com, you'll see the unredacted output, even if you didn't set
http.version. That's because setting it is only necessary for curl to
send the extra headers in its HTTP/1.1 request that say "Hey, I speak
HTTP/2; upgrade if you do, too". But for a production site speaking
https, the server advertises via ALPN, a TLS extension, that it supports
HTTP/2, and the client can immediately start using it.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c                      |  6 +++---
 t/t5551-http-fetch-smart.sh | 24 ++++++++++++------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/http.c b/http.c
index a0f169d2fe..4f6a32165f 100644
--- a/http.c
+++ b/http.c
@@ -550,8 +550,8 @@ static void redact_sensitive_header(struct strbuf *header)
 	const char *sensitive_header;
 
 	if (trace_curl_redact &&
-	    (skip_prefix(header->buf, "Authorization:", &sensitive_header) ||
-	     skip_prefix(header->buf, "Proxy-Authorization:", &sensitive_header))) {
+	    (skip_iprefix(header->buf, "Authorization:", &sensitive_header) ||
+	     skip_iprefix(header->buf, "Proxy-Authorization:", &sensitive_header))) {
 		/* The first token is the type, which is OK to log */
 		while (isspace(*sensitive_header))
 			sensitive_header++;
@@ -561,7 +561,7 @@ static void redact_sensitive_header(struct strbuf *header)
 		strbuf_setlen(header,  sensitive_header - header->buf);
 		strbuf_addstr(header, " <redacted>");
 	} else if (trace_curl_redact &&
-		   skip_prefix(header->buf, "Cookie:", &sensitive_header)) {
+		   skip_iprefix(header->buf, "Cookie:", &sensitive_header)) {
 		struct strbuf redacted_header = STRBUF_INIT;
 		const char *cookie;
 
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 4f87d90c5b..4e54226162 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -196,8 +196,8 @@ test_expect_success 'GIT_TRACE_CURL redacts auth details' '
 
 	# Ensure that there is no "Basic" followed by a base64 string, but that
 	# the auth details are redacted
-	! grep "Authorization: Basic [0-9a-zA-Z+/]" trace &&
-	grep "Authorization: Basic <redacted>" trace
+	! grep -i "Authorization: Basic [0-9a-zA-Z+/]" trace &&
+	grep -i "Authorization: Basic <redacted>" trace
 '
 
 test_expect_success 'GIT_CURL_VERBOSE redacts auth details' '
@@ -208,8 +208,8 @@ test_expect_success 'GIT_CURL_VERBOSE redacts auth details' '
 
 	# Ensure that there is no "Basic" followed by a base64 string, but that
 	# the auth details are redacted
-	! grep "Authorization: Basic [0-9a-zA-Z+/]" trace &&
-	grep "Authorization: Basic <redacted>" trace
+	! grep -i "Authorization: Basic [0-9a-zA-Z+/]" trace &&
+	grep -i "Authorization: Basic <redacted>" trace
 '
 
 test_expect_success 'GIT_TRACE_CURL does not redact auth details if GIT_TRACE_REDACT=0' '
@@ -219,7 +219,7 @@ test_expect_success 'GIT_TRACE_CURL does not redact auth details if GIT_TRACE_RE
 		git clone --bare "$HTTPD_URL/auth/smart/repo.git" redact-auth &&
 	expect_askpass both user@host &&
 
-	grep "Authorization: Basic [0-9a-zA-Z+/]" trace
+	grep -i "Authorization: Basic [0-9a-zA-Z+/]" trace
 '
 
 test_expect_success 'disable dumb http on server' '
@@ -474,10 +474,10 @@ test_expect_success 'cookies are redacted by default' '
 	GIT_TRACE_CURL=true \
 		git -c "http.cookieFile=$(pwd)/cookies" clone \
 		$HTTPD_URL/smart/repo.git clone 2>err &&
-	grep "Cookie:.*Foo=<redacted>" err &&
-	grep "Cookie:.*Bar=<redacted>" err &&
-	! grep "Cookie:.*Foo=1" err &&
-	! grep "Cookie:.*Bar=2" err
+	grep -i "Cookie:.*Foo=<redacted>" err &&
+	grep -i "Cookie:.*Bar=<redacted>" err &&
+	! grep -i "Cookie:.*Foo=1" err &&
+	! grep -i "Cookie:.*Bar=2" err
 '
 
 test_expect_success 'empty values of cookies are also redacted' '
@@ -486,7 +486,7 @@ test_expect_success 'empty values of cookies are also redacted' '
 	GIT_TRACE_CURL=true \
 		git -c "http.cookieFile=$(pwd)/cookies" clone \
 		$HTTPD_URL/smart/repo.git clone 2>err &&
-	grep "Cookie:.*Foo=<redacted>" err
+	grep -i "Cookie:.*Foo=<redacted>" err
 '
 
 test_expect_success 'GIT_TRACE_REDACT=0 disables cookie redaction' '
@@ -496,8 +496,8 @@ test_expect_success 'GIT_TRACE_REDACT=0 disables cookie redaction' '
 	GIT_TRACE_REDACT=0 GIT_TRACE_CURL=true \
 		git -c "http.cookieFile=$(pwd)/cookies" clone \
 		$HTTPD_URL/smart/repo.git clone 2>err &&
-	grep "Cookie:.*Foo=1" err &&
-	grep "Cookie:.*Bar=2" err
+	grep -i "Cookie:.*Foo=1" err &&
+	grep -i "Cookie:.*Bar=2" err
 '
 
 test_expect_success 'GIT_TRACE_CURL_NO_DATA prevents data from being traced' '
-- 
2.33.0.1029.g2347ba282e
