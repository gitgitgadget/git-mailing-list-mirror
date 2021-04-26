Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F005CC433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 01:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACD536128B
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 01:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhDZBES (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 21:04:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41788 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231565AbhDZBEQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Apr 2021 21:04:16 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F05A961477;
        Mon, 26 Apr 2021 01:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1619399015;
        bh=sRj+o+z9k5z1UJlL+/+Hua9IwvNIpUrUSmnRYLyB4VU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=rFPaAWfed9Qg+xS7e0+xmTXhbi84ZsIFPobl6tlinYEaz3js6W36KK0Tcmsh2ob2u
         qzCZn6zhAVygIU7DjOPJjFkIHhHF/XOzo+Tkx8hG65Qy/YmFLmk9BGRkqz6TJYrDLe
         4lID2iA3MCJ45KAXLQ/AA/E2Oadkrtl6u71wTaO0QNWgPa1RMr31FslWuRTSsLsvoN
         ZmJcOXXiUhYrn/iy9ejDQn/bghHzbSHFow69qSgxivRKt0+pMMu7mlGoILjLiIivrX
         7F2TrA01l3ZAqbnbxX98YhW2qNBizIDEDiHhcCb/c4BuBsddQSbMyHWXNkGJlI4H11
         zlpHT7BjpGhf+naP9UQNQtDdpBNgK/Iv/+r7tQ82dbfhdjUMBn/0Xf1csc9TzJADdl
         pfr/F5infQH41CmrSX1GuySW7lFAd3CKm4RVcBt7YMDQCNcG4p3vDoqe8UpMSrd4pW
         s7Arjp02sgU9xR8jqCvCDhAtkm7EarZOa+SenH8iOtuQ4/uHe5e
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/13] builtin/pack-objects: avoid using struct object_id for pack hash
Date:   Mon, 26 Apr 2021 01:02:59 +0000
Message-Id: <20210426010301.1093562-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d
In-Reply-To: <20210426010301.1093562-1-sandals@crustytoothpaste.net>
References: <20210426010301.1093562-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use struct object_id for the names of objects.  It isn't intended to
be used for other hash values that don't name objects such as the pack
hash.

Because struct object_id will soon need to have its algorithm member
set, using it in this code path would mean that we didn't set that
member, only the hash member, which would result in a crash.  For both
of these reasons, switch to using an unsigned char array of size
GIT_MAX_RAWSZ.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/pack-objects.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a1e33d7507..2741deac55 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1030,7 +1030,7 @@ static void write_pack_file(void)
 	write_order = compute_write_order();
 
 	do {
-		struct object_id oid;
+		unsigned char hash[GIT_MAX_RAWSZ];
 		char *pack_tmp_name = NULL;
 
 		if (pack_to_stdout)
@@ -1059,13 +1059,13 @@ static void write_pack_file(void)
 		 * If so, rewrite it like in fast-import
 		 */
 		if (pack_to_stdout) {
-			finalize_hashfile(f, oid.hash, CSUM_HASH_IN_STREAM | CSUM_CLOSE);
+			finalize_hashfile(f, hash, CSUM_HASH_IN_STREAM | CSUM_CLOSE);
 		} else if (nr_written == nr_remaining) {
-			finalize_hashfile(f, oid.hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
+			finalize_hashfile(f, hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
 		} else {
-			int fd = finalize_hashfile(f, oid.hash, 0);
-			fixup_pack_header_footer(fd, oid.hash, pack_tmp_name,
-						 nr_written, oid.hash, offset);
+			int fd = finalize_hashfile(f, hash, 0);
+			fixup_pack_header_footer(fd, hash, pack_tmp_name,
+						 nr_written, hash, offset);
 			close(fd);
 			if (write_bitmap_index) {
 				if (write_bitmap_index != WRITE_BITMAP_QUIET)
@@ -1100,17 +1100,17 @@ static void write_pack_file(void)
 			strbuf_addf(&tmpname, "%s-", base_name);
 
 			if (write_bitmap_index) {
-				bitmap_writer_set_checksum(oid.hash);
+				bitmap_writer_set_checksum(hash);
 				bitmap_writer_build_type_index(
 					&to_pack, written_list, nr_written);
 			}
 
 			finish_tmp_packfile(&tmpname, pack_tmp_name,
 					    written_list, nr_written,
-					    &pack_idx_opts, oid.hash);
+					    &pack_idx_opts, hash);
 
 			if (write_bitmap_index) {
-				strbuf_addf(&tmpname, "%s.bitmap", oid_to_hex(&oid));
+				strbuf_addf(&tmpname, "%s.bitmap", hash_to_hex(hash));
 
 				stop_progress(&progress_state);
 
@@ -1124,7 +1124,7 @@ static void write_pack_file(void)
 
 			strbuf_release(&tmpname);
 			free(pack_tmp_name);
-			puts(oid_to_hex(&oid));
+			puts(hash_to_hex(hash));
 		}
 
 		/* mark written objects as written to previous pack */
