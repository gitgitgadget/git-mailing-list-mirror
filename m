Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BFCD1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfBLBXW (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:22 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34244 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726969AbfBLBXU (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:20 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A49BB60897;
        Tue, 12 Feb 2019 01:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934599;
        bh=dirQ7xr11Sisxi8H2UaPZ7PLORagH7dGcrdo9rD/WUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=A/ykujYDBPKXWAf/R+h2ibmAx4qovrQ6I1Qp5Hr1pXQrCvnJ6Z5ctXpqYJYXQOObY
         oHlkupBkjSTXnkeApsAgT1E0q3FXeOX0JULfZRkCKQ0IzTubaR02pvrTURvjtsNViI
         +b4xpnJbAcGf7nDJbjTPCgU9jwUvmx5oxWQ4u3o77EdtpFUOcyzmVlkXDaBCwqJ74S
         tKJ/RlaogHBuCXtDQWaP5kBnLyAJBT0oKvgfUXnWuj54vRIN+hAGqVjbMecN5Drl4Y
         cONwFwLlczNqcQ8IOyJqpX9QGdG9lbv+H1N6Ot2a6Rut4ZUxpFRU2On6Phdozhxr5Q
         sMBZRV82jKsPolP/ERfHScE3Yo4pqU6NwW27/odZfIGx2U9xsWpbqFtTBGE7gfLOz0
         swWidmnqhFfcYy7cl+SRgO2mzOJEQNALNXZUkkoSBUdTt/lu86/TX+yjoNqivG9X4c
         YJ2zypSMsy5Xf1XgfOTq8NB/z8d+kIGSZvc0lk5VVAftq4l0SYV
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 05/31] pack-bitmap: switch hard-coded constants to the_hash_algo
Date:   Tue, 12 Feb 2019 01:22:30 +0000
Message-Id: <20190212012256.1005924-6-sandals@crustytoothpaste.net>
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

Switch two hard-coded uses of 20 to references to the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 pack-bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 6d6fa68563..603492c237 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -138,7 +138,7 @@ static int load_bitmap_header(struct bitmap_index *index)
 {
 	struct bitmap_disk_header *header = (void *)index->map;
 
-	if (index->map_size < sizeof(*header) + 20)
+	if (index->map_size < sizeof(*header) + the_hash_algo->rawsz)
 		return error("Corrupted bitmap index (missing header data)");
 
 	if (memcmp(header->magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE)) != 0)
@@ -157,7 +157,7 @@ static int load_bitmap_header(struct bitmap_index *index)
 				"(Git requires BITMAP_OPT_FULL_DAG)");
 
 		if (flags & BITMAP_OPT_HASH_CACHE) {
-			unsigned char *end = index->map + index->map_size - 20;
+			unsigned char *end = index->map + index->map_size - the_hash_algo->rawsz;
 			index->hashes = ((uint32_t *)end) - index->pack->num_objects;
 		}
 	}
