Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C52C636D7
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 10:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjBWK5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 05:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjBWK53 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 05:57:29 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B957E43925
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 02:57:28 -0800 (PST)
Received: (qmail 24890 invoked by uid 109); 23 Feb 2023 10:57:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Feb 2023 10:57:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20162 invoked by uid 111); 23 Feb 2023 10:57:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 05:57:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 05:57:27 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 07/16] t5551: stop forcing clone to run with v0 protocol
Message-ID: <Y/dGl990U3gMCwY4@coredump.intra.peff.net>
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the "clone http repository" test, we check the curl trace to make
sure the expected requests were made. This whole script was marked to
handle only the v0 protocol in d790ee1707 (tests: fix protocol version
for overspecifications, 2019-02-25). That makes sense, since v2 requires
an extra request, so tests as specific as this would fail unless
modified.

Later, in preparation for v2 becoming the default, this was tweaked by
8a1b0978ab (test: request GIT_TEST_PROTOCOL_VERSION=0 when appropriate,
2019-12-23). There we run the trace check only if the user has
explicitly asked to test protocol version 0. But it also forced the
clone itself to run with the v0 protocol.

This makes the check for "can we expect a v0 trace" silly; it will
always be v0. But much worse, it means that the clone we are testing is
not like the one that normal users would run. They would use the
defaults, which are now v2.  And since this is supposed to be a basic
check of clone-over-http, we should do the same.

Let's fix this by dropping the extra v0 override. The test still passes
because the trace checking only kicks in if we asked to use v0
explicitly (this is the same as before; even though we were running a v0
clone, unless you specifically set GIT_TEST_PROTOCOL_VERSION=0, the
trace check was always skipped).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5551-http-fetch-smart.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 716c9dbb69..4191174584 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -55,7 +55,7 @@ test_expect_success 'clone http repository' '
 	< content-type: application/x-git-upload-pack-result
 	EOF
 
-	GIT_TRACE_CURL=true GIT_TEST_PROTOCOL_VERSION=0 LANGUAGE="ko_KR.UTF-8" \
+	GIT_TRACE_CURL=true LANGUAGE="ko_KR.UTF-8" \
 		git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
 	test_cmp file clone/file &&
 	tr '\''\015'\'' Q <err |
-- 
2.39.2.981.g6157336f25

