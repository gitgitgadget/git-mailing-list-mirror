Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7F721F404
	for <e@80x24.org>; Mon, 12 Mar 2018 02:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932626AbeCLC2u (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 22:28:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34458 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932615AbeCLC2s (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Mar 2018 22:28:48 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 57B47610E5;
        Mon, 12 Mar 2018 02:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1520821726;
        bh=+KenqkZSUGcJDnJUYus0elVvr1Espm8By/Ezj4XOWLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=nROUsJYsz0wiF36D2KN6lMLiXVfXYFiBtW47iF61VuaycnNJnExocr2txZu/UKG75
         quE6e+1YY+d87G+LItXvbdRnwAfTD+JUcmMEHWsfLUEX/8MTJFK4pRUn85YHr42Bzm
         KWgncX3kb8MewKIjd9za+PzHIEoZYjVZ37wexpvr2Lq7w3zhbIT5aZYYWmb1H9KppG
         ScSJo65qGtWn9L7o7EuAuOzNOLZJME5OmDd5rZB18y6M4F2XNXvdJMjjw2yUNHvqhu
         6B6y9iQZ68KhUsqCOLpt/V9JaPwPZoCuvzDl6f6FpgcFfQ7f04YjGKVXtZXXUw3/de
         //YXNiXLssrHhOYwM5zKBTsd55DHukY4DGxTp9laG+pWW8JP2pByH1i/yiqIUGvFwt
         jZ4jimUC+2hGSifHHq1RS1vY12OlTPCMvVXk0OjuP/JuTPRRxu+t9G6N6lGqw63qb9
         u5rIfJxzjf6DrfX3vxEwzXr5Ty85wRwQKuZ1EFzHbH5isDyQheZ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 30/36] streaming: convert istream internals to struct object_id
Date:   Mon, 12 Mar 2018 02:27:50 +0000
Message-Id: <20180312022756.483934-31-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.660.g709887971b
In-Reply-To: <20180312022756.483934-1-sandals@crustytoothpaste.net>
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the various open_istream variants to take a pointer to struct
object_id.  Introduce a temporary, which will be removed later, to work
around the fact that lookup_replace_object still returns a pointer to
unsigned char.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 streaming.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/streaming.c b/streaming.c
index 344678e95f..3f4be1ea2c 100644
--- a/streaming.c
+++ b/streaming.c
@@ -14,7 +14,7 @@ enum input_source {
 
 typedef int (*open_istream_fn)(struct git_istream *,
 			       struct object_info *,
-			       const unsigned char *,
+			       const struct object_id *,
 			       enum object_type *);
 typedef int (*close_istream_fn)(struct git_istream *);
 typedef ssize_t (*read_istream_fn)(struct git_istream *, char *, size_t);
@@ -27,7 +27,7 @@ struct stream_vtbl {
 #define open_method_decl(name) \
 	int open_istream_ ##name \
 	(struct git_istream *st, struct object_info *oi, \
-	 const unsigned char *sha1, \
+	 const struct object_id *oid, \
 	 enum object_type *type)
 
 #define close_method_decl(name) \
@@ -142,13 +142,16 @@ struct git_istream *open_istream(const struct object_id *oid,
 	struct object_info oi = OBJECT_INFO_INIT;
 	const unsigned char *real = lookup_replace_object(oid->hash);
 	enum input_source src = istream_source(real, type, &oi);
+	struct object_id realoid;
+
+	hashcpy(realoid.hash, real);
 
 	if (src < 0)
 		return NULL;
 
 	st = xmalloc(sizeof(*st));
-	if (open_istream_tbl[src](st, &oi, real, type)) {
-		if (open_istream_incore(st, &oi, real, type)) {
+	if (open_istream_tbl[src](st, &oi, &realoid, type)) {
+		if (open_istream_incore(st, &oi, &realoid, type)) {
 			free(st);
 			return NULL;
 		}
@@ -338,7 +341,7 @@ static struct stream_vtbl loose_vtbl = {
 
 static open_method_decl(loose)
 {
-	st->u.loose.mapped = map_sha1_file(sha1, &st->u.loose.mapsize);
+	st->u.loose.mapped = map_sha1_file(oid->hash, &st->u.loose.mapsize);
 	if (!st->u.loose.mapped)
 		return -1;
 	if ((unpack_sha1_header(&st->z,
@@ -489,7 +492,7 @@ static struct stream_vtbl incore_vtbl = {
 
 static open_method_decl(incore)
 {
-	st->u.incore.buf = read_sha1_file_extended(sha1, type, &st->size, 0);
+	st->u.incore.buf = read_sha1_file_extended(oid->hash, type, &st->size, 0);
 	st->u.incore.read_ptr = 0;
 	st->vtbl = &incore_vtbl;
 
