Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1FAD1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 21:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbdBHVBZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 16:01:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:51789 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbdBHVBX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 16:01:23 -0500
Received: (qmail 28454 invoked by uid 109); 8 Feb 2017 20:53:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 20:53:12 +0000
Received: (qmail 6765 invoked by uid 111); 8 Feb 2017 20:53:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 15:53:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2017 15:53:10 -0500
Date:   Wed, 8 Feb 2017 15:53:10 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/11] receive-pack: use oidset to de-duplicate .have lines
Message-ID: <20170208205310.mnjocw4xb22ppl24@sigill.intra.peff.net>
References: <20170208205219.twgm5rggovqbepte@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170208205219.twgm5rggovqbepte@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you have an alternate object store with a very large
number of refs, the peak memory usage of the sha1_array can
grow high, even if most of them are duplicates that end up
not being printed at all.

The similar for_each_alternate_ref() code-paths in
fetch-pack solve this by using flags in "struct object" to
de-duplicate (and so are relying on obj_hash at the core).

But we don't have a "struct object" at all in this case. We
could call lookup_unknown_object() to get one, but if our
goal is reducing memory footprint, it's not great:

 - an unknown object is as large as the largest object type
   (a commit), which is bigger than an oidset entry

 - we can free the memory after our ref advertisement, but
   "struct object" entries persist forever (and the
   receive-pack may hang around for a long time, as the
   bottleneck is often client upload bandwidth).

So let's use an oidset. Note that unlike a sha1-array it
doesn't sort the output as a side effect. However, our
output is at least stable, because for_each_alternate_ref()
will give us the sha1s in ref-sorted order.

In one particularly pathological case with an alternate that
has 60,000 unique refs out of 80 million total, this reduced
the peak heap usage of "git receive-pack . </dev/null" from
13GB to 14MB.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d21332d9e..a4926fcfb 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -21,6 +21,7 @@
 #include "sigchain.h"
 #include "fsck.h"
 #include "tmp-objdir.h"
+#include "oidset.h"
 
 static const char * const receive_pack_usage[] = {
 	N_("git receive-pack <git-dir>"),
@@ -271,27 +272,24 @@ static int show_ref_cb(const char *path_full, const struct object_id *oid,
 	return 0;
 }
 
-static int show_one_alternate_sha1(const unsigned char sha1[20], void *unused)
+static void show_one_alternate_ref(const char *refname,
+				   const struct object_id *oid,
+				   void *data)
 {
-	show_ref(".have", sha1);
-	return 0;
-}
+	struct oidset *seen = data;
 
-static void collect_one_alternate_ref(const char *refname,
-				      const struct object_id *oid,
-				      void *data)
-{
-	struct sha1_array *sa = data;
-	sha1_array_append(sa, oid->hash);
+	if (oidset_insert(seen, oid))
+		return;
+
+	show_ref(".have", oid->hash);
 }
 
 static void write_head_info(void)
 {
-	struct sha1_array sa = SHA1_ARRAY_INIT;
+	static struct oidset seen = OIDSET_INIT;
 
-	for_each_alternate_ref(collect_one_alternate_ref, &sa);
-	sha1_array_for_each_unique(&sa, show_one_alternate_sha1, NULL);
-	sha1_array_clear(&sa);
+	for_each_alternate_ref(show_one_alternate_ref, &seen);
+	oidset_clear(&seen);
 	for_each_ref(show_ref_cb, NULL);
 	if (!sent_capabilities)
 		show_ref("capabilities^{}", null_sha1);
-- 
2.12.0.rc0.371.ga6cf8653b

