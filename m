Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 861D91F404
	for <e@80x24.org>; Sun, 25 Feb 2018 21:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeBYVNP (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 16:13:15 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34080 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751982AbeBYVNH (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Feb 2018 16:13:07 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 41E9C60E52;
        Sun, 25 Feb 2018 21:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519593185;
        bh=PeRrEw4WUin/82xRXmj2QQ25k32ecciB4TtjI9MNNS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=YHqRpsZvsOVNbNewGK9p0IeYxLampWrDu70+v51OMxgGaStNFx5M0Ezjq5V220Klx
         ME5CVM53PqVZlndFGXm/bmxidzXlk+O4IzKeZ7GJQI9Y9ojy91GRR8HTZdBs9NKQdg
         7VHlNE8/AutOJvnz49G98M8oFD67o910UOCrgcD8uUOlxDOBeeR9BxE5hK3QFul/u9
         sQ1JOc3IVD97VGNkFd3vShCyLoMzbic2CpZSUrspBNapvoZXeH9gn63sHLT3CzktbW
         1s06Jx8fqR45sATs+r+ZrI5IAUB95cWTSwbkVdVsNMlXlFUNPC5zgj/Jxqzh9itit8
         tNLaXYK5xXtE27eH24HEdDVkQdCDRZ3fi1UsvtEzcH2jZmPJndvf//J8J+QGqYDJXM
         NOdMBOiMLe2H/K0Xbnf9P5+wMxMVzl9M5AJuNo95EyP8UYwYjItyXBmq36LbG3f1WF
         bL9nnrtf43Br3sSxqDffiqt/zxrgbn2X+6VIa6zA8N8iQsSS7vM
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 36/36] convert: convert to struct object_id
Date:   Sun, 25 Feb 2018 21:12:12 +0000
Message-Id: <20180225211212.477570-37-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd
In-Reply-To: <20180225211212.477570-1-sandals@crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert convert.c to struct object_id.  Add a use of the_hash_algo to
replace hard-coded constants and change a strbuf_add to a strbuf_addstr
to avoid another hard-coded constant.

Note that a strict conversion using the hexsz constant would cause
problems in the future if the internal and user-visible hash algorithms
differed, as anticipated by the hash function transition plan.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 convert.c | 12 ++++++------
 convert.h |  2 +-
 entry.c   |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/convert.c b/convert.c
index cc562f6509..c480097a2a 100644
--- a/convert.c
+++ b/convert.c
@@ -914,7 +914,7 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
 		to_free = strbuf_detach(buf, NULL);
 	hash_object_file(src, len, "blob", &oid);
 
-	strbuf_grow(buf, len + cnt * 43);
+	strbuf_grow(buf, len + cnt * (the_hash_algo->hexsz + 3));
 	for (;;) {
 		/* step 1: run to the next '$' */
 		dollar = memchr(src, '$', len);
@@ -1510,7 +1510,7 @@ struct ident_filter {
 	struct stream_filter filter;
 	struct strbuf left;
 	int state;
-	char ident[45]; /* ": x40 $" */
+	char ident[GIT_MAX_HEXSZ + 5]; /* ": x40 $" */
 };
 
 static int is_foreign_ident(const char *str)
@@ -1635,12 +1635,12 @@ static struct stream_filter_vtbl ident_vtbl = {
 	ident_free_fn,
 };
 
-static struct stream_filter *ident_filter(const unsigned char *sha1)
+static struct stream_filter *ident_filter(const struct object_id *oid)
 {
 	struct ident_filter *ident = xmalloc(sizeof(*ident));
 
 	xsnprintf(ident->ident, sizeof(ident->ident),
-		  ": %s $", sha1_to_hex(sha1));
+		  ": %s $", oid_to_hex(oid));
 	strbuf_init(&ident->left, 0);
 	ident->filter.vtbl = &ident_vtbl;
 	ident->state = 0;
@@ -1655,7 +1655,7 @@ static struct stream_filter *ident_filter(const unsigned char *sha1)
  * Note that you would be crazy to set CRLF, smuge/clean or ident to a
  * large binary blob you would want us not to slurp into the memory!
  */
-struct stream_filter *get_stream_filter(const char *path, const unsigned char *sha1)
+struct stream_filter *get_stream_filter(const char *path, const struct object_id *oid)
 {
 	struct conv_attrs ca;
 	struct stream_filter *filter = NULL;
@@ -1668,7 +1668,7 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
 		return NULL;
 
 	if (ca.ident)
-		filter = ident_filter(sha1);
+		filter = ident_filter(oid);
 
 	if (output_eol(ca.crlf_action) == EOL_CRLF)
 		filter = cascade_filter(filter, lf_to_crlf_filter());
diff --git a/convert.h b/convert.h
index 65ab3e5167..2e9b4f49cc 100644
--- a/convert.h
+++ b/convert.h
@@ -93,7 +93,7 @@ extern int would_convert_to_git_filter_fd(const char *path);
 
 struct stream_filter; /* opaque */
 
-extern struct stream_filter *get_stream_filter(const char *path, const unsigned char *);
+extern struct stream_filter *get_stream_filter(const char *path, const struct object_id *);
 extern void free_stream_filter(struct stream_filter *);
 extern int is_null_stream_filter(struct stream_filter *);
 
diff --git a/entry.c b/entry.c
index 3f21d2c913..49b83f4a97 100644
--- a/entry.c
+++ b/entry.c
@@ -266,7 +266,7 @@ static int write_entry(struct cache_entry *ce,
 
 	if (ce_mode_s_ifmt == S_IFREG) {
 		struct stream_filter *filter = get_stream_filter(ce->name,
-								 ce->oid.hash);
+								 &ce->oid);
 		if (filter &&
 		    !streaming_write_entry(ce, path, filter,
 					   state, to_tempfile,
