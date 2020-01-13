Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA118C33CAE
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0184214AF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="aUkOPVRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAMMsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:48:03 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37778 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728885AbgAMMsA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:48:00 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6AB4A607F8
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 12:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919679;
        bh=B7jZ7OcAT1p+IaD8zAaRDzP9f1o69d30rknV3o2Vajo=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=aUkOPVRw7IwzcBIgIIji2GSWhtv8NF5/AZuRhfJjU3LnlePPvbKq6D8anrk+8cO11
         8a2vvEalPUqAlFV2hzV9tDfv/p35RsP1S9h8sXTi3hZXqyJiJ2lcUeaWBEAGQ+7pGh
         OYwtwjqYbyC15/ZIbIJgLnhHQ5CV+iuQtrbBaVnYhhZEKKidW/MIj1VTxNigfCBkgj
         ZOMl6NZJia/zZz72gFZj5RdmwblEa5SXkvk3eb2r3zS+HtFmp0TDmWl2GBidf/1LMn
         nmCBZzhpldEqEFWFXr/7SlYBQycnAqKAt6Q6ceXb6pnH4hyFkdVCbxvXnT/OgyBIBd
         /qMItBwHjBdc5S+lqZfyr1lqU+6FK+i0oB/vYks9ejGhquvgnLryY8umcTFHJqVnJz
         L+vSmkqD1AyyFSRBIfHPPER9owcqoNksxTKIwrm75zv8w2F7jdf1UEEwMyb0Zuwitx
         1OoJP/AHyg4xWOS4iK3vW1hyjY2AN18PfvSZchGEr6JvXZ8eWdI
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [RFC PATCH 05/22] t6300: abstract away SHA-1-specific constants
Date:   Mon, 13 Jan 2020 12:47:12 +0000
Message-Id: <20200113124729.3684846-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
References: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
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
 t/t6300-for-each-ref.sh | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 9c910ce746..2406b93d35 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -20,6 +20,10 @@ setdate_and_increment () {
 }
 
 test_expect_success setup '
+	test_oid_cache <<-EOF &&
+	disklen sha1:138
+	disklen sha256:154
+	EOF
 	setdate_and_increment &&
 	echo "Using $datestamp" > one &&
 	git add one &&
@@ -50,6 +54,9 @@ test_atom() {
 	"
 }
 
+hexlen=$(test_oid hexsz)
+disklen=$(test_oid disklen)
+
 test_atom head refname refs/heads/master
 test_atom head refname: refs/heads/master
 test_atom head refname:short master
@@ -82,9 +89,9 @@ test_atom head push:rstrip=-1 refs
 test_atom head push:strip=1 remotes/myfork/master
 test_atom head push:strip=-1 master
 test_atom head objecttype commit
-test_atom head objectsize 171
-test_atom head objectsize:disk 138
-test_atom head deltabase 0000000000000000000000000000000000000000
+test_atom head objectsize $((131 + hexlen))
+test_atom head objectsize:disk $disklen
+test_atom head deltabase $ZERO_OID
 test_atom head objectname $(git rev-parse refs/heads/master)
 test_atom head objectname:short $(git rev-parse --short refs/heads/master)
 test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
@@ -125,11 +132,11 @@ test_atom tag refname:short testtag
 test_atom tag upstream ''
 test_atom tag push ''
 test_atom tag objecttype tag
-test_atom tag objectsize 154
-test_atom tag objectsize:disk 138
-test_atom tag '*objectsize:disk' 138
-test_atom tag deltabase 0000000000000000000000000000000000000000
-test_atom tag '*deltabase' 0000000000000000000000000000000000000000
+test_atom tag objectsize $((114 + hexlen))
+test_atom tag objectsize:disk $disklen
+test_atom tag '*objectsize:disk' $disklen
+test_atom tag deltabase $ZERO_OID
+test_atom tag '*deltabase' $ZERO_OID
 test_atom tag objectname $(git rev-parse refs/tags/testtag)
 test_atom tag objectname:short $(git rev-parse --short refs/tags/testtag)
 test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
@@ -139,7 +146,7 @@ test_atom tag parent ''
 test_atom tag numparent ''
 test_atom tag object $(git rev-parse refs/tags/testtag^0)
 test_atom tag type 'commit'
-test_atom tag '*objectname' 'ea122842f48be4afb2d1fc6a4b96c05885ab7463'
+test_atom tag '*objectname' $(git rev-parse refs/tags/testtag^{})
 test_atom tag '*objecttype' 'commit'
 test_atom tag author ''
 test_atom tag authorname ''
