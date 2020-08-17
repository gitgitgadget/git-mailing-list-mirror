Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E471C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 453E72065D
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgHQVdJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:33:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:33556 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgHQVdG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 17:33:06 -0400
Received: (qmail 6686 invoked by uid 109); 17 Aug 2020 21:33:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Aug 2020 21:33:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22263 invoked by uid 111); 17 Aug 2020 21:33:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Aug 2020 17:33:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Aug 2020 17:33:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/7] submodule--helper: use strbuf_release() to free
 strbufs
Message-ID: <20200817213304.GB1854722@coredump.intra.peff.net>
References: <20200817213228.GA1854603@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200817213228.GA1854603@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The prepare_to_clone_next_submodule() function has a few local-variable
strbufs. We use strbuf_reset() throughout the function to reuse the
buffers over and over. But at the end of the function we also use
strbuf_reset() as they go out of scope, which means we end up leaking
their heap buffers. This should be strbuf_release() instead.

These were introduced by 48308681b0 (git submodule update: have a
dedicated helper for cloning, 2016-02-29), but it doesn't seem to have
the same mistake elsewhere. Likewise, I looked for other instances of
the pattern in the submodule--helper file but couldn't find any.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/submodule--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index df135abbf1..1762458345 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1747,8 +1747,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 					      "--no-single-branch");
 
 cleanup:
-	strbuf_reset(&displaypath_sb);
-	strbuf_reset(&sb);
+	strbuf_release(&displaypath_sb);
+	strbuf_release(&sb);
 	if (need_free_url)
 		free((void*)url);
 
-- 
2.28.0.605.g35fde94f44

