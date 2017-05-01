Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5761F829
	for <e@80x24.org>; Mon,  1 May 2017 02:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642373AbdEACcR (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:32:17 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36064 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2992767AbdEACaz (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:30:55 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E1B25280CE;
        Mon,  1 May 2017 02:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605811;
        bh=Ala30MPA6e330s5G28DVtX/kNIPXNyAwCgm3dlbL3D4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ui3ezN+bRJQjwT5pzDah8CpAqgFUEg9PSfTJ7WYSYY0PDLpXE3k3F06M5vgkxhIOt
         5rzSV/tlmuSSYeu1nCFx7gTy9bsjWw2ajB22baGYCTO1lkyPt4+CMo+6F9IUHxfZr5
         jvIXkdsjkI9w9dUp2SWJ7CmCbmpTSxWgkqDiwzT8glXAx9chZXNnSMcNe/75/6oxSS
         YHnNgu03gud1hqDVI3JIyDmmSwiDAH1eFEXU9sX6z8r1ra3BI6w6xUEEb6hBaVVRje
         4nCuyuwM3lMzlslzzD4ZsqnWvFU0lu8rCKLDfpu6nqruWFvGtG8spW2lA2lfC/zqqw
         trD10LMdtbOeeTTUwUrxzRzZ+Y+Qw9Qm3fRYycJDede6LaqonxVt60VJvDjZ674I4m
         /fC1tfEeOtu/JT6WDyDuxx3A7hRnEqrGAWki264WlVZ8xQZQKVXIHfKrZqL3hwYVf4
         TtUyEuLCyySBnUxcIATScGLtjUjFocs/U9xhXeP33KjhcKNGduR
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 31/53] builtin/reflog: convert tree_is_complete to take struct object_id
Date:   Mon,  1 May 2017 02:29:24 +0000
Message-Id: <20170501022946.258735-32-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/reflog.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 4831116ea..7866a0341 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -55,14 +55,14 @@ struct collect_reflog_cb {
 #define STUDYING	(1u<<11)
 #define REACHABLE	(1u<<12)
 
-static int tree_is_complete(const unsigned char *sha1)
+static int tree_is_complete(const struct object_id *oid)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
 	int complete;
 	struct tree *tree;
 
-	tree = lookup_tree(sha1);
+	tree = lookup_tree(oid->hash);
 	if (!tree)
 		return 0;
 	if (tree->object.flags & SEEN)
@@ -73,7 +73,7 @@ static int tree_is_complete(const unsigned char *sha1)
 	if (!tree->buffer) {
 		enum object_type type;
 		unsigned long size;
-		void *data = read_sha1_file(sha1, &type, &size);
+		void *data = read_sha1_file(oid->hash, &type, &size);
 		if (!data) {
 			tree->object.flags |= INCOMPLETE;
 			return 0;
@@ -85,7 +85,7 @@ static int tree_is_complete(const unsigned char *sha1)
 	complete = 1;
 	while (tree_entry(&desc, &entry)) {
 		if (!has_sha1_file(entry.oid->hash) ||
-		    (S_ISDIR(entry.mode) && !tree_is_complete(entry.oid->hash))) {
+		    (S_ISDIR(entry.mode) && !tree_is_complete(entry.oid))) {
 			tree->object.flags |= INCOMPLETE;
 			complete = 0;
 		}
@@ -152,7 +152,7 @@ static int commit_is_complete(struct commit *commit)
 		for (i = 0; i < found.nr; i++) {
 			struct commit *c =
 				(struct commit *)found.objects[i].item;
-			if (!tree_is_complete(c->tree->object.oid.hash)) {
+			if (!tree_is_complete(&c->tree->object.oid)) {
 				is_incomplete = 1;
 				c->object.flags |= INCOMPLETE;
 			}
