Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD789C83F29
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 07:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243886AbjHaHON (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 03:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjHaHOM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 03:14:12 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7331B2
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 00:14:02 -0700 (PDT)
Received: (qmail 21351 invoked by uid 109); 31 Aug 2023 07:14:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 07:14:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3458 invoked by uid 111); 31 Aug 2023 07:14:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 03:14:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 03:14:01 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 2/8] merge: simplify parsing of "-n" option
Message-ID: <20230831071401.GB3197647@coredump.intra.peff.net>
References: <20230831070935.GA3197495@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831070935.GA3197495@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "-n" option is implemented by an option callback, as it is really a
"reverse bool". If given, it sets show_diffstat to 0. In theory, when
negated, it would set the same flag to 1. But it's not possible to
trigger that, since short options cannot be negated.

So in practice this is really just a SET_INT to 0. Let's use that
instead, which shortens the code.

Note that negation here would do the wrong thing (as with any SET_INT
with a value of "0"). We could specify PARSE_OPT_NONEG to future-proof
ourselves against somebody adding a long option name (which would make
it possible to negate). But there's not much point:

  1. Nobody is going to do that, because the negated form already
     exists, and is called "--stat" (which is defined separately so that
     "--no-stat" works).

  2. If they did, the BUG() check added by 3284b93862 (parse-options:
     disallow negating OPTION_SET_INT 0, 2023-08-08) will catch it (and
     that check is smart enough to realize that our short-only option is
     OK).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/merge.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 53e9fe70d9..21363b7985 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -241,18 +241,9 @@ static int option_parse_strategy(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_n(const struct option *opt,
-			  const char *arg, int unset)
-{
-	BUG_ON_OPT_ARG(arg);
-	show_diffstat = unset;
-	return 0;
-}
-
 static struct option builtin_merge_options[] = {
-	OPT_CALLBACK_F('n', NULL, NULL, NULL,
-		N_("do not show a diffstat at the end of the merge"),
-		PARSE_OPT_NOARG, option_parse_n),
+	OPT_SET_INT('n', NULL, &show_diffstat,
+		N_("do not show a diffstat at the end of the merge"), 0),
 	OPT_BOOL(0, "stat", &show_diffstat,
 		N_("show a diffstat at the end of the merge")),
 	OPT_BOOL(0, "summary", &show_diffstat, N_("(synonym to --stat)")),
-- 
2.42.0.561.gaa987ecc69

