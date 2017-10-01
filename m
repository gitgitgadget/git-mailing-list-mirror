Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 510C720A2C
	for <e@80x24.org>; Sun,  1 Oct 2017 22:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751922AbdJAWIu (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 18:08:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54090 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751417AbdJAWIr (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Oct 2017 18:08:47 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BD8A160D8E;
        Sun,  1 Oct 2017 22:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506895726;
        bh=Lt9qP0mUfffVmzZeytRKPU0OvKKJmLlY98OKMSgqPeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fOQ5t29EQM5O+v4v/lP6LQnZw88rm25x5KhG+vcZb/lFyTH5kFzmJo4RXhL6AE/tH
         KmnmgGOWoDFKARlAa7ITAOXJu+AoifwDqB9LZw3pOf57yu09EwPCvjSoGeIlDszqgs
         6lTi2rsnHpUdzhlPoqcDIy8CiGW4n2NnAw9fnOLVG1LFLZLg2G/drcZwPK5ap9/EXO
         Q/zvpcdo38MqiVSDbcUZdwuBCWRkOh51DzYAt9mzWLkaXTkXgdfb17bBd2r3rN0ybq
         96UU1va68qhKjh2Nu2EgzacrNisT7IUriVE3Sja9B4WFDjBe2hLNgPC9/eXgIUUk0z
         UgWxoQo40OD/2h8Wqwpz2k1WsBROlca39iLDhmjHw3owqx7jJ0M0JtsYGO5eyVUbGR
         fv0c/sfFzMNihZjqTB0VRJwKeMKSrrMQ1PyLwMpdg0SBmUIvRClyrBen0XtgtnOL/z
         Xx8kJ+3yne1xmabG4VuPZBhRajrcugyMqxjAIgqeLYzSEYXk5Bt
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 02/24] refs/files-backend: convert struct ref_to_prune to object_id
Date:   Sun,  1 Oct 2017 22:08:09 +0000
Message-Id: <20171001220831.214705-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.822.g60be5d43e6
In-Reply-To: <20171001220831.214705-1-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
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
2.14.2.822.g60be5d43e6

