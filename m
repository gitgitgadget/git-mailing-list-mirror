Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B15A1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbfBSAGD (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:06:03 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34744 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732224AbfBSAGB (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:06:01 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 56A6760995;
        Tue, 19 Feb 2019 00:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534758;
        bh=+5fh+FR9PRQDRolK2uH6wkevzO/rfiLlvMVrulPvglI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=zXEBTLNlsOsQxYz48++xZao+joTeD4kH1IEPGeJYhPqb3R+fp/8rkA4mpeg+FwaFF
         k+/T7YkiANExJPSDrWeB16MVSPmPTOxYQoe74PRe5Ousvy2drEMvdRJSuaDMzqedgo
         VQJOeaokaPxpaaRfFFFazQml6iyLkHDabAbmOiDWD+AKQwJSHx1/Jw5xqpnSza48eQ
         6yr9JuVLGkG9xdKPxEfh+ECk3GwewjTZxZzT5EdI0pa0xQ08tuAllmYolHCi8QcKO0
         1h4R/PUBd1GVsZYvUAqzr8VB+9gRWlRgGAoT8Bl6JBMguVx/lsKzGO88sgu+9Xq4HM
         oKgR38/cR6z7YZOmvFaVIBMlIkMx1p32Z1+Ci4J8pXM5W4yy0aeniQ4Lpr/ix4uwOn
         iwE3+2iDb7nj9MpdWLi5ZPkhUOzabsqT+KZDWkFEYGgNW41cWX8kWbwP/RUJOgMNDZ
         8EDJwMtJrxaXlKh1Quzk7A+DxmBlcaTl+x6QZDFmirnLSnED4hN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 19/35] http-backend: allow 64-character hex names
Date:   Tue, 19 Feb 2019 00:05:10 +0000
Message-Id: <20190219000526.476553-20-sandals@crustytoothpaste.net>
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
