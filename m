Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB7D51F404
	for <e@80x24.org>; Mon, 12 Mar 2018 02:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932664AbeCLC31 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 22:29:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34402 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932590AbeCLC2i (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Mar 2018 22:28:38 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C3B9F610D3;
        Mon, 12 Mar 2018 02:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1520821717;
        bh=nMveWcOXzS14zhC47HE2WmqHV4YlfKje3Mv/TG5SyRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Vbm+/b3HBS8A3QmZunIJ7gk3/6nX51zMKReBeb7clfdgGoFShp0ce4fI6GajtOIt3
         tyWEGNZAgROV3ewGhLx3lGX63hq8NdZjgPLSZpuERbWSpLyBH9k8cPXpLL+Iv+yFjj
         HzC5G51Axwv2YWWk3GQdSTOcIeeSvPM0xs8eoKnk/kH39iNtadovGjt+kVpE0kj3mW
         2BIlQAzRiuKQID+09A+sznGrZzLcM7BgiT0AYWsO4qClzW+sWpLKmL2KU0N7TJq9zU
         R5gPrghEUZOWQ07pPSim0fotsEeSc2e2dWKz+DW4IYl856sptWdvwrI1U4ffEfKnSJ
         EyjrZgtFAo1gUakCMwCPtmj8Y8RxE9387nV28kQc45XhdsPM6YM52M39xQejBN15VN
         UzeCEEebuiv6AlltoP/W3L4HbrIAwBJ6/ZQpC6S6q9L928mRS5x2NyeIWkGFCxKdA+
         vTavBwSSz0OfJqwqTyz5B+XpigRGQ+URyxze0061qN7BpFUW8nP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 21/36] builtin/mktree: convert to struct object_id
Date:   Mon, 12 Mar 2018 02:27:41 +0000
Message-Id: <20180312022756.483934-22-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.660.g709887971b
In-Reply-To: <20180312022756.483934-1-sandals@crustytoothpaste.net>
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert this file to use struct object_id.  Modify one use of
get_sha1_hex into parse_oid_hex; this is safe since we get the data from
a strbuf.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/mktree.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index f5f3c0eea1..e39fe5d423 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -10,13 +10,13 @@
 
 static struct treeent {
 	unsigned mode;
-	unsigned char sha1[20];
+	struct object_id oid;
 	int len;
 	char name[FLEX_ARRAY];
 } **entries;
 static int alloc, used;
 
-static void append_to_tree(unsigned mode, unsigned char *sha1, char *path)
+static void append_to_tree(unsigned mode, struct object_id *oid, char *path)
 {
 	struct treeent *ent;
 	size_t len = strlen(path);
@@ -26,7 +26,7 @@ static void append_to_tree(unsigned mode, unsigned char *sha1, char *path)
 	FLEX_ALLOC_MEM(ent, name, path, len);
 	ent->mode = mode;
 	ent->len = len;
-	hashcpy(ent->sha1, sha1);
+	oidcpy(&ent->oid, oid);
 
 	ALLOC_GROW(entries, used + 1, alloc);
 	entries[used++] = ent;
@@ -54,7 +54,7 @@ static void write_tree(struct object_id *oid)
 	for (i = 0; i < used; i++) {
 		struct treeent *ent = entries[i];
 		strbuf_addf(&buf, "%o %s%c", ent->mode, ent->name, '\0');
-		strbuf_add(&buf, ent->sha1, 20);
+		strbuf_add(&buf, ent->oid.hash, the_hash_algo->rawsz);
 	}
 
 	write_object_file(buf.buf, buf.len, tree_type, oid);
@@ -69,11 +69,12 @@ static const char *mktree_usage[] = {
 static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_missing)
 {
 	char *ptr, *ntr;
+	const char *p;
 	unsigned mode;
 	enum object_type mode_type; /* object type derived from mode */
 	enum object_type obj_type; /* object type derived from sha */
 	char *path, *to_free = NULL;
-	unsigned char sha1[20];
+	struct object_id oid;
 
 	ptr = buf;
 	/*
@@ -85,9 +86,8 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 		die("input format error: %s", buf);
 	ptr = ntr + 1; /* type */
 	ntr = strchr(ptr, ' ');
-	if (!ntr || buf + len <= ntr + 40 ||
-	    ntr[41] != '\t' ||
-	    get_sha1_hex(ntr + 1, sha1))
+	if (!ntr || parse_oid_hex(ntr + 1, &oid, &p) ||
+	    *p != '\t')
 		die("input format error: %s", buf);
 
 	/* It is perfectly normal if we do not have a commit from a submodule */
@@ -116,12 +116,12 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 	}
 
 	/* Check the type of object identified by sha1 */
-	obj_type = sha1_object_info(sha1, NULL);
+	obj_type = sha1_object_info(oid.hash, NULL);
 	if (obj_type < 0) {
 		if (allow_missing) {
 			; /* no problem - missing objects are presumed to be of the right type */
 		} else {
-			die("entry '%s' object %s is unavailable", path, sha1_to_hex(sha1));
+			die("entry '%s' object %s is unavailable", path, oid_to_hex(&oid));
 		}
 	} else {
 		if (obj_type != mode_type) {
@@ -131,11 +131,11 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 			 * because the new tree entry will never be correct.
 			 */
 			die("entry '%s' object %s is a %s but specified type was (%s)",
-				path, sha1_to_hex(sha1), type_name(obj_type), type_name(mode_type));
+				path, oid_to_hex(&oid), type_name(obj_type), type_name(mode_type));
 		}
 	}
 
-	append_to_tree(mode, sha1, path);
+	append_to_tree(mode, &oid, path);
 	free(to_free);
 }
 
