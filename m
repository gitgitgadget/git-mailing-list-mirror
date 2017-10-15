Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54B8220372
	for <e@80x24.org>; Sun, 15 Oct 2017 22:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbdJOWHj (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 18:07:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54998 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751159AbdJOWHh (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Oct 2017 18:07:37 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7657C6044A;
        Sun, 15 Oct 2017 22:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1508105257;
        bh=UOfLg0f8EgMxpnv6nwLNAo6FsCrPltFYEILH9ckvuKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=c5WfTJzxEs0o5gipDZiBCQ7v2IdC3Jerqqh/tL4xieftWOv4wDDf/+hPr9CNjnCYk
         oZuLNd/5VNewx0HgiXbTEJHmJYOzP54ioctZofHn6nECHzkjfi02LCLxYQ1CusnXGL
         GYOnZGwUqmO1x8wmzIJc4ta1rmlhIfQ6s2AsA+X3qtEp2GDRb0slbZAP+omjMRFh/9
         VdFYV6QudCdRpuYmpiQiJwWk1hlggDu2euaQFj7QdkfuwyVQsM/zfLraY/lzpV/iUH
         +0k+ACMuy5+R8bFFbE0fFmxAWy0W3B0SNFnhtDIEFOZyYPIKuYNuzNSmOpJQpd95Gs
         fBqHp5moOakpr5siTPhXIsObpqST8YqQNgxZMcpwm6ktaCcHmL4VATQ+m7+Z/nz1R8
         gctCe+vnyCrg85S1aguA5nW4mrHJvRb5WhCbMQXmEet7PbkLHKx6xPfzZrz7NzBdCc
         rmU1VYfX2pKUNb+mV5rmSiWDikUy9CxGYAGraOFLjLjfxm1RUJB
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 02/25] refs/files-backend: convert struct ref_to_prune to object_id
Date:   Sun, 15 Oct 2017 22:06:49 +0000
Message-Id: <20171015220712.97308-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc
In-Reply-To: <20171015220712.97308-1-sandals@crustytoothpaste.net>
References: <20171015220712.97308-1-sandals@crustytoothpaste.net>
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
index 014dabb0bf..9db9237f1e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -926,7 +926,7 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 
 struct ref_to_prune {
 	struct ref_to_prune *next;
-	unsigned char sha1[20];
+	struct object_id oid;
 	char name[FLEX_ARRAY];
 };
 
@@ -994,7 +994,7 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 
 	transaction = ref_store_transaction_begin(&refs->base, &err);
 	if (!transaction ||
-	    ref_transaction_delete(transaction, r->name, r->sha1,
+	    ref_transaction_delete(transaction, r->name, r->oid.hash,
 				   REF_ISPRUNING | REF_NODEREF, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
@@ -1088,7 +1088,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 		if ((flags & PACK_REFS_PRUNE)) {
 			struct ref_to_prune *n;
 			FLEX_ALLOC_STR(n, name, iter->refname);
-			hashcpy(n->sha1, iter->oid->hash);
+			oidcpy(&n->oid, iter->oid);
 			n->next = refs_to_prune;
 			refs_to_prune = n;
 		}
-- 
2.15.0.rc0.271.g36b669edcc

