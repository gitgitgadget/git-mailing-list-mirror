Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74AAC433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 19:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D3E2073B
	for <git@archiver.kernel.org>; Mon, 25 May 2020 19:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vXQhq1on"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390387AbgEYT7q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 15:59:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38678 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390354AbgEYT7o (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 15:59:44 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 419866081B;
        Mon, 25 May 2020 19:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436783;
        bh=hh0AAPebP5FiADzq2rtNsAQTbv06qUSl3vhXg+93iek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=vXQhq1onyb6tdMWILgHHVIIa36sdR4Q8eLKdIZUPe/CTM3P2BwvwddvdWKnGr5+YX
         Px6ECsZ03mFQZ68gBHqXc2EBhi06PKhEKSMXXx0syvEGUmZ7ubjwARVfZ1PklO+eF2
         +yGkLqSB3iNm/3tU7GCDhTihePfC7+HOFBm8+qQZXBkGBnX3514kOutnBi4QBioTjJ
         7UBa+4tL1t5OWeORIxFUN3yygyk/YhJ6bHw1fvY8j/LJXMPYaN0J/URzCKPdh5vFzW
         //YHkcjgOP7e/l12mT5i2Bzf3VlobX1qE5cI3fvDIL0wHRKDStITMvNE9S6SOgCYHd
         Vdvcf6fOvb+cby/D/CyjBYF9Gesdk74it1s6mBRT23sFz/DghVQqgy/jaJasqTmKNL
         Q+J5CwJBGz+LyFzPSP45axvyTPiYDdajMKmPJ0Njccq5Bwa6wtPFzCvwVK9dbmRNNL
         ByXrsanhZzJvWJZKtZrBo9mJG2/Bx5MLqhGems0RyXrGkrcG/KU
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 01/44] t1050: match object ID paths in a hash-insensitive way
Date:   Mon, 25 May 2020 19:58:47 +0000
Message-Id: <20200525195930.309665-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200525195930.309665-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200525195930.309665-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pattern here looking for failures is specific to SHA-1.  Let's
create a variable that matches the regex or glob pattern for a path
within the objects directory.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1050-large.sh | 2 +-
 t/test-lib.sh    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 184b479a21..7f88ea07c2 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -64,7 +64,7 @@ test_expect_success 'add a large file or two' '
 	test $count = 1 &&
 	cnt=$(git show-index <"$idx" | wc -l) &&
 	test $cnt = 2 &&
-	for l in .git/objects/??/??????????????????????????????????????
+	for l in .git/objects/$OIDPATH_REGEX
 	do
 		test_path_is_file "$l" || continue
 		bad=t
diff --git a/t/test-lib.sh b/t/test-lib.sh
index d36b6ddc62..5c65c3e26c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1414,6 +1414,7 @@ test_oid_init
 
 ZERO_OID=$(test_oid zero)
 OID_REGEX=$(echo $ZERO_OID | sed -e 's/0/[0-9a-f]/g')
+OIDPATH_REGEX=$(test_oid_to_path $ZERO_OID | sed -e 's/0/[0-9a-f]/g')
 EMPTY_TREE=$(test_oid empty_tree)
 EMPTY_BLOB=$(test_oid empty_blob)
 _z40=$ZERO_OID
