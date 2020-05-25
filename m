Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D73EC433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76F642075F
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lWgfWh40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390657AbgEYUAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38858 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390626AbgEYUAc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 16:00:32 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0A23C60D20;
        Mon, 25 May 2020 20:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436801;
        bh=0kTnW+si/14E4LvMgtbMNpi0j1rIx5tw+Yjkj/LLNLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=lWgfWh4052vO2yv4L+bARyg0AUBiVcFw8ErpK1eCqoZNtlhoxVjis88zH6S1FfvV3
         pTUIY0nkvZBvlh/GGFZMVWN+LD0loS2kzexdd6oaQkpZjjlfMsUd07Xd2rj+Cy34Ap
         5+d2FLX4igg4R8ZI4P8SnSk0n9w50hq49zaG+YTIVFWbEf4jjoPx+TXw/uQuNcupwV
         4JD70eskY30dZd7RHB8l7R7k1RmDQAAuCxe/NxOUXkTp9u9DVtBXAkbO0p+Sjfj6sz
         y5h8plJp9sl1QWYZwCDsEwwAV8IQroD9r+R/MzNj9+RWqNF7A+679hHeLYs2quGWRh
         hvR4h7wMuvatktm5Mmeci5MFDj9Ur+ZiKPL/kjP6ky0miJsJcujD1MMBY2kmsZ0myo
         ZUOv8rypoO3H9NN3BrJBsfLqf9+p8liiHbIYp18QGVX+bCphOZ+d/uViA2ntiCdUJ0
         1Mmtcg11LBrcD71gueI1yumw1+gjoKlibXkOrTCyjUTREU8bngH
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 42/44] t5300: pass --object-format to git index-pack
Date:   Mon, 25 May 2020 19:59:28 +0000
Message-Id: <20200525195930.309665-43-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200525195930.309665-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200525195930.309665-1-sandals@crustytoothpaste.net>
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
 
