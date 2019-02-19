Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 227AB1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbfBSAGD (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:06:03 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34666 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732206AbfBSAF7 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:05:59 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EAD7861091;
        Tue, 19 Feb 2019 00:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534757;
        bh=ew3v3skWNpv8fDanCbUgTUbaHGFtLSUN80DuTfv7fUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ZMM0FzdL8dWnWVGZktUQI6eTb9qQGzfbEiw58ZQ6F7cz+aLYGaO8tqeMlkJPQSNoA
         2qFA0Mnp86ptbb9L+cWk7U0B0M6IafVk23VwL3ZNCzhw9HHQrTlABlWdN/j2IoLW+T
         Hx5MwELjQSwz7pGRuNpwqIgNb5QYviVbPfdlgsModD3KvMSq+Fbz7MRQV2F/I2c3O+
         F8/6nFa5n8hnz6mSNdA/WSRs7EgtaB43jR5UDeIb3+c50702Yq802eH9Dvd8rK8CbR
         ZMeeLQ6mzMIMn5l7iKxLCGTtvKM2mWVUHtGkAfp9I3YVNgJdpM626HGs59eKy6NaPV
         daUK+c0JBCpe6EHAMGZcZiXdNduppCFuP17iBA9dCvNq7UUDX8XI5gYDJAmwMnHGGq
         uJ+TuxvmJ5IPTPXuugFdlh6fUuxaDR2MYHj/0LC/E57dmbpl+Scnr/9/VFiRws6LU4
         IvaOm3aR8XH3zAW6M7R8+98OiLXu5SozYdP1KIEFhrFnf214WNO
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 18/35] http-push: convert to use the_hash_algo
Date:   Tue, 19 Feb 2019 00:05:09 +0000
Message-Id: <20190219000526.476553-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190219000526.476553-1-sandals@crustytoothpaste.net>
References: <20190219000526.476553-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch the lock token code to use the_hash_algo and increase its buffers
to be allocated using GIT_MAX_* constants.  Update the parsing of object
paths to use the_hash_algo as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http-push.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/http-push.c b/http-push.c
index b313ada515..c4e5142bc9 100644
--- a/http-push.c
+++ b/http-push.c
@@ -145,7 +145,7 @@ struct remote_lock {
 	char *url;
 	char *owner;
 	char *token;
-	char tmpfile_suffix[41];
+	char tmpfile_suffix[GIT_MAX_HEXSZ + 1];
 	time_t start_time;
 	long timeout;
 	int refreshing;
@@ -399,7 +399,7 @@ static void start_put(struct transfer_request *request)
 	request->dest = strbuf_detach(&buf, NULL);
 
 	append_remote_object_url(&buf, repo->url, hex, 0);
-	strbuf_add(&buf, request->lock->tmpfile_suffix, 41);
+	strbuf_add(&buf, request->lock->tmpfile_suffix, the_hash_algo->hexsz + 1);
 	request->url = strbuf_detach(&buf, NULL);
 
 	slot = get_active_slot();
@@ -758,8 +758,8 @@ static void handle_lockprop_ctx(struct xml_ctx *ctx, int tag_closed)
 static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
 {
 	struct remote_lock *lock = (struct remote_lock *)ctx->userData;
-	git_SHA_CTX sha_ctx;
-	unsigned char lock_token_sha1[20];
+	git_hash_ctx hash_ctx;
+	unsigned char lock_token_hash[GIT_MAX_RAWSZ];
 
 	if (tag_closed && ctx->cdata) {
 		if (!strcmp(ctx->name, DAV_ACTIVELOCK_OWNER)) {
@@ -771,12 +771,12 @@ static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
 		} else if (!strcmp(ctx->name, DAV_ACTIVELOCK_TOKEN)) {
 			lock->token = xstrdup(ctx->cdata);
 
-			git_SHA1_Init(&sha_ctx);
-			git_SHA1_Update(&sha_ctx, lock->token, strlen(lock->token));
-			git_SHA1_Final(lock_token_sha1, &sha_ctx);
+			the_hash_algo->init_fn(&hash_ctx);
+			the_hash_algo->update_fn(&hash_ctx, lock->token, strlen(lock->token));
+			the_hash_algo->final_fn(lock_token_hash, &hash_ctx);
 
 			lock->tmpfile_suffix[0] = '_';
-			memcpy(lock->tmpfile_suffix + 1, sha1_to_hex(lock_token_sha1), 40);
+			memcpy(lock->tmpfile_suffix + 1, hash_to_hex(lock_token_hash), the_hash_algo->hexsz);
 		}
 	}
 }
@@ -1018,7 +1018,7 @@ static void remote_ls(const char *path, int flags,
 /* extract hex from sharded "xx/x{38}" filename */
 static int get_oid_hex_from_objpath(const char *path, struct object_id *oid)
 {
-	if (strlen(path) != GIT_SHA1_HEXSZ + 1)
+	if (strlen(path) != the_hash_algo->hexsz + 1)
 		return -1;
 
 	if (hex_to_bytes(oid->hash, path, 1))
@@ -1026,7 +1026,7 @@ static int get_oid_hex_from_objpath(const char *path, struct object_id *oid)
 	path += 2;
 	path++; /* skip '/' */
 
-	return hex_to_bytes(oid->hash + 1, path, GIT_SHA1_RAWSZ - 1);
+	return hex_to_bytes(oid->hash + 1, path, the_hash_algo->rawsz - 1);
 }
 
 static void process_ls_object(struct remote_ls_ctx *ls)
