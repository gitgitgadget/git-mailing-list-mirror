Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E083C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 01:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJRBL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 21:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiJRBKv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 21:10:51 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583DF90833
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 18:10:26 -0700 (PDT)
Received: (qmail 28848 invoked by uid 109); 18 Oct 2022 01:10:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Oct 2022 01:10:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13544 invoked by uid 111); 18 Oct 2022 01:10:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 21:10:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 21:10:24 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 12/12] ll-merge: mark unused parameters in callbacks
Message-ID: <Y039AHoGP1DWgluA@coredump.intra.peff.net>
References: <Y036whEorZV0rOgB@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y036whEorZV0rOgB@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a generic ll_merge_fn, but not every implementation needs every
parameter. In particular, neither binary nor ext merges care about names
(since they do not generate conflict markers), and most do not need to
look at the ll_merge_driver itself.

Ironically, neither ll_xdl_merge() nor ll_union_merge() needs to have
their driver parameter annotated (even though both are named
drv_unused!).  This is because they may fall back to calling
ll_binary_merge() directly. And even though that function won't look at
it, we still pass it along, and hence it is "used" in the caller.

We could get away with passing NULL, but that's likely more confusing
and brittle than just passing along our own driver. And we have to keep
the driver parameter in all callbacks, since ll_ext_merge() uses it.

Signed-off-by: Jeff King <peff@peff.net>
---
 ll-merge.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/ll-merge.c b/ll-merge.c
index 8955d7e1f6..a8e2db9336 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -49,14 +49,14 @@ void reset_merge_attributes(void)
 /*
  * Built-in low-levels
  */
-static enum ll_merge_result ll_binary_merge(const struct ll_merge_driver *drv_unused,
+static enum ll_merge_result ll_binary_merge(const struct ll_merge_driver *drv UNUSED,
 			   mmbuffer_t *result,
-			   const char *path,
-			   mmfile_t *orig, const char *orig_name,
-			   mmfile_t *src1, const char *name1,
-			   mmfile_t *src2, const char *name2,
+			   const char *path UNUSED,
+			   mmfile_t *orig, const char *orig_name UNUSED,
+			   mmfile_t *src1, const char *name1 UNUSED,
+			   mmfile_t *src2, const char *name2 UNUSED,
 			   const struct ll_merge_options *opts,
-			   int marker_size)
+			   int marker_size UNUSED)
 {
 	enum ll_merge_result ret;
 	mmfile_t *stolen;
@@ -183,9 +183,9 @@ static void create_temp(mmfile_t *src, char *path, size_t len)
 static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 			mmbuffer_t *result,
 			const char *path,
-			mmfile_t *orig, const char *orig_name,
-			mmfile_t *src1, const char *name1,
-			mmfile_t *src2, const char *name2,
+			mmfile_t *orig, const char *orig_name UNUSED,
+			mmfile_t *src1, const char *name1 UNUSED,
+			mmfile_t *src2, const char *name2 UNUSED,
 			const struct ll_merge_options *opts,
 			int marker_size)
 {
-- 
2.38.0.371.g300879f34e
