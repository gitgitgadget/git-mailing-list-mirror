Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B8E81F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 21:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfJEVMU (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 17:12:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36302 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbfJEVMU (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 5 Oct 2019 17:12:20 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 32D5161C63;
        Sat,  5 Oct 2019 21:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1570309939;
        bh=R1peGq3gHTVqQyCMrxtvF/BhGK1RjhCO4LktLfzNJmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=VIPg7Ool23uiJESTzFWjcnQZb79HBGaQEAkAFLTmAdGt9zUd7TJE/+7pWw37XOYdX
         2hyzMkeQjzGanfZim1TzoacMyVR5qBkHWYsaM/67z4rK/x+6YU8GVYLORh3BwgUVKO
         eATX4PSkedWvuGmOy2C7/U/uz3qTzYCO8bMkw6oBIwAjRdZ6BUXrFXOWPRPMJT7N+S
         NcNU69JtPnbMIAIYAOeKg5ZUBD7dXR3Xot0OnA8QSReM6XuaGrwMJMFYjYJ9Ft62AJ
         6bhZ1ZaWjY8QtKEcgp9L4xdPPO9XH9Ae22nhdb7nHzTOMxubv20eE1FUlZhJOrixJH
         O+chE331FYTsOuql+2UgiB5LxdwLKLQWIkOOUHlRM2I5dSwjwE+Coyw5abuEdchBuQ
         AcgMa0va+fh8jogxu++pRAldYMRAcJFGXjP6+6NI8w5z7plfamvjmPsFFcYBzAQdFH
         P7Do+sdFOtzYAk1DSBjCUaRuWCWfD42u7gwGm6lDIEzvNOm/Kj7
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 07/15] t4011: abstract away SHA-1-specific constants
Date:   Sat,  5 Oct 2019 21:12:01 +0000
Message-Id: <20191005211209.18237-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb
In-Reply-To: <20191005211209.18237-1-sandals@crustytoothpaste.net>
References: <20191005211209.18237-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4011-diff-symlink.sh | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 5ae19b987d..b6934da266 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -10,10 +10,12 @@ test_description='Test diff of symlinks.
 . "$TEST_DIRECTORY"/diff-lib.sh
 
 test_expect_success 'diff new symlink and file' '
-	cat >expected <<-\EOF &&
+	symlink=$(git rev-parse --short \
+		$(printf xyzzy | git hash-object --stdin)) &&
+	cat >expected <<-EOF &&
 	diff --git a/frotz b/frotz
 	new file mode 120000
-	index 0000000..7c465af
+	index 0000000..$symlink
 	--- /dev/null
 	+++ b/frotz
 	@@ -0,0 +1 @@
@@ -21,7 +23,7 @@ test_expect_success 'diff new symlink and file' '
 	\ No newline at end of file
 	diff --git a/nitfol b/nitfol
 	new file mode 100644
-	index 0000000..7c465af
+	index 0000000..$symlink
 	--- /dev/null
 	+++ b/nitfol
 	@@ -0,0 +1 @@
@@ -46,10 +48,10 @@ test_expect_success 'diff unchanged symlink and file'  '
 '
 
 test_expect_success 'diff removed symlink and file' '
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	diff --git a/frotz b/frotz
 	deleted file mode 120000
-	index 7c465af..0000000
+	index $symlink..0000000
 	--- a/frotz
 	+++ /dev/null
 	@@ -1 +0,0 @@
@@ -57,7 +59,7 @@ test_expect_success 'diff removed symlink and file' '
 	\ No newline at end of file
 	diff --git a/nitfol b/nitfol
 	deleted file mode 100644
-	index 7c465af..0000000
+	index $symlink..0000000
 	--- a/nitfol
 	+++ /dev/null
 	@@ -1 +0,0 @@
@@ -90,9 +92,11 @@ test_expect_success 'diff identical, but newly created symlink and file' '
 '
 
 test_expect_success 'diff different symlink and file' '
-	cat >expected <<-\EOF &&
+	new=$(git rev-parse --short \
+		$(printf yxyyz | git hash-object --stdin)) &&
+	cat >expected <<-EOF &&
 	diff --git a/frotz b/frotz
-	index 7c465af..df1db54 120000
+	index $symlink..$new 120000
 	--- a/frotz
 	+++ b/frotz
 	@@ -1 +1 @@
@@ -101,7 +105,7 @@ test_expect_success 'diff different symlink and file' '
 	+yxyyz
 	\ No newline at end of file
 	diff --git a/nitfol b/nitfol
-	index 7c465af..df1db54 100644
+	index $symlink..$new 100644
 	--- a/nitfol
 	+++ b/nitfol
 	@@ -1 +1 @@
@@ -137,14 +141,17 @@ test_expect_success SYMLINKS 'setup symlinks with attributes' '
 '
 
 test_expect_success SYMLINKS 'symlinks do not respect userdiff config by path' '
-	cat >expect <<-\EOF &&
+	file=$(git rev-parse --short $(git hash-object file.bin)) &&
+	link=$(git rev-parse --short \
+		$(printf file.bin | git hash-object --stdin)) &&
+	cat >expect <<-EOF &&
 	diff --git a/file.bin b/file.bin
 	new file mode 100644
-	index 0000000..d95f3ad
+	index 0000000..$file
 	Binary files /dev/null and b/file.bin differ
 	diff --git a/link.bin b/link.bin
 	new file mode 120000
-	index 0000000..dce41ec
+	index 0000000..$link
 	--- /dev/null
 	+++ b/link.bin
 	@@ -0,0 +1 @@
