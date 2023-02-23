Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CF4C64ED8
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 10:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjBWKwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 05:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbjBWKwN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 05:52:13 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92C25A38D
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 02:52:11 -0800 (PST)
Received: (qmail 24795 invoked by uid 109); 23 Feb 2023 10:52:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Feb 2023 10:52:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20118 invoked by uid 111); 23 Feb 2023 10:52:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 05:52:10 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 05:52:10 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 04/16] t5551: drop redundant grep for Accept-Language
Message-ID: <Y/dFWqzaCeCbmGUs@coredump.intra.peff.net>
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit b0c4adcdd7 (remote-curl: send Accept-Language header to server,
2022-07-11) added tests to make sure the header is sent via HTTP.
However, it checks in two places:

  1. In the expected trace output, we check verbatim for the header and
     its value.

  2. Afterwards, we grep for the header again in the trace file.

This (2) is probably cargo-culted from the earlier grep for
Accept-Encoding. It is needed for the encoding because we smudge the
value of that header when doing the verbatim check; see 1a53e692af
(remote-curl: accept all encodings supported by curl, 2018-05-22).

But we don't do so for the language header, so any problem that the
"grep" would catch in (2) would already have been caught by (1).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5551-http-fetch-smart.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 10b7e7cda2..29d489768e 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -103,10 +103,7 @@ test_expect_success 'clone http repository' '
 		test_cmp exp actual.smudged &&
 
 		grep "Accept-Encoding:.*gzip" actual >actual.gzip &&
-		test_line_count = 2 actual.gzip &&
-
-		grep "Accept-Language: ko-KR, *" actual >actual.language &&
-		test_line_count = 2 actual.language
+		test_line_count = 2 actual.gzip
 	fi
 '
 
-- 
2.39.2.981.g6157336f25

