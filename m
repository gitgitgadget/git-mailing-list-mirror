Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81F0C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 20:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjARUg5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 15:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjARUgi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 15:36:38 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FD193FC
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 12:36:23 -0800 (PST)
Received: (qmail 3338 invoked by uid 109); 18 Jan 2023 20:36:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Jan 2023 20:36:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24937 invoked by uid 111); 18 Jan 2023 20:36:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Jan 2023 15:36:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Jan 2023 15:36:22 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 3/6] t7030: stop using invalid tag name
Message-ID: <Y8hYRn5+/zswl9Zx@coredump.intra.peff.net>
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We intentionally invalidate the signature of a tag by switching its tag
name from "seventh" to "7th forged". However, the latter is not a valid
tag name because it contains a space. This doesn't currently affect the
test, but we're better off using something syntactically valid. That
reduces the number of possible failure modes in the test, and
future-proofs us if git hash-object gets more picky about its input.

The t7031 script, which was mostly copied from t7030, has the same
problem, so we'll fix it, too.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7030-verify-tag.sh            | 2 +-
 t/t7031-verify-tag-signed-ssh.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 10faa64515..6f526c37c2 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -115,7 +115,7 @@ test_expect_success GPGSM 'verify and show signatures x509 with high minTrustLev
 
 test_expect_success GPG 'detect fudged signature' '
 	git cat-file tag seventh-signed >raw &&
-	sed -e "/^tag / s/seventh/7th forged/" raw >forged1 &&
+	sed -e "/^tag / s/seventh/7th-forged/" raw >forged1 &&
 	git hash-object -w -t tag forged1 >forged1.tag &&
 	test_must_fail git verify-tag $(cat forged1.tag) 2>actual1 &&
 	grep "BAD signature from" actual1 &&
diff --git a/t/t7031-verify-tag-signed-ssh.sh b/t/t7031-verify-tag-signed-ssh.sh
index 1cb36b9ab8..36eb86a4b1 100755
--- a/t/t7031-verify-tag-signed-ssh.sh
+++ b/t/t7031-verify-tag-signed-ssh.sh
@@ -125,7 +125,7 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag failes with tag date ou
 test_expect_success GPGSSH 'detect fudged ssh signature' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git cat-file tag seventh-signed >raw &&
-	sed -e "/^tag / s/seventh/7th forged/" raw >forged1 &&
+	sed -e "/^tag / s/seventh/7th-forged/" raw >forged1 &&
 	git hash-object -w -t tag forged1 >forged1.tag &&
 	test_must_fail git verify-tag $(cat forged1.tag) 2>actual1 &&
 	grep "${GPGSSH_BAD_SIGNATURE}" actual1 &&
-- 
2.39.1.616.gd06fca9e99

