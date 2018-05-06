Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38E81200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeEFXT2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:19:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41242 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752007AbeEFXTE (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:19:04 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A11926076D;
        Sun,  6 May 2018 23:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525648743;
        bh=ErIE0H1kG2jznWXK3yQv/94VWxvzJ0dZX3YsSLqJaNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=O/bdnH59evN48UPQqtYzMiV6yvmohuai15KtDH2ciYhdkg/b7JumHRoljEkA60PoI
         UOcvI/FCrfNyBIuwPVlXKxXf3NdqZ9bFhOvOihlikKoR3LPhwNoCStEcvMSkmk/7Fp
         oFIbW7yy+Id5UWjupgiU0VjTYd3HvU6WPGklyWQRqdA7JSYoO+TcMrVL7FOA1ZWUGV
         p7FN71OPefgqfJ79k1XxgE2bb+iFT2mSihq/Uq1o3/dYjaEKtGfAkC6RroexvjbrB2
         lNEweJzhc5ef5Pj97F8DiM7+MLLM5nV9DFi8cxmfevPs2azUPb+lgWogMZJzy4Nx0w
         Ncj0rMVJ5IQFAnmvfyT7iU8WPW2unFsF8J5DNrzMrVJEfBo68Kz/IWlrcHdCzuTc8j
         z0uhcvDAko9BlN0soPK22EG08o6NqWPY0Z1VbLUZxFRtK7rr4Htu615u412oVT2Fpm
         8XKefQpYoi2rPW/NEST8QB+plR7O9g81lUut8sqk47GN10XvPNK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 26/28] t4045: abstract away SHA-1-specific constants
Date:   Sun,  6 May 2018 23:17:50 +0000
Message-Id: <20180506231752.975110-27-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506231752.975110-1-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for blobs instead of using
hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4045-diff-relative.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 6471a68701..36f8ed8a81 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -8,6 +8,7 @@ test_expect_success 'setup' '
 	echo content >file1 &&
 	mkdir subdir &&
 	echo other content >subdir/file2 &&
+	blob=$(git hash-object subdir/file2) &&
 	git add . &&
 	git commit -m one
 '
@@ -17,10 +18,11 @@ check_diff () {
 	shift
 	expect=$1
 	shift
+	short_blob=$(git rev-parse --short $blob)
 	cat >expected <<-EOF
 	diff --git a/$expect b/$expect
 	new file mode 100644
-	index 0000000..25c05ef
+	index 0000000..$short_blob
 	--- /dev/null
 	+++ b/$expect
 	@@ -0,0 +1 @@
@@ -68,7 +70,7 @@ check_raw () {
 	expect=$1
 	shift
 	cat >expected <<-EOF
-	:000000 100644 0000000000000000000000000000000000000000 25c05ef3639d2d270e7fe765a67668f098092bc5 A	$expect
+	:000000 100644 0000000000000000000000000000000000000000 $blob A	$expect
 	EOF
 	test_expect_success "--raw $*" "
 		git -C '$dir' diff --no-abbrev --raw $* HEAD^ >actual &&
