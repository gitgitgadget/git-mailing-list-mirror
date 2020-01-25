Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDACC35242
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41DE2071E
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FtcYB6mx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgAYXBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:01:14 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46810 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727680AbgAYXAq (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 18:00:46 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9E52760FC7;
        Sat, 25 Jan 2020 23:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579993245;
        bh=fMUxjGVjhUrESSW40/sCXR/0wiwqI71DHozpjAit15o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=FtcYB6mxZsbYtSE+UdL0/znb+3nmnrPjgfmzVJNHnh0zqOBdSQCaZ0Odh3+mSUC8v
         8ZemChke/91zoDA/DgrPRoPORR9NUxpUj2S8djBO6P9ldMhm9H60J5J6MiU9hIQI52
         6yRFaebpZL7sQge6yA84wSVK5Ml8D5g+KGE2yImb5fb7RdUYtOXdp7IIvVh7SysBhB
         +MdsakY4ew7JDBNeVgBb0L0ngYavFsFTaxSTagt9481zaiRU3rN+riVdg6wk3n+v8G
         oVoxWjQQY50gwQHFW6zzoUTzXmBClnW0N5i5JjIHZmfudL92QjUdY6TKziguT2fNNx
         Feyt9lCnIFD70s80YhpIXh9AXmdfBBy4jf9JXXn7KYxDQfPAeT4SM3LP0ck5sAwBXT
         VpVmxIrHYLAm61Pr5VozCLjxXstqQnJ5rBnwaOl/GdKVjpSVyrOLy032RroQUuZjGJ
         gaaLk71g8Xl00JsluHqn69ecdDTN0Lc3OYgB6HJW5h2jGWFot7x
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 11/22] t5302: make hash size independent
Date:   Sat, 25 Jan 2020 23:00:17 +0000
Message-Id: <20200125230035.136348-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.24.g3f081b084b0
In-Reply-To: <20200125230035.136348-1-sandals@crustytoothpaste.net>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compute the length of object IDs and pack offsets instead of hard-coding
constants.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5302-pack-index.sh | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 91d51b35f9..93ac003639 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -8,7 +8,8 @@ test_description='pack index with 64-bit offsets and object CRC'
 
 test_expect_success \
     'setup' \
-    'rm -rf .git &&
+    'test_oid_init &&
+     rm -rf .git &&
      git init &&
      git config pack.threads 1 &&
      i=1 &&
@@ -32,7 +33,9 @@ test_expect_success \
 	 echo $tree &&
 	 git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
      } >obj-list &&
-     git update-ref HEAD $commit'
+     git update-ref HEAD $commit &&
+     rawsz=$(test_oid rawsz)
+'
 
 test_expect_success \
     'pack-objects with index version 1' \
@@ -152,6 +155,7 @@ test_expect_success \
     '[index v1] 2) create a stealth corruption in a delta base reference' \
     '# This test assumes file_101 is a delta smaller than 16 bytes.
      # It should be against file_100 but we substitute its base for file_099
+     offset=$((rawsz + 4)) &&
      sha1_101=$(git hash-object file_101) &&
      sha1_099=$(git hash-object file_099) &&
      offs_101=$(index_obj_offset 1.idx $sha1_101) &&
@@ -159,8 +163,8 @@ test_expect_success \
      chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
      dd of=".git/objects/pack/pack-${pack1}.pack" seek=$(($offs_101 + 1)) \
         if=".git/objects/pack/pack-${pack1}.idx" \
-        skip=$((4 + 256 * 4 + $nr_099 * 24)) \
-        bs=1 count=20 conv=notrunc &&
+        skip=$((4 + 256 * 4 + $nr_099 * offset)) \
+        bs=1 count=$rawsz conv=notrunc &&
      git cat-file blob $sha1_101 > file_101_foo1'
 
 test_expect_success \
@@ -200,8 +204,8 @@ test_expect_success \
      chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
      dd of=".git/objects/pack/pack-${pack1}.pack" seek=$(($offs_101 + 1)) \
         if=".git/objects/pack/pack-${pack1}.idx" \
-        skip=$((8 + 256 * 4 + $nr_099 * 20)) \
-        bs=1 count=20 conv=notrunc &&
+        skip=$((8 + 256 * 4 + $nr_099 * rawsz)) \
+        bs=1 count=$rawsz conv=notrunc &&
      git cat-file blob $sha1_101 > file_101_foo2'
 
 test_expect_success \
@@ -226,7 +230,7 @@ test_expect_success \
      nr=$(index_obj_nr ".git/objects/pack/pack-${pack1}.idx" $obj) &&
      chmod +w ".git/objects/pack/pack-${pack1}.idx" &&
      printf xxxx | dd of=".git/objects/pack/pack-${pack1}.idx" conv=notrunc \
-        bs=1 count=4 seek=$((8 + 256 * 4 + $(wc -l <obj-list) * 20 + $nr * 4)) &&
+        bs=1 count=4 seek=$((8 + 256 * 4 + $(wc -l <obj-list) * rawsz + $nr * 4)) &&
      ( while read obj
        do git cat-file -p $obj >/dev/null || exit 1
        done <obj-list ) &&
