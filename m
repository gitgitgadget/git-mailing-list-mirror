Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F494C7EE23
	for <git@archiver.kernel.org>; Thu, 18 May 2023 18:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjERSpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 14:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjERSpk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 14:45:40 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69109E5D
        for <git@vger.kernel.org>; Thu, 18 May 2023 11:45:33 -0700 (PDT)
Received: (qmail 1536 invoked by uid 109); 18 May 2023 18:45:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 May 2023 18:45:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23472 invoked by uid 111); 18 May 2023 18:45:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 May 2023 14:45:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 May 2023 14:45:32 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [BUG 2.41.0] t/lib-httpd/apache.conf incompatible with
 RHEL/CentOS 7
Message-ID: <20230518184532.GC557383@coredump.intra.peff.net>
References: <ZGUlqu7sP7yxbaTI@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZGUlqu7sP7yxbaTI@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2023 at 03:06:18PM -0400, Todd Zullinger wrote:

> The problem is that CGIPassAuth, added in 988aad99b4 (t5563:
> add tests for basic and anoymous HTTP access, 2023-02-27) is
> not supported by httpd < 2.4.13:

Thanks for reporting. I don't think we dug into version requirements for
that (obviously CGI stuff goes back forever, so it's just that
particular option). That version of Apache is "only" 8 years old. Which
is old, but we often go back that far for dependencies.

> Since edd060dc84 (t/lib-httpd: bump required apache version
> to 2.4, 2023-02-01), we require httpd-2.4 and no longer have
> any <IfVersion> conditions.  I'm not sure if this a reason
> to add some again (nor am I certain if httpd's IfVersion
> supports minor versions).

I don't think an IfVersion would be sufficient, because we need to also
tell the script making use of that config that it should skip its tests.
So I think we want something more like the HTTP/2 tests have: a separate
script which enables the extra config, and bails if the web server setup
fails.

Something like this:

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 6805229dcb..4b6d9a5817 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -191,6 +191,10 @@ enable_http2 () {
 	test_set_prereq HTTP2
 }
 
+enable_cgipassauth () {
+	HTTPD_PARA="$HTTPD_PARA -DUSE_CGIPASSAUTH"
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
index f45a43b4b5..0f23f45572 100755
--- a/t/t5563-simple-http-auth.sh
+++ b/t/t5563-simple-http-auth.sh
@@ -5,6 +5,7 @@ test_description='test http auth header and credential helper interop'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 
+enable_cgipassauth
 start_httpd
 
 test_expect_success 'setup_credential_helper' '

And then the theory is that t5551 works as before (it does not try to
use that config), and t5563 will either work out of the box (for recent
versions), or web server setup will fail, and we'll skip all tests.

BUT. That won't work if you have set GIT_TEST_HTTPD=1, rather than the
default of "auto". Because then it is instructed to complain about
webserver setup failing, so t5563 will fail rather than skip. So we have
a few options there:

  1. You use the looser value of GIT_TEST_HTTPD for CentOS tests, which
     would do the right thing. The downside is that if server setup
     failed for other reasons, we wouldn't notice and would silently
     skip the HTTP tests.

  2. We do some kind of version check in enable_cgipassauth(),
     and skip tests manually if it doesn't pass.

  3. You just skip the test manually on that platform with
     GIT_SKIP_TESTS=t5563.

Obviously (1) and (3) are the least work for us upstream, but I don't
think (2) would be too hard to do.

-Peff
