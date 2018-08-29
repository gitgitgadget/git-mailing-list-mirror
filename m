Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E87FC1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 00:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeH2EvT (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 00:51:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37200 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727168AbeH2EvS (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 00:51:18 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D8A8660750;
        Wed, 29 Aug 2018 00:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535504223;
        bh=ijtr5cdirytrRCWMkZEvPA884LFR3boU3HI0lo+KMJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=mvpl2V9flEjLAYwLkwz6RjLymbVmv7YRiYSP2aEq5nZ3cz8x8BennHLNBn5XE5/P7
         UEaeX7ut7a/bpqELmla6qfJZs7wcuOYuBo1UGgs7dCAmCOaE2hVo/f8DYzB1bmr6iu
         AQleVt5KPPm7rwmpZDfia448ppkC38bltGoNW+gfL6MglwswftETJ+EDlixGnSGjAr
         fstBMeeXMskeI8py/wfEsbEuUf8BWOASt9MkXAS7G/P9pxh5d7bBZIipaRgm5bcY7W
         veKRDptVt/RbERcKVKK5uvOb/fELpByG6o9I7LYZRCt840DrheBz9NoUC1ILqQSXcq
         nPJ6+At5YEgu5FCJsU8FIJn5meoYnqYSP/MdVA4OX7TCEaLNPKQbb+6TtREYoeKntm
         hX8JmPtUDDVAboG4JHbK6eFNl8qmqiIE/0c5JN4QmW2cFyMZpx8qNQdTwnL+AdMtvL
         toJJvqA7VMAnT4cUpMhzO9FtQcsprqKGGZv4vRVpJx1lSHHWYcx
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 02/11] t0000: use hash translation table
Date:   Wed, 29 Aug 2018 00:56:33 +0000
Message-Id: <20180829005642.980617-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <20180829005642.980617-1-sandals@crustytoothpaste.net>
References: <20180829005642.980617-1-sandals@crustytoothpaste.net>
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
index e3cace299e..b7f57ea052 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1013,12 +1013,13 @@ test_expect_success SHA1 'validate object ID for a known tree' '
 
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
