Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AEAC2D0FB
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A97DA20675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Z5/gSQx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbgEMAy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:54:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38156 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731842AbgEMAyr (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:47 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 280A6609D3;
        Wed, 13 May 2020 00:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331286;
        bh=6rJkrrv0VdfZ0C61oMUrkMGcnJ88EB6+2EVJhWj50Pg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Z5/gSQx7pC5rrfKJfyBoT4NpzQhRyFwY9YGplJVEkd9nndQ8QX3M73nlzP0q1185l
         7QJhLEvZ9XWHzLNUt3t7sKk0dSg+zZfYAYzjHdGcC73ALQRNJoP6++WjxgQ1D6RhFr
         DvpJPkEyV88dsfEgRm8jQKt9mTrWwX9KY8ImmpyNfXmQTZF2sPWajClusYeyYgbnFo
         /DbHvH3MZIcJLi2DLa+8nnMYbb3JLf2FsTMBWQFj0U/QAVndOg3vC7Ij6s3e0U1Wjs
         no8UJ3nrvYd7vzq/8CXNoCI8hBtWlhCEpEC4T3XEBll5GJ9S4VzIolx6ou8xAudlf+
         YmffVtBZ2VFWLCT5BBDFVqJbu0IK0id9q5fPY/VfGkWt3LBkArY672sxb8Z3xihYAl
         R90HyLO0pvK9l1S4bAHmYLmek87GOg8+Z2EjetePC4D5r3oz1JImQu/wf5mxSh5Uwc
         4chL2L2T7SNDy+1gzuoMrzQhH8gq2VrvkVvgROD9sPGl43JNf4F
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 20/44] t5562: pass object-format in synthesized test data
Date:   Wed, 13 May 2020 00:54:00 +0000
Message-Id: <20200513005424.81369-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ensure that we pass the object-format capability in the synthesized test
data so that this test works with algorithms other than SHA-1.

In addition, add an additional test using the old data for when we're
using SHA-1 so that we can be sure that we preserve backwards
compatibility with servers not offering the object-format capability.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5562-http-backend-content-length.sh | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index 3f4ac71f83..f508d4d449 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -46,6 +46,7 @@ ssize_b100dots() {
 }
 
 test_expect_success 'setup' '
+	test_oid_init &&
 	HTTP_CONTENT_ENCODING="identity" &&
 	export HTTP_CONTENT_ENCODING &&
 	git config http.receivepack true &&
@@ -62,8 +63,8 @@ test_expect_success 'setup' '
 	test_copy_bytes 10 <fetch_body >fetch_body.trunc &&
 	hash_next=$(git commit-tree -p HEAD -m next HEAD^{tree}) &&
 	{
-		printf "%s %s refs/heads/newbranch\\0report-status\\n" \
-			"$ZERO_OID" "$hash_next" | packetize &&
+		printf "%s %s refs/heads/newbranch\\0report-status object-format=%s\\n" \
+			"$ZERO_OID" "$hash_next" "$(test_oid algo)" | packetize &&
 		printf 0000 &&
 		echo "$hash_next" | git pack-objects --stdout
 	} >push_body &&
@@ -117,6 +118,15 @@ test_expect_success GZIP 'push plain' '
 	test_cmp act.head exp.head
 '
 
+test_expect_success GZIP 'push plain with SHA-1' '
+	test_when_finished "git branch -D newbranch" &&
+	test_http_env receive push_body &&
+	verify_http_result "200 OK" &&
+	git rev-parse newbranch >act.head &&
+	echo "$hash_next" >exp.head &&
+	test_cmp act.head exp.head
+'
+
 test_expect_success 'push plain truncated' '
 	test_http_env receive push_body.trunc &&
 	! verify_http_result "200 OK"
