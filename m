Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6596DC54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 19:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiIHTY3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 15:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIHTY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 15:24:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9243B1
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 12:24:22 -0700 (PDT)
Received: (qmail 28601 invoked by uid 109); 8 Sep 2022 19:24:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Sep 2022 19:24:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23811 invoked by uid 111); 8 Sep 2022 19:24:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Sep 2022 15:24:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Sep 2022 15:24:21 -0400
From:   Jeff King <peff@peff.net>
To:     Lana Deere <lana.deere@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: [PATCH 1/2] fetch: stop checking for NULL transport->remote in
 do_fetch()
Message-ID: <YxpBZUyiSJcQ+EMD@coredump.intra.peff.net>
References: <YxpBMaIckimFJYEi@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YxpBMaIckimFJYEi@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This field will never be NULL; if it were, we'd segfault earlier in the
function when we unconditionally check transport->remote->fetch_tags.
Likewise, many other functions dereference it unconditionally.

This is a small simplification, but it will make things easier as we
extend this conditional in the next patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 368a0f5329..f78146ca81 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1616,7 +1616,7 @@ static int do_fetch(struct transport *transport,
 				break;
 			}
 		}
-	} else if (transport->remote && transport->remote->fetch.nr)
+	} else if (transport->remote->fetch.nr)
 		refspec_ref_prefixes(&transport->remote->fetch,
 				     &transport_ls_refs_options.ref_prefixes);
 
-- 
2.37.3.1164.gb600acaa9f

