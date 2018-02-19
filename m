Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCE111F404
	for <e@80x24.org>; Mon, 19 Feb 2018 22:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932278AbeBSW7t (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 17:59:49 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33306 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932213AbeBSW7s (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Feb 2018 17:59:48 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 14D99609EB;
        Mon, 19 Feb 2018 22:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519081187;
        bh=c3K+uOW/fF//wL+e81N9gPnho16FV459lYVUa1jylfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Lxs4NupXYHobeoexfT2a2cYMtPWVWC8q4917Bn5C54V6AWJBrJtSnPH3gdVQSGQlW
         m39ifOtsv5lAexfOYLBvyUu1KCtkNIzgoktc0rU1gb1aMl/AIN5+nXGKTfYEr8oHz5
         TypPshfGCMBjLI7coGbfRVrDwLrZjjlRZD8z37nhS2m9zs4xibSxahCaeVvrSHEoTw
         OIDAz45oriP9rtpq5OQx8QkmKWD+KGji1Sc63qHViFdUzCzSEUZsHhvDOMRVyMW5LO
         EGJu3Wo1unsQOQBwP8yrNlFuhGULWzzp2O6yD7nZjXGFf4h0gT3ZwJHJGiGNtL82aa
         /9ZHlr3TWTEkvlAHKYC3s73lYUMPItA5iZdnk6zlYbJIRAElaN9cVs/SxnFtgCttHP
         kwf+sl9LCLwt5A7v5MKU/j0DYY4aS2IawyekUogRWOZqU3YbmXM1SgTLF4Bsdn9g7A
         JJos6N94itpmngHLqnUnUZpLsav1Q6XeUN/eTXR1Y1gaC/jZi+A
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 13/36] replace_object: convert struct replace_object to object_id
Date:   Mon, 19 Feb 2018 22:59:04 +0000
Message-Id: <20180219225927.386065-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132
In-Reply-To: <20180219225927.386065-1-sandals@crustytoothpaste.net>
References: <20180219225927.386065-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the two members of this struct to be instances of struct
object_id.  Adjust the various functions in this file accordingly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 replace_object.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/replace_object.c b/replace_object.c
index 3e49965d05..232e8b8550 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -8,8 +8,8 @@
  * sha1.
  */
 static struct replace_object {
-	unsigned char original[20];
-	unsigned char replacement[20];
+	struct object_id original;
+	struct object_id replacement;
 } **replace_object;
 
 static int replace_object_alloc, replace_object_nr;
@@ -17,7 +17,7 @@ static int replace_object_alloc, replace_object_nr;
 static const unsigned char *replace_sha1_access(size_t index, void *table)
 {
 	struct replace_object **replace = table;
-	return replace[index]->original;
+	return replace[index]->original.hash;
 }
 
 static int replace_object_pos(const unsigned char *sha1)
@@ -29,7 +29,7 @@ static int replace_object_pos(const unsigned char *sha1)
 static int register_replace_object(struct replace_object *replace,
 				   int ignore_dups)
 {
-	int pos = replace_object_pos(replace->original);
+	int pos = replace_object_pos(replace->original.hash);
 
 	if (0 <= pos) {
 		if (ignore_dups)
@@ -59,14 +59,14 @@ static int register_replace_ref(const char *refname,
 	const char *hash = slash ? slash + 1 : refname;
 	struct replace_object *repl_obj = xmalloc(sizeof(*repl_obj));
 
-	if (strlen(hash) != 40 || get_sha1_hex(hash, repl_obj->original)) {
+	if (get_oid_hex(hash, &repl_obj->original)) {
 		free(repl_obj);
 		warning("bad replace ref name: %s", refname);
 		return 0;
 	}
 
 	/* Copy sha1 from the read ref */
-	hashcpy(repl_obj->replacement, oid->hash);
+	oidcpy(&repl_obj->replacement, oid);
 
 	/* Register new object */
 	if (register_replace_object(repl_obj, 1))
@@ -113,7 +113,7 @@ const unsigned char *do_lookup_replace_object(const unsigned char *sha1)
 
 		pos = replace_object_pos(cur);
 		if (0 <= pos)
-			cur = replace_object[pos]->replacement;
+			cur = replace_object[pos]->replacement.hash;
 	} while (0 <= pos);
 
 	return cur;
