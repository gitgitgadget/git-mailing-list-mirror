Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E683620248
	for <e@80x24.org>; Thu, 21 Mar 2019 09:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbfCUJ24 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 05:28:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:58770 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727903AbfCUJ2z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 05:28:55 -0400
Received: (qmail 10295 invoked by uid 109); 21 Mar 2019 09:28:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Mar 2019 09:28:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8300 invoked by uid 111); 21 Mar 2019 09:29:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Mar 2019 05:29:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2019 05:28:54 -0400
Date:   Thu, 21 Mar 2019 05:28:54 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/2] refs/files-backend: don't look at an aborted transaction
Message-ID: <20190321092853.GB2722@sigill.intra.peff.net>
References: <20190321092829.GA2648@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190321092829.GA2648@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When deleting refs, we hold packed-refs.lock and prepare a packed
transaction to drop the refs from the packed-refs file. If it turns out
that we don't need to rewrite the packed refs (e.g., because none of the
deletions were present in the file), then we abort the transaction.

If that abort succeeds, then the transaction struct will have been
freed, and we set our local pointer to NULL so we don't look at it
again.

However, if it fails, then the struct will _still_ have been freed
(because ref_transaction_abort() always frees). But we don't clean up
the pointer, and will jump to our cleanup code, which will try to abort
it again, causing a use-after-free.

It's actually impossible for this to trigger in practice, since
packed_transaction_abort() will never return anything but success. But
let's fix it anyway, since that's more than we should assume about the
packed-refs code (after all, we are already bothering to check for an
error result which cannot be triggered).

Signed-off-by: Jeff King <peff@peff.net>
---
 refs/files-backend.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2186cbbe26..442204af4d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2711,12 +2711,16 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 			 * file. But we do need to leave it locked, so
 			 * that somebody else doesn't pack a reference
 			 * that we are trying to delete.
+			 *
+			 * We need to disconnect our transaction from
+			 * backend_data, since the abort (whether successful or
+			 * not) will free it.
 			 */
+			backend_data->packed_transaction = NULL;
 			if (ref_transaction_abort(packed_transaction, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			}
-			backend_data->packed_transaction = NULL;
 		}
 	}
 
-- 
2.21.0.701.g4401309e11
