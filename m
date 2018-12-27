Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DA57211B9
	for <e@80x24.org>; Thu, 27 Dec 2018 02:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbeL0CRv (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Dec 2018 21:17:51 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58004 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727363AbeL0CRu (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Dec 2018 21:17:50 -0500
Received: from genre.crustytoothpaste.net (S0106ac1f6b61f856.vc.shawcable.net [50.64.113.123])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9925A60FE0;
        Thu, 27 Dec 2018 02:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1545877067;
        bh=1icl5mNLwP9w1XA/yAgji3mPG83xphEdPhI/fzESOcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=o3fBd5xJRHywXV47ht4soa2gu/D1q2iBL12uCytFV0hiHUf+p/dxVwXQTnIzLFi42
         VrEGACf5yw5PHD6ZUVNQgin+NllLTXodc+GSNtU1SO4ltTTt4a3E3szqPIdA1k7YSP
         lN3dJwtIr2VzWvRMyA5Nj+cqjpMMXTJy8rRvHmtPUGxKNyfdQ9fHeDWpwBRGHlbX9F
         bKZ1vhjf3LI0J2SIm7fzJ5LSy4OMgJQmtzL4pSc9SUbodTv0EliSXXz+Dbf2fvmko1
         Izsc8RxdOVC0rJAEhhVWMnYAQLmcuPdi82DdxJO8ROBCpeX8uUTzYHihR8QZRV5nCs
         EqUqt1Y2GMRxdAdz+UmUaMo7Uvdyry6eUoG6Oq0gMQ7TMnVWVvBmn4q3ESQdIs8+Fs
         mEOtwzDSSHNLAxuuHIa/+nmXqIuBqd4c3JVClnHXH04wQGZEiJyQsKOEBP4dQPvXQr
         vhIan+4HWUPYClyz4eDNFsMssft1Q2Dn639Q2iJVH2sgJxH/KHa
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 2/2] utf8: add comment explaining why BOMs are rejected
Date:   Thu, 27 Dec 2018 02:17:34 +0000
Message-Id: <20181227021734.528629-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.415.g653613c723
In-Reply-To: <20181227021734.528629-1-sandals@crustytoothpaste.net>
References: <20181227021734.528629-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A source of confusion for many Git users is why UTF-16LE and UTF-16BE do
not allow a BOM, instead treating it as a ZWNBSP, according to the
Unicode FAQ[0]. Explain in a comment why we cannot allow that to occur
due to our use of UTF-8 internally.

[0] https://unicode.org/faq/utf_bom.html#bom9

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 utf8.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/utf8.c b/utf8.c
index eb78587504..22af2c485a 100644
--- a/utf8.c
+++ b/utf8.c
@@ -571,6 +571,13 @@ static const char utf16_le_bom[] = {'\xFF', '\xFE'};
 static const char utf32_be_bom[] = {'\0', '\0', '\xFE', '\xFF'};
 static const char utf32_le_bom[] = {'\xFF', '\xFE', '\0', '\0'};
 
+/*
+ * We check here for a forbidden BOM. When using UTF-16BE or UTF-16LE, a BOM is
+ * not allowed by RFC 2781, and any U+FEFF would be treated as a ZWNBSP, not a
+ * BOM. However, because we encode into UTF-8 internally, we cannot allow that
+ * character to occur as a ZWNBSP, since when encoded into UTF-8 it would be
+ * interpreted as a BOM.
+ */
 int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 {
 	return (
