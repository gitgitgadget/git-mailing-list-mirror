Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B96FE20248
	for <e@80x24.org>; Thu,  4 Apr 2019 23:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbfDDX3P (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 19:29:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:47440 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729999AbfDDX3P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 19:29:15 -0400
Received: (qmail 1513 invoked by uid 109); 4 Apr 2019 23:29:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Apr 2019 23:29:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20497 invoked by uid 111); 4 Apr 2019 23:29:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Apr 2019 19:29:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2019 19:29:13 -0400
Date:   Thu, 4 Apr 2019 19:29:13 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 09/12] server-info: drop nr_alloc struct member
Message-ID: <20190404232913.GI21839@sigill.intra.peff.net>
References: <20190404232104.GA27770@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190404232104.GA27770@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We keep an array of struct pointers, with each one representing a single
packfile. But for some reason there is a nr_alloc parameter inside each
struct, which has never been used.

This is probably cruft left over from development, where we might have
wanted a nr_alloc to dynamically grow the list. But as it turns out, we
do not dynamically grow the list at all, but rather count up the total
number of packs and use that as a maximum size. So while we're thinking
of this, let's add an assert() that documents (and checks!) that our
allocation and fill loops stay in sync.

Signed-off-by: Jeff King <peff@peff.net>
---
 server-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/server-info.c b/server-info.c
index d4115fecbb..c9fbfd3a51 100644
--- a/server-info.c
+++ b/server-info.c
@@ -91,7 +91,6 @@ static struct pack_info {
 	struct packed_git *p;
 	int old_num;
 	int new_num;
-	int nr_alloc;
 } **info;
 static int num_pack;
 static const char *objdir;
@@ -213,6 +212,7 @@ static void init_pack_info(const char *infofile, int force)
 	for (i = 0, p = get_all_packs(the_repository); p; p = p->next) {
 		if (!p->pack_local)
 			continue;
+		assert(i < num_pack);
 		info[i] = xcalloc(1, sizeof(struct pack_info));
 		info[i]->p = p;
 		info[i]->old_num = -1;
-- 
2.21.0.714.gd1be1d035b

