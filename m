Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2625520985
	for <e@80x24.org>; Tue, 13 Sep 2016 03:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754083AbcIMDXc (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 23:23:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:42273 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753299AbcIMDXa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 23:23:30 -0400
Received: (qmail 20230 invoked by uid 109); 13 Sep 2016 03:23:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 03:23:25 +0000
Received: (qmail 18434 invoked by uid 111); 13 Sep 2016 03:23:34 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 23:23:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2016 20:23:22 -0700
Date:   Mon, 12 Sep 2016 20:23:22 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 03/16] patch-id: use RUN_SETUP_GENTLY
Message-ID: <20160913032321.cv6732hyzv3d4z57@sigill.intra.peff.net>
References: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patch-id does not require a repository because it is just
processing the incoming diff on stdin, but it may look at
git config for keys like patchid.stable.

Even though we do not setup_git_directory(), this works from
the top-level of a repository because we blindly look at
".git/config" in this case. But as the included test
demonstrates, it does not work from a subdirectory.

We can fix it by using RUN_SETUP_GENTLY. We do not take any
filenames from the user on the command line, so there's no
need to adjust them via prefix_filename().

Signed-off-by: Jeff King <peff@peff.net>
---
 git.c               |  2 +-
 t/t4204-patch-id.sh | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/git.c b/git.c
index 1c61151..ab5c99c 100644
--- a/git.c
+++ b/git.c
@@ -444,7 +444,7 @@ static struct cmd_struct commands[] = {
 	{ "pack-objects", cmd_pack_objects, RUN_SETUP },
 	{ "pack-redundant", cmd_pack_redundant, RUN_SETUP },
 	{ "pack-refs", cmd_pack_refs, RUN_SETUP },
-	{ "patch-id", cmd_patch_id },
+	{ "patch-id", cmd_patch_id, RUN_SETUP_GENTLY },
 	{ "pickaxe", cmd_blame, RUN_SETUP },
 	{ "prune", cmd_prune, RUN_SETUP },
 	{ "prune-packed", cmd_prune_packed, RUN_SETUP },
diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index 84a8096..0288c17 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -143,6 +143,20 @@ test_expect_success 'patch-id supports git-format-patch MIME output' '
 	test_cmp patch-id_master patch-id_same
 '
 
+test_expect_success 'patch-id respects config from subdir' '
+	test_config patchid.stable true &&
+	mkdir subdir &&
+
+	# copy these because test_patch_id() looks for them in
+	# the current directory
+	cp bar-then-foo foo-then-bar subdir &&
+
+	(
+		cd subdir &&
+		test_patch_id irrelevant patchid.stable=true
+	)
+'
+
 cat >nonl <<\EOF
 diff --git i/a w/a
 index e69de29..2e65efe 100644
-- 
2.10.0.230.g6f8d04b

