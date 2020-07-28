Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5A4C43458
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F90C2075D
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0O9QMtrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbgG1XfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:35:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40852 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbgG1XfJ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jul 2020 19:35:09 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5349C61016;
        Tue, 28 Jul 2020 23:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595979306;
        bh=e0GG4MGDDPBIn8sVOpdBt+JTBrciFKCG4qAUcFp9kSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=0O9QMtrZqmllujhw6IE/ev6iBnIlzBAnkCl1c4fIIWN8wzVxzZC84QFeEHZr054xd
         Sd1oZkmlMIS355OUWol0Q9cltwkYJVjOZo7T7p50UHAOh3pM73XRvTLn4yFz/8Befc
         IYQsn3d+01hYL2XfMcB5Om32h/FwswhRoo8AWuD/FZNYekvdUTo4gODZqjlrRgKYXu
         eFuNjBpZeLc40jzQrKuq6pS/lYpaeRVQy6W6pCTuyThDRibjonTuV2MicW8rz3xL1v
         99ZmO72Nj9bE3A+1hdmgFpaPhJBa+bQ8514nLsL/VgjeQ6lx5/pqHphSP3NFCo0a6R
         bQ5a0gtItx79cytK3/1i4bHLVpSpgi5lJdMyyuFXhSmXepPktddK6bwkii9hcXtOCq
         pBMO6PU7964PMLNz3HIfMbvEN7PSiv9qrdUHbAv5dde3p9uakS+UGnQxeL/Jh4M9eh
         WpH3t9nAZlergRn5iuNwIUNgdvORmKFi1TJSreBJsTbjBA1U2su
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 25/39] t9500: ensure that algorithm info is preserved in config
Date:   Tue, 28 Jul 2020 23:34:32 +0000
Message-Id: <20200728233446.3066485-26-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
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
