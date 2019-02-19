Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33BDB1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbfBSAFn (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:05:43 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34602 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732147AbfBSAFm (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:05:42 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A27C26098B;
        Tue, 19 Feb 2019 00:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534741;
        bh=VGJW+syuTlUQ1JiMelAd2KeGi1GkwrWiTo4ZH3HNkOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=vGB88kBmZINRhOSAOku+ywyPqx3reey5mJpxP4+fMbenmoSF7+I8vo3ihA92rcenk
         MC+QYrIU9nixB9PBVuL/jFIUo//Hw7z7TNnVxMFFiy0zB752dZmDA/5LzAiVqncKp2
         m1n8uTSpq6MassPIkN//nTmN9C0CHA3zx+4cOzHyVtZYtSQC+G7ZjC0ekaaEk1vB/+
         tC57b+bEcInIyyuSfcp2vRZLYH1tL408HOpQGDGz7Jg6769Bo/QIIbA033wtYv/hA9
         zvR1o5BoFsMl1IXJt5TaWTS2C4jg1IYy4t7ErcI2aePhlexKhOwrabxZVJWNPlgb+J
         KJLDyUynLhuZMV5ySvuoMa2PNNrgY3NVBQTpCdUX2pbyaLvLXbG8NxTgphRtMYizy2
         9TVAMlLpoIYtoiQ+n6EpvMLePUWcjaH4lF6mgEH84OoHf7ESOXE/dzxsl6XPlPYYfS
         h1vbl5TzLzs7mKvIWqm67Q2wjGZM6AqpcXj2iD49sWfeYFV+I3H
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 03/35] pack-bitmap: make bitmap header handling hash agnostic
Date:   Tue, 19 Feb 2019 00:04:54 +0000
Message-Id: <20190219000526.476553-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190219000526.476553-1-sandals@crustytoothpaste.net>
References: <20190219000526.476553-1-sandals@crustytoothpaste.net>
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
