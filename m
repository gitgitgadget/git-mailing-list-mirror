Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68B91F462
	for <e@80x24.org>; Sun,  9 Jun 2019 22:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbfFIWoS (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 18:44:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37570 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729692AbfFIWoR (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Jun 2019 18:44:17 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1504:7263:609b:f73f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AADAB61B34;
        Sun,  9 Jun 2019 22:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1560120256;
        bh=axlbtRUpZ5RiLIVlbfzPVAE+a73AC2bmKrWScyFgNEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=TpRFjiOPr9ixP+UcrNETB8ZOEjukwLgtYlmRSLrLlm0Sr6NXdwh/RMNXQ+9wz0j59
         CMMj1BXHpQWnehINv8iZxfDbVDkoIYC0xuE6XqC9D8lMLW8PEH8bl0nnj+pnp+r5SZ
         1s2uoLr8CKuqZWyOAfjAK3qVakkksB7lInBg+Rb2Ub5cOkHYsoWFi9kL/JR8Deiz8T
         TV1LGkAdYIgDAP0USa/nPy+Bsl4sGELaTYzAddYSQMHsWq668kXj5EVSpwm1LKhpgE
         YJJ+0YacAaENmGz99y8OxBEtfvlql7eoQO09DrTepUfSYmJK6v0AuuKbAH9Rcuq+gb
         ORIVHmSHIpBHp3UOyeMAyluGv0Q9sbXwlaWAOZdpyJVXKAR49KyNKzrPQwhhqPZ4LK
         ivwedNkfBdnq5IkFAzFWz9Yy2l4qZj8gV2TCz0xuuq9DIATMiRB/FqtRWGSQQ7Ckpx
         h75+BPvpL66LKHcJl2rLWdbLcEiEj2XOFvfvcdRJAZn8R50xOaP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 04/10] t5000: make hash independent
Date:   Sun,  9 Jun 2019 22:43:54 +0000
Message-Id: <20190609224400.41557-5-sandals@crustytoothpaste.net>
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

This test uses a stub of a very large (64 GB) object to test our
generation of tar archives.  In doing so, it uses the object ID of the
object so it can insert it into the database properly.  Look up these
values using test_oid.  Restructure the test slightly to use
test_oid_in_path.

Since we care about the object, not how it is named in a particular hash
algorithm, rename it to "huge-object", which is shorter and more
descriptive.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5000-tar-tree.sh                             |  16 +++++++++++-----
 ...5a8938e6999cb59b3ff66739902a => huge-object} | Bin
 2 files changed, 11 insertions(+), 5 deletions(-)
 rename t/t5000/{19f9c8273ec45a8938e6999cb59b3ff66739902a => huge-object} (100%)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 602bfd9574..37655a237c 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -94,6 +94,13 @@ check_tar() {
 	'
 }
 
+test_expect_success 'setup' '
+	test_oid_cache <<-EOF
+	obj sha1:19f9c8273ec45a8938e6999cb59b3ff66739902a
+	obj sha256:3c666f798798601571f5cec0adb57ce4aba8546875e7693177e0535f34d2c49b
+	EOF
+'
+
 test_expect_success \
     'populate workdir' \
     'mkdir a &&
@@ -369,11 +376,10 @@ test_lazy_prereq TAR_HUGE '
 '
 
 test_expect_success LONG_IS_64BIT 'set up repository with huge blob' '
-	obj_d=19 &&
-	obj_f=f9c8273ec45a8938e6999cb59b3ff66739902a &&
-	obj=${obj_d}${obj_f} &&
-	mkdir -p .git/objects/$obj_d &&
-	cp "$TEST_DIRECTORY"/t5000/$obj .git/objects/$obj_d/$obj_f &&
+	obj=$(test_oid obj) &&
+	path=$(test_oid_to_path $obj) &&
+	mkdir -p .git/objects/$(dirname $path) &&
+	cp "$TEST_DIRECTORY"/t5000/huge-object .git/objects/$path &&
 	rm -f .git/index &&
 	git update-index --add --cacheinfo 100644,$obj,huge &&
 	git commit -m huge
diff --git a/t/t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a b/t/t5000/huge-object
similarity index 100%
rename from t/t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a
rename to t/t5000/huge-object
