Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04019ECAAD5
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 04:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiIHE6P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 00:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIHE6N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 00:58:13 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F94B2CCB
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 21:58:13 -0700 (PDT)
Received: (qmail 24584 invoked by uid 109); 8 Sep 2022 04:58:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Sep 2022 04:58:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17827 invoked by uid 111); 8 Sep 2022 04:58:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Sep 2022 00:58:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Sep 2022 00:58:11 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 3/5] transport: free filter options in disconnect_git()
Message-ID: <Yxl2Yz8bg9T0dBGo@coredump.intra.peff.net>
References: <Yxl1BNQoy6Drf0Oe@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yxl1BNQoy6Drf0Oe@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a user of the transport API calls transport_set_option() with
TRANS_OPT_LIST_OBJECTS_FILTER, it doesn't pass a struct, but rather a
string with the filter-spec, which the transport code then stores in its
own list_objects_filter_options struct.

When the caller is done and we call transport_disconnect(), the contents
of that filter struct are then leaked. We should release it before
freeing the transport struct.

Another way to solve this would be for transport_set_option() to pass a
pointer to the struct. But that's awkward, because there's a generic
transport-option interface that always takes a string. Plus it opens up
questions of memory lifetimes; by storing its own filter-options struct,
the transport code remains self-contained.

Signed-off-by: Jeff King <peff@peff.net>
---
 transport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/transport.c b/transport.c
index 24540f642a..6ec6130852 100644
--- a/transport.c
+++ b/transport.c
@@ -895,6 +895,7 @@ static int disconnect_git(struct transport *transport)
 		finish_connect(data->conn);
 	}
 
+	list_objects_filter_release(&data->options.filter_options);
 	free(data);
 	return 0;
 }
-- 
2.37.3.1139.g47294c03c7

