Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C61CC1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 13:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756215AbeARNoB (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 08:44:01 -0500
Received: from mail.strova.dk ([83.169.38.5]:48936 "EHLO mail.strova.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756185AbeARNoA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 08:44:00 -0500
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jan 2018 08:44:00 EST
Received: from novascotia (users-1190.st.net.au.dk [130.225.0.251])
        by mail.strova.dk (Postfix) with ESMTPSA id DBDAF6070A;
        Thu, 18 Jan 2018 14:38:42 +0100 (CET)
Date:   Thu, 18 Jan 2018 14:38:41 +0100
From:   Mathias Rav <m@git.strova.dk>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] files_initial_transaction_commit(): only unlock if locked
Message-ID: <20180118143841.1a4c674d@novascotia>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running git clone --single-branch --mirror -b TAGNAME previously
triggered the following error message:

	fatal: multiple updates for ref 'refs/tags/TAGNAME' not allowed.

This error condition is handled in files_initial_transaction_commit().

42c7f7ff9 ("commit_packed_refs(): remove call to `packed_refs_unlock()`", 2017-06-23)
introduced incorrect unlocking in the error path of this function,
which changes the error message to

	fatal: BUG: packed_refs_unlock() called when not locked

Move the call to packed_refs_unlock() above the "cleanup:" label
since the unlocking should only be done in the last error path.

Signed-off-by: Mathias Rav <m@git.strova.dk>
---
 refs/files-backend.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a80d60aa0..afe5c4e94 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2874,13 +2874,12 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 
 	if (initial_ref_transaction_commit(packed_transaction, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
-		goto cleanup;
 	}
 
+	packed_refs_unlock(refs->packed_ref_store);
 cleanup:
 	if (packed_transaction)
 		ref_transaction_free(packed_transaction);
-	packed_refs_unlock(refs->packed_ref_store);
 	transaction->state = REF_TRANSACTION_CLOSED;
 	string_list_clear(&affected_refnames, 0);
 	return ret;
-- 
2.15.1

