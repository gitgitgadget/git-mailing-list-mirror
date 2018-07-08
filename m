Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42A141F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 23:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933292AbeGHXhK (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 19:37:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54400 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933174AbeGHXhG (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 19:37:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5BCB76047B;
        Sun,  8 Jul 2018 23:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531093025;
        bh=FZevZFIE9zCFGfByasyRYTbqLDI/t9xWWD9TrnfAPgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=bSWkah5FT5Tt8q9SJBrmj1I11UMh6G6Pk4XFOssuyElUiqiCNrSO4yxqil35bU3YK
         hktRnBzNZb9qCD/2fzLss1vqSgPAUADvR/JYGiSC5GRUezLRBz79xvkiu2tFllpjh9
         hkeXCTKecadFE3azA0gWNSiZ467tr031gmrFSF2q7fP1basD5Omc+HmScVAyLAjGBA
         vGAwhtnmuNwE/EMGyKw5m3bkCszoGN8FL8X5Eh8ob47+howMhhOMkB1ystBveVYoBT
         V2894BC11k/DXViSQAXicFmVrQXVt2QoK2a2fSq36Ho2YlISjW148QcrJRKG+Fbs3G
         x3xq04cA5wxHQPP+siIP6IT5swMaeLg1YfgsBrV8rVG1uTeotAWTkOUGBnx8vXhFNN
         NDfw9nyXYhj+gp9QnI5P1D/iYzrKFYUNcmkOLCMh2tm4f23u6DbWQEnBSVVNbjE5Is
         d/S7bK51MEmX8JSyvWCp80c6saYlloZZjhh3TNhCADatAiw8L7b
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 16/17] sha1-file: convert constants to uses of the_hash_algo
Date:   Sun,  8 Jul 2018 23:36:37 +0000
Message-Id: <20180708233638.520172-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180708233638.520172-1-sandals@crustytoothpaste.net>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert one use of 20 and several uses of GIT_SHA1_HEXSZ into references
to the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sha1-file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sha1-file.c b/sha1-file.c
index de4839e634..1f66b9594f 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -336,7 +336,7 @@ int raceproof_create_file(const char *path, create_file_fn fn, void *cb)
 static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 {
 	int i;
-	for (i = 0; i < 20; i++) {
+	for (i = 0; i < the_hash_algo->rawsz; i++) {
 		static char hex[] = "0123456789abcdef";
 		unsigned int val = sha1[i];
 		strbuf_addch(buf, hex[val >> 4]);
@@ -1473,7 +1473,7 @@ void *read_object_with_reference(const struct object_id *oid,
 		}
 		ref_length = strlen(ref_type);
 
-		if (ref_length + GIT_SHA1_HEXSZ > isize ||
+		if (ref_length + the_hash_algo->hexsz > isize ||
 		    memcmp(buffer, ref_type, ref_length) ||
 		    get_oid_hex((char *) buffer + ref_length, &actual_oid)) {
 			free(buffer);
@@ -2062,9 +2062,9 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 		namelen = strlen(de->d_name);
 		strbuf_setlen(path, baselen);
 		strbuf_add(path, de->d_name, namelen);
-		if (namelen == GIT_SHA1_HEXSZ - 2 &&
+		if (namelen == the_hash_algo->hexsz - 2 &&
 		    !hex_to_bytes(oid.hash + 1, de->d_name,
-				  GIT_SHA1_RAWSZ - 1)) {
+				  the_hash_algo->rawsz - 1)) {
 			if (obj_cb) {
 				r = obj_cb(&oid, path->buf, data);
 				if (r)
