Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766D9EB64DC
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjGCGoK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjGCGoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:44:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33468CE
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:44:07 -0700 (PDT)
Received: (qmail 14029 invoked by uid 109); 3 Jul 2023 06:44:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:44:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2616 invoked by uid 111); 3 Jul 2023 06:44:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:44:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:44:05 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 03/14] http: mark unused parameters in curl callbacks
Message-ID: <20230703064405.GC3537614@coredump.intra.peff.net>
References: <20230703064347.GA3524892@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703064347.GA3524892@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These functions are all used as callbacks for curl, so they have to
conform to a particular interface. But they don't need all of their
parameters:

  - fwrite_null() throws away the input, so it doesn't look at most
    parameters

  - fwrite_wwwauth() in theory could take the auth struct in its void
    pointer, but instead we just access it as the global http_auth
    (matching the rest of the code in this file)

  - curl_trace() always writes via the trace mechanism, so it doesn't
    need its void pointer to know where to send things. Likewise, it
    ignores the CURL parameter, since nothing we trace requires querying
    the handle.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index 5772c8ced3..5b8e9c8c48 100644
--- a/http.c
+++ b/http.c
@@ -196,7 +196,7 @@ static inline int is_hdr_continuation(const char *ptr, const size_t size)
 	return size && (*ptr == ' ' || *ptr == '\t');
 }
 
-static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
+static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p UNUSED)
 {
 	size_t size = eltsize * nmemb;
 	struct strvec *values = &http_auth.wwwauth_headers;
@@ -295,7 +295,8 @@ static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
 	return size;
 }
 
-size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf)
+size_t fwrite_null(char *ptr UNUSED, size_t eltsize UNUSED, size_t nmemb,
+		   void *data UNUSED)
 {
 	return nmemb;
 }
@@ -820,7 +821,9 @@ static void curl_dump_info(char *data, size_t size)
 	strbuf_release(&buf);
 }
 
-static int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size, void *userp)
+static int curl_trace(CURL *handle UNUSED, curl_infotype type,
+		      char *data, size_t size,
+		      void *userp UNUSED)
 {
 	const char *text;
 	enum { NO_FILTER = 0, DO_FILTER = 1 };
-- 
2.41.0.586.g3c0cc15bc7

