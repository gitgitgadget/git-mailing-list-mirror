Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6251B1F829
	for <e@80x24.org>; Mon,  1 May 2017 02:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999576AbdEACbg (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:31:36 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36000 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S642378AbdEACap (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:30:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 041BD280C0;
        Mon,  1 May 2017 02:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605807;
        bh=heg7nrZaNhcP64HrHIH63j2VIJtZsMo2naMPWspPmfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zm26UDY2EnV5DBHuXyj6qBzuYUHTJmaI2FBgNRilw4cLNcr+WjBlKPcDtMSqkJG+n
         piJdK5Mcw+tAZ2u5f7SS6QVklGv/ad5SlzFWQpLO9z0XKbctapCBRg4FTE/loLrqCh
         zrHdpZm6uM94t/JXN1w9mjtJijadAgWgii9TtAM/0MPfGXpxpZuPGPgV5eqrJMvJju
         G1qvSWCIsccSrLYYUWWIODHqUpvG3tjJXwtMYBXbGE8QWEoXLXR9OZrgVJ91rCeTHv
         MVxnfBBNTZAMj3co9x2/ab2SOHfMPy1k767p25rk5YZL7FD3/DZjsGgx9JY1Uxkyog
         +plLzcQuHoTsbZ/vW/nkoncwaxkT5juRFmeAsiicQpOzzMb3uQ4t5yz+LwoxXNOQgH
         QIW4PPnVMdVWJgr+GRG+lQepc1C1b0ItH+CMQe7jrkyWYwVCWQpg0F2sTnv4OgrHhA
         5Xe39bqIgVmdYSO8GSz41EsiZa79lqnijT15wkblXflWVX3qB8O
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 17/53] tag: convert parse_tag_buffer to struct object_id
Date:   Mon,  1 May 2017 02:29:10 +0000
Message-Id: <20170501022946.258735-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
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
