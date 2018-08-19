Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 283CE1F954
	for <e@80x24.org>; Sun, 19 Aug 2018 17:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeHSVGa (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 17:06:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55020 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726661AbeHSVGa (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Aug 2018 17:06:30 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 84EA46074C;
        Sun, 19 Aug 2018 17:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1534701253;
        bh=D/8H3vtZXPmoT3XnA0P4KHBhtj+N1nGyGT9/H8wi4K0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=rNB3Vm0ldyn4u18gYU1NlkQqdQjoLkjE5b37Xy+wSSnyrUp6VIKFrdt0qhRzW02gg
         oCR4vTqByC9JwyUvYInVcEz6rgPCXf0HlaPDltMkDrGEwM9O+bPYaVVch9MxRIoeWo
         Ymc+GYk1Hqop9Ud5hCXaH8qNqDxLuSn+ogfAgLqgOafsK8nGqgwsCwIAiYFTQP77Pg
         wdHU/yFq/h6Uh5BBoDybDZlbJ/AAQom2Yf7VUlJCU01XO7UdqVbMGRjicZI4OFZ40v
         v3TTPAX5OYmOlKHVcHezOh3i3/pcyTsPDuvxlVqA9G1bznB+VGC/TR1wBVHXePgq0s
         sozEWJyr/+yLmGwaBgyDug82E32LCoyOLkzpDIYE/AiNrHFo43HPmvOyGf5jkR6RT/
         74Ohq/hqX8/Of0S8KUGJXQJ+NZvr/RRjoMGYcL0vRUFsBYVJRcS78GWDOL2lV8S+RG
         XKb6zJSiBvo5zAcigd88ViWvHHJ1DqyRmm19uiNzIEe+VRqnqwI
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 02/11] t0000: use hash translation table
Date:   Sun, 19 Aug 2018 17:53:42 +0000
Message-Id: <20180819175351.449973-3-sandals@crustytoothpaste.net>
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

If the hash we're using is 32 bytes in size, attempting to insert a
20-byte object name won't work.  Since these are synthesized objects
that are almost all zeros, look them up in a translation table.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t0000-basic.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index ace779bf7d..57d374f2dc 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1007,12 +1007,13 @@ test_expect_success SHA1 'validate object ID for a known tree' '
 
 test_expect_success 'put invalid objects into the index' '
 	rm -f .git/index &&
-	cat >badobjects <<-\EOF &&
-	100644 blob 1000000000000000000000000000000000000000	dir/file1
-	100644 blob 2000000000000000000000000000000000000000	dir/file2
-	100644 blob 3000000000000000000000000000000000000000	dir/file3
-	100644 blob 4000000000000000000000000000000000000000	dir/file4
-	100644 blob 5000000000000000000000000000000000000000	dir/file5
+	suffix=$(echo $ZERO_OID | sed -e "s/^.//") &&
+	cat >badobjects <<-EOF &&
+	100644 blob $(test_oid 001)	dir/file1
+	100644 blob $(test_oid 002)	dir/file2
+	100644 blob $(test_oid 003)	dir/file3
+	100644 blob $(test_oid 004)	dir/file4
+	100644 blob $(test_oid 005)	dir/file5
 	EOF
 	git update-index --index-info <badobjects
 '
