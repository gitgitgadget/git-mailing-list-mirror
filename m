Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0D9C33CAE
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610012081E
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="DzxM5KiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgAMMsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:48:23 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37778 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbgAMMsB (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:48:01 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C6F0760735
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 12:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919681;
        bh=9EEePANQ2c24SEBMWwUKldhh+6sYn65TqetuuT6CHk0=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=DzxM5KiYNFIV/2xmjp7Dx/QDjxbo04HJMMnuv/tm2IEh+ByLwhiBL3rVMuQuBigPd
         CzaOzxMb6Ge1UC0ZRnE4OEznSz2eSPhQDdJGOZLSsSYTR23u9DcmgPwM+vPbXkJnMh
         ADy8UlsCDZdhoEV4UGTU45BdyYDs01LNRsVJ6vK9zmsgARL+L/jTSNdXQDas08wwoh
         cQ8mr6ZWf2aUncmsrbD885vaeinL8NN27fiMViD31SGMkADTuRRZv1XALfsn+vHMQS
         Z7yvBoVv21JFkhcK0d0XYjOwl4Axn3Fz6DrEi0NTXJIc94cIdzzh1FGB1erxJ9juGY
         q+ZpOYzHv3KgTx6z7Uu80ReDMKMoBkn9tLMigfI2WFtf3QHXx6An0Eaik5oqNOCuyi
         6SApKVbuuV0CURhUhXAVf7LWiLbR+uCniNYUp31WFuGwIXNsBZEkDMLcU2zkoCV3Mz
         +2IyYy9fXNgFvnC90TwWzx0/nadRZhVevmSZH5MFlmjAlCmND8Z
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [RFC PATCH 08/22] t/helper: initialize repository if necessary
Date:   Mon, 13 Jan 2020 12:47:15 +0000
Message-Id: <20200113124729.3684846-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
References: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The repository helper is used in t5318 to read commit graphs whether
we're in a repository or not. However, without a repository, we have no
way to properly initialize the hash algorithm, meaning that the file is
misread.

Fix this by calling setup_git_directory_gently, which will read the
environment variable the testsuite sets to ensure that the correct hash
algorithm is set.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/helper/test-repository.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index f7f8618445..ecc768e4cb 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -75,6 +75,10 @@ static void test_get_commit_tree_in_graph(const char *gitdir,
 
 int cmd__repository(int argc, const char **argv)
 {
+	int nongit_ok = 0;
+
+	setup_git_directory_gently(&nongit_ok);
+
 	if (argc < 2)
 		die("must have at least 2 arguments");
 	if (!strcmp(argv[1], "parse_commit_in_graph")) {
