Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9191F404
	for <e@80x24.org>; Sun, 25 Mar 2018 19:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeCYTVZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 15:21:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42528 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752016AbeCYTVW (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Mar 2018 15:21:22 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1839C609A0;
        Sun, 25 Mar 2018 19:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1522005680;
        bh=CzCOo1t6RqL+VjN1vASE/P+zLF5BmCHSDMCBCpx9jAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=aBSCADea7OHvF1IxKiayIBj6BPGhecf0iyyqZTZMPOFIp9Zf2B4jZ86YyFugTZFA2
         SYZve2sHHpg6uqNcbZl/3BuvM12XcKNaqazBaWdu2MLvnnI2MjkFY6j6KAcH9gOHJl
         cLmyehvKsjJv5OmK2yZMGbUSRLWnndaYNx5/0oUoioN1ExJFzbNXN7T9lrgJ3o8YPS
         dQXAKKbD9wmPCvLu+l7e//kvGnic2cXWPA9d9nj3ulp+oI4ixXH64twWH9m3MR96SV
         bgaH0mVDrimD+kwRXQ6JV7O8XxsIOLuhztLZBS65IVYcItmVx18hhX2gtsK+5FvTAw
         0qUxWU0Je8BJZFmnx+zOTiE11X/rZr7ZhMN7o8rwzMGfOQ3m1jRksYKk4b9GrRfa//
         9Dmf10tt9znxdIjkrVCrEK2fTPmanOHdgM5xSb1QLqg0QjOyPV1avUsrM0qTIXkMXu
         fnisqcq5vzp5DU2K6MZE2A92yuFq3CrsaYjdE8e2EiHY8IBf/qZ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 07/10] t2020: abstract away SHA-1 specific constants
Date:   Sun, 25 Mar 2018 19:20:52 +0000
Message-Id: <20180325192055.841459-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.rc1.317.g4a561d2cc9
In-Reply-To: <20180325192055.841459-1-sandals@crustytoothpaste.net>
References: <20180325192055.841459-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it uses variables for the revisions we're
checking out instead of hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t2020-checkout-detach.sh | 40 +++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index bb4f2e0c63..1fa670625c 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -189,8 +189,12 @@ test_expect_success 'no advice given for explicit detached head state' '
 # Detached HEAD tests for GIT_PRINT_SHA1_ELLIPSIS (new format)
 test_expect_success 'describe_detached_head prints no SHA-1 ellipsis when not asked to' "
 
+	commit=$(git rev-parse --short=12 master^) &&
+	commit2=$(git rev-parse --short=12 master~2) &&
+	commit3=$(git rev-parse --short=12 master~3) &&
+
 	# The first detach operation is more chatty than the following ones.
-	cat >1st_detach <<-'EOF' &&
+	cat >1st_detach <<-EOF &&
 	Note: checking out 'HEAD^'.
 
 	You are in 'detached HEAD' state. You can look around, make experimental
@@ -202,18 +206,18 @@ test_expect_success 'describe_detached_head prints no SHA-1 ellipsis when not as
 
 	  git checkout -b <new-branch-name>
 
-	HEAD is now at 7c7cd714e262 three
+	HEAD is now at \$commit three
 	EOF
 
 	# The remaining ones just show info about previous and current HEADs.
-	cat >2nd_detach <<-'EOF' &&
-	Previous HEAD position was 7c7cd714e262 three
-	HEAD is now at 139b20d8e6c5 two
+	cat >2nd_detach <<-EOF &&
+	Previous HEAD position was \$commit three
+	HEAD is now at \$commit2 two
 	EOF
 
-	cat >3rd_detach <<-'EOF' &&
-	Previous HEAD position was 139b20d8e6c5 two
-	HEAD is now at d79ce1670bdc one
+	cat >3rd_detach <<-EOF &&
+	Previous HEAD position was \$commit2 two
+	HEAD is now at \$commit3 one
 	EOF
 
 	reset &&
@@ -261,8 +265,12 @@ test_expect_success 'describe_detached_head prints no SHA-1 ellipsis when not as
 # Detached HEAD tests for GIT_PRINT_SHA1_ELLIPSIS (old format)
 test_expect_success 'describe_detached_head does print SHA-1 ellipsis when asked to' "
 
+	commit=$(git rev-parse --short=12 master^) &&
+	commit2=$(git rev-parse --short=12 master~2) &&
+	commit3=$(git rev-parse --short=12 master~3) &&
+
 	# The first detach operation is more chatty than the following ones.
-	cat >1st_detach <<-'EOF' &&
+	cat >1st_detach <<-EOF &&
 	Note: checking out 'HEAD^'.
 
 	You are in 'detached HEAD' state. You can look around, make experimental
@@ -274,18 +282,18 @@ test_expect_success 'describe_detached_head does print SHA-1 ellipsis when asked
 
 	  git checkout -b <new-branch-name>
 
-	HEAD is now at 7c7cd714e262... three
+	HEAD is now at \$commit... three
 	EOF
 
 	# The remaining ones just show info about previous and current HEADs.
-	cat >2nd_detach <<-'EOF' &&
-	Previous HEAD position was 7c7cd714e262... three
-	HEAD is now at 139b20d8e6c5... two
+	cat >2nd_detach <<-EOF &&
+	Previous HEAD position was \$commit... three
+	HEAD is now at \$commit2... two
 	EOF
 
-	cat >3rd_detach <<-'EOF' &&
-	Previous HEAD position was 139b20d8e6c5... two
-	HEAD is now at d79ce1670bdc... one
+	cat >3rd_detach <<-EOF &&
+	Previous HEAD position was \$commit2... two
+	HEAD is now at \$commit3... one
 	EOF
 
 	reset &&
