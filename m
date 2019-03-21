Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95B3A20248
	for <e@80x24.org>; Thu, 21 Mar 2019 09:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfCUJ2q (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 05:28:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:58762 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727903AbfCUJ2q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 05:28:46 -0400
Received: (qmail 10281 invoked by uid 109); 21 Mar 2019 09:28:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Mar 2019 09:28:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8283 invoked by uid 111); 21 Mar 2019 09:29:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Mar 2019 05:29:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2019 05:28:44 -0400
Date:   Thu, 21 Mar 2019 05:28:44 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/2] refs/files-backend: handle packed transaction prepare
 failure
Message-ID: <20190321092844.GA2722@sigill.intra.peff.net>
References: <20190321092829.GA2648@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190321092829.GA2648@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In files_transaction_prepare(), if we have to delete some refs, we use a
subordinate packed_transaction to do so. It's rare for that
sub-transaction's prepare step to fail, since we hold the packed-refs
lock. But if it does, we trigger a BUG() due to these steps:

  - we've attached the packed transaction to the files transaction as
    backend_data->packed_transaction

  - when the prepare step fails, the packed transaction cleans itself
    up, putting itself into the CLOSED state

  - the error value from preparing the packed transaction lets us know
    in files_transaction_prepare() that we should also clean up and
    return an error. We call files_transaction_cleanup(), which tries to
    abort backend_data->packed_transaction. Since it's already CLOSED,
    that triggers an assertion in ref_transaction_abort().

We can fix that by disconnecting the packed transaction from the outer
files transaction, and then free-ing (not aborting!) it ourselves.

A few other options/alternatives I considered:

  - we could just make it a noop to abort a CLOSED transaction. But that
    seems less safe, since clearly this code expects (and enforces) a
    particular set of state transitions.

  - we could have files_transaction_cleanup() selectively call abort()
    vs free() based on the state of the on the packed transaction.
    That's basically a more restricted version of the above, but also
    potentially unsafe.

  - instead of disconnecting backend_data->packed_transaction on error,
    we could wait to install it until we successfully prepare. That
    might make the flow a little simpler, but it introduces a hassle.
    Earlier parts of files_transaction_prepare() that encounter an error
    will jump to the cleanup label, and expect that cleaning up the
    outer transaction will clean up the packed transaction, too. We'd
    have to adjust those sites to clean up the packed transaction.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs/files-backend.c         | 10 ++++++++++
 t/t1404-update-ref-errors.sh | 16 ++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index ef053f716c..2186cbbe26 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2695,6 +2695,16 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		if (is_packed_transaction_needed(refs->packed_ref_store,
 						 packed_transaction)) {
 			ret = ref_transaction_prepare(packed_transaction, err);
+			/*
+			 * A failure during the prepare step will abort
+			 * itself, but not free. Do that now, and disconnect
+			 * from the files_transaction so it does not try to
+			 * abort us when we hit the cleanup code below.
+			 */
+			if (ret) {
+				ref_transaction_free(packed_transaction);
+				backend_data->packed_transaction = NULL;
+			}
 		} else {
 			/*
 			 * We can skip rewriting the `packed-refs`
diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 6b6a8e2292..970c5c36b9 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -618,4 +618,20 @@ test_expect_success 'delete fails cleanly if packed-refs file is locked' '
 	test_cmp unchanged actual
 '
 
+test_expect_success 'delete fails cleanly if packed-refs.new write fails' '
+	# Setup and expectations are similar to the test above.
+	prefix=refs/failed-packed-refs &&
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	git update-ref $prefix/foo $D &&
+	git for-each-ref $prefix >unchanged &&
+	# This should not happen in practice, but it is an easy way to get a
+	# reliable error (we open with create_tempfile(), which uses O_EXCL).
+	: >.git/packed-refs.new &&
+	test_when_finished "rm -f .git/packed-refs.new" &&
+	test_must_fail git update-ref -d $prefix/foo &&
+	git for-each-ref $prefix >actual &&
+	test_cmp unchanged actual
+'
+
 test_done
-- 
2.21.0.701.g4401309e11

