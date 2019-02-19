Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 527531F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732216AbfBSAF4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:05:56 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34638 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730731AbfBSAFv (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:05:51 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B91CE60489;
        Tue, 19 Feb 2019 00:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534749;
        bh=ULl7lYn/vl2qJUXXC+CwoJLW2Y6YjqIy1ABwq96Lih8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=zGIyjsHYzWOwR2ZkKRm2oEvRkt5w/t00PafqnlubI+EbKqdd3VApxM3Wkr2Rlmwhc
         TbXZBWvHH8vKXgVH6PkKKK6woF0YmdQM5Bzx6gs+M69cAJHC3aEBSl31CrOJJjtXC1
         ZEgvPikAFZt1IaoJzrSQs/1IkGsaHbh1BngN9lAT0362lFjWl1nVc9Qi2AakYkhe7U
         UTwroWgS6fzM634Vt65OPpbIXpuzcIE7QI39zVqxlcfTtFKnLx9bQmpp2GKvB6ADqN
         ZHwgYFadUw9RAQ07Tqr+A1N/Xu80l4UlgnTKgwEt5B4FZa7P/KQ1eSKeoNa2ypTSMA
         hUL8SEYmdXDuvzIjPObiQc8o+KLnKk+FyyGHm92AhLykO5bLdj3w+LOpLFt8DV6bmp
         cIDZSXyR4s2FezMsc11IKV7sel2VOmrq1WEkt3K2WaiBUCfii8lwHsMHjQMoHg1RtQ
         oAYnZNsMhB4RPY7FkM/mZTNrjbSM7M5rDZRNmJvIyJi4r8G8sBh
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 11/35] notes: replace sha1_to_hex
Date:   Tue, 19 Feb 2019 00:05:02 +0000
Message-Id: <20190219000526.476553-12-sandals@crustytoothpaste.net>
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

Replace the uses of sha1_to_hex in this function with hash_to_hex to
allow the use of SHA-256 as well.  Rename some variables since this code
is no longer limited to SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 notes.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/notes.c b/notes.c
index 5457bd70c6..be72780a8f 100644
--- a/notes.c
+++ b/notes.c
@@ -532,19 +532,19 @@ static unsigned char determine_fanout(struct int_node *tree, unsigned char n,
 /* hex oid + '/' between each pair of hex digits + NUL */
 #define FANOUT_PATH_MAX GIT_MAX_HEXSZ + FANOUT_PATH_SEPARATORS_MAX + 1
 
-static void construct_path_with_fanout(const unsigned char *sha1,
+static void construct_path_with_fanout(const unsigned char *hash,
 		unsigned char fanout, char *path)
 {
 	unsigned int i = 0, j = 0;
-	const char *hex_sha1 = sha1_to_hex(sha1);
+	const char *hex_hash = hash_to_hex(hash);
 	assert(fanout < the_hash_algo->rawsz);
 	while (fanout) {
-		path[i++] = hex_sha1[j++];
-		path[i++] = hex_sha1[j++];
+		path[i++] = hex_hash[j++];
+		path[i++] = hex_hash[j++];
 		path[i++] = '/';
 		fanout--;
 	}
-	xsnprintf(path + i, FANOUT_PATH_MAX - i, "%s", hex_sha1 + j);
+	xsnprintf(path + i, FANOUT_PATH_MAX - i, "%s", hex_hash + j);
 }
 
 static int for_each_note_helper(struct notes_tree *t, struct int_node *tree,
@@ -1167,7 +1167,7 @@ void prune_notes(struct notes_tree *t, int flags)
 
 	while (l) {
 		if (flags & NOTES_PRUNE_VERBOSE)
-			printf("%s\n", sha1_to_hex(l->sha1));
+			printf("%s\n", hash_to_hex(l->sha1));
 		if (!(flags & NOTES_PRUNE_DRYRUN))
 			remove_note(t, l->sha1);
 		l = l->next;
