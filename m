Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17B3A1F829
	for <e@80x24.org>; Mon,  1 May 2017 02:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999689AbdEACby (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:31:54 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:35796 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2999464AbdEACa7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:30:59 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6396F280D4;
        Mon,  1 May 2017 02:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605813;
        bh=8ZrGlo44YuVGzIMA7grwgAGzhF1yA5C+l+ZRkBmP3ZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ulcZhT8BRvNct5Oo+rI2Po6kT9OlSTxo1aTRECKLDe3Jc97IuBDWprmLCazW1rxaQ
         j6jl9Be/odTI1iLqyGjO3MI3w8tPhrQqQfKt232epuG067qlk+A1TaIcHumQl3XtVA
         tlKCQjSD1qtqUKCXfMd4xyHWpC02uO0C3M72C5+cxRLxZAHpgocLKeZZmjIPUm6lPV
         xhVxuHww/Kbj7ISt85cf0GhFQTFJ8RwzlaDpCZlmiT4b8zRvv7Xuu5umAY2JOVHuUv
         f2BA57Nl9aVm5MILs2VGg4PVNKNzU7LrX2tqCZ6Tu1UzarE1zW6igXLdR6DFe8JWvE
         jihdGn7LzH22mwYp9zzZCvZ2LyN0c6tkCZnq/g3hYQcWRXTo9O7q2Fp/U3i94IXwDZ
         k31NhPBvzfB41TpOOBZESS4LzMdLnvD+TUJu+vlZByIjogM+ezo86yEwRI5/WUSsl3
         7zuRQKTkdurplVA8EpjNsYatCo1uFsDaseBUUH61AHW1Pn5V6Br
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 37/53] ref-filter: convert some static functions to struct object_id
Date:   Mon,  1 May 2017 02:29:30 +0000
Message-Id: <20170501022946.258735-38-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Among the converted functions is a caller of parse_object_buffer, which
we will convert later.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 ref-filter.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 77aee273f..56fc990a5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -677,13 +677,13 @@ int verify_ref_format(const char *format)
  * by the "struct object" representation, set *eaten as well---it is a
  * signal from parse_object_buffer to us not to free the buffer.
  */
-static void *get_obj(const unsigned char *sha1, struct object **obj, unsigned long *sz, int *eaten)
+static void *get_obj(const struct object_id *oid, struct object **obj, unsigned long *sz, int *eaten)
 {
 	enum object_type type;
-	void *buf = read_sha1_file(sha1, &type, sz);
+	void *buf = read_sha1_file(oid->hash, &type, sz);
 
 	if (buf)
-		*obj = parse_object_buffer(sha1, type, *sz, buf, eaten);
+		*obj = parse_object_buffer(oid->hash, type, *sz, buf, eaten);
 	else
 		*obj = NULL;
 	return buf;
@@ -1293,7 +1293,7 @@ static void populate_value(struct ref_array_item *ref)
 	struct object *obj;
 	int eaten, i;
 	unsigned long size;
-	const unsigned char *tagged;
+	const struct object_id *tagged;
 
 	ref->value = xcalloc(used_atom_cnt, sizeof(struct atom_value));
 
@@ -1370,10 +1370,10 @@ static void populate_value(struct ref_array_item *ref)
 			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			const char *head;
-			unsigned char sha1[20];
+			struct object_id oid;
 
 			head = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
-						  sha1, NULL);
+						  oid.hash, NULL);
 			if (head && !strcmp(ref->refname, head))
 				v->s = "*";
 			else
@@ -1415,7 +1415,7 @@ static void populate_value(struct ref_array_item *ref)
 	return;
 
  need_obj:
-	buf = get_obj(ref->objectname.hash, &obj, &size, &eaten);
+	buf = get_obj(&ref->objectname, &obj, &size, &eaten);
 	if (!buf)
 		die(_("missing object %s for %s"),
 		    oid_to_hex(&ref->objectname), ref->refname);
@@ -1438,7 +1438,7 @@ static void populate_value(struct ref_array_item *ref)
 	 * If it is a tag object, see if we use a value that derefs
 	 * the object, and if we do grab the object it refers to.
 	 */
-	tagged = ((struct tag *)obj)->tagged->oid.hash;
+	tagged = &((struct tag *)obj)->tagged->oid;
 
 	/*
 	 * NEEDSWORK: This derefs tag only once, which
@@ -1449,10 +1449,10 @@ static void populate_value(struct ref_array_item *ref)
 	buf = get_obj(tagged, &obj, &size, &eaten);
 	if (!buf)
 		die(_("missing object %s for %s"),
-		    sha1_to_hex(tagged), ref->refname);
+		    oid_to_hex(tagged), ref->refname);
 	if (!obj)
 		die(_("parse_object_buffer failed on %s for %s"),
-		    sha1_to_hex(tagged), ref->refname);
+		    oid_to_hex(tagged), ref->refname);
 	grab_values(ref->value, 1, obj, buf, size);
 	if (!eaten)
 		free(buf);
