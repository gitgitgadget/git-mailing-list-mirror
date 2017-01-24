Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12FA620A17
	for <e@80x24.org>; Tue, 24 Jan 2017 00:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbdAXArv (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 19:47:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:43573 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751880AbdAXArn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 19:47:43 -0500
Received: (qmail 10069 invoked by uid 109); 24 Jan 2017 00:47:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 00:47:42 +0000
Received: (qmail 11040 invoked by uid 111); 24 Jan 2017 00:48:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Jan 2017 19:48:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jan 2017 19:47:39 -0500
Date:   Mon, 23 Jan 2017 19:47:39 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 09/12] receive-pack: use oidset to de-duplicate .have lines
Message-ID: <20170124004739.5aowmmkesbanyohm@sigill.intra.peff.net>
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
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
index b9f2c0cc5..27bb52988 100644
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
2.11.0.765.g454d2182f

