Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 780EB1FA21
	for <e@80x24.org>; Mon,  9 Oct 2017 01:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753773AbdJIBLz (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 21:11:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54634 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753527AbdJIBLr (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Oct 2017 21:11:47 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EF6CF60D94;
        Mon,  9 Oct 2017 01:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1507511505;
        bh=CgnvXoJfEFiund93qEHNjdTRfwk67JzbgV2PAHkK2YE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=GcsFdKY74HhVCg6JP8hohB5COard9bn1SgwlKM1V4cEX+jCB1Q/zUw8j5mSsI+JDA
         x7bCLRcqrYYJYiY+koH9IkvFCOt3/QbCH9TGqiMbBtlCBmbKwgy1vBIe6kZ38Gnyhh
         No+axuk6AN5RMcholcqJPxpOY5NXdLsjb6CXsnjaONdKnniL+WRvIi/VtmW1HhLwCd
         /3H6vhGptEb/grTh4KoR24Cp68cXZltndHPjXD4BJjGLXbz0KvODbNimB7kFtiDJD8
         uEZbxNNlPJz+X2dOUhRAImHnhrkGoBSAJNSJ9h/NIsFVFwyAriat/BjzkV4q1q+2hX
         hW0MeiQmyT+5KtuPW/qffKZyeCEtfOuAPMDblRl9TZH1fca2N/mLGmX+74KJ9ZKpnl
         uH2M/L7qGoF2LmYMwNl6i7nL+jmKM8TJBCosEXLgdMfAvK3U4/k8zNfGvCXRfjkMN6
         wl+WnLTFzy4hxn0Yn6DmyHkxInTG9xnGM29sX1qqeD+rdrmYjKG
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 02/24] refs/files-backend: convert struct ref_to_prune to object_id
Date:   Mon,  9 Oct 2017 01:11:10 +0000
Message-Id: <20171009011132.675341-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.920.gcf0c67979c
In-Reply-To: <20171009011132.675341-1-sandals@crustytoothpaste.net>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the member of this struct to be a struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs/files-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index fec77744b4..e3968d4f7c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -961,7 +961,7 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 
 struct ref_to_prune {
 	struct ref_to_prune *next;
-	unsigned char sha1[20];
+	struct object_id oid;
 	char name[FLEX_ARRAY];
 };
 
@@ -1029,7 +1029,7 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 
 	transaction = ref_store_transaction_begin(&refs->base, &err);
 	if (!transaction ||
-	    ref_transaction_delete(transaction, r->name, r->sha1,
+	    ref_transaction_delete(transaction, r->name, r->oid.hash,
 				   REF_ISPRUNING | REF_NODEREF, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
@@ -1123,7 +1123,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 		if ((flags & PACK_REFS_PRUNE)) {
 			struct ref_to_prune *n;
 			FLEX_ALLOC_STR(n, name, iter->refname);
-			hashcpy(n->sha1, iter->oid->hash);
+			oidcpy(&n->oid, iter->oid);
 			n->next = refs_to_prune;
 			refs_to_prune = n;
 		}
-- 
2.14.2.920.gcf0c67979c

