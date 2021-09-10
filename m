Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E5AC433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7044461026
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbhIJOF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 10:05:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:43856 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233658AbhIJOFz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 10:05:55 -0400
Received: (qmail 5763 invoked by uid 109); 10 Sep 2021 14:04:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Sep 2021 14:04:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25286 invoked by uid 111); 10 Sep 2021 14:04:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Sep 2021 10:04:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Sep 2021 10:04:42 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: [PATCH 1/5] t5551: test v2-to-v0 http protocol fallback
Message-ID: <YTtl+gB0V+fe1hOJ@coredump.intra.peff.net>
References: <YTtleYs48A1NpUpp@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTtleYs48A1NpUpp@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we use the v2 protocol by default, the connection of a v2 client
to a v2 server is well covered by the test suite. And with the
GIT_TEST_PROTOCOL_VERSION knob, we can easily test a v0 client
connecting to a v2-aware server (which will then just speak v0). But we
have no regular tests that a v2 client, when encountering a non-v2-aware
server, will correctly fall back to using v0.

In theory this is a job for the cross-version tests in t/interop, but:

  - they cover only git:// and file:// clones

  - they are not part of the usual test suite, so nobody ever runs them
    anyway

Since using v2 over http requires configuring the web server to pass
along the Git-Protocol header, we can easily create a situation where
the server does not respect the v2 probe, and the conversation falls
back to v0.

This works just fine. This new test is not about fixing any particular
bug, but just making sure that the system works (and continues to work)
as expected.

Signed-off-by: Jeff King <peff@peff.net>
---
Not strictly necessary for this series, but it seemed like a good chance
to beef up test coverage, and make sure the setenv() overwrite flag in
the next patch was set sensibly. :)

 t/lib-httpd/apache.conf     | 5 +++++
 t/t5551-http-fetch-smart.sh | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index afa91e38b0..1321357d8b 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -117,6 +117,11 @@ Alias /auth/dumb/ www/auth/dumb/
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
 </LocationMatch>
+<LocationMatch /smart_v0/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+	SetEnv GIT_PROTOCOL
+</LocationMatch>
 ScriptAlias /smart/incomplete_length/git-upload-pack incomplete-length-upload-pack-v2-http.sh/
 ScriptAlias /smart/incomplete_body/git-upload-pack incomplete-body-upload-pack-v2-http.sh/
 ScriptAliasMatch /error_git_upload_pack/(.*)/git-upload-pack error.sh/
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 4f87d90c5b..cffc47a8e3 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -558,4 +558,13 @@ test_expect_success 'http auth forgets bogus credentials' '
 	expect_askpass both user@host
 '
 
+test_expect_success 'client falls back from v2 to v0 to match server' '
+	GIT_TRACE_PACKET=$PWD/trace \
+	GIT_TEST_PROTOCOL_VERSION=2 \
+	git clone $HTTPD_URL/smart_v0/repo.git repo-v0 &&
+	# check for v0; there the HEAD symref is communicated in the capability
+	# line; v2 uses a different syntax on each ref advertisement line
+	grep symref=HEAD:refs/heads/ trace
+'
+
 test_done
-- 
2.33.0.731.g24eb83922d

