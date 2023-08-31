Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E6FC83F37
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 21:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbjHaVV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 17:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347551AbjHaVV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 17:21:57 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B2AE7F
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 14:21:50 -0700 (PDT)
Received: (qmail 26023 invoked by uid 109); 31 Aug 2023 21:21:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 21:21:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11607 invoked by uid 111); 31 Aug 2023 21:21:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 17:21:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 17:21:49 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 08/10] parse-options: add more BUG_ON() annotations
Message-ID: <20230831212149.GH949469@coredump.intra.peff.net>
References: <20230831211637.GA949188@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831211637.GA949188@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These callbacks are similar to the ones touched by 517fe807d6 (assert
NOARG/NONEG behavior of parse-options callbacks, 2018-11-05), but were
either missed in that commit (the one in add.c) or were added later (the
one in log.c).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/add.c | 2 ++
 builtin/log.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index 4b0dd798df..cf59108523 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -232,6 +232,8 @@ static char *chmod_arg;
 
 static int ignore_removal_cb(const struct option *opt, const char *arg, int unset)
 {
+	BUG_ON_OPT_ARG(arg);
+
 	/* if we are told to ignore, we are not adding removals */
 	*(int *)opt->value = !unset ? 0 : 1;
 	return 0;
diff --git a/builtin/log.c b/builtin/log.c
index 3599063554..190e1952e9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -121,6 +121,8 @@ static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
 static int clear_decorations_callback(const struct option *opt UNUSED,
 				      const char *arg, int unset)
 {
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
 	string_list_clear(&decorate_refs_include, 0);
 	string_list_clear(&decorate_refs_exclude, 0);
 	use_default_decoration_filter = 0;
-- 
2.42.0.561.gaa987ecc69

