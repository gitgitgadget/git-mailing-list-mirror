Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6646A1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 21:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeJIFLF (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:11:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49326 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbeJIFLF (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Oct 2018 01:11:05 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4FCFA6078E;
        Mon,  8 Oct 2018 21:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539035834;
        bh=TxBGW6kI35xH8pKYdfEu2uX8VVyCdYUbCN1x2GNYOVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=DpXisGmWh3wxT6+evMOl3TsQ4hl0XGqj21OgEew+aaLXf/wMqiBP02I8k3SBdExah
         8ARDpdAW5oreQynafP4YLhulp1CLLebSiiNULKSUH41uTYwVBiSlO7psOWvH9bwszv
         mPEn8RL445JllEX0f0VlwvoKP9ILdHsByCeq7RWrZSKLTZNbq5IDLMVDYflPyZGoHD
         vLsMYM8NurVhigSkMOxdYCxC1J/bo0RwDjQHet8acSz1o8AjxvNr4k2Z4iSoBy4xet
         I2YgFxH+JiL9AN324njWwccoogmZ7L+K5FrFckLaKHVu29/ERL+Yg3IwJpsNNLgUwd
         KV49mYIPAT1Yi+d0YT2dStaSnsS1IHHC5mI1Jqi5rChPlyWpfrsY9f5SoBlScmW3mp
         lTsxLNALWBxMSnQOH+79Eb9AnkWNlV0Dt9sKseTH62SCupTNRKFUPXfVG6jku994Hu
         z8plfDJj1cj+OCsWgOANJBb1howEpteREYxTfQEPrQaMjK3DD3g
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/14] upload-pack: express constants in terms of the_hash_algo
Date:   Mon,  8 Oct 2018 21:56:55 +0000
Message-Id: <20181008215701.779099-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c
In-Reply-To: <20181008215701.779099-1-sandals@crustytoothpaste.net>
References: <20181008215701.779099-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert all uses of the GIT_SHA1_HEXSZ to use the_hash_algo so that they
are appropriate for any given hash length.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 upload-pack.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 62a1000f44..1aae5dd828 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -443,6 +443,7 @@ static int do_reachable_revlist(struct child_process *cmd,
 	struct object *o;
 	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + hash + LF */
 	int i;
+	const unsigned hexsz = the_hash_algo->hexsz;
 
 	cmd->argv = argv;
 	cmd->git_cmd = 1;
@@ -461,7 +462,7 @@ static int do_reachable_revlist(struct child_process *cmd,
 		goto error;
 
 	namebuf[0] = '^';
-	namebuf[GIT_SHA1_HEXSZ + 1] = '\n';
+	namebuf[hexsz + 1] = '\n';
 	for (i = get_max_object_index(); 0 < i; ) {
 		o = get_indexed_object(--i);
 		if (!o)
@@ -470,11 +471,11 @@ static int do_reachable_revlist(struct child_process *cmd,
 			o->flags &= ~TMP_MARK;
 		if (!is_our_ref(o))
 			continue;
-		memcpy(namebuf + 1, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
-		if (write_in_full(cmd->in, namebuf, GIT_SHA1_HEXSZ + 2) < 0)
+		memcpy(namebuf + 1, oid_to_hex(&o->oid), hexsz);
+		if (write_in_full(cmd->in, namebuf, hexsz + 2) < 0)
 			goto error;
 	}
-	namebuf[GIT_SHA1_HEXSZ] = '\n';
+	namebuf[hexsz] = '\n';
 	for (i = 0; i < src->nr; i++) {
 		o = src->objects[i].item;
 		if (is_our_ref(o)) {
@@ -484,8 +485,8 @@ static int do_reachable_revlist(struct child_process *cmd,
 		}
 		if (reachable && o->type == OBJ_COMMIT)
 			o->flags |= TMP_MARK;
-		memcpy(namebuf, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
-		if (write_in_full(cmd->in, namebuf, GIT_SHA1_HEXSZ + 1) < 0)
+		memcpy(namebuf, oid_to_hex(&o->oid), hexsz);
+		if (write_in_full(cmd->in, namebuf, hexsz + 1) < 0)
 			goto error;
 	}
 	close(cmd->in);
