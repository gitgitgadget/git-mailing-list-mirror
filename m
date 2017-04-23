Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B896B207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046173AbdDWVgM (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:36:12 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37312 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046103AbdDWVfi (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:35:38 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4EBE0280BE;
        Sun, 23 Apr 2017 21:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983333;
        bh=heg7nrZaNhcP64HrHIH63j2VIJtZsMo2naMPWspPmfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VitvHZADdqkjzbafHRs92UagFJWSZVsNHmknqp4YveWAXmBQJyOb+yPn/Od/Wk5ld
         +U1l4JN3QqnnF2YV8b6GShZzZuqW6y0PElPyTFCj6QqI1xbUUENQ5VVyQ2gEkONWxO
         4ceWApgKnISVnO52itlau/Gi0FMS6/oOn9+ajLrEB5Z+gwvwBCCzFB17iPhYS0hPtb
         UseSbq1xP5CNl3x+k1taEqfcniBLFXseqqXh3WP92aDhg69N5H7O2C8RXLLwc7oKs4
         mRnpqkelwlq0n9bA23lHtNdOxdaWPEOiPYOi/6d07taCFlZfklzjNVXjpGIfPrZH+9
         BzOd1U2ufdW4Z7nIEI82SxWZxzZbdMAc8ygYhdGyie0mK9r5S0hRJ4l1aI7j6uK+Jh
         k3GlmacBw8w5KWUOzMXHdd9azV8qwBfeXhXg3G7O0OZP+98Zsq6N12i0OPPRlvEIyy
         twqpxedHkNExr5FlYQXhnJn3pKeVqt3mSdjtOd84NgGdtFrO50x
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 17/53] tag: convert parse_tag_buffer to struct object_id
Date:   Sun, 23 Apr 2017 21:34:17 +0000
Message-Id: <20170423213453.253425-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Specify some constants in terms of GIT_SHA1_HEXSZ, and convert a
get_sha1_hex into parse_oid_hex to avoid needing to specify additional
constants.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 tag.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tag.c b/tag.c
index 243d1fdbb..625f5cd71 100644
--- a/tag.c
+++ b/tag.c
@@ -116,7 +116,7 @@ static unsigned long parse_tag_date(const char *buf, const char *tail)
 
 int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	char type[20];
 	const char *bufptr = data;
 	const char *tail = bufptr + size;
@@ -126,11 +126,10 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 		return 0;
 	item->object.parsed = 1;
 
-	if (size < 64)
+	if (size < GIT_SHA1_HEXSZ + 24)
 		return -1;
-	if (memcmp("object ", bufptr, 7) || get_sha1_hex(bufptr + 7, sha1) || bufptr[47] != '\n')
+	if (memcmp("object ", bufptr, 7) || parse_oid_hex(bufptr + 7, &oid, &bufptr) || *bufptr++ != '\n')
 		return -1;
-	bufptr += 48; /* "object " + sha1 + "\n" */
 
 	if (!starts_with(bufptr, "type "))
 		return -1;
@@ -143,13 +142,13 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 	bufptr = nl + 1;
 
 	if (!strcmp(type, blob_type)) {
-		item->tagged = &lookup_blob(sha1)->object;
+		item->tagged = &lookup_blob(oid.hash)->object;
 	} else if (!strcmp(type, tree_type)) {
-		item->tagged = &lookup_tree(sha1)->object;
+		item->tagged = &lookup_tree(oid.hash)->object;
 	} else if (!strcmp(type, commit_type)) {
-		item->tagged = &lookup_commit(sha1)->object;
+		item->tagged = &lookup_commit(oid.hash)->object;
 	} else if (!strcmp(type, tag_type)) {
-		item->tagged = &lookup_tag(sha1)->object;
+		item->tagged = &lookup_tag(oid.hash)->object;
 	} else {
 		error("Unknown type %s", type);
 		item->tagged = NULL;
