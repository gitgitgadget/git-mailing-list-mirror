Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B1720450
	for <e@80x24.org>; Sun,  5 Nov 2017 08:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752804AbdKEImw (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 03:42:52 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56864 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752470AbdKEImX (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2017 03:42:23 -0500
X-AuditID: 12074413-38bff70000007929-0a-59feceea1098
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 2E.71.31017.AEECEF95; Sun,  5 Nov 2017 03:42:18 -0500 (EST)
Received: from bagpipes.fritz.box (p4FC6E019.dip0.t-ipconnect.de [79.198.224.25])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id vA58gCCr018723
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 5 Nov 2017 03:42:17 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 2/9] prune_ref(): call `ref_transaction_add_update()` directly
Date:   Sun,  5 Nov 2017 09:42:02 +0100
Message-Id: <4421de69e71019b4f137fbc5ce0c275138691b3c.1509870243.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1509870243.git.mhagger@alum.mit.edu>
References: <cover.1509870243.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqPv63L9Ig9uTGC26rnQzWTT0XmG2
        +Pumi9Hi9or5zBZn3jQyOrB6/H3/gclj56y77B4XLyl7LH7g5fF5k1wAaxSXTUpqTmZZapG+
        XQJXxr1HZQXLRCpeT33D3MC4W6CLkZNDQsBE4lD3LNYuRi4OIYEdTBLP/y5hhHBOMEl8PAvi
        cHKwCehKLOppZgKxRQTUJCa2HWIBKWIW2Moo8be7mRkkISwQKPFy0hSwBhYBVYkjZ54C2Rwc
        vAJREpvvVEFsk5c49+A2WDmngIXEn4/z2EBsIQFziU+fdrJOYORZwMiwilEuMac0Vzc3MTOn
        ODVZtzg5MS8vtUjXXC83s0QvNaV0EyMkbIR3MO46KXeIUYCDUYmH94THv0gh1sSy4srcQ4yS
        HExKorxXXv6JFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCG7QYqJw3JbGyKrUoHyYlzcGiJM6r
        tkTdT0ggPbEkNTs1tSC1CCYrw8GhJMErAIwPIcGi1PTUirTMnBKENBMHJ8hwHqDhUSA1vMUF
        ibnFmekQ+VOMxhzPZr5uYOaYdrW1iVmIJS8/L1VKnNcNpFQApDSjNA9uGiz2XzGKAz0nzDvt
        LFAVDzBtwM17BbSKCWjVbI4/IKtKEhFSUg2Mk0vsL15mZFzJ7G1w+SJjyQnPw94LC0t2Fyi/
        ne60+M5nts8F19YHpLzfpFGtuKP95dq/fRYlKnXrBXMnnJ98u7LgWixDR+yc1a0b2EyyT9Vd
        XaBZsXvboTNpa/Z9mHTSwuDrdIY3n89nn3yudGCr7JpSy8cfzfeG8rj1te85sHjriaCvBcFV
        05RYijMSDbWYi4oTAeTxWtvYAgAA
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

