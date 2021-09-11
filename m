Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C92C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 15:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FC9661208
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 15:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhIKPCb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 11:02:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:44986 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230282AbhIKPCa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 11:02:30 -0400
Received: (qmail 12578 invoked by uid 109); 11 Sep 2021 15:01:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Sep 2021 15:01:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21120 invoked by uid 111); 11 Sep 2021 15:01:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Sep 2021 11:01:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 11 Sep 2021 11:01:16 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] strvec: use size_t to store nr and alloc
Message-ID: <YTzEvLHWcfuD20x4@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We converted argv_array (which later became strvec) to use size_t in
819f0e76b1 (argv-array: use size_t for count and alloc, 2020-07-28) in
order to avoid the possibility of integer overflow. But later, commit
d70a9eb611 (strvec: rename struct fields, 2020-07-28) accidentally
converted these back to ints!

Those two commits were part of the same patch series. I'm pretty sure
what happened is that they were originally written in the opposite order
and then cleaned up and re-ordered during an interactive rebase. And
when resolving the inevitable conflict, I mistakenly took the "rename"
patch completely, accidentally dropping the type change.

We can correct it now; better late than never.

Signed-off-by: Jeff King <peff@peff.net>
---
This was posted previously in the midst of another thread, but I don't
think was picked up. There was some positive reaction, but one "do we
really need this?" to which I responded in detail:

  https://lore.kernel.org/git/YTIBnT8Ue1HZXs82@coredump.intra.peff.net/

I don't really think any of that needs to go into the commit message,
but if that's a hold-up, I can try to summarize it (though I think
referring to the commit which _already_ did this and was accidentally
reverted would be sufficient).

 strvec.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/strvec.h b/strvec.h
index fdcad75b45..6b3cbd6758 100644
--- a/strvec.h
+++ b/strvec.h
@@ -29,8 +29,8 @@ extern const char *empty_strvec[];
  */
 struct strvec {
 	const char **v;
-	int nr;
-	int alloc;
+	size_t nr;
+	size_t alloc;
 };
 
 #define STRVEC_INIT { empty_strvec, 0, 0 }
-- 
2.33.0.811.g40f7f3a89c
