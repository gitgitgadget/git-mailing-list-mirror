Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DABAC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 044AD61260
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346241AbhIXSiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:38:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:54648 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346163AbhIXSiq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:38:46 -0400
Received: (qmail 19098 invoked by uid 109); 24 Sep 2021 18:37:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 18:37:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11075 invoked by uid 111); 24 Sep 2021 18:37:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 14:37:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 14:37:11 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 07/16] t5312: be more assertive about command failure
Message-ID: <YU4a19JXV67wsV+o@coredump.intra.peff.net>
References: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When repacking or pruning in a corrupted repository, our tests in t5312
argue that it is OK to complete the operation or bail, as long as we
don't actually delete the objects pointed to by the corruption.

This isn't a wrong line of reasoning, but the tests are a bit permissive
by using test_might_fail. The fact is that we _do_ bail currently, and
if we ever stopped doing so, that would be worthy of a human
investigating. So let's switch these to test_must_fail.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5312-prune-corruption.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index c7010fb754..1522a4ba8e 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -7,6 +7,9 @@ if we see, for example, a ref with a bogus name, it is OK either to
 bail out or to proceed using it as a reachable tip, but it is _not_
 OK to proceed as if it did not exist. Otherwise we might silently
 delete objects that cannot be recovered.
+
+Note that we do assert command failure in these cases, because that is
+what currently happens. If that changes, these tests should be revisited.
 '
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
@@ -35,7 +38,7 @@ test_expect_success 'create history reachable only from a bogus-named ref' '
 test_expect_success 'pruning does not drop bogus object' '
 	test_when_finished "git hash-object -w -t commit saved" &&
 	create_bogus_ref &&
-	test_might_fail git prune --expire=now &&
+	test_must_fail git prune --expire=now &&
 	git cat-file -e $bogus
 '
 
@@ -53,9 +56,9 @@ test_expect_success 'non-destructive repack ignores bogus name' '
 
 test_expect_success 'destructive repack keeps packed object' '
 	create_bogus_ref &&
-	test_might_fail git repack -Ad --unpack-unreachable=now &&
+	test_must_fail git repack -Ad --unpack-unreachable=now &&
 	git cat-file -e $bogus &&
-	test_might_fail git repack -ad &&
+	test_must_fail git repack -ad &&
 	git cat-file -e $bogus
 '
 
@@ -83,7 +86,7 @@ test_expect_success 'create history with missing tip commit' '
 
 test_expect_success 'pruning with a corrupted tip does not drop history' '
 	test_when_finished "git hash-object -w -t commit saved" &&
-	test_might_fail git prune --expire=now &&
+	test_must_fail git prune --expire=now &&
 	git cat-file -e $recoverable
 '
 
-- 
2.33.0.1071.gb37e412355

