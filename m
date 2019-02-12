Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D788A1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfBLBXZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:25 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34250 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726177AbfBLBXV (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:21 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 023EB60E51;
        Tue, 12 Feb 2019 01:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934600;
        bh=HMx0XwcuzIG10NLQ1Reh03cO6a4KnQFfr4gzx9GgN9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=oDv5XLh818clWtBvzPF9ysFHIf5To/BCztmIw/D77Kyo9ytunDihezcJJhEbv2nK6
         +IbUwpZpfGmWIrOv9bprFZMsJJCQojJMs74g+xAyfkXAMYfqUqMav14n9JGTf+0+8g
         dmoq6JhRY7WMZ6/Dqur+zI3fAZ2p6oLsl7iyoH8pCeWGOYLpLxFx3SxFBTI/t9fdkh
         CGMNWtoCUmPq/10bA44xks2QPh58Zwx55R8OW5wQs9gpQXJaWWokuEs7rMrv1sQP3S
         qrXq5w2Vd0ymKj47Vai+ig2VxI50xQBJK6cpQ1PAvzMl0rAdCKDCaIx0uj1+09ASQS
         7JJZSA9FJX+PLyeqgJbkUJongKP9A+jkevwrDToalwBJTQ1TsTQZo9OAA09/tSIT1R
         1rybHqP6kIrEfa9dsU9vWWNh67B9jifKvuBPWa83cC1Y/CPSjZpfnbZQ4F9G+MMJhj
         8jBVUn5Et8wUTV1FWD7cVdC/sabCGjIxazoQybwBfRUOQ1NyY5y
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 07/31] notes-merge: switch to use the_hash_algo
Date:   Tue, 12 Feb 2019 01:22:32 +0000
Message-Id: <20190212012256.1005924-8-sandals@crustytoothpaste.net>
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

Switch from using GIT_SHA1_HEXSZ to GIT_MAX_HEXSZ and the_hash_algo so
that the code works with any hash algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 notes-merge.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/notes-merge.c b/notes-merge.c
index 280aa8e6c1..2fe724f1cf 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -29,14 +29,14 @@ void init_notes_merge_options(struct repository *r,
 
 static int path_to_oid(const char *path, struct object_id *oid)
 {
-	char hex_oid[GIT_SHA1_HEXSZ];
+	char hex_oid[GIT_MAX_HEXSZ];
 	int i = 0;
-	while (*path && i < GIT_SHA1_HEXSZ) {
+	while (*path && i < the_hash_algo->hexsz) {
 		if (*path != '/')
 			hex_oid[i++] = *path;
 		path++;
 	}
-	if (*path || i != GIT_SHA1_HEXSZ)
+	if (*path || i != the_hash_algo->hexsz)
 		return -1;
 	return get_oid_hex(hex_oid, oid);
 }
