Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAAD91F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 23:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933308AbeGHXhU (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 19:37:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54370 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933087AbeGHXhC (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 19:37:02 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 609526047B;
        Sun,  8 Jul 2018 23:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531093021;
        bh=5GKqYD+Qjg6NCuj33n6oL/9O+atTLH+x2Qzp4236Xhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=iNXFIv9AcfBZSA0vfOy9O+o1iYK4hDwQKXZ5H7L6jHfstEAcy/1h85XcrXxvhpUGY
         CDjzfLnIT0+Wm7NZZonDSC2DrbF5lVhE6hULgJGfVF3tNIe/1/+nIWa9jr60igBwpw
         tDT9YUGfm/UjUNzAkCSIDuOTPb0hXj0hcK0u8goBgroPRvRmaCTxBOxQyyJiOBRYmY
         uI4YXIhebyP75yFUpwS0ixUGFLBfUWIf1PHWw6WfcMBofe3CWHIdD4kmguFBlhbHQC
         PzpmciOKCVOqZJQmZk+v5p9umgGBMX6QMROJX8NOqkEXLnfEnCU0jfYTJUYQKM2tSi
         /GcgTAxHe/K5AiKnvDaaYGrqlbYLT2NimoNCJ2Aliv1lAJt1R9rv8zjShtMyrlhwH1
         2r0763u4KA685k7SuG3hLNyG4fw/Xq51K32MBLJa0oPwQh1nA8ZaumWsfkKH9okatz
         EfhCvDMtvo+q5QZgMOX6xfIV48+6jKXMMEh4lZQVZd4IVUry33z
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 12/17] builtin/merge: switch to use the_hash_algo
Date:   Sun,  8 Jul 2018 23:36:33 +0000
Message-Id: <20180708233638.520172-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180708233638.520172-1-sandals@crustytoothpaste.net>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch uses of GIT_SHA1_HEXSZ to use the_hash_algo instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/merge.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 4a4c09496c..916c9f0569 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1034,6 +1034,7 @@ static void handle_fetch_head(struct commit_list **remotes, struct strbuf *merge
 	const char *filename;
 	int fd, pos, npos;
 	struct strbuf fetch_head_file = STRBUF_INIT;
+	const unsigned hexsz = the_hash_algo->hexsz;
 
 	if (!merge_names)
 		merge_names = &fetch_head_file;
@@ -1059,16 +1060,16 @@ static void handle_fetch_head(struct commit_list **remotes, struct strbuf *merge
 		else
 			npos = merge_names->len;
 
-		if (npos - pos < GIT_SHA1_HEXSZ + 2 ||
+		if (npos - pos < hexsz + 2 ||
 		    get_oid_hex(merge_names->buf + pos, &oid))
 			commit = NULL; /* bad */
-		else if (memcmp(merge_names->buf + pos + GIT_SHA1_HEXSZ, "\t\t", 2))
+		else if (memcmp(merge_names->buf + pos + hexsz, "\t\t", 2))
 			continue; /* not-for-merge */
 		else {
-			char saved = merge_names->buf[pos + GIT_SHA1_HEXSZ];
-			merge_names->buf[pos + GIT_SHA1_HEXSZ] = '\0';
+			char saved = merge_names->buf[pos + hexsz];
+			merge_names->buf[pos + hexsz] = '\0';
 			commit = get_merge_parent(merge_names->buf + pos);
-			merge_names->buf[pos + GIT_SHA1_HEXSZ] = saved;
+			merge_names->buf[pos + hexsz] = saved;
 		}
 		if (!commit) {
 			if (ptr)
