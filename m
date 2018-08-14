Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B4A71F404
	for <e@80x24.org>; Tue, 14 Aug 2018 18:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbeHNVCu (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 17:02:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:54942 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725915AbeHNVCu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 17:02:50 -0400
Received: (qmail 31790 invoked by uid 109); 14 Aug 2018 18:14:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 18:14:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24401 invoked by uid 111); 14 Aug 2018 18:14:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 14:14:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 14:14:27 -0400
Date:   Tue, 14 Aug 2018 14:14:27 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: [PATCH 1/4] cat-file: use oidset check-and-insert
Message-ID: <20180814181427.GA26919@sigill.intra.peff.net>
References: <20180814181358.GA26391@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180814181358.GA26391@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need to check if the oidset has our object before
we insert it; that's done as part of the insertion. We can
just rely on the return value from oidset_insert(), which
saves one hash lookup per object.

This measurable speedup is tiny and within the run-to-run
noise, but the result is simpler to read, too.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 45992c9be9..04b5cda191 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -443,9 +443,8 @@ static int batch_unordered_object(const struct object_id *oid, void *vdata)
 {
 	struct object_cb_data *data = vdata;
 
-	if (oidset_contains(data->seen, oid))
+	if (oidset_insert(data->seen, oid))
 		return 0;
-	oidset_insert(data->seen, oid);
 
 	return batch_object_cb(oid, data);
 }
-- 
2.18.0.1066.g0d97f3a098

