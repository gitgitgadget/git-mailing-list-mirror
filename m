Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBE5C433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 06:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359420AbiFPGze (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 02:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359169AbiFPGzK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 02:55:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680685D5CC
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 23:54:42 -0700 (PDT)
Received: (qmail 12769 invoked by uid 109); 16 Jun 2022 06:54:41 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jun 2022 06:54:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Thu, 16 Jun 2022 02:54:41 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Richard Oliver <roliver@roku.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, jonathantanmy@google.com
Subject: [PATCH] is_promisor_object(): walk promisor packs in pack-order
Message-ID: <YqrTsbXbEjx0Pabn@coredump.intra.peff.net>
References: <77035a0f-c42e-5cb3-f422-03fe81093adb@roku.com>
 <0067c46a-7bfd-db9c-5156-16f032814464@github.com>
 <797af8c8-229f-538b-d122-8ea48067cc19@roku.com>
 <574dc4a9-b3c7-1fd3-8c0e-39071117c7f0@github.com>
 <YqkpRE8nykqVv8cn@nand.local>
 <YqlZb3Ycc71+dPu4@coredump.intra.peff.net>
 <ad9b5ec9-14fd-cd66-be87-2fe1eb24296a@roku.com>
 <1fe6c00a-806c-89de-cb67-d063dc4a5279@github.com>
 <YqrIrYHKUP6b/EtN@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqrIrYHKUP6b/EtN@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 16, 2022 at 02:07:41AM -0400, Jeff King wrote:

> Those rev-lists run in 1.7s and 224s respectively. Ouch!

Even though I expected the second one to be slow, I was shocked at just
how slow it was. The patch below speeds it up by a factor of 2, and I
think is worth applying separately, regardless of anything else being
discussed in this thread.

-- >8 --
Subject: is_promisor_object(): walk promisor packs in pack-order

When we generate the list of promisor objects, we walk every pack with a
.promisor file and examine its objects for any links to other objects.
By default, for_each_packed_object() will go in pack .idx order.

This is the worst case with respect to our delta base cache. If we have
a delta chain of A->B->C->D, then visiting A may require reconstructing
both B and C, unless we also visited B recently, in which case we may
have cached its value. Because .idx order is based on sha1, it's random
with respect to the actual object contents and deltas, and thus we're
unlikely to get many cache hits.

If we instead traverse in pack order, then we get the optimal case:
packs are written to keep delta families together, and to place bases
before their children.

Even on a modest repository like git.git, this has a noticeable speedup
on p5600.4, which runs "fsck" on a partial clone with blob:none (so lots
of trees which need to be walked, and which delta well):

Test       HEAD^               HEAD
-------------------------------------------------------
5600.4:    17.87(17.83+0.04)   15.42(15.35+0.06) -13.7%

On a larger repository like linux.git, the speedup is even more
pronounced:

Test       HEAD^                 HEAD
-----------------------------------------------------------
5600.4:    322.47(322.01+0.42)   186.41(185.76+0.63) -42.2%

Any other operations that call is_promisor_object(), like "rev-list
--exclude-promisor-objects", would similarly benefit, but the
invocations in p5600 don't actually trigger any such cases.

Note that we may pay a small price to build a rev-index in-memory to do
the pack-order traversal. But it's still a big net win, and even that
small cost goes away if you are using pack.writeReverseIndex.

Signed-off-by: Jeff King <peff@peff.net>
---
As an aside, feels like pack.writeReverseIndex ought to become the
default (which AFAIK hasn't happened yet).

 packfile.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index 8e812a84a3..ed69fe457b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2275,7 +2275,8 @@ int is_promisor_object(const struct object_id *oid)
 		if (has_promisor_remote()) {
 			for_each_packed_object(add_promisor_object,
 					       &promisor_objects,
-					       FOR_EACH_OBJECT_PROMISOR_ONLY);
+					       FOR_EACH_OBJECT_PROMISOR_ONLY |
+					       FOR_EACH_OBJECT_PACK_ORDER);
 		}
 		promisor_objects_prepared = 1;
 	}
-- 
2.37.0.rc0.352.g10876ef154

