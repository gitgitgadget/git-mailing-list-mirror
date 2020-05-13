Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B26C2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E7420753
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="SgTdrtwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbgEMAzb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:55:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38272 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732057AbgEMAzZ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:55:25 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8FB2160D06;
        Wed, 13 May 2020 00:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331293;
        bh=QhWwx5JrFjkmi9fYf3BLeqi+AU9uqTKM8zuKL+dV4ZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=SgTdrtwFErQZF+7LDlnQeltYPjk9usGWQhIE3g1qnipmlUpooqy/WY1/5hOHe0WJ8
         hGsw1YLGeax1JhcHqqVaOV0qZhRTwE5drOn/j9tmRa7ufmaaM/6yK7Cwy2r3jzeRNX
         lBEMyI+v+tXkUT+IVJMxrNJTWAaQp5RcbmI1bKfzdUMXUvbHLd5V/s7DWhlNBeQwAO
         +ETNZnRCSWPhYep4V37mE4Rfzik1+LILGFVAgG5c07Z5KHaSIX9uNhv+B2MmceEJvR
         TbayKhJo79gMndxm8rgQm7sc5ehJYAYnf56qwtf8zK+oW3wTjn6Tlkfq+hOuqfnQ1Y
         IGRIOd7IPAhlFFSUNhWny8gdHvZT0eEbScsvnEIcoRiMUE8ChOgKfrl3Ikideq/H0i
         MNruH9hpOiR0RM2ACguWsqEP6ypAD9JPODDrBMc3TDaYQAfYaInsA2ygjzm6KjY1yf
         oOHmZv8vQOI5AwFd28UeflKCLpxX3kmJTEanYrigLuz0JVcUXFs
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 37/44] t1050: pass algorithm to index-pack when outside repo
Date:   Wed, 13 May 2020 00:54:17 +0000
Message-Id: <20200513005424.81369-38-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When outside a repository, git index-pack is unable to guess the hash
algorithm in use for a pack, since packs don't contain any information
on the algorithm in use. Pass an option to index-pack to help it out in
this test.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1050-large.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 7f88ea07c2..6a56d1ca24 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -12,6 +12,7 @@ file_size () {
 }
 
 test_expect_success setup '
+	test_oid_init &&
 	# clone does not allow us to pass core.bigfilethreshold to
 	# new repos, so set core.bigfilethreshold globally
 	git config --global core.bigfilethreshold 200k &&
@@ -177,7 +178,8 @@ test_expect_success 'git-show a large file' '
 
 test_expect_success 'index-pack' '
 	git clone file://"$(pwd)"/.git foo &&
-	GIT_DIR=non-existent git index-pack --strict --verify foo/.git/objects/pack/*.pack
+	GIT_DIR=non-existent git index-pack --object-format=$(test_oid algo) \
+		--strict --verify foo/.git/objects/pack/*.pack
 '
 
 test_expect_success 'repack' '
