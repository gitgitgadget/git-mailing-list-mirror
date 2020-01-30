Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A725C33C9E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 09:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE28620702
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 09:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgA3Jwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 04:52:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:48324 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726873AbgA3Jwd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 04:52:33 -0500
Received: (qmail 26066 invoked by uid 109); 30 Jan 2020 09:52:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Jan 2020 09:52:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22623 invoked by uid 111); 30 Jan 2020 10:00:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jan 2020 05:00:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jan 2020 04:52:32 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] walker_fetch(): avoid raw array length computation
Message-ID: <20200130095232.GB840531@coredump.intra.peff.net>
References: <20200130095155.GA839988@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200130095155.GA839988@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We compute the length of an array of object_id's with a raw
multiplication. In theory this could trigger an integer overflow which
would cause an under-allocation (and eventually an out of bounds write).

I doubt this can be triggered in practice, since you'd need to feed it
an enormous number of target objects, which would typically come from
the ref advertisement and be using proportional memory. And even on
64-bit systems, where "int" is much smaller than "size_t", that should
hold: even though "targets" is an int, the multiplication will be done
as a size_t because of the use of sizeof().

But we can easily fix it by using ALLOC_ARRAY(), which uses st_mult()
under the hood.

Signed-off-by: Jeff King <peff@peff.net>
---
 walker.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/walker.c b/walker.c
index 06cd2bd569..bb010f7a2b 100644
--- a/walker.c
+++ b/walker.c
@@ -261,12 +261,14 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 	struct strbuf refname = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 	struct ref_transaction *transaction = NULL;
-	struct object_id *oids = xmalloc(targets * sizeof(struct object_id));
+	struct object_id *oids;
 	char *msg = NULL;
 	int i, ret = -1;
 
 	save_commit_buffer = 0;
 
+	ALLOC_ARRAY(oids, targets);
+
 	if (write_ref) {
 		transaction = ref_transaction_begin(&err);
 		if (!transaction) {
-- 
2.25.0.515.gaba5347bc6

