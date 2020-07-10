Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8343CC433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FA7020663
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MhhA3zlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgGJCtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:49:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40368 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbgGJCsn (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:43 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8135960A64;
        Fri, 10 Jul 2020 02:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349314;
        bh=e0GG4MGDDPBIn8sVOpdBt+JTBrciFKCG4qAUcFp9kSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=MhhA3zlJMht1QyYigDAmnpZOXQrx4f1XfC0jotJoSNZ1ry1+BL28MNaQJM/8ve+L7
         z96IGcohnx/f7i3VWFFLlbzDw63rXlahaRFLzXBDqpZ8ldBLK/AhiWu0bv5ECHkPup
         dhzZNttvcYla6b+nrS/lnBglphR7nEXaxuLnvEo7Gyz8Z0SwZzuXNGMvLsa0p3LfgH
         VP9vID3fWsvr0f9U4bNmeZW8fsgNrIRCGyxME/kQgKJfOPkjLhzU3ers4ZO6Jyjmni
         otlYNm4DdQXHUoib1zDHUcAjJ7lHS9tTVMEWkNusH5re8ywM5w1+KuT1sof5eiKWIt
         SN9Ywcui6zZWwA6DwK/BgQNX05X1R0rXTaPKKEEmbDWLRFgq79qjfKY591P/KuXEee
         ZdLFLXDTytF7k6r1b/hj5KD0w+xZuhyvACBSsqi5nwvVRwA9lQLzORCTXRPJh1Qiju
         w8EK8IRyZODhoBArBAz+3O9dU5RFlJy99zKQHxm1NCZmx4U7mrU
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 25/38] t9500: ensure that algorithm info is preserved in config
Date:   Fri, 10 Jul 2020 02:47:15 +0000
Message-Id: <20200710024728.3100527-26-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we use a hash algorithm other than SHA-1, it's important to
preserve the hash-related values in the config file, but this test
overwrites the config file with a new one. Ensure we copy these values
properly from the old config to the new one so that the repository can
be read if it's using SHA-256.

Note that if there is no extensions.objectFormat value set, git config
will return unsuccessfully if we try to read it; since this is not an
error for us, use test_might_fail.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t9500-gitweb-standalone-no-errors.sh | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 267ddc997d..b484e3e250 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -621,12 +621,22 @@ test_expect_success \
 	 git config gitweb.snapshot "zip,tgz, tbz2" &&
 	 gitweb_run "p=.git;a=tree"'
 
-cat >.git/config <<\EOF
-# testing noval and alternate separator
-[gitweb]
-	blame
-	snapshot = zip tgz
-EOF
+test_expect_success 'setup' '
+	version=$(git config core.repositoryformatversion) &&
+	algo=$(test_might_fail git config extensions.objectformat) &&
+	cat >.git/config <<-\EOF &&
+	# testing noval and alternate separator
+	[gitweb]
+		blame
+		snapshot = zip tgz
+	EOF
+	git config core.repositoryformatversion "$version" &&
+	if test -n "$algo"
+	then
+		git config extensions.objectformat "$algo"
+	fi
+'
+
 test_expect_success \
 	'config override: tree view, features enabled in repo config (2)' \
 	'gitweb_run "p=.git;a=tree"'
