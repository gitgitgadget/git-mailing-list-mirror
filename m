Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2895C54EE9
	for <git@archiver.kernel.org>; Sun, 11 Sep 2022 04:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiIKE6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 00:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiIKE6L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 00:58:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EB63ECEA
        for <git@vger.kernel.org>; Sat, 10 Sep 2022 21:58:10 -0700 (PDT)
Received: (qmail 18243 invoked by uid 109); 11 Sep 2022 04:58:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 11 Sep 2022 04:58:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31474 invoked by uid 111); 11 Sep 2022 04:58:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 11 Sep 2022 00:58:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 11 Sep 2022 00:58:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 1/4] list-objects-filter: don't memset after releasing filter
 struct
Message-ID: <Yx1q4crkHGNzwLhh@coredump.intra.peff.net>
References: <Yx1qwlpNbxGEiUgc@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yx1qwlpNbxGEiUgc@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we see an error while parsing a "combine" filter, we call
list_objects_filter_release() to free any allocated memory,
and then use memset() to return the struct to a known state. But the
release function already does that reinitializing. Doing it again is
pointless.

Signed-off-by: Jeff King <peff@peff.net>
---
 list-objects-filter-options.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 6cc4eb8e1c..ea989db260 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -187,10 +187,8 @@ static int parse_combine_filter(
 
 cleanup:
 	strbuf_list_free(subspecs);
-	if (result) {
+	if (result)
 		list_objects_filter_release(filter_options);
-		memset(filter_options, 0, sizeof(*filter_options));
-	}
 	return result;
 }
 
-- 
2.37.3.1242.g835d375f85

