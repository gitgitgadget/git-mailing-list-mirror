Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8539C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9289961269
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345353AbhIXShx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:37:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:54632 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344684AbhIXShw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:37:52 -0400
Received: (qmail 19078 invoked by uid 109); 24 Sep 2021 18:36:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 18:36:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11051 invoked by uid 111); 24 Sep 2021 18:36:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 14:36:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 14:36:18 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 05/16] t5312: create bogus ref as necessary
Message-ID: <YU4aoicz2qXWCle5@coredump.intra.peff.net>
References: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests in t5312 create an illegally-named ref, and then see how
various operations handle it. But between those operations, we also do
some more setup (e.g., repacking), and we are subtly depending on how
those setup steps react to the illegal ref.

To future-proof us against those behaviors changing, let's instead
create and clean up our bogus ref on demand in the tests that need it.

This has two small extra advantages:

 - the tests are more stand-alone; we do not need an extra test to clean
   up the ref before moving on to other parts of the script

 - the creation and cleanup is together in one helper function. Because
   these depend on touching the refs in the filesystem directly, they
   may need to be tweaked for a world with alternate backends (they have
   not been noticed so far in the reftable work because with a non-file
   backend the tests don't fail; they simply become uninteresting noops
   because the broken ref isn't read at all).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5312-prune-corruption.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index 165cc80fa4..0704f3e930 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -18,18 +18,23 @@ test_expect_success 'disable reflogs' '
 	git reflog expire --expire=all --all
 '
 
+create_bogus_ref () {
+	test_when_finished 'rm -f .git/refs/heads/bogus..name' &&
+	echo $bogus >.git/refs/heads/bogus..name
+}
+
 test_expect_success 'create history reachable only from a bogus-named ref' '
 	test_tick && git commit --allow-empty -m main &&
 	base=$(git rev-parse HEAD) &&
 	test_tick && git commit --allow-empty -m bogus &&
 	bogus=$(git rev-parse HEAD) &&
 	git cat-file commit $bogus >saved &&
-	echo $bogus >.git/refs/heads/bogus..name &&
 	git reset --hard HEAD^
 '
 
 test_expect_success 'pruning does not drop bogus object' '
 	test_when_finished "git hash-object -w -t commit saved" &&
+	create_bogus_ref &&
 	test_might_fail git prune --expire=now &&
 	git cat-file -e $bogus
 '
@@ -42,17 +47,13 @@ test_expect_success 'put bogus object into pack' '
 '
 
 test_expect_success 'destructive repack keeps packed object' '
+	create_bogus_ref &&
 	test_might_fail git repack -Ad --unpack-unreachable=now &&
 	git cat-file -e $bogus &&
 	test_might_fail git repack -ad &&
 	git cat-file -e $bogus
 '
 
-# subsequent tests will have different corruptions
-test_expect_success 'clean up bogus ref' '
-	rm .git/refs/heads/bogus..name
-'
-
 # We create two new objects here, "one" and "two". Our
 # main branch points to "two", which is deleted,
 # corrupting the repository. But we'd like to make sure
-- 
2.33.0.1071.gb37e412355

