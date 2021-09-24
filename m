Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAB9C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22CC461268
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345531AbhIXSfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:35:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:54624 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345073AbhIXSfj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:35:39 -0400
Received: (qmail 19064 invoked by uid 109); 24 Sep 2021 18:34:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 18:34:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11020 invoked by uid 111); 24 Sep 2021 18:34:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 14:34:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 14:34:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 03/16] t5600: provide detached HEAD for corruption failures
Message-ID: <YU4aHBX/cMht6rRX@coredump.intra.peff.net>
References: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When checking how git-clone behaves when it fails, we stimulate some
failures by trying to do a clone from a local repository whose objects
have been removed. Because these clones use local optimizations, there's
a subtle dependency in how the corruption is handled on the sending
side.

If upload-pack does not show us the broken refs (which it does not
currently), then we see only HEAD (which is itself broken), and clone
that as a detached HEAD. When we try to write the ref, we notice that we
never got the object and bail.

But if upload-pack _does_ show us the broken refs (which it may in a
future patch), then we'll realize that HEAD is a symref and just write
that. You'd think we'd fail when writing out the refs themselves, but we
don't; we do a bulk write and skip the connectivity check because of our
--local optimizations. For the non-bare case, we do notice the problem
when we try to checkout. But for a bare repository, we unexpectedly
complete the clone successfully!

At first glance this may seem like a bug. But the whole point of those
local optimizations is to give up some safety for speed. If you want to
be careful, you should be using "--no-local", which would notice that
the pack did not transfer sufficient objects. We could do that in these
tests, but part of the point is for them to fail at specific moments
(and indeed, we have a later test that checks for transport failure).

However, we can make this less subtle and future-proof it against
changes on the upload-pack side by just having an explicit detached
HEAD in the corrupted repo. Now we'll fail as expected during the ref
write if any ref _or_ HEAD is corrupt, whether we're --bare or not.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5600-clone-fail-cleanup.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup.sh
index 5bf10261d3..34b3df4027 100755
--- a/t/t5600-clone-fail-cleanup.sh
+++ b/t/t5600-clone-fail-cleanup.sh
@@ -35,7 +35,9 @@ test_expect_success 'create a repo to clone' '
 '
 
 test_expect_success 'create objects in repo for later corruption' '
-	test_commit -C foo file
+	test_commit -C foo file &&
+	git -C foo checkout --detach &&
+	test_commit -C foo detached
 '
 
 # source repository given to git clone should be relative to the
-- 
2.33.0.1071.gb37e412355

