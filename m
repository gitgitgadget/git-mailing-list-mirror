Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEEAC47076
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9270A20675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mewEXEbS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbgEMAzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:55:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38118 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731938AbgEMAy6 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:58 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CBA4360D1B;
        Wed, 13 May 2020 00:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331296;
        bh=0kTnW+si/14E4LvMgtbMNpi0j1rIx5tw+Yjkj/LLNLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=mewEXEbSORqDeyGJAZVPtt8y/0JSQXEUVE+eMlIdqzED5YdO55WPITbO/sEo0Is2M
         EfAB369+w5vhnhoD7YNZswf973OzCctSXi39BnbCz4ex9JYFzMiU86qTOYPMAz8vKL
         ip8cNXiCp3ypeHmMZmVVqaqJnRbfYBUuJZtPfzcGcqa1XZi6+2DqsBc32GQtwRO14j
         OoV/IwvEKkccv8LWO77C4SfTd9k99neSHUErwifnsMQkqQtUikAM+RU7cHUCIquZ10
         9hlNrFOz498vFGiGI1aigKEqvzhIJz0m1aOXORqSJ+/lb+7qfWlupec8nER6E0U7I/
         iZWs9wvK2tXSofUVsSFzhTiWRJjcHJuB7NSRVG8JmlnkX896nTM/L292RIT0p9OeWy
         nEz2yWoMgQc6yMsVYwZqWY1WpeRLJse4T7dnXvKTNSIRMxSV0pCFZZFEp8J5GUlZVy
         xiqCzksJUGdzPb42g7uDkrBJAESdEwljKL/ENVOghijYctUCQQ8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 42/44] t5300: pass --object-format to git index-pack
Date:   Wed, 13 May 2020 00:54:22 +0000
Message-Id: <20200513005424.81369-43-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git index-pack by default reads the repository to determine the object
format. However, when outside of a repository, it's necessary to specify
the hash algorithm in use so that the pack can be properly indexed. Add
an --object-format argument when invoking git index-pack outside of a
repository.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5300-pack-object.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 410a09b0dd..746cdb626e 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -12,7 +12,8 @@ TRASH=$(pwd)
 
 test_expect_success \
     'setup' \
-    'rm -f .git/index* &&
+    'test_oid_init &&
+     rm -f .git/index* &&
      perl -e "print \"a\" x 4096;" > a &&
      perl -e "print \"b\" x 4096;" > b &&
      perl -e "print \"c\" x 4096;" > c &&
@@ -412,18 +413,18 @@ test_expect_success 'set up pack for non-repo tests' '
 '
 
 test_expect_success 'index-pack --stdin complains of non-repo' '
-	nongit test_must_fail git index-pack --stdin <foo.pack &&
+	nongit test_must_fail git index-pack --object-format=$(test_oid algo) --stdin <foo.pack &&
 	test_path_is_missing non-repo/.git
 '
 
 test_expect_success 'index-pack <pack> works in non-repo' '
-	nongit git index-pack ../foo.pack &&
+	nongit git index-pack --object-format=$(test_oid algo) ../foo.pack &&
 	test_path_is_file foo.idx
 '
 
 test_expect_success 'index-pack --strict <pack> works in non-repo' '
 	rm -f foo.idx &&
-	nongit git index-pack --strict ../foo.pack &&
+	nongit git index-pack --strict --object-format=$(test_oid algo) ../foo.pack &&
 	test_path_is_file foo.idx
 '
 
