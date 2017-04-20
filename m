Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62DA2207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031470AbdDTVJj (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:09:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:37267 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030615AbdDTVJi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:09:38 -0400
Received: (qmail 2101 invoked by uid 109); 20 Apr 2017 21:09:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 21:09:37 +0000
Received: (qmail 9706 invoked by uid 111); 20 Apr 2017 21:10:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 17:10:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 17:09:35 -0400
Date:   Thu, 20 Apr 2017 17:09:35 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 6/6] am: drop "dir" parameter from am_state_init
Message-ID: <20170420210935.dx2old5l6yuakqhq@sigill.intra.peff.net>
References: <20170420210754.bzrnc74dpjs7fgpf@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170420210754.bzrnc74dpjs7fgpf@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The only caller of this function passes in a static buffer
returned from git_path(). This looks dangerous at first
glance, but turns out to be OK because the first thing we do
is xstrdup() the result.

Let's turn this into a git_pathdup(). That's slightly more
efficient (no extra copy), and makes it easier to audit for
dangerous git_path() invocations.

Since there's only a single caller, let's just set this
default path inside the init function. That makes the memory
ownership clear.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/am.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index f7a7a971f..97849d4dc 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -134,17 +134,15 @@ struct am_state {
 };
 
 /**
- * Initializes am_state with the default values. The state directory is set to
- * dir.
+ * Initializes am_state with the default values.
  */
-static void am_state_init(struct am_state *state, const char *dir)
+static void am_state_init(struct am_state *state)
 {
 	int gpgsign;
 
 	memset(state, 0, sizeof(*state));
 
-	assert(dir);
-	state->dir = xstrdup(dir);
+	state->dir = git_pathdup("rebase-apply");
 
 	state->prec = 4;
 
@@ -2322,7 +2320,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	git_config(git_am_config, NULL);
 
-	am_state_init(&state, git_path("rebase-apply"));
+	am_state_init(&state);
 
 	in_progress = am_in_progress(&state);
 	if (in_progress)
-- 
2.13.0.rc0.363.g8726c260e
