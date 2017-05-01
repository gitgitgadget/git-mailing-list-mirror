Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 859A01F829
	for <e@80x24.org>; Mon,  1 May 2017 02:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2996919AbdEACcx (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:32:53 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36000 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2999563AbdEACbc (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:31:32 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 78C18280DC;
        Mon,  1 May 2017 02:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605815;
        bh=v47/5DpeWArSIuwy3i7qvugzLYHomigldtTkBBJFnl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BX/0YlC0r248kS47hkXZ9rNHawF6DKFmy7G+zo88hlPnGMaqRahwjZNQtjoV7tdxO
         U8Fu44Fvq8BmuspYxshkgsfSSFR34Jbjn8g1Fr9IX0pUyyJRkSEuIxA2aqWr7tu6C0
         XVdQHkW/jbnuaFGCSya53/TK3Tj/3lRKuhYjoqpLum8pdTUxYaVlsR5rgtLTGcYpJo
         gJAEvLj8NX27MINIQrcI8fpWilNE2FwaElPm0Ia/HiJv89VOMwYNB7aHCqArJg2l5O
         81xIgVZepswsB8TPnWsBFQBr9+waL+HgDK2s0WmZ4GcC9LI+dm8if0msIFYMBm/npK
         SOGRszM4I3CAdghujpuSo5//FnSkUQvW8vYs6hjLAhffAX+8b3NeeD9LYnj1+d0olJ
         r8DO4XwYjNaXENEGq+xlcIdfhEL/WNdhLlqV9abg7OjEKDFKssLzybigQNL5kJKZuG
         Qz7HbuRgQIAR/DzY5XxeIJ1RLulSuyWxeaLSLraEG3FhvKzsbNS
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 45/53] builtin/read-tree: convert to struct object_id
Date:   Mon,  1 May 2017 02:29:38 +0000
Message-Id: <20170501022946.258735-46-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a caller of parse_tree_indirect, which must be converted in
order to convert parse_object.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/read-tree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 23e212ee8..92eff23e4 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -23,13 +23,13 @@ static int read_empty;
 static struct tree *trees[MAX_UNPACK_TREES];
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 
-static int list_tree(unsigned char *sha1)
+static int list_tree(struct object_id *oid)
 {
 	struct tree *tree;
 
 	if (nr_trees >= MAX_UNPACK_TREES)
 		die("I cannot read more than %d trees", MAX_UNPACK_TREES);
-	tree = parse_tree_indirect(sha1);
+	tree = parse_tree_indirect(oid->hash);
 	if (!tree)
 		return -1;
 	trees[nr_trees++] = tree;
@@ -121,7 +121,7 @@ static struct lock_file lock_file;
 int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 {
 	int i, stage = 0;
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct tree_desc t[MAX_UNPACK_TREES];
 	struct unpack_trees_options opts;
 	int prefix_set = 0;
@@ -204,9 +204,9 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
 
-		if (get_sha1(arg, sha1))
+		if (get_oid(arg, &oid))
 			die("Not a valid object name %s", arg);
-		if (list_tree(sha1) < 0)
+		if (list_tree(&oid) < 0)
 			die("failed to unpack tree object %s", arg);
 		stage++;
 	}
