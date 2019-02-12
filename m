Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34FD71F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfBLBX5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:57 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34370 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727224AbfBLBXn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:43 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 82E3260E5B;
        Tue, 12 Feb 2019 01:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934622;
        bh=i8oMIBFk1M7HDWz+nRmVOvycOU4QF3MXjsZSqwjhY68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=N9ghY7vgJLmOmyzOrc5lwjuyPsqBCOl8xk8aSzMPM0sJQmjv8/0L/Zv96NTetJy1w
         h43gf0gULXs+2K/WS/otwqaCJSPZArSmRz/8pSa4nXYId3j03vPE2kdEp3e6rZ/0IZ
         1HGIhXj8JErr9V7Cl0mDDbvkrtNDlrwo/deWzP7Nkw7S5A6tBLAc9M1PgNzeUnms5d
         Mv00EgfOfsIjiusfF4IKvs08FN4djvANCJ2leH9xqwU7IWrXjtc7TxVNId0LO+w9Gz
         BDawTnNnJPYfbqUOw7gWB8FTRBCLJacpvitqcasfOCDEgimovhZE34HpTCe3zgUdht
         GemUFs7R3RWX1IIcr8M1JlShgLt4Qrhu9hiGqzZ1CMxH9rtbQPeR1gUjElWSrxVitU
         Z1Gr9nWFjWtoTjxy1Gen1r48FBYCafsxnAFu9xqv+pfXWl6ZMm8PL/R2+XOxA62PhO
         GfUUaopOLwFHuhjz+8L8aB72wX6LNfvlSOwzqNLMszWc1DLTugg
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 27/31] builtin/difftool: use parse_oid_hex
Date:   Tue, 12 Feb 2019 01:22:52 +0000
Message-Id: <20190212012256.1005924-28-sandals@crustytoothpaste.net>
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

Instead of using get_oid_hex and adding constants to the result, use
parse_oid_hex to make this code independent of the hash size.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/difftool.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index a3ea60ea71..1b648226dc 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -65,14 +65,12 @@ static int parse_index_info(char *p, int *mode1, int *mode2,
 	*mode2 = (int)strtol(p + 1, &p, 8);
 	if (*p != ' ')
 		return error("expected ' ', got '%c'", *p);
-	if (get_oid_hex(++p, oid1))
+	if (parse_oid_hex(++p, oid1, (const char **)&p))
 		return error("expected object ID, got '%s'", p + 1);
-	p += GIT_SHA1_HEXSZ;
 	if (*p != ' ')
 		return error("expected ' ', got '%c'", *p);
-	if (get_oid_hex(++p, oid2))
+	if (parse_oid_hex(++p, oid2, (const char **)&p))
 		return error("expected object ID, got '%s'", p + 1);
-	p += GIT_SHA1_HEXSZ;
 	if (*p != ' ')
 		return error("expected ' ', got '%c'", *p);
 	*status = *++p;
