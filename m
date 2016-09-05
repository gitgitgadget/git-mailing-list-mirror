Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F01A820705
	for <e@80x24.org>; Mon,  5 Sep 2016 20:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964937AbcIEUJ7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 16:09:59 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:42998 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964897AbcIEUI3 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 16:08:29 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0C560280B3;
        Mon,  5 Sep 2016 20:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1473106109;
        bh=0K4CQjll6ygpIkJFn2P2uBZp0RaUrZReQIaUqM/v8ZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qon1WdwZMVkMyuZmstYK4onyIqQf06T1KMUAzJf83OlvdSmgDYlwCMf1baditwKdz
         LLnxG4oLLxJG2XsivRxntBEgs7lxwJEh9A3tba8wVlkgIBvJzQ1T6EyRg6kHMaETlj
         tesMofCJ3bEFVyhjTMcmkcT+SHX9Ci6REF/3y0Ifw1J69L7+2unciV+KiqWRM1qJzj
         Ae8Ka+Dcs1rjCltHoIo029TNITEzcW33XQkuu4oR1xjJEKY4CB9ut/dfRG0JGSttUQ
         ojh2CawaifpnpW0OBfmvZBmqj/B4QFNn0lHfgP/PKV7OILjOD7iXCnRYY5pyqEs8gb
         F3yy3K6htcvfXcIzTy7zODQFQe9jJaFOONQgGYjtr7UscSQrn1NT6hvawjEnos73zi
         YC3pRwuYbhP/UY3FZJxZAQuMcIS3GQLidbURSuyYtrjrgE7a588U0XZGY+l5csqONT
         gNrgFZc6mqnMOMs22xDYjM1+679lkwPj560w/aXtMys4YZy40n/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v2 13/20] builtin/rm: convert to use struct object_id
Date:   Mon,  5 Sep 2016 20:08:04 +0000
Message-Id: <20160905200811.697889-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160905200811.697889-1-sandals@crustytoothpaste.net>
References: <20160905200811.697889-1-sandals@crustytoothpaste.net>
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
