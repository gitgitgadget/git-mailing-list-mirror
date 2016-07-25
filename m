Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F635203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 18:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbcGYSuP (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 14:50:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:48736 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753121AbcGYSuO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 14:50:14 -0400
Received: (qmail 9818 invoked by uid 102); 25 Jul 2016 18:50:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jul 2016 14:50:13 -0400
Received: (qmail 27476 invoked by uid 107); 25 Jul 2016 18:50:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jul 2016 14:50:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jul 2016 14:50:10 -0400
Date:	Mon, 25 Jul 2016 14:50:10 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH 1/2] pack-objects: break out of want_object loop early
Message-ID: <20160725185010.GA12974@sigill.intra.peff.net>
References: <20160725184938.GA12871@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160725184938.GA12871@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When pack-objects collects the list of objects to pack
(either from stdin, or via its internal rev-list), it
filters each one through want_object_in_pack().

This function loops through each existing packfile, looking
for the object. When we find it, we mark the pack/offset
combo for later use. However, we can't just return "yes, we
want it" at that point. If --honor-pack-keep is in effect,
we must keep looking to find it in _all_ packs, to make sure
none of them has a .keep. Likewise, if --local is in effect,
we must make sure it is not present in any local pack.

As a result, the sum effort of these calls is effectively
O(nr_objects * nr_packs). In an ordinary repository, we have
only a handful of packs, and this doesn't make a big
difference. But in pathological cases, it can slow the
counting phase to a crawl.

This patch notices the case that we have neither "--local"
nor "--honor-pack-keep" in effect and breaks out of the loop
early, after finding the first instance. Note that our worst
case is still "objects * packs" (i.e., we might find each
object in the last pack we look in), but in practice we will
often break out early. On an "average" repo, my git.git with
8 packs, this shows a modest 2% (a few dozen milliseconds)
improvement in the counting-objects phase of "git
pack-objects --all <foo" (hackily instrumented by sticking
exit(0) right after list_objects).

But in a much more pathological case, it makes a bigger
difference. I ran the same command on a real-world example
with ~9 million objects across 1300 packs. The counting time
dropped from 413s to 45s, an improvement of about 89%.

Note that this patch won't do anything by itself for a
normal "git gc", as it uses both --honor-pack-keep and
--local.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a2f8cfd..55ef5a8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -981,6 +981,8 @@ static int want_object_in_pack(const unsigned char *sha1,
 				return 0;
 			if (ignore_packed_keep && p->pack_local && p->pack_keep)
 				return 0;
+			if (!ignore_packed_keep && !local)
+				break;
 		}
 	}
 
-- 
2.9.2.512.g8a06708

