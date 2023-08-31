Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C744C83F2B
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 07:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbjHaHSt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 03:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjHaHSt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 03:18:49 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A486F1B1
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 00:18:46 -0700 (PDT)
Received: (qmail 21380 invoked by uid 109); 31 Aug 2023 07:18:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 07:18:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3512 invoked by uid 111); 31 Aug 2023 07:18:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 03:18:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 03:18:45 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 5/8] merge: do not pass unused opt->value parameter
Message-ID: <20230831071845.GC3197751@coredump.intra.peff.net>
References: <20230831070935.GA3197495@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831070935.GA3197495@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The option_parse_strategy() callback does not look at opt->value;
instead it calls append_strategy(), which manipulates the global
use_strategies array directly. But the OPT_CALLBACK declaration assigns
"&use_strategies" to opt->value.

One could argue this is good, as it tells the reader what we generally
expect the callback to do. But it is also bad, because it can mislead
you into thinking that swapping out "&use_strategies" there might have
any effect. Let's switch it to pass NULL (which is what every other
"does not bother to look at opt->value" callback does). If you want to
know what the callback does, it's easy to read the function itself.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 0436986dab..545da0c8a1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -264,7 +264,7 @@ static struct option builtin_merge_options[] = {
 	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 	OPT_BOOL(0, "verify-signatures", &verify_signatures,
 		N_("verify that the named commit has a valid GPG signature")),
-	OPT_CALLBACK('s', "strategy", &use_strategies, N_("strategy"),
+	OPT_CALLBACK('s', "strategy", NULL, N_("strategy"),
 		N_("merge strategy to use"), option_parse_strategy),
 	OPT_STRVEC('X', "strategy-option", &xopts, N_("option=value"),
 		N_("option for selected merge strategy")),
-- 
2.42.0.561.gaa987ecc69

