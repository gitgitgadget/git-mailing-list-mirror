Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B7EC83F12
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 21:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjH1Vrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 17:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjH1VrV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 17:47:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8D2189
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 14:47:18 -0700 (PDT)
Received: (qmail 526 invoked by uid 109); 28 Aug 2023 21:47:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Aug 2023 21:47:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4520 invoked by uid 111); 28 Aug 2023 21:47:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 17:47:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 17:47:17 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 02/22] sequencer: mark repository argument as unused
Message-ID: <20230828214717.GB3831137@coredump.intra.peff.net>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828214604.GA3830831@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In sequencer_get_last_command(), we don't ever look at the repository
parameter. It _should_ be used when calling into git_path_* functions,
but the one we use here is declared with the non-REPO variant of
GIT_PATH_FUNC(), and so just uses the_repository internally.

We could change the path helper to use REPO_GIT_PATH_FUNC(), but doing
so piecemeal is not great. There are 41 uses of GIT_PATH_FUNC() in
sequencer.c, and inconsistently switching one makes the code more
confusing. Likewise, this one function is used in half a dozen other
spots, all of which would need to start passing in a repository argument
(with rippling effects up the call stack).

So let's punt on that for now and just silence any -Wunused-parameter
warning.

Note that we could also drop this parameter entirely, as the function is
always called directly, and not as a callback that has to conform to
some external interface. But since we'd eventually want to use the
repository parameter, let's leave it in place to avoid disrupting the
callers twice.

Signed-off-by: Jeff King <peff@peff.net>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 82dc3e160e..41fd79d215 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2649,7 +2649,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	return item->commit ? 0 : -1;
 }
 
-int sequencer_get_last_command(struct repository *r, enum replay_action *action)
+int sequencer_get_last_command(struct repository *r UNUSED, enum replay_action *action)
 {
 	const char *todo_file, *bol;
 	struct strbuf buf = STRBUF_INIT;
-- 
2.42.0.505.g4c6fb48dec

