Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF7E81F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfHRUFq (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58004 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727231AbfHRUFq (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:46 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2138D6075B;
        Sun, 18 Aug 2019 20:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158745;
        bh=KK1MUfkkD78W5dM0cgtz3R+3erf0K2oce/76uSCAzuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=hPJkqWDQ6VKkosb++dW0102/betR7qEUbP5fpS/KTUYQ/KZbvzpxljW/jFwYtPY6c
         5+wXQBIaJsPzTYqUf0sDToGpUzmdIwmBrwVuhea69gNbRYR6g5w8dCrFWtsADPZTHs
         CQkE63BBRwWSOn1Kl7RVgVVbPKakijb4MtG9Qlbt5nGH5QejeVM1FDuC2ziz4E6e01
         HvT07XPD77LSjhr8hhpWSx5d4Nq1wI1ECAC53kg3GVHqu7V8aouEQjXaEzdVXeq7Aq
         boJiddoe4LY8TO2UEZIpmjzpuepsg90g5imCZ+SeiAEshyPsn4aEmTV+dmd5nAIEIl
         U3etk1SCbp5S4/lWH0TZhfONF/lQyMTQ8vOgxrLcU51mTpUhAbH4ITL7Ug1GRog1dv
         6jVuQXRzY8Ds4+3HgTK1njVe0PCzlZNRWm7/RS0HZVPlIbFL9StfEWnEL7RmfoBUDr
         rYYaBvR/8bPIoITc87ovmq8nSR3wsSqgXPqBzheiL/KTzSpN6JF
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 16/26] pack-write: use hash_to_hex when writing checksums
Date:   Sun, 18 Aug 2019 20:04:17 +0000
Message-Id: <20190818200427.870753-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pack checksums always use the current hash algorithm in use, so switch
from sha1_to_hex to hash_to_hex.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 pack-write.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index 29d17a9bec..f0017beb9d 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -349,7 +349,7 @@ void finish_tmp_packfile(struct strbuf *name_buffer,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,
 			 struct pack_idx_option *pack_idx_opts,
-			 unsigned char sha1[])
+			 unsigned char hash[])
 {
 	const char *idx_tmp_name;
 	int basename_len = name_buffer->len;
@@ -358,18 +358,18 @@ void finish_tmp_packfile(struct strbuf *name_buffer,
 		die_errno("unable to make temporary pack file readable");
 
 	idx_tmp_name = write_idx_file(NULL, written_list, nr_written,
-				      pack_idx_opts, sha1);
+				      pack_idx_opts, hash);
 	if (adjust_shared_perm(idx_tmp_name))
 		die_errno("unable to make temporary index file readable");
 
-	strbuf_addf(name_buffer, "%s.pack", sha1_to_hex(sha1));
+	strbuf_addf(name_buffer, "%s.pack", hash_to_hex(hash));
 
 	if (rename(pack_tmp_name, name_buffer->buf))
 		die_errno("unable to rename temporary pack file");
 
 	strbuf_setlen(name_buffer, basename_len);
 
-	strbuf_addf(name_buffer, "%s.idx", sha1_to_hex(sha1));
+	strbuf_addf(name_buffer, "%s.idx", hash_to_hex(hash));
 	if (rename(idx_tmp_name, name_buffer->buf))
 		die_errno("unable to rename temporary index file");
 
