Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE90C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 20:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjC1U7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC1U7B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 16:59:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F609B
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:58:43 -0700 (PDT)
Received: (qmail 2350 invoked by uid 109); 28 Mar 2023 20:58:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Mar 2023 20:58:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2251 invoked by uid 111); 28 Mar 2023 20:58:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 16:58:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 16:58:42 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 7/7] parse-options: drop parse_opt_unknown_cb()
Message-ID: <20230328205842.GG1754055@coredump.intra.peff.net>
References: <20230328205253.GA1753925@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230328205253.GA1753925@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This low-level callback was introduced in ce564eb1bd5 (parse-options:
add parse_opt_unknown_cb(), 2016-09-05) so that we could advertise
--indent-heuristic in git-blame's "-h" output, even though the option is
actually handled in parse_revision_opt(). We later stopped doing so in
44ae131e384 (builtin/blame.c: remove '--indent-heuristic' from usage
string, 2019-10-28).

This is a weird thing to do, and in the intervening years, we've never
used it again. Let's drop the helper in the name of simplicity.

Signed-off-by: Jeff King <peff@peff.net>
---
I guess this one is an oddball in this series, is it isn't about argv
directly. But it is argv-adjacent, and it needs to happen at some point
to silence the unused parameter warning.

 parse-options-cb.c | 15 ---------------
 parse-options.h    |  3 ---
 2 files changed, 18 deletions(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index d346dbe2100..4729277aa69 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -213,21 +213,6 @@ int parse_opt_noop_cb(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-/**
- * Report that the option is unknown, so that other code can handle
- * it. This can be used as a callback together with
- * OPTION_LOWLEVEL_CALLBACK to allow an option to be documented in the
- * "-h" output even if it's not being handled directly by
- * parse_options().
- */
-enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
-					   const struct option *opt,
-					   const char *arg, int unset)
-{
-	BUG_ON_OPT_ARG(arg);
-	return PARSE_OPT_UNKNOWN;
-}
-
 /**
  * Recreates the command-line option in the strbuf.
  */
diff --git a/parse-options.h b/parse-options.h
index 50d852f2991..60b0a758d6b 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -348,9 +348,6 @@ int parse_opt_commit(const struct option *, const char *, int);
 int parse_opt_tertiary(const struct option *, const char *, int);
 int parse_opt_string_list(const struct option *, const char *, int);
 int parse_opt_noop_cb(const struct option *, const char *, int);
-enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
-					   const struct option *,
-					   const char *, int);
 int parse_opt_passthru(const struct option *, const char *, int);
 int parse_opt_passthru_argv(const struct option *, const char *, int);
 /* value is enum branch_track* */
-- 
2.40.0.675.gb17cd5d94c8
