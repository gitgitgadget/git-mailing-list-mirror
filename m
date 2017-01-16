Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 311AE20A17
	for <e@80x24.org>; Mon, 16 Jan 2017 21:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbdAPVei (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 16:34:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:39864 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751680AbdAPVef (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 16:34:35 -0500
Received: (qmail 20784 invoked by uid 109); 16 Jan 2017 21:34:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 21:34:23 +0000
Received: (qmail 12382 invoked by uid 111); 16 Jan 2017 21:35:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 16:35:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jan 2017 16:34:21 -0500
Date:   Mon, 16 Jan 2017 16:34:21 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 5/6] fsck: do not fallback "git fsck <bogus>" to "git fsck"
Message-ID: <20170116213420.d3e6ziu4gt3app4x@sigill.intra.peff.net>
References: <20170116212231.ojoqzlajpszifaf3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170116212231.ojoqzlajpszifaf3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since fsck tries to continue as much as it can after seeing
an error, we still do the reachability check even if some
heads we were given on the command-line are bogus. But if
_none_ of the heads is is valid, we fallback to checking all
refs and the index, which is not what the user asked for at
all.

Instead of checking "heads", the number of successful heads
we got, check "argc" (which we know only has non-options in
it, because parse_options removed the others).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c  |  2 +-
 t/t1450-fsck.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index c7d0590e5..8ae065b2d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -778,7 +778,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	 * default ones from .git/refs. We also consider the index file
 	 * in this case (ie this implies --cache).
 	 */
-	if (!heads) {
+	if (!argc) {
 		get_default_heads();
 		keep_cache_objects = 1;
 	}
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 2f3b05276..96b74dc9a 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -610,4 +610,15 @@ test_expect_success 'fsck $name notices bogus $name' '
 	test_must_fail git fsck $_z40
 '
 
+test_expect_success 'bogus head does not fallback to all heads' '
+	# set up a case that will cause a reachability complaint
+	echo to-be-deleted >foo &&
+	git add foo &&
+	blob=$(git rev-parse :foo) &&
+	test_when_finished "git rm --cached foo" &&
+	remove_object $blob &&
+	test_must_fail git fsck $_z40 >out 2>&1 &&
+	! grep $blob out
+'
+
 test_done
-- 
2.11.0.642.gd6f8cda6c

