Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9376B1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfBLBXe (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:34 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34316 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727168AbfBLBXd (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:33 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0CFBD60E54;
        Tue, 12 Feb 2019 01:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934612;
        bh=+5fh+FR9PRQDRolK2uH6wkevzO/rfiLlvMVrulPvglI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=SE8yK/ISp0FxOKocWl30aadQDr6to/YQemn0VwtFwkvbTF0VGq8TNxX4qUvcEK9Ql
         DKqMojUCGGsYyAxV5ixysKacutxwIde7bNCFJJk6RKq18rPrPlfiVsXNcJO7qTxCGH
         /J+Rx+w987HOZonP/Kv+Oa+4fgSJ9ovtPoHvlA+zlUTPDRv+X31LCwdQDd4VV4KIzt
         Bwv4KOV92Yu2fhNML4FcrsWSwHHgutT74kSGQGREbKH0ZlsZQWDamcP+7zZfE/WZOK
         9cAEy8ckeFn1+0uhkZvFtz2lF0Ne8Gnj24U22VnHXlDq8ifYaeeXDu2fBnohhF+X+t
         sui6u/3wEB77iy8AWJXApKbtcOxqzIjGCdyXB4UzNmt3yDIqxZhAZLxY/FvpVziKyi
         edn6J6z2pHsYvzcQrnGy0LI5XIrFp+rdYo6RFdf6uJ62QsKxvDYRiA1u+v3VUPv45c
         k3BFd4jFMw2SKBnmVz1zLdoRpI2p/h8oRDGC1tbiZSL0kcJddkk
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 17/31] http-backend: allow 64-character hex names
Date:   Tue, 12 Feb 2019 01:22:42 +0000
Message-Id: <20190212012256.1005924-18-sandals@crustytoothpaste.net>
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

In an SHA-256-backed repository using the http-backend handler for dumb
protocol clients, it may be necessary to access the raw packs using
their full SHA-256-specified names.  Allow packs and loose objects to be
accessed using their full SHA-256-specified 64-character hex names.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http-backend.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/http-backend.c b/http-backend.c
index 29e68e38b5..ec3144b444 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -711,8 +711,11 @@ static struct service_cmd {
 	{"GET", "/objects/info/http-alternates$", get_text_file},
 	{"GET", "/objects/info/packs$", get_info_packs},
 	{"GET", "/objects/[0-9a-f]{2}/[0-9a-f]{38}$", get_loose_object},
+	{"GET", "/objects/[0-9a-f]{2}/[0-9a-f]{62}$", get_loose_object},
 	{"GET", "/objects/pack/pack-[0-9a-f]{40}\\.pack$", get_pack_file},
+	{"GET", "/objects/pack/pack-[0-9a-f]{64}\\.pack$", get_pack_file},
 	{"GET", "/objects/pack/pack-[0-9a-f]{40}\\.idx$", get_idx_file},
+	{"GET", "/objects/pack/pack-[0-9a-f]{64}\\.idx$", get_idx_file},
 
 	{"POST", "/git-upload-pack$", service_rpc},
 	{"POST", "/git-receive-pack$", service_rpc}
