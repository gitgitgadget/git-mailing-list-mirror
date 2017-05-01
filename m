Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E0EE1F829
	for <e@80x24.org>; Mon,  1 May 2017 02:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642337AbdEACcG (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:32:06 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:35662 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2999499AbdEACbI (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:31:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 442A6280D8;
        Mon,  1 May 2017 02:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605814;
        bh=CuEHIlHgzxzz9iYpTChUk/qguRoOgxdC3n7Vzj+K3/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9NLqqPQICT3/QOPzhdMO1e1JU4qbRyVVh0MRP+5t4Xehah48uU60tHDZeG4BbV9I
         FF5Q46mF+VCdkW/xzm6f7+bn4M+OQ5gxaN5UYhEoB/nm9j8QnGUdkC27GDLkHqRdM1
         5M0eIBUu1/jCfLN04c4Do+pj4pgBXdI+AZEubKAV7i+8pSQF3b8N13OHJOLa5Ret5u
         qZV25F9JjUZpChxqJSnK1R1N9PnPetMF+WSGH4sP4MDTVJN7cpG73z8Y6ABp4aFBHi
         lRucTksYQNyrtJJWwwS4rFgzsCv8Vnb1Dj9LKAadaTsbNHXOe5G6ykpnlx6rIqOtY5
         ZvIt5TaqVptPKoKysEXE+IYQnD+jIzGShxDc4Of/BGANgcU2p19IT4nepYZ0+45MrJ
         QgL4lcyIBhusOUqUv+auUh1Xdhg24WHmni9BcluvYCPXboOjQQc7WUfxF5WVxserbg
         fARUoKKXQvP1A/sZ8DhGMwB3cLmLLfhMOBJFmyK5vy2siAARvFK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 40/53] http-push: convert process_ls_object and descendants to object_id
Date:   Mon,  1 May 2017 02:29:33 +0000
Message-Id: <20170501022946.258735-41-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename one function to reflect that it now uses struct object_id.  This
conversion is a prerequisite for converting parse_object.

Note that while the use of a buffer that is exactly forty bytes long
looks questionable, get_oid_hex reads exactly the right number of bytes
and does not require the data to be NUL-terminated.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http-push.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/http-push.c b/http-push.c
index 7781f4078..4e7bd9e42 100644
--- a/http-push.c
+++ b/http-push.c
@@ -718,13 +718,13 @@ static int fetch_indices(void)
 	return ret;
 }
 
-static void one_remote_object(const unsigned char *sha1)
+static void one_remote_object(const struct object_id *oid)
 {
 	struct object *obj;
 
-	obj = lookup_object(sha1);
+	obj = lookup_object(oid->hash);
 	if (!obj)
-		obj = parse_object(sha1);
+		obj = parse_object(oid->hash);
 
 	/* Ignore remote objects that don't exist locally */
 	if (!obj)
@@ -1013,26 +1013,26 @@ static void remote_ls(const char *path, int flags,
 		      void *userData);
 
 /* extract hex from sharded "xx/x{40}" filename */
-static int get_sha1_hex_from_objpath(const char *path, unsigned char *sha1)
+static int get_oid_hex_from_objpath(const char *path, struct object_id *oid)
 {
-	char hex[40];
+	char hex[GIT_MAX_HEXSZ];
 
-	if (strlen(path) != 41)
+	if (strlen(path) != GIT_SHA1_HEXSZ + 1)
 		return -1;
 
 	memcpy(hex, path, 2);
 	path += 2;
 	path++; /* skip '/' */
-	memcpy(hex, path, 38);
+	memcpy(hex, path, GIT_SHA1_HEXSZ - 2);
 
-	return get_sha1_hex(hex, sha1);
+	return get_oid_hex(hex, oid);
 }
 
 static void process_ls_object(struct remote_ls_ctx *ls)
 {
 	unsigned int *parent = (unsigned int *)ls->userData;
 	const char *path = ls->dentry_name;
-	unsigned char sha1[20];
+	struct object_id oid;
 
 	if (!strcmp(ls->path, ls->dentry_name) && (ls->flags & IS_DIR)) {
 		remote_dir_exists[*parent] = 1;
@@ -1040,10 +1040,10 @@ static void process_ls_object(struct remote_ls_ctx *ls)
 	}
 
 	if (!skip_prefix(path, "objects/", &path) ||
-	    get_sha1_hex_from_objpath(path, sha1))
+	    get_oid_hex_from_objpath(path, &oid))
 		return;
 
-	one_remote_object(sha1);
+	one_remote_object(&oid);
 }
 
 static void process_ls_ref(struct remote_ls_ctx *ls)
