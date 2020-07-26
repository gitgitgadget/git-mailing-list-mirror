Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCD3C43461
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1991920715
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="pJWQw/pI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgGZTzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:55:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40780 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728053AbgGZTzQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:55:16 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 793986100C;
        Sun, 26 Jul 2020 19:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793284;
        bh=+PqxO8ska++rKIP2kfK1D/tpsnkaFSXfLGOy/Y1ZYlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=pJWQw/pI3IRiWhmzhsUEb9czvyrgNQd6Owp/syur+nEbCGUPvnkhmO17dxcWqTLLP
         ItoIJcNkxELOY8tlfQ1ij32LFmkc10oo3ye3aq4RypiT6rFES4gLJ1VxI3Dz0uLQ0E
         f4o5RKq8qrCPUKuGd2QNyWSjPYS7eZbVmdf/PU9RK3qS4HiBrImwJ+Xknpq1D7aPwk
         p40tNt4RMk16dAbMBCb3+RWOkCGc20/d+49bXyA6BXCZTmIJgDs2m+2wvo6STU0UiE
         lVHpl8zVHG91tKMiCDDi7Jqbl11J0sN8Q2batgY4HNET1C6DDqZxFhTNwYnMr8bejG
         woKasn7s0u+PVXroF7X6k58U9/JGV3x+xjJNJ+s5qxLc52981LzSL3Cv2RTzw+Q/cY
         Sio9L4dr6+ptw2znuiUoC03NJpTV+pyLn5bZdkN5AguMtdUj5w1w2TEnIJNSvBl6OO
         1udPeIeFUWtuj7uoFVwapREFltr8JDdnpc7hylJdvntMhRDGTKD
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 09/39] t6501: avoid hard-coded objects
Date:   Sun, 26 Jul 2020 19:53:54 +0000
Message-Id: <20200726195424.626969-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test contains hard-coded invalid object IDs.  Make it hash size
independent by generating invalid object IDs using the translation
tables.  Add a setup target to ensure the output of test_oid_init is
checked properly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6501-freshen-objects.sh | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
index f30b4849b6..7416ed5ffe 100755
--- a/t/t6501-freshen-objects.sh
+++ b/t/t6501-freshen-objects.sh
@@ -45,6 +45,10 @@ maybe_repack () {
 	fi
 }
 
+test_expect_success 'setup' '
+	test_oid_init
+'
+
 for repack in '' true; do
 	title=${repack:+repack}
 	title=${title:-loose}
@@ -128,9 +132,9 @@ for repack in '' true; do
 done
 
 test_expect_success 'do not complain about existing broken links (commit)' '
-	cat >broken-commit <<-\EOF &&
-	tree 0000000000000000000000000000000000000001
-	parent 0000000000000000000000000000000000000002
+	cat >broken-commit <<-EOF &&
+	tree $(test_oid 001)
+	parent $(test_oid 002)
 	author whatever <whatever@example.com> 1234 -0000
 	committer whatever <whatever@example.com> 1234 -0000
 
@@ -143,8 +147,8 @@ test_expect_success 'do not complain about existing broken links (commit)' '
 '
 
 test_expect_success 'do not complain about existing broken links (tree)' '
-	cat >broken-tree <<-\EOF &&
-	100644 blob 0000000000000000000000000000000000000003	foo
+	cat >broken-tree <<-EOF &&
+	100644 blob $(test_oid 003)	foo
 	EOF
 	tree=$(git mktree --missing <broken-tree) &&
 	git gc -q 2>stderr &&
@@ -153,8 +157,8 @@ test_expect_success 'do not complain about existing broken links (tree)' '
 '
 
 test_expect_success 'do not complain about existing broken links (tag)' '
-	cat >broken-tag <<-\EOF &&
-	object 0000000000000000000000000000000000000004
+	cat >broken-tag <<-EOF &&
+	object $(test_oid 004)
 	type commit
 	tag broken
 	tagger whatever <whatever@example.com> 1234 -0000
