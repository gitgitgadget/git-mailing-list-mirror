Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33B9E202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 17:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752978AbdJSRtF (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 13:49:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:57868 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752202AbdJSRtD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 13:49:03 -0400
Received: (qmail 29126 invoked by uid 109); 19 Oct 2017 17:49:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 17:49:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10232 invoked by uid 111); 19 Oct 2017 17:49:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 13:49:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 13:49:01 -0400
Date:   Thu, 19 Oct 2017 13:49:01 -0400
From:   Jeff King <peff@peff.net>
To:     Andrey Okoshkin <a.okoshkin@samsung.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, pclouds@gmail.com,
        l.s.r@web.de, avarab@gmail.com, krh@redhat.com, rctay89@gmail.com,
        Ivan Arishchenko <i.arishchenk@samsung.com>,
        Mikhail Labiuk <m.labiuk@samsung.com>
Subject: [PATCH 3/4] log: handle broken HEAD in decoration check
Message-ID: <20171019174900.4a5qypeabbt4mgwc@sigill.intra.peff.net>
References: <20171019174452.hd3c47ocducddvgr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171019174452.hd3c47ocducddvgr@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The resolve_ref_unsafe() function may return NULL even with
a REF_ISSYMREF flag if a symref points to a broken ref. As a
result, it's possible for the decoration code's "is this
branch the current HEAD" check to segfault when it passes
the NULL to starts_with().

This is unlikely in practice, since we can only reach this
code if we already resolved HEAD to a matching sha1 earlier.
But it's possible if HEAD racily becomes broken, or if
there's a transient filesystem error.

We can fix this by returning early in the broken case, since
NULL could not possibly match any of our branch names.

Signed-off-by: Jeff King <peff@peff.net>
---
 log-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/log-tree.c b/log-tree.c
index cea056234d..580b3a98a0 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -198,7 +198,7 @@ static const struct name_decoration *current_pointed_by_HEAD(const struct name_d
 
 	/* Now resolve and find the matching current branch */
 	branch_name = resolve_ref_unsafe("HEAD", 0, NULL, &rru_flags);
-	if (!(rru_flags & REF_ISSYMREF))
+	if (!branch_name || !(rru_flags & REF_ISSYMREF))
 		return NULL;
 
 	if (!starts_with(branch_name, "refs/"))
-- 
2.15.0.rc1.560.g5f0609e481

