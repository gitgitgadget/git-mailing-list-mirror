Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F384EC83F37
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 21:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347503AbjHaVRW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 17:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347502AbjHaVRV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 17:17:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F342FF
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 14:17:18 -0700 (PDT)
Received: (qmail 25961 invoked by uid 109); 31 Aug 2023 21:17:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 21:17:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11535 invoked by uid 111); 31 Aug 2023 21:17:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 17:17:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 17:17:16 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 02/10] merge: simplify parsing of "-n" option
Message-ID: <20230831211716.GB949469@coredump.intra.peff.net>
References: <20230831211637.GA949188@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831211637.GA949188@coredump.intra.peff.net>
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

