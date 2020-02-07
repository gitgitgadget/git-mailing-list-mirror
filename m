Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AC1C35247
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B63320838
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lgMWimxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgBGAxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:53:43 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55540 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727131AbgBGAxi (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 19:53:38 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5B4DB60456;
        Fri,  7 Feb 2020 00:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581036817;
        bh=tRshZRJCp72zAKYAtifXJs+fKxXtT5TiRv1rzzPBoXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=lgMWimxoQv/wfGAW4YuCsO/oHMy3//TTOAbbz9THjDK3jE6qj68z0rXT5+OHS+2qi
         zezetA9tIQCAq5UKcSGeyfSz4nv74YQn6bBcftrh7J6sVbGqDerbw/KIMIcPm0o1FK
         ram2248mJ8qim7apE2Qt4xfEqQ0Jq+uXisskZZcNThEznZm9zkh0qTmEHbYNIv3WZQ
         vKo9VudZtaDOg5wkZ4dc0IZXN0wnGv5/DWsnmbOLHcHX5MnB3vHmq627t6Ig77PyOx
         FroMDObAIY0MwC/a7JExCl+X1Svf3AJ7ij3u1dooK+hfH+itN12MkO97JafdqsltNU
         QtI+SQP+m/aQGWdjhBaLn1Kf7rF0JqzMxpyLOCIfz7PbwIVhWinl+uLaJjt5OWOsw7
         Ai5W7OT7GG1PmekPCQsFvtxfXsKE83Nt7GWBsCXdDOCs5xxAqmlZiCzG7T5ZQ3Sjva
         mKySUxacjfJ9Q/5QdpBE8t61m7b06bdnjxUKndi1Dhhtn8TTVqu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 11/21] t5302: make hash size independent
Date:   Fri,  7 Feb 2020 00:52:44 +0000
Message-Id: <20200207005254.1495851-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7
In-Reply-To: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
References: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
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
 t/t5302-pack-index.sh | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 91d51b35f9..ad07f2f7fc 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -6,9 +6,10 @@
 test_description='pack index with 64-bit offsets and object CRC'
 . ./test-lib.sh
 
-test_expect_success \
-    'setup' \
-    'rm -rf .git &&
+test_expect_success 'setup' '
+     test_oid_init &&
+     rawsz=$(test_oid rawsz) &&
+     rm -rf .git &&
      git init &&
      git config pack.threads 1 &&
      i=1 &&
@@ -32,7 +33,8 @@ test_expect_success \
 	 echo $tree &&
 	 git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
      } >obj-list &&
-     git update-ref HEAD $commit'
+     git update-ref HEAD $commit
+'
 
 test_expect_success \
     'pack-objects with index version 1' \
@@ -157,10 +159,11 @@ test_expect_success \
      offs_101=$(index_obj_offset 1.idx $sha1_101) &&
      nr_099=$(index_obj_nr 1.idx $sha1_099) &&
      chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
+     recordsz=$((rawsz + 4)) &&
      dd of=".git/objects/pack/pack-${pack1}.pack" seek=$(($offs_101 + 1)) \
         if=".git/objects/pack/pack-${pack1}.idx" \
-        skip=$((4 + 256 * 4 + $nr_099 * 24)) \
-        bs=1 count=20 conv=notrunc &&
+        skip=$((4 + 256 * 4 + $nr_099 * recordsz)) \
+        bs=1 count=$rawsz conv=notrunc &&
      git cat-file blob $sha1_101 > file_101_foo1'
 
 test_expect_success \
@@ -200,8 +203,8 @@ test_expect_success \
      chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
      dd of=".git/objects/pack/pack-${pack1}.pack" seek=$(($offs_101 + 1)) \
         if=".git/objects/pack/pack-${pack1}.idx" \
-        skip=$((8 + 256 * 4 + $nr_099 * 20)) \
-        bs=1 count=20 conv=notrunc &&
+        skip=$((8 + 256 * 4 + $nr_099 * rawsz)) \
+        bs=1 count=$rawsz conv=notrunc &&
      git cat-file blob $sha1_101 > file_101_foo2'
 
 test_expect_success \
@@ -226,7 +229,7 @@ test_expect_success \
      nr=$(index_obj_nr ".git/objects/pack/pack-${pack1}.idx" $obj) &&
      chmod +w ".git/objects/pack/pack-${pack1}.idx" &&
      printf xxxx | dd of=".git/objects/pack/pack-${pack1}.idx" conv=notrunc \
-        bs=1 count=4 seek=$((8 + 256 * 4 + $(wc -l <obj-list) * 20 + $nr * 4)) &&
+        bs=1 count=4 seek=$((8 + 256 * 4 + $(wc -l <obj-list) * rawsz + $nr * 4)) &&
      ( while read obj
        do git cat-file -p $obj >/dev/null || exit 1
        done <obj-list ) &&
