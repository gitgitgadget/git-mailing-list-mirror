Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B2CC1F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfHRUFo (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57942 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727182AbfHRUFh (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:37 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 78EDB60736;
        Sun, 18 Aug 2019 20:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158735;
        bh=O7wPqFA8Zmb9aa/+aWJG42J4CkB5WhXr+92fLQIoHY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Hs1yARsdSX+gfWuPscbn65SUmPqP7y/1SPimorfhFwoYQlcHM3cW+qHO+XE/+dOZl
         SlsngBD6JC/2GmlENASsBRgXQ+ogqkKQ/i7kdy0EPR3eEifLZlFcVK9JWuBVehkYo+
         2rMTu2J26sxa7BaRuA4D+urCb8E3MuOqHqCJKw6S4q0v+SIiBT/xRF/QFC5xSVsUQf
         +lP8fTa++IeUeFH8ObQ81Effe3GiRFVSJdik5aujdyoEnnAMPUjH/KAMiz0vx63wvw
         Dnqo9ehQ73QBmo5+D3mzYvDSynwHDt73WcDnYPfRA5nPCN/UcmwPTEv3xWpYkF8IxE
         TYqBlBlz0kxv0rS3ngvi/H82QKF/O5AgkY4mT0s1BymmfzzdNfIULW/0s0WUxsKRBx
         4ZDRtsVOmFwew4K+d4mszj7tdppxCYOd81nwr+tBl6KsR1BuVJWvIYAmBSelSkxdNr
         CnCUkiFuj6PQSAffzCi1B5d+r+RHuD7uA7DQtxXxg8QFV0yOhn/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 08/26] show-index: switch hard-coded constants to the_hash_algo
Date:   Sun, 18 Aug 2019 20:04:09 +0000
Message-Id: <20190818200427.870753-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

show-index uses a variety of hard-coded constants to enumerate the
values in pack indices.  Switch these hard-coded constants to use
the_hash_algo or GIT_MAX_RAWSZ, as appropriate, and convert one instance
of an unsigned char array to struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/show-index.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/show-index.c b/builtin/show-index.c
index a6e678809e..e95b84e8eb 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -11,6 +11,7 @@ int cmd_show_index(int argc, const char **argv, const char *prefix)
 	unsigned nr;
 	unsigned int version;
 	static unsigned int top_index[256];
+	const unsigned hashsz = the_hash_algo->rawsz;
 
 	if (argc != 1)
 		usage(show_index_usage);
@@ -36,9 +37,9 @@ int cmd_show_index(int argc, const char **argv, const char *prefix)
 	}
 	if (version == 1) {
 		for (i = 0; i < nr; i++) {
-			unsigned int offset, entry[6];
+			unsigned int offset, entry[(GIT_MAX_RAWSZ + 4) / sizeof(unsigned int)];
 
-			if (fread(entry, 4 + 20, 1, stdin) != 1)
+			if (fread(entry, 4 + hashsz, 1, stdin) != 1)
 				die("unable to read entry %u/%u", i, nr);
 			offset = ntohl(entry[0]);
 			printf("%u %s\n", offset, sha1_to_hex((void *)(entry+1)));
@@ -46,13 +47,13 @@ int cmd_show_index(int argc, const char **argv, const char *prefix)
 	} else {
 		unsigned off64_nr = 0;
 		struct {
-			unsigned char sha1[20];
+			struct object_id oid;
 			uint32_t crc;
 			uint32_t off;
 		} *entries;
 		ALLOC_ARRAY(entries, nr);
 		for (i = 0; i < nr; i++)
-			if (fread(entries[i].sha1, 20, 1, stdin) != 1)
+			if (fread(entries[i].oid.hash, hashsz, 1, stdin) != 1)
 				die("unable to read sha1 %u/%u", i, nr);
 		for (i = 0; i < nr; i++)
 			if (fread(&entries[i].crc, 4, 1, stdin) != 1)
@@ -77,7 +78,7 @@ int cmd_show_index(int argc, const char **argv, const char *prefix)
 			}
 			printf("%" PRIuMAX " %s (%08"PRIx32")\n",
 			       (uintmax_t) offset,
-			       sha1_to_hex(entries[i].sha1),
+			       oid_to_hex(&entries[i].oid),
 			       ntohl(entries[i].crc));
 		}
 		free(entries);
