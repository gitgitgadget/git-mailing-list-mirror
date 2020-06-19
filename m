Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD971C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8768C21532
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="rgAsq1ZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394162AbgFSR5c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:57:32 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39458 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394009AbgFSR4l (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:41 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A242560A7E;
        Fri, 19 Jun 2020 17:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589395;
        bh=0kTnW+si/14E4LvMgtbMNpi0j1rIx5tw+Yjkj/LLNLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=rgAsq1ZYKLEcTp2nsBf8ziNC/hKH/VKkKd7k0sYFZW8HbN/9vUJoK0ihj47tBbliF
         kb7i+EdFMxQr58sVTg3/qyYahsdXZmJ6q0VCM4JSqS92J//B2UsYPlKk59tJehdq4H
         gqIgBoDETj92iR5B2gTF2ndXVlZXtpGEOwzH1Ku5FU/DrYNQ/Q87K8zGWyYBKkz/Pd
         NaYJXx5Fws2M8Yx7LdpkuWFxl81YQPsKjeeTr2xdvEQ2vh01bQ9dwFvKcjP/x1Ydga
         BO+eEgrPY/8fW58UJEj6lh+2HQ7TVI2dpB1R33AS8FQkvCx7CEz/teBzf7o4PM9o3/
         hpdFugpjpkbfsvAtKW/BTXcsdt8uZgUjOK6kePGYKa10Yihs5SkHxPMOKLSF8hwaq5
         nq1CeKfETFvJlKhvwBfDKTyUx4G8ol0D3rSQhIofAWyWq142vApbp2IRE6P1kHnDRR
         RNvBTqMhfu/rpSr/97tr1CNPxPXLbO6/dIsoxxX2rrsFw0UtSg/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 42/44] t5300: pass --object-format to git index-pack
Date:   Fri, 19 Jun 2020 17:55:59 +0000
Message-Id: <20200619175601.569856-43-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619175601.569856-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200619175601.569856-1-sandals@crustytoothpaste.net>
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
 
