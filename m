Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20199C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F260D20776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zulGy1w1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436496AbgFSR5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:57:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39614 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404689AbgFSR4p (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:45 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3293D60791;
        Fri, 19 Jun 2020 17:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589373;
        bh=wLSEs4YSnnzYOGxzW174eZGSDZmYUM3piJq4zdKUr5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=zulGy1w1e8m2XM7W4SIoPFm6tBVqmMQ2Pnx1Dmp8pmNrR3jfP32Nl9wBD2/K6FmTq
         VAuU8sCUjVs/syK0krVh8GiL3AnBqBcvn4W3txBPlL3+nkFAWnD5JlKl8DkTgO6QFq
         l9+nAHk97dMMcrWkmPX3lFP+jjrpI6FfPUuSQULIFnVm+GJPAgoEBI5zwPJrRGS7oz
         QDh0aT5ZYFlCaD1/kYZak0cX8DqL3J4l4PlaMraPkNS7RtLflutYw75tVeCbseOnKG
         v+FpFbbR0gqT7m+6Z6UWri/e4cdC7fNAcq2mVrx7GXTGDsElkcycMfLiYlJx+h2S22
         ZhQsgVrXxhc6H+YceOwLcbWMZCWOGuJ0lYFXWgYlXz7/kqbT/H8fw7Q6LcjG54rRHs
         CHeQEvgpP6+Eg6NaOXPi0X2lqjAfvJGvc+rY+2E4V2xl7bFuH7awT/FWtViFFEFvZL
         waO4dNKlTW2ob4tD5JxPCG9ONV0oz7nqz1yvYyW2xurQYOATIDm
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 01/44] t1050: match object ID paths in a hash-insensitive way
Date:   Fri, 19 Jun 2020 17:55:18 +0000
Message-Id: <20200619175601.569856-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619175601.569856-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200619175601.569856-1-sandals@crustytoothpaste.net>
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
index dbc027ff26..618a7c8d5b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1414,6 +1414,7 @@ test_oid_init
 
 ZERO_OID=$(test_oid zero)
 OID_REGEX=$(echo $ZERO_OID | sed -e 's/0/[0-9a-f]/g')
+OIDPATH_REGEX=$(test_oid_to_path $ZERO_OID | sed -e 's/0/[0-9a-f]/g')
 EMPTY_TREE=$(test_oid empty_tree)
 EMPTY_BLOB=$(test_oid empty_blob)
 _z40=$ZERO_OID
