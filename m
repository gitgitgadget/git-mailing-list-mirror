Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D17C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9987C20738
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="nuHtQ6Lf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391638AbgFWVWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:22:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40134 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388978AbgFWUVj (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Jun 2020 16:21:39 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 525066048A;
        Tue, 23 Jun 2020 20:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592943698;
        bh=XXHOeBvvuIg5rOdJVT9dfP5epCWfpKXhtPUR8jCvpBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=nuHtQ6LfXsPFwMkI5tEmawC9UnpYEgdkUYt6IlZpQaa71WK33d7U2X2n3AUTS1wnK
         TZaIOffB2xCUXFXf6+Lzw4or/QM4w1aoMa3QteoKh64DavGM/1W18FHjGP5eAkahsb
         4SppkY+tT3SGrkGArJVYHeAHqyWLMPXeUmghqgMTohRTscYSuzExA4ecFf+srTy9Cs
         JR7qHkYV93XdUYyE/5PjgZ5yqITnh4iyXhVjJYCFCeHYtfFhF8LwCC5x7u9a0bejuX
         34hhVjJFMyvz7ZPpr24IFH80EoS3SogBvREsSnRhIaeT0vuCBJNsNPhmy4rQ7hqw1i
         D/r89t2NqSsR2HiUi70M7wbPQRvoCCu4RM192QaPIbKU2nvgeQM9cxlsb7q5qRsp6y
         sDzMxkzvGjC3W8R/yTLg9ceXBdpvq3gw07jJ7rLjS6EiE3nqfA9Wc+6L6EGhiWAtE0
         CCNiLIQ9o0ra18P/kp2WHN1uiJCw0Y6J2fLgukd/uSB3hMUjJ58
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Ward <mward@smartsoftwareinc.com>
Subject: [PATCH] http-push: ensure unforced pushes fail when data would be lost
Date:   Tue, 23 Jun 2020 20:21:29 +0000
Message-Id: <20200623202129.2616672-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200623010519.GR6531@camp.crustytoothpaste.net>
References: <20200623010519.GR6531@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we push using the DAV-based protocol, the client is the one that
performs the ref updates and therefore makes the checks to see whether
an unforced push should be allowed.  We make this check by determining
if either (a) we lack the object file for the old value of the ref or
(b) the new value of the ref is not newer than the old value, and in
either case, reject the push.

However, the ref_newer function, which performs this latter check, has
an odd behavior due to the reuse of certain object flags.  Specifically,
it will incorrectly return false in its first invocation and then
correctly return true on a subsequent invocation.  This occurs because
the object flags used by http-push.c are the same as those used by
commit-reach.c, which implements ref_newer, and one piece of code
misinterprets the flags set by the other.

Note that this does not occur in all cases.  For example, if the example
used in the tests is changed to use one repository instead of two and
rewind the head to add a commit, the test passes and we correctly reject
the push.  However, the example provided does trigger this behavior, and
the code has been broken in this way since at least Git 2.0.0.

To solve this problem, let's move the two sets of object flags so that
they don't overlap, since we're clearly using them at the same time.
The new set should not conflict with other usage because other users are
either builtin code (which is not compiled into git http-push) or
upload-pack (which we similarly do not use here).

Signed-off-by: René Scharfe <l.s.r@web.de>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http-push.c                 |  8 ++++----
 object.h                    |  2 +-
 t/t5540-http-push-webdav.sh | 16 ++++++++++++++++
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/http-push.c b/http-push.c
index 822f326599..99adbebdcf 100644
--- a/http-push.c
+++ b/http-push.c
@@ -70,10 +70,10 @@ enum XML_Status {
 #define LOCK_REFRESH 30
 
 /* Remember to update object flag allocation in object.h */
-#define LOCAL    (1u<<16)
-#define REMOTE   (1u<<17)
-#define FETCHING (1u<<18)
-#define PUSHING  (1u<<19)
+#define LOCAL    (1u<<11)
+#define REMOTE   (1u<<12)
+#define FETCHING (1u<<13)
+#define PUSHING  (1u<<14)
 
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define MAXDEPTH 5
diff --git a/object.h b/object.h
index b22328b838..a496d2e4e1 100644
--- a/object.h
+++ b/object.h
@@ -67,7 +67,7 @@ struct object_array {
  * builtin/blame.c:                        12-13
  * bisect.c:                                        16
  * bundle.c:                                        16
- * http-push.c:                                     16-----19
+ * http-push.c:                          11-----14
  * commit-graph.c:                                15
  * commit-reach.c:                                  16-----19
  * sha1-name.c:                                              20
diff --git a/t/t5540-http-push-webdav.sh b/t/t5540-http-push-webdav.sh
index d476c33509..450321fddb 100755
--- a/t/t5540-http-push-webdav.sh
+++ b/t/t5540-http-push-webdav.sh
@@ -126,6 +126,22 @@ test_expect_success 'create and delete remote branch' '
 	test_must_fail git show-ref --verify refs/remotes/origin/dev
 '
 
+test_expect_success 'non-force push fails if not up to date' '
+	git init --bare "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_conflict.git &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_conflict.git update-server-info &&
+	git clone $HTTPD_URL/dumb/test_repo_conflict.git "$ROOT_PATH"/c1 &&
+	git clone $HTTPD_URL/dumb/test_repo_conflict.git "$ROOT_PATH"/c2 &&
+	test_commit -C "$ROOT_PATH/c1" path1 &&
+	git -C "$ROOT_PATH/c1" push origin HEAD &&
+	git -C "$ROOT_PATH/c2" pull &&
+	test_commit -C "$ROOT_PATH/c1" path2 &&
+	git -C "$ROOT_PATH/c1" push origin HEAD &&
+	test_commit -C "$ROOT_PATH/c2" path3 &&
+	git -C "$ROOT_PATH/c1" log --graph --all &&
+	git -C "$ROOT_PATH/c2" log --graph --all &&
+	test_must_fail git -C "$ROOT_PATH/c2" push origin HEAD
+'
+
 test_expect_success 'MKCOL sends directory names with trailing slashes' '
 
 	! grep "\"MKCOL.*[^/] HTTP/[^ ]*\"" < "$HTTPD_ROOT_PATH"/access.log
