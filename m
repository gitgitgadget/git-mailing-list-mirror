Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C78A5207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046254AbdDWVhl (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:37:41 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37462 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046150AbdDWVf4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:35:56 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id F3579280D4;
        Sun, 23 Apr 2017 21:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983341;
        bh=CuEHIlHgzxzz9iYpTChUk/qguRoOgxdC3n7Vzj+K3/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dbqwLJb8jsid3O4VfS4LJbLcxSDj8bwGn5FTKPK+klHmBRc/DvbgExBYorEErVKSH
         vVdEDv4JeZIWId4/TK0VIQSqeiHZNux/qRlDOe7//acNLj4w57Xw+VW+qDGJLjDZ2Z
         +I3YVwfnY+1L6qhkB4q70jC1RQhzEiHoe1STwmkyvMugdNcKAnWe9X4x0wJ+ofGMjl
         B1jXjmIhVTgRavoPx1Jl9ShOB+uEHSquiHYCwHXNT1pMmhTBGDq4+vQFXr5e/KN6sj
         rvm3NICd0DGpOrvbfbrSvsLhRUMo0V0DBduyVc2i9VQTlToP2kFfTSb+0+HnmrSRe6
         X88UHVduDYCU1xydHpBdrarIagBi2TCPFf6eWiwpRFiQxRFbpKDbBygRJ7kyiCRdho
         9mSKdk8pLRQZ/HkzUVqWAn0/klbdP9l8VDSJK+2blP40W6d9Isz4nUWscpijYc/p+k
         MqS4kZROij3U7WV3BAJ44YWPJ/kixJKhJJZeZGkY9H1K+TXHI0m
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 40/53] http-push: convert process_ls_object and descendants to object_id
Date:   Sun, 23 Apr 2017 21:34:40 +0000
Message-Id: <20170423213453.253425-41-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
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
