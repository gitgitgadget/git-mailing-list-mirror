Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F7351F517
	for <e@80x24.org>; Mon,  4 Jun 2018 23:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeFDXw5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 19:52:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33220 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751290AbeFDXwt (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Jun 2018 19:52:49 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:54a4:7f2e:59a2:6beb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C235A60745;
        Mon,  4 Jun 2018 23:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528156368;
        bh=ksA4fUvFbmVY4UOf6mO6ztr0z5vc0KpE+r1/epZuKow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ITf9hsbvU+nxwAso+qNwHBW71K9W21VrPJDLgTMR7t46yz92Q8hlxYOPDJtLvw+Sj
         Xxv47vtoURTbjDSuZsQbAlPXawsAPKNcCiaMlsZ5j15jsof2CKkYwwKouefMFteQc2
         9P60CB6NqqMGzJPhpC7lqC0gPtzgRCXxweXYIKTE1f+GX8k4K1vuotTLVzOo/+5+PY
         gm9FVcG12oe3d7msltBKqy/UdCvYkRvgDQ+vD2kpxF/ETlEeWzryFCopONXfUHgM6S
         pouM42d9b8OWvLG/wMLaylMnRnwWUVHC5x4w9mASVQeHmgEWc1wTA9NjWI9vV2r9Oj
         bn9FfDpnumQoaU/pdRACUljlF/gTXBIWybWlEE4tUyjt2LZ8XYnEgGu8mY4Hg6DRu3
         I3jSdqFw6EyNbNifDr4/XgLre53gvm2A06RioAD45HKaTrjfZQuZYRdK6Epw86R1qI
         umF5YcIKx/ANOcNh6tFLmNt4qBm2D1sfNwCJYBqx0axfKFyUPtF
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 06/10] t1006: make hash size independent
Date:   Mon,  4 Jun 2018 23:52:25 +0000
Message-Id: <20180604235229.279814-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.1.1185.g55be947832
In-Reply-To: <20180604235229.279814-1-sandals@crustytoothpaste.net>
References: <20180604235229.279814-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compute the size of the tree and commit objects we're creating by
checking for the size of an object ID and computing the resulting sizes
accordingly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1006-cat-file.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 13dd510b2e..3b82051e2b 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -141,14 +141,14 @@ test_expect_success '--batch-check without %(rest) considers whole line' '
 '
 
 tree_sha1=$(git write-tree)
-tree_size=33
+tree_size=$(($(test_translate -f hash-info rawsz) + 13))
 tree_pretty_content="100644 blob $hello_sha1	hello"
 
 run_tests 'tree' $tree_sha1 $tree_size "" "$tree_pretty_content"
 
 commit_message="Initial commit"
 commit_sha1=$(echo_without_newline "$commit_message" | git commit-tree $tree_sha1)
-commit_size=177
+commit_size=$(($(test_translate -f hash-info hexsz) + 137))
 commit_content="tree $tree_sha1
 author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 0000000000 +0000
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 0000000000 +0000
