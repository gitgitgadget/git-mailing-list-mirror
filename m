Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C571C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F3960F21
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346078AbhIXSeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:34:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:54620 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345073AbhIXSee (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:34:34 -0400
Received: (qmail 19058 invoked by uid 109); 24 Sep 2021 18:33:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 18:33:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11016 invoked by uid 111); 24 Sep 2021 18:33:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 14:33:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 14:33:00 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 02/16] t5516: don't use HEAD ref for invalid ref-deletion
 tests
Message-ID: <YU4Z3As2RoBeUbJa@coredump.intra.peff.net>
References: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few tests in t5516 want to assert that we can delete a corrupted ref
whose pointed-to object is missing. They do so by using the "main"
branch, which is also pointed to by HEAD.

This does work, but only because of a subtle assumption about the
implementation. We do not block the deletion because of the invalid ref,
but we _also_ do not notice that the deleted branch is pointed to by
HEAD. And so the safety rule of "do not allow HEAD to be deleted in a
non-bare repository" does not kick in, and the test passes.

Let's instead use a non-HEAD branch. That still tests what we care about
here (deleting a corrupt ref), but without implicitly depending on our
failure to notice that we're deleting HEAD. That will future proof the
test against that behavior changing.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5516-fetch-push.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4db8edd9c8..b13553ecf4 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -662,10 +662,10 @@ test_expect_success 'push does not update local refs on failure' '
 
 test_expect_success 'allow deleting an invalid remote ref' '
 
-	mk_test testrepo heads/main &&
+	mk_test testrepo heads/branch &&
 	rm -f testrepo/.git/objects/??/* &&
-	git push testrepo :refs/heads/main &&
-	(cd testrepo && test_must_fail git rev-parse --verify refs/heads/main)
+	git push testrepo :refs/heads/branch &&
+	(cd testrepo && test_must_fail git rev-parse --verify refs/heads/branch)
 
 '
 
@@ -706,25 +706,25 @@ test_expect_success 'pushing valid refs triggers post-receive and post-update ho
 '
 
 test_expect_success 'deleting dangling ref triggers hooks with correct args' '
-	mk_test_with_hooks testrepo heads/main &&
+	mk_test_with_hooks testrepo heads/branch &&
 	rm -f testrepo/.git/objects/??/* &&
-	git push testrepo :refs/heads/main &&
+	git push testrepo :refs/heads/branch &&
 	(
 		cd testrepo/.git &&
 		cat >pre-receive.expect <<-EOF &&
-		$ZERO_OID $ZERO_OID refs/heads/main
+		$ZERO_OID $ZERO_OID refs/heads/branch
 		EOF
 
 		cat >update.expect <<-EOF &&
-		refs/heads/main $ZERO_OID $ZERO_OID
+		refs/heads/branch $ZERO_OID $ZERO_OID
 		EOF
 
 		cat >post-receive.expect <<-EOF &&
-		$ZERO_OID $ZERO_OID refs/heads/main
+		$ZERO_OID $ZERO_OID refs/heads/branch
 		EOF
 
 		cat >post-update.expect <<-EOF &&
-		refs/heads/main
+		refs/heads/branch
 		EOF
 
 		test_cmp pre-receive.expect pre-receive.actual &&
-- 
2.33.0.1071.gb37e412355

