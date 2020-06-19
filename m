Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EFFC433E2
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15BD620776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="TU2zNGgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436556AbgFSR5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:57:34 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39526 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390614AbgFSR4k (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:40 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A4BC960A71;
        Fri, 19 Jun 2020 17:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589394;
        bh=uDVYhPzZg5oVXaxsTp1TA02b1tBgrRU+5xBUU4TII00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=TU2zNGgDHfvkewJU4+T9PGhX74jq6cnEniyUjwGAx+Yq3jJVSWGHXsKtJxnA2VgF8
         OwhtGSy6bpDko3G/0rf3Cx1J99gCVwBaf1KcDIiL1uyla5hFgMVuxYOSKd0bFZ+p51
         TETgZIckVrJhytNOU1TWmVcqjqHQqOsZOrglM18MMLDG67nIh+SCIdk/CVaBsripeq
         gnbbJm+GxE+dWbNB9ue7f1oq2UUtEHSBALnRM1vDhMERudRflYiv5PJ3eAwQIlo58I
         qbIR3P8jYGqa38N7Xbp9dxcdTEyF/y1bR9dHOlzwhe9YdBHW4AKjN2WisFyeb8PDml
         BoAXtyN12Neqb5G1jHUwg1z0RtkqXqQvv1J8iJLhExrulQdW3h//hW18e/z9lXwvaT
         kf+W6cio1SdOLuDTNrdBFxFMUCbgLd+ngfG9HzLVoR11NIJhAJuASz+OZ4kc4T9vGc
         eIVysORicuQzy/0+iKVMtWUMGXGG3D8nmsjTmXXNfSkUIuAghRj
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 40/44] t5703: use object-format serve option
Date:   Fri, 19 Jun 2020 17:55:57 +0000
Message-Id: <20200619175601.569856-41-sandals@crustytoothpaste.net>
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

When we're using an algorithm other than SHA-1, we need to specify the
algorithm in use so we don't get a failure with an "unknown format"
message. Add a wrapper function that specifies this header if required.
Skip specifying this header for SHA-1 to test that it works both with an
without this header.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5703-upload-pack-ref-in-want.sh | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 92ad5eeec0..748282f058 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -27,6 +27,15 @@ check_output () {
 	test_cmp sorted_commits actual_commits
 }
 
+write_command () {
+	echo "command=$1"
+
+	if test "$(test_oid algo)" != sha1
+	then
+		echo "object-format=$(test_oid algo)"
+	fi
+}
+
 # c(o/foo) d(o/bar)
 #        \ /
 #         b   e(baz)  f(master)
@@ -65,7 +74,7 @@ test_expect_success 'config controls ref-in-want advertisement' '
 
 test_expect_success 'invalid want-ref line' '
 	test-tool pkt-line pack >in <<-EOF &&
-	command=fetch
+	$(write_command fetch)
 	0001
 	no-progress
 	want-ref refs/heads/non-existent
@@ -86,7 +95,7 @@ test_expect_success 'basic want-ref' '
 
 	oid=$(git rev-parse a) &&
 	test-tool pkt-line pack >in <<-EOF &&
-	command=fetch
+	$(write_command fetch)
 	0001
 	no-progress
 	want-ref refs/heads/master
@@ -110,7 +119,7 @@ test_expect_success 'multiple want-ref lines' '
 
 	oid=$(git rev-parse b) &&
 	test-tool pkt-line pack >in <<-EOF &&
-	command=fetch
+	$(write_command fetch)
 	0001
 	no-progress
 	want-ref refs/heads/o/foo
@@ -132,7 +141,7 @@ test_expect_success 'mix want and want-ref' '
 	git rev-parse e f >expected_commits &&
 
 	test-tool pkt-line pack >in <<-EOF &&
-	command=fetch
+	$(write_command fetch)
 	0001
 	no-progress
 	want-ref refs/heads/master
@@ -155,7 +164,7 @@ test_expect_success 'want-ref with ref we already have commit for' '
 
 	oid=$(git rev-parse c) &&
 	test-tool pkt-line pack >in <<-EOF &&
-	command=fetch
+	$(write_command fetch)
 	0001
 	no-progress
 	want-ref refs/heads/o/foo
