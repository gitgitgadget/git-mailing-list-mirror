Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05006C433FE
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E13FD61265
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346159AbhIXSdz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:33:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:54614 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346152AbhIXSdw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:33:52 -0400
Received: (qmail 19050 invoked by uid 109); 24 Sep 2021 18:32:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 18:32:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11005 invoked by uid 111); 24 Sep 2021 18:32:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 14:32:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 14:32:17 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 01/16] t7900: clean up some more broken refs
Message-ID: <YU4Zse+dAeDg8RqV@coredump.intra.peff.net>
References: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "incremental-repack task" test replaces the object directory with a
known state. As a result, some of our refs point to objects that are not
included in that state.

Commit 3cf5f221be (t7900: clean up some broken refs, 2021-01-19) cleaned
up some of those (that were causing warnings to stderr from the
maintenance process). But there are a few more that were missed. These
aren't hurting anything for now, but it's certainly an unexpected state
to leave the test repository in, and it will become a problem if repack
ever gets more picky about broken refs.

Let's clean up those additional refs (which are all in refs/remotes,
with nothing there that isn't broken), and add an extra "for-each-ref"
call to assert that we've got everything.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7900-maintenance.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 36a4218745..31245f6276 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -277,7 +277,7 @@ test_expect_success 'incremental-repack task' '
 
 	# Delete refs that have not been repacked in these packs.
 	git for-each-ref --format="delete %(refname)" \
-		refs/prefetch refs/tags >refs &&
+		refs/prefetch refs/tags refs/remotes >refs &&
 	git update-ref --stdin <refs &&
 
 	# Replace the object directory with this pack layout.
@@ -286,6 +286,10 @@ test_expect_success 'incremental-repack task' '
 	ls $packDir/*.pack >packs-before &&
 	test_line_count = 3 packs-before &&
 
+	# make sure we do not have any broken refs that were
+	# missed in the deletion above
+	git for-each-ref &&
+
 	# the job repacks the two into a new pack, but does not
 	# delete the old ones.
 	git maintenance run --task=incremental-repack &&
-- 
2.33.0.1071.gb37e412355

