Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC1F3207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046167AbdDWVgG (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:36:06 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37430 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046101AbdDWVfi (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:35:38 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7AE13280BA;
        Sun, 23 Apr 2017 21:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983332;
        bh=DFrH+ZjQdMQMhsCulOlxzzx+WcrfZYr1OEsTVpEnG18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zy7AKTZiXaz8DyhwaANZc4tVD2PsbyDOt9qCibmqtX9gmp8aYVzbMqazq0bYPmbG3
         fcToyjZiAa0LHNODNALxFE0Ezu2iLrAQR2+wa35EMvMAaTgYqfj/9JzQ9FC8TPYxda
         6ijbHEbjJ4hgh6gxYi+JMII6ziPlW6Hmqr1R4QB21kiJuizpf20EapxbFpVxznC3xq
         tfRaDxaA2GoPesGXi6qqrnc8GigAYtp+kbhcick4AdBxSPB2/jUyg4zT6PNKPu8+SM
         CVlgqX9fMzkiHJJJcArqFSNQh4oft3wt2tMJE/Se4yHcCQDlS4M34VQbtmv0h4n8pj
         BcH001rRmQaxw5yzy4vRH8YCVcvbuk/S+WgYJFVtVvFoTYspnlNShulUPcjg4Qr/Re
         5Avxthuem9uKYEJrlmu95QU6qIVEdBULZT394kBOD07CDrpHiISJ+rydKLrQ75M/fK
         +FjGiq8qDaRKV+vCKar8SNy2d9cKAuBIzFYgjMWVzQtJSNClRHI
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/53] notes-cache: convert to struct object_id
Date:   Sun, 23 Apr 2017 21:34:13 +0000
Message-Id: <20170423213453.253425-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert as many instances of unsigned char [20] as possible,  Update the
callers of notes_cache_get and notes_cache_put to use the new interface.
Among the functions updated are callers of
lookup_commit_reference_gently, which we will soon convert.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 diff.c        |  4 ++--
 notes-cache.c | 29 ++++++++++++++---------------
 notes-cache.h |  4 ++--
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/diff.c b/diff.c
index 11eef1c85..3bd23ae4c 100644
--- a/diff.c
+++ b/diff.c
@@ -5244,7 +5244,7 @@ size_t fill_textconv(struct userdiff_driver *driver,
 
 	if (driver->textconv_cache && df->oid_valid) {
 		*outbuf = notes_cache_get(driver->textconv_cache,
-					  df->oid.hash,
+					  &df->oid,
 					  &size);
 		if (*outbuf)
 			return size;
@@ -5256,7 +5256,7 @@ size_t fill_textconv(struct userdiff_driver *driver,
 
 	if (driver->textconv_cache && df->oid_valid) {
 		/* ignore errors, as we might be in a readonly repository */
-		notes_cache_put(driver->textconv_cache, df->oid.hash, *outbuf,
+		notes_cache_put(driver->textconv_cache, &df->oid, *outbuf,
 				size);
 		/*
 		 * we could save up changes and flush them all at the end,
diff --git a/notes-cache.c b/notes-cache.c
index 5dfc5cbd0..1cdd4984a 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -5,16 +5,16 @@
 
 static int notes_cache_match_validity(const char *ref, const char *validity)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct commit *commit;
 	struct pretty_print_context pretty_ctx;
 	struct strbuf msg = STRBUF_INIT;
 	int ret;
 
-	if (read_ref(ref, sha1) < 0)
+	if (read_ref(ref, oid.hash) < 0)
 		return 0;
 
-	commit = lookup_commit_reference_gently(sha1, 1);
+	commit = lookup_commit_reference_gently(oid.hash, 1);
 	if (!commit)
 		return 0;
 
@@ -46,8 +46,7 @@ void notes_cache_init(struct notes_cache *c, const char *name,
 
 int notes_cache_write(struct notes_cache *c)
 {
-	unsigned char tree_sha1[20];
-	unsigned char commit_sha1[20];
+	struct object_id tree_oid, commit_oid;
 
 	if (!c || !c->tree.initialized || !c->tree.update_ref ||
 	    !*c->tree.update_ref)
@@ -55,19 +54,19 @@ int notes_cache_write(struct notes_cache *c)
 	if (!c->tree.dirty)
 		return 0;
 
-	if (write_notes_tree(&c->tree, tree_sha1))
+	if (write_notes_tree(&c->tree, tree_oid.hash))
 		return -1;
-	if (commit_tree(c->validity, strlen(c->validity), tree_sha1, NULL,
-			commit_sha1, NULL, NULL) < 0)
+	if (commit_tree(c->validity, strlen(c->validity), tree_oid.hash, NULL,
+			commit_oid.hash, NULL, NULL) < 0)
 		return -1;
-	if (update_ref("update notes cache", c->tree.update_ref, commit_sha1,
+	if (update_ref("update notes cache", c->tree.update_ref, commit_oid.hash,
 		       NULL, 0, UPDATE_REFS_QUIET_ON_ERR) < 0)
 		return -1;
 
 	return 0;
 }
 
-char *notes_cache_get(struct notes_cache *c, unsigned char key_sha1[20],
+char *notes_cache_get(struct notes_cache *c, struct object_id *key_oid,
 		      size_t *outsize)
 {
 	const unsigned char *value_sha1;
@@ -75,7 +74,7 @@ char *notes_cache_get(struct notes_cache *c, unsigned char key_sha1[20],
 	char *value;
 	unsigned long size;
 
-	value_sha1 = get_note(&c->tree, key_sha1);
+	value_sha1 = get_note(&c->tree, key_oid->hash);
 	if (!value_sha1)
 		return NULL;
 	value = read_sha1_file(value_sha1, &type, &size);
@@ -84,12 +83,12 @@ char *notes_cache_get(struct notes_cache *c, unsigned char key_sha1[20],
 	return value;
 }
 
-int notes_cache_put(struct notes_cache *c, unsigned char key_sha1[20],
+int notes_cache_put(struct notes_cache *c, struct object_id *key_oid,
 		    const char *data, size_t size)
 {
-	unsigned char value_sha1[20];
+	struct object_id value_oid;
 
-	if (write_sha1_file(data, size, "blob", value_sha1) < 0)
+	if (write_sha1_file(data, size, "blob", value_oid.hash) < 0)
 		return -1;
-	return add_note(&c->tree, key_sha1, value_sha1, NULL);
+	return add_note(&c->tree, key_oid->hash, value_oid.hash, NULL);
 }
diff --git a/notes-cache.h b/notes-cache.h
index 356f88fb3..aeeee8409 100644
--- a/notes-cache.h
+++ b/notes-cache.h
@@ -12,9 +12,9 @@ void notes_cache_init(struct notes_cache *c, const char *name,
 		     const char *validity);
 int notes_cache_write(struct notes_cache *c);
 
-char *notes_cache_get(struct notes_cache *c, unsigned char sha1[20], size_t
+char *notes_cache_get(struct notes_cache *c, struct object_id *oid, size_t
 		      *outsize);
-int notes_cache_put(struct notes_cache *c, unsigned char sha1[20],
+int notes_cache_put(struct notes_cache *c, struct object_id *oid,
 		    const char *data, size_t size);
 
 #endif /* NOTES_CACHE_H */
