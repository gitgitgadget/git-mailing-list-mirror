Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834C6C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55142206D8
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cy10K8iA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfLUTu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:50:27 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42036 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727417AbfLUTuO (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 14:50:14 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 45CCF60787;
        Sat, 21 Dec 2019 19:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576957813;
        bh=myXE14f++BnO4FaXiEwV70mCZv/vJ0A2tsrmInH+uYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=cy10K8iAJ7SuSvjzBwsfu9Bv9XA7RdV3sBGy3l4+A+WQaiJ8Y+8XHVzYGfh8dG/y8
         Q1rIeb7Iyi6o8RmXZvUNk0SfMK+6ROnUukXNavkl4h1Hvk5kakRSYG5QpMTvaDVUBw
         xkGFXFAgfHmq4BuOvxEuJYNgiUDAYN5gGlOihj/yiDnAHxgBeZIDAndiO76WY4eA5j
         fH7Pn2+f08JXjGGTFbtqTvC2hkuHnR/le+nII4OmORYR9goAefC4YcJB7H4UQPVPpU
         5dveWc+LUQUardGzuwBe/Okyv/lFo6xsSma6aEzN/ykX/DYCrV+PYDAWw1U3n/67IQ
         LUQcd2hb88akuDPOfvpwPgl3Q2F2JejEYo9Z1ORalwaP65lmqdsIHbbVwD9012RKnA
         Ao9buomjmqho6DCnn9bPXXlnkky6Bm6K10YchkKQH+jDI0Fyg/jbAykFF4s64wEuQk
         rGYuKWtnuYZeTM8KlkXB2umRobuawd7dbeydhpD0f2uWAIBsi6q
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 16/20] t5537: make hash size independent
Date:   Sat, 21 Dec 2019 19:49:32 +0000
Message-Id: <20191221194936.1346664-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.1.658.g99f4b37f93
In-Reply-To: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test modifies a pkt-line stream with sed to change a line with
"shallow" to "unshallow".  However, this modification is dependent on
the size of the hash in use; with SHA-256, the pkt-line length is
different, leading to the sed command having no effect.

Use test_oid_cache to specify the correct values for each hash so that
the test continues to work.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5537-fetch-shallow.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 97a67728ca..9e16512fe3 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -15,7 +15,11 @@ test_expect_success 'setup' '
 	commit 2 &&
 	commit 3 &&
 	commit 4 &&
-	git config --global transfer.fsckObjects true
+	git config --global transfer.fsckObjects true &&
+	test_oid_cache <<-EOF
+	sed sha1:s/0034shallow %s/0036unshallow %s/
+	sed sha256:s/004cshallow %s/004eunshallow %s/
+	EOF
 '
 
 test_expect_success 'setup shallow clone' '
@@ -239,7 +243,7 @@ test_expect_success 'shallow fetches check connectivity before writing shallow f
 	# with an empty packfile. This is done by refetching with a shorter
 	# depth (to ensure that the packfile is empty), and overwriting the
 	# shallow line in the response with the unshallow line we want.
-	printf "s/0034shallow %s/0036unshallow %s/" \
+	printf "$(test_oid sed)" \
 	       "$(git -C "$REPO" rev-parse HEAD)" \
 	       "$(git -C "$REPO" rev-parse HEAD^)" \
 	       >"$HTTPD_ROOT_PATH/one-time-sed" &&
