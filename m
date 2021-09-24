Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48F8C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB15461050
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346729AbhIXSt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:49:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:54688 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244073AbhIXStz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:49:55 -0400
Received: (qmail 19166 invoked by uid 109); 24 Sep 2021 18:48:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 18:48:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11218 invoked by uid 111); 24 Sep 2021 18:48:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 14:48:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 14:48:20 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 15/16] ref-filter: drop broken-ref code entirely
Message-ID: <YU4ddK+tLFwj9oCT@coredump.intra.peff.net>
References: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that none of our callers passes the INCLUDE_BROKEN flag, we can drop
it entirely, along with the code to plumb it through to the
for_each_fullref_in() functions.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 11 ++++-------
 ref-filter.h |  1 -
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 93ce2a6ef2..e59bb4cf9c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2405,13 +2405,10 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 {
 	struct ref_filter_cbdata ref_cbdata;
 	int ret = 0;
-	unsigned int broken = 0;
 
 	ref_cbdata.array = array;
 	ref_cbdata.filter = filter;
 
-	if (type & FILTER_REFS_INCLUDE_BROKEN)
-		broken = 1;
 	filter->kind = type & FILTER_REFS_KIND_MASK;
 
 	init_contains_cache(&ref_cbdata.contains_cache);
@@ -2428,13 +2425,13 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 		 * of filter_ref_kind().
 		 */
 		if (filter->kind == FILTER_REFS_BRANCHES)
-			ret = for_each_fullref_in("refs/heads/", ref_filter_handler, &ref_cbdata, broken);
+			ret = for_each_fullref_in("refs/heads/", ref_filter_handler, &ref_cbdata, 0);
 		else if (filter->kind == FILTER_REFS_REMOTES)
-			ret = for_each_fullref_in("refs/remotes/", ref_filter_handler, &ref_cbdata, broken);
+			ret = for_each_fullref_in("refs/remotes/", ref_filter_handler, &ref_cbdata, 0);
 		else if (filter->kind == FILTER_REFS_TAGS)
-			ret = for_each_fullref_in("refs/tags/", ref_filter_handler, &ref_cbdata, broken);
+			ret = for_each_fullref_in("refs/tags/", ref_filter_handler, &ref_cbdata, 0);
 		else if (filter->kind & FILTER_REFS_ALL)
-			ret = for_each_fullref_in_pattern(filter, ref_filter_handler, &ref_cbdata, broken);
+			ret = for_each_fullref_in_pattern(filter, ref_filter_handler, &ref_cbdata, 0);
 		if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
 			head_ref(ref_filter_handler, &ref_cbdata);
 	}
diff --git a/ref-filter.h b/ref-filter.h
index c15dee8d6b..b636f4389d 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -13,7 +13,6 @@
 #define QUOTE_PYTHON 4
 #define QUOTE_TCL 8
 
-#define FILTER_REFS_INCLUDE_BROKEN 0x0001
 #define FILTER_REFS_TAGS           0x0002
 #define FILTER_REFS_BRANCHES       0x0004
 #define FILTER_REFS_REMOTES        0x0008
-- 
2.33.0.1071.gb37e412355

