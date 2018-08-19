Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C72B1F954
	for <e@80x24.org>; Sun, 19 Aug 2018 17:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeHSVGv (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 17:06:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55068 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726661AbeHSVGv (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Aug 2018 17:06:51 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F24A96081B;
        Sun, 19 Aug 2018 17:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1534701273;
        bh=jO60aYmHp5n0drJMhqX1iownzRcB0Or/NjyXfml8wO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=G3GSRA9wXJ2kYTrb0F7jZlMmXlXRjl1GqdyxZ+q+ubLRC8LLB8V1UvjvS3AQXZ3zk
         Lv5T9BOZ7pFgL/4PD02B9sC0r3a16h9WlVJOmTjQvtt50fxZlhDRu0V/3IFQLxGjdT
         jnIBSZGXerI1RiqngkKlTm9+l0lvZqmB8pg/Sq3Dz1mXBcfCLMrDvAQZSmny4K4Z0+
         as9buIfy499Sm0Me77Ddlli9gGdVbRd5qTI9sIfrASUI7paYVx56J0C/Lbq5I7A3L9
         SG7cEL8FL2YmZBbrYugpSXbMhKWYQnXGBA1ZX9tAq3juGuH0QQnxLnihS8GxNWN33d
         KNfTtNNX59IAEHe+4/D/OFR3yvYncdV1GxO2ekU2Vuqwzf7wyiWapJAVlYOEIMQ/qe
         GCzKjlLgBlXHa/ndwFQm7EAsG5J0PNn7nq754qfT0pFFsMo74yQPBIEzN6ml3wvsbD
         Q1hVSV5tIJYv/n9GxSMDJSmE+bcDzEqWbYzn0HQ5KxFsG77Zgy/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 07/11] t1006: make hash size independent
Date:   Sun, 19 Aug 2018 17:53:47 +0000
Message-Id: <20180819175351.449973-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.1017.ga543ac7ca45
In-Reply-To: <20180819175351.449973-1-sandals@crustytoothpaste.net>
References: <20180819175351.449973-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 t/t1006-cat-file.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 13dd510b2e..345ed70e53 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -140,15 +140,17 @@ test_expect_success '--batch-check without %(rest) considers whole line' '
 	test_cmp expect actual
 '
 
+test_oid_cache hash-info
+
 tree_sha1=$(git write-tree)
-tree_size=33
+tree_size=$(($(test_oid rawsz) + 13))
 tree_pretty_content="100644 blob $hello_sha1	hello"
 
 run_tests 'tree' $tree_sha1 $tree_size "" "$tree_pretty_content"
 
 commit_message="Initial commit"
 commit_sha1=$(echo_without_newline "$commit_message" | git commit-tree $tree_sha1)
-commit_size=177
+commit_size=$(($(test_oid hexsz) + 137))
 commit_content="tree $tree_sha1
 author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 0000000000 +0000
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 0000000000 +0000
