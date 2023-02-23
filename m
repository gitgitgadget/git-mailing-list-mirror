Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3281CC636D6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 11:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjBWLFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 06:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjBWLFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 06:05:09 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49A353EC7
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 03:05:08 -0800 (PST)
Received: (qmail 25048 invoked by uid 109); 23 Feb 2023 11:05:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Feb 2023 11:05:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20269 invoked by uid 111); 23 Feb 2023 11:05:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 06:05:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 06:05:07 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 12/16] t5551: drop curl trace lines without headers
Message-ID: <Y/dIY7wTfBuG9Rox@coredump.intra.peff.net>
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We pick apart a curl trace, looking for "=> Send header:" and so on, and
matching against an expected set of requests and responses. We remove
"== Info" lines entirely. However, our parser is fooled when running the
test with LIB_HTTPD_SSL on Ubuntu 20.04 (as found in our linux-gcc CI
job), as curl hands us an "Info" buffer with a newline, and we get:

  == Info: successfully set certificate verify locations:
  == Info:   CAfile: /etc/ssl/certs/ca-certificates.crt
    CApath: /etc/ssl/certs
  => Send SSL data[...]

which results in the "CApath" line ending up in the cleaned-up output,
causing the test to fail.

Arguably the tracing code should detect this and put it on two separate
"== Info" lines. But this is actually a curl bug, fixed by their
80d73bcca (tls: provide the CApath verbose log on its own line,
2020-08-18). It's simpler to just work around it here.

Since we are using GIT_TRACE_CURL, every line should just start with one
of "<=", "==", or "=>", and we can throw away anything else. In fact, we
can just replace the pattern for deleting "*" lines. Those were from the
old GIT_CURL_VERBOSE output, but we switched over in 14e24114d9
(t5551-http-fetch-smart.sh: use the GIT_TRACE_CURL environment var,
2016-09-05).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5551-http-fetch-smart.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 2e42271cb8..13b38c7ef5 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -86,7 +86,7 @@ test_expect_success 'clone http repository' '
 	'\'' |
 	sed -e "
 		s/Q\$//
-		/^[*] /d
+		/^[^<=]/d
 		/^== Info:/d
 		/^=> Send header, /d
 		/^=> Send header:$/d
-- 
2.39.2.981.g6157336f25

