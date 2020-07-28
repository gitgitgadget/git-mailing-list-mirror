Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B5AC433E0
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 592DC2083B
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lQFKu+yR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgG1Xf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:35:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40958 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730305AbgG1Xf0 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jul 2020 19:35:26 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6BF88607E8;
        Tue, 28 Jul 2020 23:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595979295;
        bh=Ni60BVyy3697LdUPCNff0L0kAJ2/erkulVYjnf5hQSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=lQFKu+yRofRzWcSY3guSjYDRPKYIc+4OzmqKTdZREa0iESkHEhKrMLhxQ2zp9Om/O
         oUD5zIy4tPdDSrpcpggZhvfFKcNtKIjygXH+LCv9gQLrpcmAI7+h4yBtl+cSKyPvgd
         r+iYL1w36FGhZU+6QjALJKjnnPFSa+h5opIJubKWTrMmDCUXpPQ78ZarkciDo+ijpM
         ZQhUAKBt0QuAm6hERcTdvpayvDy3RpEKvF4BhbAoeNjsAxDKL92HzBEu01GtSo7lyv
         Zs7uIX/eYw+7tbtYT0bgtAI/Jhftw6FQdQPkLqV6u1A7EIW0yaS2Wd9Ky7hIVM9yz0
         2dOmxSXBmtsbDO9Gx0qi+6d842xHak9UCG7vL2gaXPlrbYlrG3/M90oJFYRQ1wPuPe
         NUQKhi23AFavIANAon93o9R4QX5gImSdkoRWneK+xyJOrIoazm4I5HjaNukTLZ3G3q
         V4wYkR2JKLiPZa6Sl0jngmnq/SFunuTFtgEuoE6XYJnYvss1/Q/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 01/39] t: make test-bloom initialize repository
Date:   Tue, 28 Jul 2020 23:34:08 +0000
Message-Id: <20200728233446.3066485-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
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
 
