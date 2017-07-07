Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D82A202AC
	for <e@80x24.org>; Fri,  7 Jul 2017 09:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752625AbdGGJIs (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 05:08:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:33480 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752123AbdGGJHh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 05:07:37 -0400
Received: (qmail 8388 invoked by uid 109); 7 Jul 2017 09:07:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 09:07:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20746 invoked by uid 111); 7 Jul 2017 09:07:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 05:07:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jul 2017 05:07:34 -0400
Date:   Fri, 7 Jul 2017 05:07:34 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Kyle Meyer <kyle@kyleam.com>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: [PATCH v2 3/7] log: do not free parents when walking reflog
Message-ID: <20170707090734.x2ki7lluawf66g4a@sigill.intra.peff.net>
References: <20170707090507.ko2ygry7j4zv7t3s@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170707090507.ko2ygry7j4zv7t3s@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we're doing a reflog walk (instead of walking the
actual parent pointers), we may see commits multiple times.
For this reason, we hold on to the commit buffer for each
commit rather than freeing it after we've showed the commit.

We should do the same for the parent list. Right now this is
just a minor optimization. But once we refactor how reflog
walks are performed, keeping the parents will avoid
confusing us the second time we see the commit.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 8ca1de9894..9c8bb3b5c3 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -374,9 +374,9 @@ static int cmd_log_walk(struct rev_info *rev)
 		if (!rev->reflog_info) {
 			/* we allow cycles in reflog ancestry */
 			free_commit_buffer(commit);
+			free_commit_list(commit->parents);
+			commit->parents = NULL;
 		}
-		free_commit_list(commit->parents);
-		commit->parents = NULL;
 		if (saved_nrl < rev->diffopt.needed_rename_limit)
 			saved_nrl = rev->diffopt.needed_rename_limit;
 		if (rev->diffopt.degraded_cc_to_c)
-- 
2.13.2.1000.g8590c1af5d

