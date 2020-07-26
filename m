Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F0EC433E8
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6675220715
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="sJo6AmCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgGZTyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:54:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40666 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbgGZTyo (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:54:44 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9811F60CF8;
        Sun, 26 Jul 2020 19:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793283;
        bh=GOwWURZWcS80hrBtH5tnhZJpLhQbfrdP5Wk4iblxXNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=sJo6AmCRZ9uVM1NdCOp0zbrDh1SitLjr+pkytDvGl2uh/oAnZyv9GKnvvU9ZcGYJb
         gdfeIBoWC8lkrgj8UItSby1E8w3w/3WePNgXjqMaS3H9DEgVxU8SKAOIPhhuTe33G5
         pjVmyZfI5uHYx8mgJAgKLJ3h4IucHqe4zYrj4ZsvOeJIMhSQdjSsWp7ahVRqvtP4ey
         mCI8Gh8YHEF+WXYPoNZIlXiwUhC18KwD8h9pPEd2VTvWtwAQ0K9Sb5O1dQiYRxst/1
         9Go7fBarfjh1RxNj8YIus89UVbAWU74VErS8DdxCyTpL5CjSBTWi0ZYzHPpKpaevxj
         Vxj4HHyD2AdbRJoyYeRte3hFHmK6OnbqroVu4dKXfTflTV5fcND3ehjUwXvBiBrTmP
         lYEL9BqDeadEzT7JD0EYhKFY7ieFsJwzWJL6wXzBfbyYAyjxjvevykcDIUNj8/ZDxg
         d6HhRPJUowTIHbMAaEQlwURVgBFRGSHcMybx7Sr/WBIsakVXb5Z
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 07/39] t6301: make hash size independent
Date:   Sun, 26 Jul 2020 19:53:52 +0000
Message-Id: <20200726195424.626969-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding a fixed length example object ID in the test,
compute one using the translation tables.  Move a variable into the
setup block so that we can ensure the exit status of test_oid_init is
checked.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6301-for-each-ref-errors.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index 49cc65bb58..d545a725a5 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -5,9 +5,10 @@ test_description='for-each-ref errors for broken refs'
 . ./test-lib.sh
 
 ZEROS=$ZERO_OID
-MISSING=abababababababababababababababababababab
 
 test_expect_success setup '
+	test_oid_init &&
+	MISSING=$(test_oid deadbeef) &&
 	git commit --allow-empty -m "Initial" &&
 	git tag testtag &&
 	git for-each-ref >full-list &&
