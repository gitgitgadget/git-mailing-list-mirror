Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054D2C433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC20A20767
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kzqw85t6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbgFVSEa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:04:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39994 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730234AbgFVSE1 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Jun 2020 14:04:27 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 40E7360A5E;
        Mon, 22 Jun 2020 18:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592849066;
        bh=PFwsn2BGLChsioOxqyEXOQRSkXGQIrT4VC6X5k/0YUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=kzqw85t6m6pdR89FFVSgXSovPPEeumov8H+A5coQLQhvCfJ+tOMk6qWkdSYJHFffv
         CuDp/ewImic86OM4pZk+1G9ismYq3NivjDlklQSNFzrD72Zub8rjsPvnKD4DPv7BWE
         t7IUcUyZKEBBslSW/NykQme07Hs4dBTLYKPOcCgWg8VGH6v8+sRMiuitC35yhOgqq7
         9K5Shrm4eO36mjjkQDrGh8wtTPJMUl8lURUYHyCPjf9+XshJ3N5edlVBEFc+qVhY6m
         +Z/EktUeQltIUvdTN3kpsGe2oKBYjLnrdTGGlOHhreSttBA5bJ0RciL5qYTMqpvR+M
         Ev1/5mp1oFmVq7jSEe/mEG9yla0cYo/8QoUCLXccNAf4E9DD95hGpnAKhekY8e+zZf
         R0SGsoeKyFdeuKwkhoA5S9MiA/TPr7ZXXb2W8oPm/IhoXNOXEyiHtqQczntBXMCjKC
         JfHE29QPRsvD+3W7jHCSRdkyYN+RbcqhvaNjKZupnjICektCv74
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>, Eric Wong <e@80x24.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/14] t9100: make test work with SHA-256
Date:   Mon, 22 Jun 2020 18:04:08 +0000
Message-Id: <20200622180418.2418483-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200622180418.2418483-1-sandals@crustytoothpaste.net>
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
 <20200622180418.2418483-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compute the relevant tree objects for SHA-256 and use those when
appropriate instead of using the SHA-1 ones.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t9100-git-svn-basic.sh | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 2c309a57d9..9f2d19ecc4 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -208,9 +208,10 @@ name='check imported tree checksums expected tree checksums'
 rm -f expected
 if test_have_prereq UTF8
 then
-	echo tree dc68b14b733e4ec85b04ab6f712340edc5dc936e > expected
+	echo tree dc68b14b733e4ec85b04ab6f712340edc5dc936e > expected.sha1
+	echo tree b95b55b29d771f5eb73aa9b9d52d02fe11a2538c2feb0829f754ce20a91d98eb > expected.sha256
 fi
-cat >> expected <<\EOF
+cat >> expected.sha1 <<\EOF
 tree c3322890dcf74901f32d216f05c5044f670ce632
 tree d3ccd5035feafd17b030c5732e7808cc49122853
 tree d03e1630363d4881e68929d532746b20b0986b83
@@ -220,8 +221,20 @@ tree 149d63cd5878155c846e8c55d7d8487de283f89e
 tree d667270a1f7b109f5eb3aaea21ede14b56bfdd6e
 tree 8f51f74cf0163afc9ad68a4b1537288c4558b5a4
 EOF
+cat >> expected.sha256 <<\EOF
+tree 8d12756699d0b5b110514240a0ff141f6cbf8891fd69ab05e5594196fb437c9f
+tree 8187168d33f7d4ccb8c1cc6e99532810aaccb47658f35d19b3803072d1128d7a
+tree 74e535d85da8ee25eb23d7b506790c5ab3ccdb1ba0826bd57625ed44ef361650
+tree 6fd7dd963e3cdca0cbd6368ed3cfcc8037cc154d2e7719d9d369a0952364fd95
+tree 1fd6cec6aa95102d69266e20419bb62ec2a06372d614b9850ef23ff204103bb4
+tree 6fd7dd963e3cdca0cbd6368ed3cfcc8037cc154d2e7719d9d369a0952364fd95
+tree deb2b7ac79cd8ce6f52af6a5a0a08691e94ba74a2ed55966bb27dbec551730eb
+tree 59e2e936761188476a7752034e8aa0a822b34050c8504b0dfd946407f4bc9215
+EOF
 
-test_expect_success POSIXPERM,SYMLINKS "$name" "test_cmp expected a"
+test_expect_success POSIXPERM,SYMLINKS "$name" '
+	test_cmp expected.$(test_oid algo) a
+'
 
 test_expect_success 'exit if remote refs are ambigious' '
         git config --add svn-remote.svn.fetch \
