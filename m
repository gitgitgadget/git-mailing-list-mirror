Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068C7C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 23:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D91966104F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 23:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbhHKXRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 19:17:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41124 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232763AbhHKXRY (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Aug 2021 19:17:24 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B9C7160752;
        Wed, 11 Aug 2021 23:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1628723819;
        bh=PN7wCc1cSgksFvehe+VxBXyt/ZCQwb6pylfAlKhNxJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=sI0l/AhT3iVkIiWUiVAERatL5Sq6dtOuLVBV+xZ/rLBJnWw8QjEj7K6pXPweMoFki
         IyIFVR4r1E0fV2srE5ijJgKiHggRd5763TOTNiXZgFjpGzkNO6u5uGlbMZ91ak1zP3
         NPRmjVWQDpqL8UywDfJrjox4rc7aLOAaAgDE1y58944QpkQvRvAjOmeTHKLCnIIeCw
         fkio97/R6gLV1Pgb+my10yywADoHQ3YhLKEtlS9t6STRn3lK72UC/FslcF4OKt3lu6
         tw8m1vfTgk5PnddfVwom6rcf2wqWB0OjE8NhCkGJFFF1pYP7VqOyFxnIaoQyOCyjCp
         t5tNVLbmlmQZgGVVYq0NeIhAUA3wdGWSmJEvaP5irq2xafI1DYXdVfCILp6RayRTGY
         1X5rROHL+EfVFKMd+KYKemYYHA+llwmYXkdMkZEhR71aC93wwpiG/bwn0r/aO8lrtV
         HbeggRWrb58JexVGE7TOPVQiXXEL3KOtGjeLvy8VoeOCem+P3BE
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Son Luong Ngoc <sluongng@gmail.com>
Subject: [PATCH v2] t5607: avoid using prerequisites to select algorithm
Date:   Wed, 11 Aug 2021 23:16:44 +0000
Message-Id: <20210811231644.570030-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.32.0.272.g935e593368
In-Reply-To: <YRRZ7E6W+xV2f/CG@camp.crustytoothpaste.net>
References: <YRRZ7E6W+xV2f/CG@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this test, we currently use the SHA1 prerequisite to specify the
algorithm we're using to test, since SHA-256 bundles are always v3,
whereas SHA-1 bundles default to v2, and as a result the default output
differs.

However, this causes a problem if we run with GIT_TEST_FAIL_PREREQS set,
since that means that we'll unexpectedly fail the SHA1 prerequisite,
resulting in incorrect expected output.  Let's fix this by checking
against the built-in data called "algo", which tells us which algorithm
is in use.  This should work in any situation, making our test a little
more robust.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5607-clone-bundle.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index ed0d911e95..51705aa86a 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -91,7 +91,8 @@ test_expect_success 'ridiculously long subject in boundary' '
 
 	git fetch long-subject-bundle.bdl &&
 
-	if ! test_have_prereq SHA1
+	algo=$(test_oid algo) &&
+	if test "$algo" != sha1
 	then
 		echo "@object-format=sha256"
 	fi >expect &&
@@ -100,7 +101,7 @@ test_expect_success 'ridiculously long subject in boundary' '
 	$(git rev-parse HEAD) HEAD
 	EOF
 
-	if test_have_prereq SHA1
+	if test "$algo" = sha1
 	then
 		head -n 3 long-subject-bundle.bdl
 	else
