Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1AD51FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 03:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938230AbdD0DZ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 23:25:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:40969 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934492AbdD0DZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 23:25:58 -0400
Received: (qmail 13801 invoked by uid 109); 27 Apr 2017 03:25:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 03:25:58 +0000
Received: (qmail 30651 invoked by uid 111); 27 Apr 2017 03:26:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Apr 2017 23:26:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Apr 2017 23:25:55 -0400
Date:   Wed, 26 Apr 2017 23:25:55 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] am: fix commit buffer leak in get_commit_info()
Message-ID: <20170427032555.imjr5to4uys2cz4k@sigill.intra.peff.net>
References: <20170427032503.rgz3bnctnxdn3hin@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170427032503.rgz3bnctnxdn3hin@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calling logmsg_reencode() may allocate a buffer for the
commit message (because we need to load it from disk, or
because it needs re-encoded). We must "unuse" it afterwards
to free it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/am.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/am.c b/builtin/am.c
index 805f56cec..baab951ed 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1421,6 +1421,7 @@ static void get_commit_info(struct am_state *state, struct commit *commit)
 		die(_("unable to parse commit %s"), oid_to_hex(&commit->object.oid));
 	state->msg = xstrdup(msg + 2);
 	state->msg_len = strlen(state->msg);
+	unuse_commit_buffer(commit, buffer);
 }
 
 /**
-- 
2.13.0.rc0.465.ga1e654229

