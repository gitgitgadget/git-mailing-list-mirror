Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B31FC433E1
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 128EC206D9
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="niSJkiBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgGMCtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:49:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40586 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgGMCtX (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 22:49:23 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D0A21607F6;
        Mon, 13 Jul 2020 02:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594608563;
        bh=Ni60BVyy3697LdUPCNff0L0kAJ2/erkulVYjnf5hQSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=niSJkiBc17s03ooH6EEv0WAvn5C8aC2cGlY61dzIWxtAT/QfmNpufUC3HB06vARMy
         92hi4Hmh97LV5ki7Y1epdbAWUfUdjOMWOnLdYMUzzuUBH2C6fto3KYKizlLFp3Jo9+
         nIGNl5i7AmyrlhA9nGVB2wB8CKSnI7aK64xk9bq6bUM2ZaMglXEdPddA5gCGs7PJ8l
         mpcvvR4fIBG3bYM1sVFxWmep0TMV49b9GAU4gJ/zTDl7/ZJQUuPPeQbNobCC9bstoh
         v47PtGXug+FrUL49cxvGpZ83wJoRT4BCZeNlIBo8xXMIs5paBIuk9UorHPbRf6YNiZ
         LYD1iHVRURSVPYCmCQqWDRL8Yz5QIK7bjj62FF9Y+Z25zuRsoulf5gg0Y++k1ipnet
         ZcwQmvV43I+XJubZ9oso5n9koCy1o+g6nGpZba3anf81WFDmSwEKyTQFyBW9guquPk
         FPX9RnqC+rYGseg2srXk1Ei/1qzorNsrYbUtCyyviDIzAEB8Ia/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 01/39] t: make test-bloom initialize repository
Date:   Mon, 13 Jul 2020 02:48:31 +0000
Message-Id: <20200713024909.3714837-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The bloom filter code relies on reading object IDs using parse_oid_hex.
In order to make that work with an appropriate size, we need to have
initialized the repository's hash algorithm.  Since the values we're
processing depend on the repository in use, let's set up the repository
when we run the test helper.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/helper/test-bloom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index f0aa80b98e..5e77d56f59 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -50,6 +50,8 @@ static const char *bloom_usage = "\n"
 
 int cmd__bloom(int argc, const char **argv)
 {
+	setup_git_directory();
+
 	if (argc < 2)
 		usage(bloom_usage);
 
