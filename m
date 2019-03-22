Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5667620248
	for <e@80x24.org>; Fri, 22 Mar 2019 00:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfCVAGD (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 20:06:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:60180 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726611AbfCVAGD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 20:06:03 -0400
Received: (qmail 28767 invoked by uid 109); 22 Mar 2019 00:06:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Mar 2019 00:06:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14876 invoked by uid 111); 22 Mar 2019 00:06:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Mar 2019 20:06:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2019 20:06:01 -0400
Date:   Thu, 21 Mar 2019 20:06:01 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] refs/files-backend: handle packed transaction
 prepare failure
Message-ID: <20190322000601.GA32671@sigill.intra.peff.net>
References: <20190321092829.GA2648@sigill.intra.peff.net>
 <20190321092844.GA2722@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190321092844.GA2722@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 21, 2019 at 05:28:44AM -0400, Jeff King wrote:

>   - instead of disconnecting backend_data->packed_transaction on error,
>     we could wait to install it until we successfully prepare. That
>     might make the flow a little simpler, but it introduces a hassle.
>     Earlier parts of files_transaction_prepare() that encounter an error
>     will jump to the cleanup label, and expect that cleaning up the
>     outer transaction will clean up the packed transaction, too. We'd
>     have to adjust those sites to clean up the packed transaction.

This actually isn't too bad. Here's what it would look like as a
cleanup patch on top. I dunno if it's worth it or not.

-- >8 --
Subject: [PATCH] refs/files-backend: delay setting packed_transaction

When preparing a files_transaction, we have two pointers to the
subordinate packed transaction: a local variable, and one in
backend_data which will be carried forward if we succeed.

These always point to the same thing, so one is basically an alias of
the other. But in some of the trickier cleanup code added by the last
few commits, we have to set them to NULL if we've already freed the
struct. We only _need_ to do this for the one in backend_data, but that
leaves the local variable as a dangling pointer.

Instead, let's make the rules more obvious:

  - only point backend_data at the packed transaction when we know it is
    needed and preparation has succeeded. We should never need to roll
    back backend_data->packed_transaction

  - clean up the local packed_transaction variable on failure manually,
    instead of relying on files_transaction_cleanup() to do it

An alternative would be to drop the local variable entirely, and just
use backend_data->packed_transaction. That works, but the resulting code
is a bit harder to read because of the length of the name.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs/files-backend.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 442204af4d..13a53bcb30 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2672,9 +2672,6 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 					ret = TRANSACTION_GENERIC_ERROR;
 					goto cleanup;
 				}
-
-				backend_data->packed_transaction =
-					packed_transaction;
 			}
 
 			ref_transaction_add_update(
@@ -2695,15 +2692,23 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		if (is_packed_transaction_needed(refs->packed_ref_store,
 						 packed_transaction)) {
 			ret = ref_transaction_prepare(packed_transaction, err);
-			/*
-			 * A failure during the prepare step will abort
-			 * itself, but not free. Do that now, and disconnect
-			 * from the files_transaction so it does not try to
-			 * abort us when we hit the cleanup code below.
-			 */
-			if (ret) {
+			if (!ret) {
+				/*
+				 * Attach the prepared packed transaction to
+				 * the files transaction so it can be committed
+				 * later.
+				 */
+				backend_data->packed_transaction =
+					packed_transaction;
+			} else {
+				/*
+				 * A failure during the prepare step will abort
+				 * itself, but not free. Do that now, so we
+				 * don't try to double-abort during the cleanup
+				 * below.
+				 */
 				ref_transaction_free(packed_transaction);
-				backend_data->packed_transaction = NULL;
+				packed_transaction = NULL;
 			}
 		} else {
 			/*
@@ -2712,25 +2717,27 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 			 * that somebody else doesn't pack a reference
 			 * that we are trying to delete.
 			 *
-			 * We need to disconnect our transaction from
-			 * backend_data, since the abort (whether successful or
-			 * not) will free it.
+			 * We need to NULL our local pointer, since the abort
+			 * (whether successful or not) will free it.
 			 */
-			backend_data->packed_transaction = NULL;
 			if (ref_transaction_abort(packed_transaction, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
+				packed_transaction = NULL;
 				goto cleanup;
 			}
+			packed_transaction = NULL;
 		}
 	}
 
 cleanup:
 	free(head_ref);
 	string_list_clear(&affected_refnames, 0);
 
-	if (ret)
+	if (ret) {
 		files_transaction_cleanup(refs, transaction);
-	else
+		if (packed_transaction)
+			ref_transaction_abort(packed_transaction, err);
+	} else
 		transaction->state = REF_TRANSACTION_PREPARED;
 
 	return ret;
-- 
2.21.0.705.g64cb90f133

