Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29688C35666
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E650E206ED
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="XudF2o6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgBVUSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:18:14 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39080 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726955AbgBVUSI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Feb 2020 15:18:08 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8327C6079A
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 20:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582402687;
        bh=9EEePANQ2c24SEBMWwUKldhh+6sYn65TqetuuT6CHk0=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=XudF2o6ZvzJ1V8/jZCdvFezCntIlQE4bSGkupHVX2e919YV1tykyaJPfm7Naa0wEE
         aMva4Y8VzjAm0pf+/ZRUPorgIEFR0m0Wh9l3zPtcHfb6ltlCrkEJjyvkSgJvUynn6+
         TEVP3OkQ3BNKWUKLV/nlDVjYsget3ex7Ky1CqHxa4tXHr9rgcVLYMelxC2al19GOph
         aYC4nKgKBR4oNT5pRTW/5R0cNzwZTVfmoAYMbvGVmA9TacIBu+I8ICRtfyvVGS8tTp
         EfPHWuyQ8N9mMWRZZass4gv/osCSN3W9LzzQkA1INgsCqGT182D+5Fzzc21sIqJ/qh
         BbVjKqphb3TAE3LnAfZsfIbtuKd1Kiq7DWloXYQSNs7G4pZa4SgeA8s8mO2kLS3Ieo
         YCUkXtH/Q2aBOzfFhPp8E3jV5kqujjdW1qcQrxD6DxAx5OqiFDyR+TKlGuocbwRzd2
         QLaFC3vyKc+sAEKOyM8lX59nOiS0mIqkxxCt0V3k63KbB5IjUIC
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v2 10/24] t/helper: initialize repository if necessary
Date:   Sat, 22 Feb 2020 20:17:35 +0000
Message-Id: <20200222201749.937983-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200222201749.937983-1-sandals@crustytoothpaste.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
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
