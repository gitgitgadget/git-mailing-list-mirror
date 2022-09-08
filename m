Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838A3ECAAD5
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 04:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiIHEye (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 00:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIHEyc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 00:54:32 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA4E627E
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 21:54:30 -0700 (PDT)
Received: (qmail 24570 invoked by uid 109); 8 Sep 2022 04:54:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Sep 2022 04:54:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17785 invoked by uid 111); 8 Sep 2022 04:54:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Sep 2022 00:54:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Sep 2022 00:54:29 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 1/5] list_objects_filter_copy(): deep-copy sparse_oid_name
 field
Message-ID: <Yxl1hcX97W4wpWNj@coredump.intra.peff.net>
References: <Yxl1BNQoy6Drf0Oe@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yxl1BNQoy6Drf0Oe@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The purpose of our copy function is to do a deep copy of each field so
that the source and destination structs become independent. We correctly
copy the filter_spec string list, but we forgot the sparse_oid_name
field. By doing a shallow copy of the pointer, that puts us at risk for
a use-after-free if one or both of the structs is cleaned up.

I don't think this can be triggered in practice, because we tend to leak
the structs rather than actually clean them up. But this should
future-proof us for plugging those leaks.

Signed-off-by: Jeff King <peff@peff.net>
---
I think this is the only thing missing. You can correlate with the
_release() function to see what other things might need a deep copy, and
everything else seems covered.

 list-objects-filter-options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 4b25287886..41c41c9d45 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -418,6 +418,7 @@ void list_objects_filter_copy(
 	string_list_init_dup(&dest->filter_spec);
 	for_each_string_list_item(item, &src->filter_spec)
 		string_list_append(&dest->filter_spec, item->string);
+	dest->sparse_oid_name = xstrdup_or_null(src->sparse_oid_name);
 
 	ALLOC_ARRAY(dest->sub, dest->sub_alloc);
 	for (i = 0; i < src->sub_nr; i++)
-- 
2.37.3.1139.g47294c03c7

