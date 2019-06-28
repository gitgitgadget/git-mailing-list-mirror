Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F18651F461
	for <e@80x24.org>; Fri, 28 Jun 2019 22:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfF1W7v (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 18:59:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56372 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726887AbfF1W7s (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Jun 2019 18:59:48 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f01a:2fd6:a95e:5f84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7C0566101B;
        Fri, 28 Jun 2019 22:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1561762787;
        bh=Phj/AHj6kyTS/Qy5e/n5OvwxT34sihB9KInmpPuA8ZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=YV1fLZoVPagbv+NuKBZXznpwwny2b+FXCz0Wg6qC69LSJitK5wfYKQI0+CkUEhTJG
         L1mekwtJ+HqAC3xpFj7ucM88NdSvqSBOKGXCXB71WzbFX5GKvMX3kldXEYrzhfpyVu
         x43LJMzlcck6H3bG//pUSayKvK9CNVE+Glqo4kc90z2ghohJCPFbHNgVGfNeHB8Y6D
         kqhHrGibazL1Lts9gChKzAo19Y127kMxLibucDbMKfds2jxdap2dF451ySqDtFOn7U
         Oq6ui7F9BpirXYBTHEsrK60r4ah4MVegVJPk8ks3vM84HAvjBW1+7VsTSaoARKvcEV
         UiqDr20at54kgkQBlQkKtfYdQCfpieIo4KvjSyt0yOVV5xrfcV5G6m4i5hQhPF/ogI
         n9jfghLk4NXeufNSa2B/1t32bfup0WYoLkLlYJcxQNeavoZL64Xt4K2krkn+K+nQy9
         QT+dW7fveofAC2aSc12SWX6E6dmkpoH1pKN4ly2OWz4SxGdB2p0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 07/10] t0090: make test pass with SHA-256
Date:   Fri, 28 Jun 2019 22:59:25 +0000
Message-Id: <20190628225928.622372-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190628225928.622372-1-sandals@crustytoothpaste.net>
References: <20190628225928.622372-1-sandals@crustytoothpaste.net>
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
