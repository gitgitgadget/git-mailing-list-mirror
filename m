Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289B5EDE99C
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 09:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbjINJms (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 05:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237761AbjINJme (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 05:42:34 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E7661AE
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 02:39:54 -0700 (PDT)
Received: (qmail 27327 invoked by uid 109); 14 Sep 2023 09:39:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Sep 2023 09:39:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21307 invoked by uid 111); 14 Sep 2023 09:39:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Sep 2023 05:39:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Sep 2023 05:39:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/4] merge-ort: stop passing "opt" to read_oid_strbuf()
Message-ID: <20230914093953.GB2254894@coredump.intra.peff.net>
References: <20230914093409.GA2254811@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230914093409.GA2254811@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function doesn't look at its merge_options parameter. It used to
pass it down to err(), but that function no longer exists (and didn't
look at "opt" anyway). We can drop it here.

Signed-off-by: Jeff King <peff@peff.net>
---
 merge-ort.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 027ecc7f78..31c663b297 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3491,8 +3491,7 @@ static int sort_dirs_next_to_their_children(const char *one, const char *two)
 		return c1 - c2;
 }
 
-static int read_oid_strbuf(struct merge_options *opt,
-			   const struct object_id *oid,
+static int read_oid_strbuf(const struct object_id *oid,
 			   struct strbuf *dst)
 {
 	void *buf;
@@ -3527,8 +3526,8 @@ static int blob_unchanged(struct merge_options *opt,
 	if (oideq(&base->oid, &side->oid))
 		return 1;
 
-	if (read_oid_strbuf(opt, &base->oid, &basebuf) ||
-	    read_oid_strbuf(opt, &side->oid, &sidebuf))
+	if (read_oid_strbuf(&base->oid, &basebuf) ||
+	    read_oid_strbuf(&side->oid, &sidebuf))
 		goto error_return;
 	/*
 	 * Note: binary | is used so that both renormalizations are
-- 
2.42.0.628.g8a27295885

