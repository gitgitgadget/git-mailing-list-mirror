Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DA6B20357
	for <e@80x24.org>; Sun,  9 Jul 2017 09:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752088AbdGIJ6N (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 05:58:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:34702 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751160AbdGIJ6M (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 05:58:12 -0400
Received: (qmail 2808 invoked by uid 109); 9 Jul 2017 09:58:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 09 Jul 2017 09:58:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32295 invoked by uid 111); 9 Jul 2017 09:58:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 09 Jul 2017 05:58:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jul 2017 05:58:10 -0400
Date:   Sun, 9 Jul 2017 05:58:10 -0400
From:   Jeff King <peff@peff.net>
To:     Leo Razoumov <slonik.az@gmail.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/3] branch: only perform HEAD check for local branches
Message-ID: <20170709095810.vtwclyvqbayit2u6@sigill.intra.peff.net>
References: <20170709095708.moymrozmqdv2oixx@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170709095708.moymrozmqdv2oixx@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When assembling the ref-filter format to show "git branch"
output, we put the "%(if)%(HEAD)" conditional at the start
of the overall format. But there's no point in checking
whether a remote branch matches HEAD, as it never will.
The check should go inside the local conditional; we
assemble that format inside the "local" strbuf.

By itself, this is just a minor optimization. But in a
future patch, we'll need this refactoring to fix
local-branch coloring.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index c958e9325..a849373b7 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -335,8 +335,9 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 	struct strbuf local = STRBUF_INIT;
 	struct strbuf remote = STRBUF_INIT;
 
-	strbuf_addf(&fmt, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)",
+	strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)",
 		    branch_get_color(BRANCH_COLOR_CURRENT));
+	strbuf_addf(&remote, "  ");
 
 	if (filter->verbose) {
 		struct strbuf obname = STRBUF_INIT;
-- 
2.13.2.1066.gabaed60bd

