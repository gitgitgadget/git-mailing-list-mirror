Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63334C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 07:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 652192064B
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 07:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgHDHuT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:50:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:47386 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgHDHuT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 03:50:19 -0400
Received: (qmail 614 invoked by uid 109); 4 Aug 2020 07:50:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Aug 2020 07:50:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9744 invoked by uid 111); 4 Aug 2020 07:50:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Aug 2020 03:50:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 Aug 2020 03:50:17 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 3/3] revision: avoid leak when preparing bloom filter for "/"
Message-ID: <20200804075017.GC284046@coredump.intra.peff.net>
References: <20200804074146.GA190027@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200804074146.GA190027@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we're given an empty pathspec, we refuse to set up bloom filters, as
described in f3c2a36810 (revision: empty pathspecs should not use Bloom
filters, 2020-07-01).

But before the empty string check, we drop any trailing slash by
allocating a new string without it. So a pathspec consisting only of "/"
will allocate that string, but then still cause us to bail, leaking the
new string. Let's make sure to free it.

Signed-off-by: Jeff King <peff@peff.net>
---
Just noticed while reading the function to fix the previous patch.

I'm not even sure if it's possible to get here with a pathspec of "/",
since we'd probably give a "/ is outside repository" error before then.

So maybe this case doesn't even matter. If it doesn't, then it might
simplify the function a bit to do the empty-pathspec check before
handling trailing slashes. But handling it does help make it more clear
this function is doing the right thing no matter what input it is given,
so that's what I went with here.

 revision.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.c b/revision.c
index 5ed86e4524..b80868556b 100644
--- a/revision.c
+++ b/revision.c
@@ -702,6 +702,7 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 	len = strlen(path);
 	if (!len) {
 		revs->bloom_filter_settings = NULL;
+		free(path_alloc);
 		return;
 	}
 
-- 
2.28.0.536.ga4d8134877
