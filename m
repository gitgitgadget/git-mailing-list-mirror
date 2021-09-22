Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD1EC433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 22:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 795FB60F3A
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 22:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbhIVWNZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 18:13:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:53072 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232149AbhIVWNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 18:13:25 -0400
Received: (qmail 12524 invoked by uid 109); 22 Sep 2021 22:11:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Sep 2021 22:11:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19663 invoked by uid 111); 22 Sep 2021 22:11:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Sep 2021 18:11:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Sep 2021 18:11:53 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Daniel Stenberg <daniel@haxx.se>
Subject: [PATCH v2] http: match headers case-insensitively when redacting
Message-ID: <YUuqKeXRYuXjXy1+@coredump.intra.peff.net>
References: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
 <xmqq8rzo770h.fsf@gitster.g>
 <YUuNXOb5blV7iN6P@coredump.intra.peff.net>
 <xmqqk0j85o6c.fsf@gitster.g>
 <YUudqYmzy9N3e0Bk@coredump.intra.peff.net>
 <xmqqbl4k5lsu.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbl4k5lsu.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 02:42:57PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > No, I think we are on the same page now. Do you want me to take
> > another stab at writing the commit message to clarify things (i.e., do
> > we think it's badly written, or was it just mis-interpreted)?
> 
> I am not sure which, but perhaps more of the latter.  So I would not
> insist.

Well, I did it anyway. :) Here's the updated patch. I think it explains
things more clearly by showing the example output from our discussion
(and reframes the text around it to explain it more). I'll send a
range-diff in a moment.

(It also fixes the s/insensitive/sensitive/ typo).

-- >8 --
Subject: http: match headers case-insensitively when redacting

When HTTP/2 is in use, we fail to correctly redact "Authorization" (and
other) headers in our GIT_TRACE_CURL output.

We get the headers in our CURLOPT_DEBUGFUNCTION callback, curl_trace().
It passes them along to curl_dump_header(), which in turn checks
redact_sensitive_header(). We see the headers as a text buffer like:

  Host: ...
  Authorization: Basic ...

After breaking it into lines, we match each header using skip_prefix().
This is case-sensitive, even though HTTP headers are case-insensitive.
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

Furthermore, even with the changes above, this test still does not
detect the current failure, because we see _both_ HTTP/1.1 and HTTP/2
requests, which confuse it. Quoting only the interesting bits from the
resulting trace file, we first see:

  => Send header: GET /auth/smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
  => Send header: Connection: Upgrade, HTTP2-Settings
  => Send header: Upgrade: h2c
  => Send header: HTTP2-Settings: AAMAAABkAAQCAAAAAAIAAAAA

  <= Recv header: HTTP/1.1 401 Unauthorized
  <= Recv header: Date: Wed, 22 Sep 2021 20:03:32 GMT
  <= Recv header: Server: Apache/2.4.49 (Debian)
  <= Recv header: WWW-Authenticate: Basic realm="git-auth"

So the client asks for HTTP/2, but Apache does not do the upgrade for
the 401 response. Then the client repeats with credentials:

  => Send header: GET /auth/smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
  => Send header: Authorization: Basic <redacted>
  => Send header: Connection: Upgrade, HTTP2-Settings
  => Send header: Upgrade: h2c
  => Send header: HTTP2-Settings: AAMAAABkAAQCAAAAAAIAAAAA

  <= Recv header: HTTP/1.1 101 Switching Protocols
  <= Recv header: Upgrade: h2c
  <= Recv header: Connection: Upgrade
  <= Recv header: HTTP/2 200
  <= Recv header: content-type: application/x-git-upload-pack-advertisement

So the client does properly redact there, because we're speaking
HTTP/1.1, and the server indicates it can do the upgrade. And then the
client will make further requests using HTTP/2:

  => Send header: POST /auth/smart/repo.git/git-upload-pack HTTP/2
  => Send header: authorization: Basic dXNlckBob3N0OnBhc3NAaG9zdA==
  => Send header: content-type: application/x-git-upload-pack-request

And there we can see that the credential is _not_ redacted. This part of
the test is what gets confused:

	# Ensure that there is no "Basic" followed by a base64 string, but that
	# the auth details are redacted
	! grep "Authorization: Basic [0-9a-zA-Z+/]" trace &&
	grep "Authorization: Basic <redacted>" trace

The first grep does not match the un-redacted HTTP/2 header, because
it insists on an uppercase "A". And the second one does find the
HTTP/1.1 header. So as far as the test is concerned, everything is OK,
but it failed to notice the un-redacted lines.

We can make this test (and the other related ones) more robust by adding
"-i" to grep case-insensitively. This isn't really doing anything for
now, since we're not actually speaking HTTP/2, but it future-proofs the
tests for a day when we do (either we add explicit HTTP/2 test support,
or it's eventually enabled by default by our Apache+curl test setup).
And it doesn't hurt in the meantime for the tests to be more careful.

The change to use "grep -i", coupled with the changes to use HTTP/2
shown above, causes the test to fail with the current code, and pass
after this patch is applied.

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
2.33.0.1031.gb334554566

