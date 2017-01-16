Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 619B820A17
	for <e@80x24.org>; Mon, 16 Jan 2017 21:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751229AbdAPVYH (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 16:24:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:39846 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750968AbdAPVYG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 16:24:06 -0500
Received: (qmail 20138 invoked by uid 109); 16 Jan 2017 21:24:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 21:24:06 +0000
Received: (qmail 12324 invoked by uid 111); 16 Jan 2017 21:24:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 16:24:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jan 2017 16:24:03 -0500
Date:   Mon, 16 Jan 2017 16:24:03 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/6] t1450: clean up sub-objects in duplicate-entry test
Message-ID: <20170116212403.l7ca7crmt47id3mu@sigill.intra.peff.net>
References: <20170116212231.ojoqzlajpszifaf3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170116212231.ojoqzlajpszifaf3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test creates a multi-level set of trees, but its
cleanup routine only removes the top-level tree. After the
test finishes, the inner tree and the blob it points to
remain, making the inner tree dangling.

A later test ("cleaned up") verifies that we've removed any
cruft and "git fsck" output is clean. This passes only
because of a bug in git-fsck which fails to notice dangling
trees.

In preparation for fixing the bug, let's teach this earlier
test to clean up after itself correctly. We have to remove
the inner tree (and therefore the blob, too, which becomes
dangling after removing that tree).

Since the setup code happens inside a subshell, we can't
just set a variable for each object. However, we can stuff
all of the sha1s into the $T output variable, which is not
used for anything except cleanup.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1450-fsck.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index ee7d4736d..6eef8b28e 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -189,14 +189,16 @@ test_expect_success 'commit with NUL in header' '
 '
 
 test_expect_success 'tree object with duplicate entries' '
-	test_when_finished "remove_object \$T" &&
+	test_when_finished "for i in \$T; do remove_object \$i; done" &&
 	T=$(
 		GIT_INDEX_FILE=test-index &&
 		export GIT_INDEX_FILE &&
 		rm -f test-index &&
 		>x &&
 		git add x &&
+		git rev-parse :x &&
 		T=$(git write-tree) &&
+		echo $T &&
 		(
 			git cat-file tree $T &&
 			git cat-file tree $T
-- 
2.11.0.642.gd6f8cda6c

