Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19692202A0
	for <e@80x24.org>; Sat, 28 Oct 2017 09:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbdJ1JuH (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 05:50:07 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:47161 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751278AbdJ1JuE (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2017 05:50:04 -0400
X-AuditID: 12074413-3a3ff70000007929-1e-59f452ccb6f4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id A7.47.31017.CC254F95; Sat, 28 Oct 2017 05:50:04 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE7F1.dip0.t-ipconnect.de [84.170.231.241])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9S9nwqX016802
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 28 Oct 2017 05:50:03 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/7] prune_ref(): call `ref_transaction_add_update()` directly
Date:   Sat, 28 Oct 2017 11:49:51 +0200
Message-Id: <4421de69e71019b4f137fbc5ce0c275138691b3c.1509183413.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1509183413.git.mhagger@alum.mit.edu>
References: <cover.1509183413.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsUixO6iqHsm6EukwbWtPBZdV7qZLBp6rzBb
        3F4xn9nizJtGRgcWj7/vPzB5XLyk7LH4gZfH501yASxRXDYpqTmZZalF+nYJXBn3HpUVLBOp
        eD31DXMD426BLkZODgkBE4nle7uZuhi5OIQEdjBJHO28yAzhnGKSmPBvOhtIFZuArsSinmYm
        EFtEQE1iYtshFhCbWaBI4uv6s2BxYQE/iVMbJjOD2CwCqhKHez+B1fAKREn8ePycGWKbvMS5
        B7fBbE4BC4m7y9aC2UIC5hJv3yxgncDIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrrle
        bmaJXmpK6SZGSIgI72DcdVLuEKMAB6MSD69E7udIIdbEsuLK3EOMkhxMSqK8+85/ihTiS8pP
        qcxILM6ILyrNSS0+xCjBwawkwnvR50ukEG9KYmVValE+TEqag0VJnFdtibqfkEB6Yklqdmpq
        QWoRTFaGg0NJgjcoEKhRsCg1PbUiLTOnBCHNxMEJMpwHaHgjSA1vcUFibnFmOkT+FKMxR8fN
        u3+YOJ7NfN3ALMSSl5+XKiXO+wKkVACkNKM0D24aLM5fMYoDPSfMOxukigeYIuDmvQJaxQS0
        SkMSbFVJIkJKqoEx68jce7dOLvU5m3rUfY9VPc+HToYtC7keLO26kHb0Z5Vj2w+VHE2OpXyX
        58d9MuFwNghm7TuhWnqy6V2WDvPu90+zTFzXec6IPjKFsy54rtsa1vLCv/oWH7wy9bU9U6pu
        nAy987c4nPfdF8mp18tOqha8fPJi978yrVSjhycXJq1k1698sW2REktxRqKhFnNRcSIATbsK
        Ms4CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`prune_ref()` needs to use the `REF_ISPRUNING` flag, but we want to
make that flag private to the files backend. So instead of calling
`ref_transaction_delete()`, which is a public function and therefore
shouldn't allow the `REF_ISPRUNING` flag, change `prune_ref()` to call
`ref_transaction_add_update()`, which is private to the refs
module. (Note that we don't need any of the other services provided by
`ref_transaction_delete()`.)

This allows us to change `ref_transaction_update()` to reject the
`REF_ISPRUNING` flag. Do so by adjusting
`REF_TRANSACTION_UPDATE_ALLOWED_FLAGS`. Also add parentheses to its
definition to avoid potential future mishaps.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.h               |  4 +---
 refs/files-backend.c | 25 ++++++++++++++++---------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/refs.h b/refs.h
index 15fd419c7d..4ffef9502d 100644
--- a/refs.h
+++ b/refs.h
@@ -349,9 +349,7 @@ int refs_pack_refs(struct ref_store *refs, unsigned int flags);
  * Flags that can be passed in to ref_transaction_update
  */
 #define REF_TRANSACTION_UPDATE_ALLOWED_FLAGS \
-	REF_ISPRUNING |                      \
-	REF_FORCE_CREATE_REFLOG |            \
-	REF_NODEREF
+	(REF_NODEREF | REF_FORCE_CREATE_REFLOG)
 
 /*
  * Setup reflog before using. Fill in err and return -1 on failure.
diff --git a/refs/files-backend.c b/refs/files-backend.c
index fadf1036d3..ba72d28b13 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -989,22 +989,29 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
+	int ret = -1;
 
 	if (check_refname_format(r->name, 0))
 		return;
 
 	transaction = ref_store_transaction_begin(&refs->base, &err);
-	if (!transaction ||
-	    ref_transaction_delete(transaction, r->name, &r->oid,
-				   REF_ISPRUNING | REF_NODEREF, NULL, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
-		ref_transaction_free(transaction);
+	if (!transaction)
+		goto cleanup;
+	ref_transaction_add_update(
+			transaction, r->name,
+			REF_NODEREF | REF_HAVE_NEW | REF_HAVE_OLD | REF_ISPRUNING,
+			&null_oid, &r->oid, NULL);
+	if (ref_transaction_commit(transaction, &err))
+		goto cleanup;
+
+	ret = 0;
+
+cleanup:
+	if (ret)
 		error("%s", err.buf);
-		strbuf_release(&err);
-		return;
-	}
-	ref_transaction_free(transaction);
 	strbuf_release(&err);
+	ref_transaction_free(transaction);
+	return;
 }
 
 /*
-- 
2.14.1

