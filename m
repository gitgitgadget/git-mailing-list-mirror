Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E2601F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfBLBXT (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:19 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34244 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbfBLBXS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:18 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2036060898;
        Tue, 12 Feb 2019 01:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934597;
        bh=ns5OIlmI+Q9VJxVLCbPsvywGa+K6IjsuT4RgI4txHJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=X52Iz/sqT3sWACYXftlpMS/uMrSo966ssFk+0ayk71qZen1mnNYVPMYJqde2hPCsD
         cYox8MN8PbdFpy2U2thhrQ6YYQHzinrexNoyvtLfh76lwG+cw2jVIYZz0qK2WrBHqD
         EhrjHaxEcTVB4Z0PA/tK0uqQEW4PQ5fNOjRKKxQP6TFhJuP/ysTeJncQEPSaCIYqZc
         XBlJcWbgkDP8Twq9Fz9FycE3XBlWGcY0EnKOi6qz2BLunWRF0fxYc40ZPeLpEho/cK
         ci/eGF5pJeauP9Zmm5TrFEmymVJyumdwbp/YyiHAkS0CN+8McINc16pbbg3fse78kb
         FyyTLnNadcREacbeAm3FnPj45T6aJo5Ksqr4AOs/9sXofJKuBTR0A8dpqrGJyKytrC
         8ttcLTStYl3R/QWjYCx4wqyb+voPOE1h/6gDejGAVp7lGDZmLrjAaRQgtGkU+sBttU
         +YN4JNoiDEKi5LOLWkCwZIOhMtF4kmLU/zpJwrUWXgI8bvCQY5U
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 03/31] pack-bitmap: convert struct stored_bitmap to object_id
Date:   Tue, 12 Feb 2019 01:22:28 +0000
Message-Id: <20190212012256.1005924-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a
In-Reply-To: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert struct stored_bitmap to use struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 pack-bitmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index b53f37243c..c760913cea 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -18,7 +18,7 @@
  * commit.
  */
 struct stored_bitmap {
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct ewah_bitmap *root;
 	struct stored_bitmap *xor;
 	int flags;
@@ -181,9 +181,9 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 	stored->root = root;
 	stored->xor = xor_with;
 	stored->flags = flags;
-	hashcpy(stored->sha1, sha1);
+	oidread(&stored->oid, sha1);
 
-	hash_pos = kh_put_sha1(index->bitmaps, stored->sha1, &ret);
+	hash_pos = kh_put_sha1(index->bitmaps, stored->oid.hash, &ret);
 
 	/* a 0 return code means the insertion succeeded with no changes,
 	 * because the SHA1 already existed on the map. this is bad, there
@@ -1080,7 +1080,7 @@ int rebuild_existing_bitmaps(struct bitmap_index *bitmap_git,
 					    lookup_stored_bitmap(stored),
 					    rebuild)) {
 				hash_pos = kh_put_sha1(reused_bitmaps,
-						       stored->sha1,
+						       stored->oid.hash,
 						       &hash_ret);
 				kh_value(reused_bitmaps, hash_pos) =
 					bitmap_to_ewah(rebuild);
