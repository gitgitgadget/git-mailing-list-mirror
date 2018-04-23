Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADA1F1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932767AbeDWXkg (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:40:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60562 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932728AbeDWXk2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:28 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 737D360B3A;
        Mon, 23 Apr 2018 23:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526826;
        bh=xP1CPBYCnRgYWxgOAOO0POYQK+iMe4SVkeS8rTTYOe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=LdwPn0DQ7pjsHHmgINKUpto5MHasDc9mTx997/cgknvdKgPaqaRW/bkp2IfX3rPg4
         9f7QlrdyPlqQOVvHXDrhU/IVxC30ejPVycu3VdUSt0VX+cbVx0UgDqUTSQD9SeAc5S
         p2MdqcxeCoAF14cUqPzakFgFm2MMPDTj1yiWzCkGW48uNYQ+6br2VbtfISD+a+mbOw
         JSnrFxQ0M2DbYFaajla/Uf8QXwiQ3KWP/V350qD419Iu6mYfHotcWAu0oW3gqC1cPE
         H0qYskzk+/x7/sGgd10JzgjzUB/c2/XGrp9O5urmF5Il6ieMxzUpWc/9L8uz90GCAn
         jCUxSZmJhjCD/xBEKURbgs0gU2uoz225IQxQeb1woxeC05a9K8vG3NPGzjT2baYBOf
         CFhI11jnArxrfW+jPa2hB9WLk8ItXcmdXjQHu6qHOiCRzBsM0ldB560BUIsimV5LNk
         8mVWGYy9io5HUETB7hdnovprFXPV4AE3DzP7fj6yM/F/lKdE+tN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 20/41] dir: convert struct untracked_cache_dir to object_id
Date:   Mon, 23 Apr 2018 23:39:30 +0000
Message-Id: <20180423233951.276447-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the exclude_sha1 member of struct untracked_cache_dir and rename
it to exclude_oid.  Eliminate several hard-coded integral constants, and
update a function name that referred to SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 dir.c                                | 23 ++++++++++++-----------
 dir.h                                |  5 +++--
 t/helper/test-dump-untracked-cache.c |  2 +-
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/dir.c b/dir.c
index 63a917be45..06f4c4a8bf 100644
--- a/dir.c
+++ b/dir.c
@@ -1240,11 +1240,11 @@ static void prep_exclude(struct dir_struct *dir,
 		    (!untracked || !untracked->valid ||
 		     /*
 		      * .. and .gitignore does not exist before
-		      * (i.e. null exclude_sha1). Then we can skip
+		      * (i.e. null exclude_oid). Then we can skip
 		      * loading .gitignore, which would result in
 		      * ENOENT anyway.
 		      */
-		     !is_null_sha1(untracked->exclude_sha1))) {
+		     !is_null_oid(&untracked->exclude_oid))) {
 			/*
 			 * dir->basebuf gets reused by the traversal, but we
 			 * need fname to remain unchanged to ensure the src
@@ -1275,9 +1275,9 @@ static void prep_exclude(struct dir_struct *dir,
 		 * order, though, if you do that.
 		 */
 		if (untracked &&
-		    hashcmp(oid_stat.oid.hash, untracked->exclude_sha1)) {
+		    oidcmp(&oid_stat.oid, &untracked->exclude_oid)) {
 			invalidate_gitignore(dir->untracked, untracked);
-			hashcpy(untracked->exclude_sha1, oid_stat.oid.hash);
+			oidcpy(&untracked->exclude_oid, &oid_stat.oid);
 		}
 		dir->exclude_stack = stk;
 		current = stk->baselen;
@@ -2622,9 +2622,10 @@ static void write_one_dir(struct untracked_cache_dir *untracked,
 		stat_data_to_disk(&stat_data, &untracked->stat_data);
 		strbuf_add(&wd->sb_stat, &stat_data, sizeof(stat_data));
 	}
-	if (!is_null_sha1(untracked->exclude_sha1)) {
+	if (!is_null_oid(&untracked->exclude_oid)) {
 		ewah_set(wd->sha1_valid, i);
-		strbuf_add(&wd->sb_sha1, untracked->exclude_sha1, 20);
+		strbuf_add(&wd->sb_sha1, untracked->exclude_oid.hash,
+			   the_hash_algo->rawsz);
 	}
 
 	intlen = encode_varint(untracked->untracked_nr, intbuf);
@@ -2825,16 +2826,16 @@ static void read_stat(size_t pos, void *cb)
 	ud->valid = 1;
 }
 
-static void read_sha1(size_t pos, void *cb)
+static void read_oid(size_t pos, void *cb)
 {
 	struct read_data *rd = cb;
 	struct untracked_cache_dir *ud = rd->ucd[pos];
-	if (rd->data + 20 > rd->end) {
+	if (rd->data + the_hash_algo->rawsz > rd->end) {
 		rd->data = rd->end + 1;
 		return;
 	}
-	hashcpy(ud->exclude_sha1, rd->data);
-	rd->data += 20;
+	hashcpy(ud->exclude_oid.hash, rd->data);
+	rd->data += the_hash_algo->rawsz;
 }
 
 static void load_oid_stat(struct oid_stat *oid_stat, const unsigned char *data,
@@ -2917,7 +2918,7 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	ewah_each_bit(rd.check_only, set_check_only, &rd);
 	rd.data = next + len;
 	ewah_each_bit(rd.valid, read_stat, &rd);
-	ewah_each_bit(rd.sha1_valid, read_sha1, &rd);
+	ewah_each_bit(rd.sha1_valid, read_oid, &rd);
 	next = rd.data;
 
 done:
diff --git a/dir.h b/dir.h
index b0758b82a2..de66be9f4e 100644
--- a/dir.h
+++ b/dir.h
@@ -3,6 +3,7 @@
 
 /* See Documentation/technical/api-directory-listing.txt */
 
+#include "cache.h"
 #include "strbuf.h"
 
 struct dir_entry {
@@ -118,8 +119,8 @@ struct untracked_cache_dir {
 	/* all data except 'dirs' in this struct are good */
 	unsigned int valid : 1;
 	unsigned int recurse : 1;
-	/* null SHA-1 means this directory does not have .gitignore */
-	unsigned char exclude_sha1[20];
+	/* null object ID means this directory does not have .gitignore */
+	struct object_id exclude_oid;
 	char name[FLEX_ARRAY];
 };
 
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index d7c55c2355..bd92fb305a 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -23,7 +23,7 @@ static void dump(struct untracked_cache_dir *ucd, struct strbuf *base)
 	len = base->len;
 	strbuf_addf(base, "%s/", ucd->name);
 	printf("%s %s", base->buf,
-	       sha1_to_hex(ucd->exclude_sha1));
+	       oid_to_hex(&ucd->exclude_oid));
 	if (ucd->recurse)
 		fputs(" recurse", stdout);
 	if (ucd->check_only)
