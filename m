Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D09A31F732
	for <e@80x24.org>; Wed, 31 Jul 2019 05:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfGaFk5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 01:40:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:56574 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726597AbfGaFk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 01:40:57 -0400
Received: (qmail 11777 invoked by uid 109); 31 Jul 2019 05:40:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 05:40:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14011 invoked by uid 111); 31 Jul 2019 05:42:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 01:42:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 01:40:56 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Gregory Szorc <gregory.szorc@gmail.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
Subject: [PATCH 3/3] repack: simplify handling of auto-bitmaps and .keep files
Message-ID: <20190731054055.GC16941@sigill.intra.peff.net>
References: <20190731053703.GA16709@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190731053703.GA16709@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 7328482253 (repack: disable bitmaps-by-default if .keep files
exist, 2019-06-29) taught repack to prefer disabling bitmaps to
duplicating objects (unless bitmaps were asked for explicitly).

But there's an easier way to do this: if we keep passing the
--honor-pack-keep flag to pack-objects when auto-enabling bitmaps, then
pack-objects already makes the same decision (it will disable bitmaps
rather than duplicate). Better still, pack-objects can actually decide
to do so based not just on the presence of a .keep file, but on whether
that .keep file actually impacts the new pack we're making (so if we're
racing with a push or fetch, for example, their temporary .keep file
will not block us from generating bitmaps if they haven't yet updated
their refs).

And because repack uses the --write-bitmap-index-quiet flag, we don't
have to worry about pack-objects generating confusing warnings when it
does see a .keep file. We can confirm this by tweaking the .keep test to
check repack's stderr.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/repack.c  | 17 ++---------------
 t/t7700-repack.sh |  3 ++-
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index db93ca3660..632c0c0a79 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -89,17 +89,6 @@ static void remove_pack_on_signal(int signo)
 	raise(signo);
 }
 
-static int has_pack_keep_file(void)
-{
-	struct packed_git *p;
-
-	for (p = get_all_packs(the_repository); p; p = p->next) {
-		if (p->pack_keep)
-			return 1;
-	}
-	return 0;
-}
-
 /*
  * Adds all packs hex strings to the fname list, which do not
  * have a corresponding .keep file. These packs are not to
@@ -346,13 +335,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	if (write_bitmaps < 0) {
 		if (!(pack_everything & ALL_INTO_ONE) ||
-		    !is_bare_repository() ||
-		    keep_pack_list.nr != 0 ||
-		    has_pack_keep_file())
+		    !is_bare_repository())
 			write_bitmaps = 0;
 	}
 	if (pack_kept_objects < 0)
-		pack_kept_objects = !!write_bitmaps;
+		pack_kept_objects = write_bitmaps > 0;
 
 	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE))
 		die(_(incremental_bitmap_conflict_error));
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 54f815b8b9..4e855bc21b 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -245,7 +245,8 @@ test_expect_success 'no bitmaps created if .keep files present' '
 	keep=${pack%.pack}.keep &&
 	test_when_finished "rm -f \"\$keep\"" &&
 	>"$keep" &&
-	git -C bare.git repack -ad &&
+	git -C bare.git repack -ad 2>stderr &&
+	test_must_be_empty stderr &&
 	find bare.git/objects/pack/ -type f -name "*.bitmap" >actual &&
 	test_must_be_empty actual
 '
-- 
2.23.0.rc0.426.gbdee707ba7
