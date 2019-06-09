Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5285E1F462
	for <e@80x24.org>; Sun,  9 Jun 2019 22:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbfFIWoX (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 18:44:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37590 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729928AbfFIWoV (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Jun 2019 18:44:21 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1504:7263:609b:f73f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9E47861B3D;
        Sun,  9 Jun 2019 22:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1560120259;
        bh=Phj/AHj6kyTS/Qy5e/n5OvwxT34sihB9KInmpPuA8ZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=0SDlCp+eoWkkIVFaR+fkpd1fMZJCbg4aaoIB19P0TaijEkOyKiLFKrMEItcZPUX9S
         XJ2THwxhNuLcOHkWYRJLR9A65tpD0363gFHPYXTo1GvSnd+Evo/9oogvSussIyNZte
         iXwEXfR8xpndMGqtWIWPVsDzKZmpy81j2PSekqfhZoHm439Jyx/wxVyYLzewY2CGF3
         oyO+kd8Ho6rhocgbltklSm06vBybmEWixVS/j1XCn66RnXSzPMTNfKg/IRqDVymQVM
         OKwUOEDjnmzlaIm17PT5scd7g4IfUYRVvxenK1JLMj2q5MEL+Ubp6rPF6k09441Q8M
         0C+P7czl1rzIGWu8YS4cWtQf39Yfpr4wUELyOWHjMk0sh7xeHtpl3aoJC36ICDkxh0
         t7IUDoaJK382ZhTmPFx7A7s/gWH0QDOER91d33fr643PDfo6Qh5N4qevvPpfZ5aexs
         lQPzQt/JteLT3ZNqVtGklri0lfagAzVyUd+P2l7heidUsZrrg7S
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 07/10] t0090: make test pass with SHA-256
Date:   Sun,  9 Jun 2019 22:43:57 +0000
Message-Id: <20190609224400.41557-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2
In-Reply-To: <20190609224400.41557-1-sandals@crustytoothpaste.net>
References: <20190609224400.41557-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One assertion of this test checks for a shrinking cache tree.  The
initial index contains a cache tree with two directory names but no
object ID, and the second index contains a cache tree with an object ID
but no directory name.

With SHA-1, the second index is smaller than the first, because the
directory information stored takes more than the 20 bytes of an SHA-1
hash, but with SHA-256, the hash is longer, and the test fails the
assertion that the second index is smaller than the first.

To address this issue, increase the length of the subdirectory name to
ensure that the cache tree does indeed shrink in size regardless of the
algorithm in use.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t0090-cache-tree.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 504334e552..ce9a4a5f32 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -162,8 +162,8 @@ test_expect_success PERL 'commit --interactive gives cache-tree on partial commi
 '
 
 test_expect_success PERL 'commit -p with shrinking cache-tree' '
-	mkdir -p deep/subdir &&
-	echo content >deep/subdir/file &&
+	mkdir -p deep/very-long-subdir &&
+	echo content >deep/very-long-subdir/file &&
 	git add deep &&
 	git commit -m add &&
 	git rm -r deep &&
