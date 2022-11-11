Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0E7C433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 14:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiKKOt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 09:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiKKOty (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 09:49:54 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B30526106
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 06:49:52 -0800 (PST)
Received: (qmail 307 invoked by uid 109); 11 Nov 2022 14:49:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Nov 2022 14:49:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5608 invoked by uid 111); 11 Nov 2022 14:49:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Nov 2022 09:49:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Nov 2022 09:49:50 -0500
From:   Jeff King <peff@peff.net>
To:     Glen Choo <chooglen@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH] t: run t5551 tests with both HTTP and HTTP/2
Message-ID: <Y25hDr7aHvKnxso3@coredump.intra.peff.net>
References: <pull.1377.git.git.1667955151994.gitgitgadget@gmail.com>
 <Y2xnUyEoCFmbPtUI@nand.local>
 <kl6lpmdu3dl5.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Y21yPIDmwB53e+aj@coredump.intra.peff.net>
 <kl6lk0422zgd.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Y22ze1m6ayQCv9B5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y22ze1m6ayQCv9B5@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 09:29:15PM -0500, Jeff King wrote:

> We don't get the _whole_ test suite running with http2, but hopefully it
> gives us a fairly representative sample. And it does find this bug.
> 
> I can try to work the above into patch form, but I may not get to it for
> a day or two.

So here's a patch which finds the bug you're fixing. It's set up to be
prepared before your patch, which helps confirm the bug (and that we're
correctly using http/2 in the tests!). You'll want to unmark the !HTTP2
prereqs as part of your patch.

Alternatively, it could come after your patch to confirm the fix, in
which case it would omit those !HTTP2 prereqs from the get-go.

Let me know if you'd like to pick it up as part of your series.
Otherwise, I can submit it separately in the on-top form (but my
preference is for you to take it, since it makes testing the fix
easier).

-- >8 --
Subject: t: run t5551 tests with both HTTP and HTTP/2

We have occasionally seen bugs that affect Git running only against an
HTTP/2 web server, not an HTTP one. For instance, b66c77a64e (http:
match headers case-insensitively when redacting, 2021-09-22). But since
we have no test coverage using HTTP/2, we only uncover these bugs in the
wild.

That commit gives a recipe for converting our Apache setup to support
HTTP/2, but:

  - it's not necessarily portable

  - we don't want to just test HTTP/2; we really want to do a variety of
    basic tests for _both_ protocols

This patch handles both problems by running a duplicate of t5551
(labeled as t5559 here) with an alternate-universe setup that enables
HTTP/2. So we'll continue to run t5551 as before, but run the same
battery of tests again with HTTP/2. If HTTP/2 isn't supported on a given
platform, then t5559 should bail during the webserver setup, and
gracefully skip all tests (unless GIT_TEST_HTTPD has been changed from
"auto" to "yes", where the point is to complain when webserver setup
fails).

In theory other http-related test scripts could benefit from the same
duplication, but doing t5551 should give us a reasonable check of basic
functionality, and would have caught both bugs we've seen in the wild
with HTTP/2.

A few notes on the implementation:

  - a script enables the server side config by calling enable_http2
    before starting the webserver. This avoids even trying to load any
    HTTP/2 config for t5551 (which is what lets it keep working with
    regular HTTP even on systems that don't support it). This also sets
    a prereq which can be used by individual tests.

  - As discussed in b66c77a64e, the http2 module isn't compatible with
    the "prefork" mpm, so we need to pick something else. I chose
    "event" here, which works on my Debian system, but it's possible
    there are platforms which would prefer something else. We can adjust
    that later if somebody finds such a platform.

  - The test "large fetch-pack requests can be sent using chunked
    encoding" makes sure we use a chunked transfer-encoding by looking
    for that header in the trace. But since HTTP/2 has its own streaming
    mechanisms, we won't find such a header. We could skip the test
    entirely by marking it with !HTTP2. But there's some value in making
    sure that the fetch itself succeeded. So instead, we'll confirm that
    either we're using HTTP2 _or_ we saw the expected chunked header.

  - the redaction tests fail under HTTP/2 with recent versions of curl.
    This is a bug! I've marked them with !HTTP2 here to skip them under
    t5559 for the moment. Using test_expect_failure would be more
    appropriate, but would require a bunch of boilerplate. Since we'll
    be fixing them momentarily, let's just skip them for now to keep the
    test suite bisectable, and we can re-enable them in the commit that
    fixes the bug.

  - one alternative layout would be to push most of t5551 into a
    lib-t5551.sh script, then source it from both t5551 and t5559.
    Keeping t5551 intact seemed a little simpler, as its one less level
    of indirection for people fixing bugs/regressions in the non-HTTP/2
    tests.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd.sh                    |  5 +++++
 t/lib-httpd/apache.conf           | 19 ++++++++++++++++---
 t/t5551-http-fetch-smart.sh       | 19 ++++++++++++++-----
 t/t5559-http-fetch-smart-http2.sh |  4 ++++
 4 files changed, 39 insertions(+), 8 deletions(-)
 create mode 100755 t/t5559-http-fetch-smart-http2.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 1f6b9b08d1..ba9fe36772 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -174,6 +174,11 @@ prepare_httpd() {
 	fi
 }
 
+enable_http2 () {
+	HTTPD_PARA="$HTTPD_PARA -DHTTP2"
+	test_set_prereq HTTP2
+}
+
 start_httpd() {
 	prepare_httpd >&3 2>&4
 
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 706799391b..0294739a77 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -29,6 +29,11 @@ ErrorLog error.log
 	LoadModule setenvif_module modules/mod_setenvif.so
 </IfModule>
 
+<IfDefine HTTP2>
+LoadModule http2_module modules/mod_http2.so
+Protocols h2c
+</IfDefine>
+
 <IfVersion < 2.4>
 LockFile accept.lock
 </IfVersion>
@@ -64,12 +69,20 @@ LockFile accept.lock
 <IfModule !mod_access_compat.c>
 	LoadModule access_compat_module modules/mod_access_compat.so
 </IfModule>
-<IfModule !mod_mpm_prefork.c>
-	LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
-</IfModule>
 <IfModule !mod_unixd.c>
 	LoadModule unixd_module modules/mod_unixd.so
 </IfModule>
+
+<IfDefine HTTP2>
+<IfModule !mod_mpm_event.c>
+	LoadModule mpm_event_module modules/mod_mpm_event.so
+</IfModule>
+</IfDefine>
+<IfDefine !HTTP2>
+<IfModule !mod_mpm_prefork.c>
+	LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
+</IfModule>
+</IfDefine>
 </IfVersion>
 
 PassEnv GIT_VALGRIND
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 64c6c9f59e..9826631926 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -1,13 +1,19 @@
 #!/bin/sh
 
-test_description='test smart fetching over http via http-backend'
+: ${HTTP_PROTO:=HTTP}
+test_description="test smart fetching over http via http-backend ($HTTP_PROTO)"
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
+test "$HTTP_PROTO" = "HTTP/2" && enable_http2
 start_httpd
 
+test_expect_success HTTP2 'enable client-side http/2' '
+	git config --global http.version HTTP/2
+'
+
 test_expect_success 'setup repository' '
 	git config push.default matching &&
 	echo content >file &&
@@ -194,7 +200,7 @@ test_expect_success 'redirects send auth to new location' '
 	expect_askpass both user@host auth/smart/repo.git
 '
 
-test_expect_success 'GIT_TRACE_CURL redacts auth details' '
+test_expect_success !HTTP2 'GIT_TRACE_CURL redacts auth details' '
 	rm -rf redact-auth trace &&
 	set_askpass user@host pass@host &&
 	GIT_TRACE_CURL="$(pwd)/trace" git clone --bare "$HTTPD_URL/auth/smart/repo.git" redact-auth &&
@@ -206,7 +212,7 @@ test_expect_success 'GIT_TRACE_CURL redacts auth details' '
 	grep -i "Authorization: Basic <redacted>" trace
 '
 
-test_expect_success 'GIT_CURL_VERBOSE redacts auth details' '
+test_expect_success !HTTP2 'GIT_CURL_VERBOSE redacts auth details' '
 	rm -rf redact-auth trace &&
 	set_askpass user@host pass@host &&
 	GIT_CURL_VERBOSE=1 git clone --bare "$HTTPD_URL/auth/smart/repo.git" redact-auth 2>trace &&
@@ -347,7 +353,10 @@ test_expect_success CMDLINE_LIMIT \
 test_expect_success 'large fetch-pack requests can be sent using chunked encoding' '
 	GIT_TRACE_CURL=true git -c http.postbuffer=65536 \
 		clone --bare "$HTTPD_URL/smart/repo.git" split.git 2>err &&
-	grep "^=> Send header: Transfer-Encoding: chunked" err
+	{
+		test_have_prereq HTTP2 ||
+		grep "^=> Send header: Transfer-Encoding: chunked" err
+	}
 '
 
 test_expect_success 'test allowreachablesha1inwant' '
@@ -473,7 +482,7 @@ test_expect_success 'fetch by SHA-1 without tag following' '
 		--no-tags origin $(cat bar_hash)
 '
 
-test_expect_success 'cookies are redacted by default' '
+test_expect_success !HTTP2 'cookies are redacted by default' '
 	rm -rf clone &&
 	echo "Set-Cookie: Foo=1" >cookies &&
 	echo "Set-Cookie: Bar=2" >>cookies &&
diff --git a/t/t5559-http-fetch-smart-http2.sh b/t/t5559-http-fetch-smart-http2.sh
new file mode 100755
index 0000000000..9eece71c2c
--- /dev/null
+++ b/t/t5559-http-fetch-smart-http2.sh
@@ -0,0 +1,4 @@
+#!/bin/sh
+
+HTTP_PROTO=HTTP/2
+. ./t5551-http-fetch-smart.sh
-- 
2.38.1.808.gb4bb4d4010

