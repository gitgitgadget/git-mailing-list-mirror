Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A5BA2018E
	for <e@80x24.org>; Sun, 28 Aug 2016 23:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756238AbcH1X2j (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 19:28:39 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41078 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756206AbcH1X2I (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Aug 2016 19:28:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8D5AC280A8;
        Sun, 28 Aug 2016 23:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1472426885;
        bh=0K4CQjll6ygpIkJFn2P2uBZp0RaUrZReQIaUqM/v8ZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wR8SgHeZg1RUlB8RgH7o+geEDAhsHdvmhlWMwyJjSZdnTG/PjrHLLTWOQYNoohRdz
         LVa2pf2vhIFFcGYHr52Iv8XuHl/V0xT7Mnk17clOz93EHslQawhEIfeL4KyQPizoRJ
         ZlNaU/tzgb+PuRZA95QLBrVwiXohxkw6KxReUjXCMh7gqB7HmVfpqrGXSXWYTGg1/K
         +8zIA5iNyu7HzDNDH72YJa8edwY/VRxC0ypAansbzb5VVOkUlq+Oz7SplmlQgMdB34
         vHDbW09H/SmBEsvt1FZsNeMaBpiEdSvl7+R5i0Rj7UkLqbliwbHC4hKFG8GWlGSB7M
         BIr2sXmpFL1hvwG4jSMhAmJZ5lW+xqZkSBzxW5i10ZaazW/GwPMGuPOj2bJXZXiprV
         iDpK7GU+84gIdJ24Jm99cg8FQ22xlAhqrKCpYQRMTEttu8iRXxJinTYO4/FiEXmvO+
         +L4YoidNrfZtHlNYrmx57R/JbA7R/CLXvGtsX48qXHJ8Qb8yj6E
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 13/20] builtin/rm: convert to use struct object_id
Date:   Sun, 28 Aug 2016 23:27:50 +0000
Message-Id: <20160828232757.373278-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160828232757.373278-1-sandals@crustytoothpaste.net>
References: <20160828232757.373278-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/rm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 109969d5..3f3e24eb 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -107,7 +107,7 @@ static int check_submodules_use_gitfiles(void)
 	return errs;
 }
 
-static int check_local_mod(unsigned char *head, int index_only)
+static int check_local_mod(struct object_id *head, int index_only)
 {
 	/*
 	 * Items in list are already sorted in the cache order,
@@ -123,13 +123,13 @@ static int check_local_mod(unsigned char *head, int index_only)
 	struct string_list files_submodule = STRING_LIST_INIT_NODUP;
 	struct string_list files_local = STRING_LIST_INIT_NODUP;
 
-	no_head = is_null_sha1(head);
+	no_head = is_null_oid(head);
 	for (i = 0; i < list.nr; i++) {
 		struct stat st;
 		int pos;
 		const struct cache_entry *ce;
 		const char *name = list.entry[i].name;
-		unsigned char sha1[20];
+		struct object_id oid;
 		unsigned mode;
 		int local_changes = 0;
 		int staged_changes = 0;
@@ -197,9 +197,9 @@ static int check_local_mod(unsigned char *head, int index_only)
 		 * way as changed from the HEAD.
 		 */
 		if (no_head
-		     || get_tree_entry(head, name, sha1, &mode)
+		     || get_tree_entry(head->hash, name, oid.hash, &mode)
 		     || ce->ce_mode != create_ce_mode(mode)
-		     || hashcmp(ce->oid.hash, sha1))
+		     || oidcmp(&ce->oid, &oid))
 			staged_changes = 1;
 
 		/*
@@ -351,10 +351,10 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	 * report no changes unless forced.
 	 */
 	if (!force) {
-		unsigned char sha1[20];
-		if (get_sha1("HEAD", sha1))
-			hashclr(sha1);
-		if (check_local_mod(sha1, index_only))
+		struct object_id oid;
+		if (get_oid("HEAD", &oid))
+			oidclr(&oid);
+		if (check_local_mod(&oid, index_only))
 			exit(1);
 	} else if (!index_only) {
 		if (check_submodules_use_gitfiles())
