Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EEA91F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932712AbeDWXkT (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:40:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60490 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932687AbeDWXkK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:10 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A7ADA609CB;
        Mon, 23 Apr 2018 23:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526810;
        bh=dmZuao2ENExmM1FUZnid9Ux4PYfBiJBhhYCmlcdgKs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=FdZ3q9UQfx+bKLuTrPxO4KbQC6P+eumVw6BrxZg62MueFw7F/09Xoid4eeATk2HMT
         ALjzQQaPOio3f8k+KMEN8pCGFTeACoRzXBeuNvNLXuMvebU6N5e/eWw/QBB2J+s8Ta
         PPNXPkp8OtmsTrwKFj5tcnFx+LLeLRlErioYQf7iGJ06Omrhqxmdu6myeerHsIglvH
         1aUu2pYl10mSsI6HoZVRnub/CGGQD7NOm7FDcVwqI5BJOWbWmFXX3cpUyfws5hNabZ
         f/sV9J6QwMwGMMyXGcDVeneM0G792Pic00piXaIxJ98D3MdFJD2YydvQkZEAHP/Zjr
         0pU3nJE7rIoYywy1xP/FawzZTmesg5ZDYTrH9+ZdyHTcIh7ApUiQe4Qstz1cYnr2Si
         WtbBRxGM5shVMgyrEHQHvz/ggGv4T/1ajdkCECcEPZh/N+6uDnhXtakjIXQQO17mnX
         0u4lFX/yO/xQe3bhTVnW93YeL+WD3BLJycTY2zKn2ZR5Q8m0UMQ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 06/41] sha1_file: convert freshen functions to object_id
Date:   Mon, 23 Apr 2018 23:39:16 +0000
Message-Id: <20180423233951.276447-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the various functions for freshening objects and
has_loose_object_nonlocal to use struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/pack-objects.c |  2 +-
 cache.h                |  2 +-
 sha1_file.c            | 36 ++++++++++++++++++------------------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4bdae5a1d8..907e112331 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1012,7 +1012,7 @@ static int want_object_in_pack(const struct object_id *oid,
 	int want;
 	struct list_head *pos;
 
-	if (!exclude && local && has_loose_object_nonlocal(oid->hash))
+	if (!exclude && local && has_loose_object_nonlocal(oid))
 		return 0;
 
 	/*
diff --git a/cache.h b/cache.h
index dd1a9c6094..e03a0d4d23 100644
--- a/cache.h
+++ b/cache.h
@@ -1275,7 +1275,7 @@ extern int has_object_file_with_flags(const struct object_id *oid, int flags);
  * with the specified name.  This function does not respect replace
  * references.
  */
-extern int has_loose_object_nonlocal(const unsigned char *sha1);
+extern int has_loose_object_nonlocal(const struct object_id *oid);
 
 extern void assert_oid_type(const struct object_id *oid, enum object_type expect);
 
diff --git a/sha1_file.c b/sha1_file.c
index 77ccaab928..1617e25495 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -709,42 +709,42 @@ int check_and_freshen_file(const char *fn, int freshen)
 	return 1;
 }
 
-static int check_and_freshen_local(const unsigned char *sha1, int freshen)
+static int check_and_freshen_local(const struct object_id *oid, int freshen)
 {
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(the_repository, &buf, sha1);
+	sha1_file_name(the_repository, &buf, oid->hash);
 
 	return check_and_freshen_file(buf.buf, freshen);
 }
 
-static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
+static int check_and_freshen_nonlocal(const struct object_id *oid, int freshen)
 {
 	struct alternate_object_database *alt;
 	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects->alt_odb_list; alt; alt = alt->next) {
-		const char *path = alt_sha1_path(alt, sha1);
+		const char *path = alt_sha1_path(alt, oid->hash);
 		if (check_and_freshen_file(path, freshen))
 			return 1;
 	}
 	return 0;
 }
 
-static int check_and_freshen(const unsigned char *sha1, int freshen)
+static int check_and_freshen(const struct object_id *oid, int freshen)
 {
-	return check_and_freshen_local(sha1, freshen) ||
-	       check_and_freshen_nonlocal(sha1, freshen);
+	return check_and_freshen_local(oid, freshen) ||
+	       check_and_freshen_nonlocal(oid, freshen);
 }
 
-int has_loose_object_nonlocal(const unsigned char *sha1)
+int has_loose_object_nonlocal(const struct object_id *oid)
 {
-	return check_and_freshen_nonlocal(sha1, 0);
+	return check_and_freshen_nonlocal(oid, 0);
 }
 
-static int has_loose_object(const unsigned char *sha1)
+static int has_loose_object(const struct object_id *oid)
 {
-	return check_and_freshen(sha1, 0);
+	return check_and_freshen(oid, 0);
 }
 
 static void mmap_limit_check(size_t length)
@@ -1661,15 +1661,15 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	return finalize_object_file(tmp_file.buf, filename.buf);
 }
 
-static int freshen_loose_object(const unsigned char *sha1)
+static int freshen_loose_object(const struct object_id *oid)
 {
-	return check_and_freshen(sha1, 1);
+	return check_and_freshen(oid, 1);
 }
 
-static int freshen_packed_object(const unsigned char *sha1)
+static int freshen_packed_object(const struct object_id *oid)
 {
 	struct pack_entry e;
-	if (!find_pack_entry(the_repository, sha1, &e))
+	if (!find_pack_entry(the_repository, oid->hash, &e))
 		return 0;
 	if (e.p->freshened)
 		return 1;
@@ -1689,7 +1689,7 @@ int write_object_file(const void *buf, unsigned long len, const char *type,
 	 * it out into .git/objects/??/?{38} file.
 	 */
 	write_object_file_prepare(buf, len, type, oid, hdr, &hdrlen);
-	if (freshen_packed_object(oid->hash) || freshen_loose_object(oid->hash))
+	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		return 0;
 	return write_loose_object(oid, hdr, hdrlen, buf, len, 0);
 }
@@ -1708,7 +1708,7 @@ int hash_object_file_literally(const void *buf, unsigned long len,
 
 	if (!(flags & HASH_WRITE_OBJECT))
 		goto cleanup;
-	if (freshen_packed_object(oid->hash) || freshen_loose_object(oid->hash))
+	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		goto cleanup;
 	status = write_loose_object(oid, header, hdrlen, buf, len, 0);
 
@@ -1726,7 +1726,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	int hdrlen;
 	int ret;
 
-	if (has_loose_object(oid->hash))
+	if (has_loose_object(oid))
 		return 0;
 	buf = read_object(oid->hash, &type, &len);
 	if (!buf)
