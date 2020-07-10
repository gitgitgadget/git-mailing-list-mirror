Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714ABC433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D0120663
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="O+2HCoFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgGJCsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:48:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40358 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbgGJCsZ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:25 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EE8CF607F6;
        Fri, 10 Jul 2020 02:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349304;
        bh=Ni60BVyy3697LdUPCNff0L0kAJ2/erkulVYjnf5hQSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=O+2HCoFIFIZ80WWtmRPwWzC0wt+8/h1QHBHjypWVUGPe7liSYjqxnGx7wWTxIJQzy
         RQj/2+gaj/wAv4C3T6Sn/SP597SPOjwvKgIiY/4kj/xFMsi3f39YabhOsxdxgDF0aB
         AOnzFjCi7ITAWlLctwz2gE7dfSlY5ocXDfNBEtkbkJajN5R22eWZOBIcuDI1QJYMfp
         2tM4LFPZW2usfCyyshEfP7BttR53zmthcNmpX7lUogKAY3yRXme0IveChvdwBMHhrk
         hxTa1NBVbkIemp3afplx8QUrpBB+wFiroktGpXaVRbUnU7QDGzrXnRbL/twi1zNTHI
         8Wzq3dk58mIbA3Yt1Hkokjd4iPrHXrgVHqPxq/7479EljsGrJHARQYvYObWBs1zXVE
         /6y5rBsje5Tu9f9OCvBhthbkBmy6E/XDlVS0BhgIFwb3ZpVkYWaZZ22yqdKKxT8wse
         vvuy+U/EFFl8qBdijFX+M5X+n0Jsm8cn5EFmMaX8BONvr8P/++g
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 01/38] t: make test-bloom initialize repository
Date:   Fri, 10 Jul 2020 02:46:51 +0000
Message-Id: <20200710024728.3100527-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
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
 
