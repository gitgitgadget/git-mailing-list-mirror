Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1DD91F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfBLBXS (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:18 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34238 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726337AbfBLBXS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:18 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 670D860897;
        Tue, 12 Feb 2019 01:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934596;
        bh=VGJW+syuTlUQ1JiMelAd2KeGi1GkwrWiTo4ZH3HNkOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=hjLvVfnhe+bJRr+FdwoILo5xuD7WrTIetRxSDLzVXto1nRkqAtuKtRTFWBSuy41nm
         clTT+WCrkanlGjFxtHZ3TSLEP951FRlI4rTqhVB8HMlo25FtPfCvoO/SY3XBW5WxvA
         SDgCzVpb3bF5P0M4F8bV7b8Kp4H7a47N3WiZgKvW7NRSogfMoctNebqaRDpjwrikmh
         QlcoPyQGVh5HQkTX7aiOoS9jP0HWNPcMSYctX+IJQ0+n5NZ7BFLYgXIdEPy9TeJ0j+
         +3dSJmzJ6MeqvzO0DVyOQYUTLSPEyOxg29yp6YUnxqIvrxCSh6+kIJciYTC1X2+RRd
         yq9q0iPQGbdGKN6eKUhVUVYbcjl0rfw0LSxqWTn2+QZdnwZQDA0ef9jRewPVrD4YwC
         1xeoCI3fkPw8YEup0eICMouMb8oILTv9OCDhngJwc/eS5ZUcomEJgtmVmGfmfl5UtB
         ufL6C/402z5o3PbBipfW6mxL8ZfcYMBaY1ITR5iGLiAo6CZFGL/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 02/31] pack-bitmap: make bitmap header handling hash agnostic
Date:   Tue, 12 Feb 2019 01:22:27 +0000
Message-Id: <20190212012256.1005924-3-sandals@crustytoothpaste.net>
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

Increase the checksum field in struct bitmap_disk_header to be
GIT_MAX_RAWSZ bytes in length and ensure that we hash the proper number
of bytes out when computing the bitmap checksum.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 pack-bitmap-write.c | 2 +-
 pack-bitmap.c       | 2 +-
 pack-bitmap.h       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 5566e94abe..c82fb01fd7 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -535,7 +535,7 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	header.entry_count = htonl(writer.selected_nr);
 	hashcpy(header.checksum, writer.pack_checksum);
 
-	hashwrite(f, &header, sizeof(header));
+	hashwrite(f, &header, sizeof(header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz);
 	dump_bitmap(f, writer.commits);
 	dump_bitmap(f, writer.trees);
 	dump_bitmap(f, writer.blobs);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 4695aaf6b4..b53f37243c 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -163,7 +163,7 @@ static int load_bitmap_header(struct bitmap_index *index)
 	}
 
 	index->entry_count = ntohl(header->entry_count);
-	index->map_pos += sizeof(*header);
+	index->map_pos += sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
 	return 0;
 }
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 8418ba8c79..344ba23af9 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -14,7 +14,7 @@ struct bitmap_disk_header {
 	uint16_t version;
 	uint16_t options;
 	uint32_t entry_count;
-	unsigned char checksum[20];
+	unsigned char checksum[GIT_MAX_RAWSZ];
 };
 
 static const char BITMAP_IDX_SIGNATURE[] = {'B', 'I', 'T', 'M'};
