Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C78E1F829
	for <e@80x24.org>; Tue,  2 May 2017 08:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbdEBIng (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 04:43:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:43722 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751411AbdEBInc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 04:43:32 -0400
Received: (qmail 5137 invoked by uid 109); 2 May 2017 08:43:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 May 2017 08:43:28 +0000
Received: (qmail 10595 invoked by uid 111); 2 May 2017 08:43:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 May 2017 04:43:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 May 2017 04:43:26 -0400
Date:   Tue, 2 May 2017 04:43:26 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] pack-objects: disable pack reuse for object-selection options
Message-ID: <20170502084326.65eisqmr4th5cbf7@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If certain options like --honor-pack-keep, --local, or
--incremental are used with pack-objects, then we need to
feed each potential object to want_object_in_pack() to see
if it should be filtered out.  This is totally contrary to
the purpose of the pack-reuse optimization, which tries hard
to avoid doing any per-object work.  Therefore we need to
disable this optimization when these options are in use.

This bug has been present since the inception of the
pack-reuse code, but was unlikely to come up in practice.
These options are generally used for on-disk packing, not
transfer packs (which go to stdout), but we've never allowed
pack reuse for non-stdout packs (until 645c432d6, we did not
even use bitmaps, which the reuse optimization relies on;
after that, we explicitly turned it off when not packing to
stdout).

There are tests in t5310 that check these options with
bitmaps and --stdout, but they didn't catch the bug, and
it's hard to adapt them to do so.

One problem is that they don't use --delta-base-offset;
without that option, we always disable the reuse
optimization entirely. It would be fine to add it in (it
actually makes the test more realistic), but that still
isn't quite enough.

Another problem is that the reuse code is very picky; it
only kicks in when it can reuse most of a pack, starting
from the first byte. So we'd have to start from a fully
repacked and bitmapped state to trigger it. But the tests
for these options use a much more subtle state; they want to
be sure that the want_object_in_pack() code is allowing some
objects but not others. Doing a full repack runs counter to
that.

So this patch adds new tests at the end of the script which
create the fully-packed state and make sure that each option
is not fooled by reusable pack.

Signed-off-by: Jeff King <peff@peff.net>
---
I happened to notice this because I have a series which makes the reuse
code much less picky (it kicks in more often, and can even convert to
non-ofs-delta clients on the fly). And it fails the tests when merged
with 702d1b958 (pack-objects: respect --local/--honor-pack-keep/--incremental
when bitmap is in use, 2016-09-10).

But the bug is much older than that.  So this isn't at all urgent for
v2.13.

 builtin/pack-objects.c  |  6 +++++-
 t/t5310-pack-bitmaps.sh | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0fe35d1b5..50e01aa80 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2717,7 +2717,11 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
  */
 static int pack_options_allow_reuse(void)
 {
-	return pack_to_stdout && allow_ofs_delta;
+	return pack_to_stdout &&
+	       allow_ofs_delta &&
+	       !ignore_packed_keep &&
+	       (!local || !have_non_local_packs) &&
+	       !incremental;
 }
 
 static int get_object_list_from_bitmap(struct rev_info *revs)
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 424bec7d7..c3ddfa217 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -289,4 +289,42 @@ test_expect_success 'splitting packs does not generate bogus bitmaps' '
 	git -C no-bitmaps.git fetch .. HEAD
 '
 
+test_expect_success 'set up reusable pack' '
+	rm -f .git/objects/pack/*.keep &&
+	git repack -adb &&
+	reusable_pack () {
+		git for-each-ref --format="%(objectname)" |
+		git pack-objects --delta-base-offset --revs --stdout "$@"
+	}
+'
+
+test_expect_success 'pack reuse respects --honor-pack-keep' '
+	test_when_finished "rm -f .git/objects/pack/*.keep" &&
+	for i in .git/objects/pack/*.pack; do
+		>${i%.pack}.keep
+	done &&
+	reusable_pack --honor-pack-keep >empty.pack &&
+	git index-pack empty.pack &&
+	>expect &&
+	git show-index <empty.idx >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pack reuse respects --local' '
+	mv .git/objects/pack/* alt.git/objects/pack/ &&
+	test_when_finished "mv alt.git/objects/pack/* .git/objects/pack/" &&
+	reusable_pack --local >empty.pack &&
+	git index-pack empty.pack &&
+	>expect &&
+	git show-index <empty.idx >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pack reuse respects --incremental' '
+	reusable_pack --incremental >empty.pack &&
+	git index-pack empty.pack &&
+	>expect &&
+	git show-index <empty.idx >actual &&
+	test_cmp expect actual
+'
 test_done
-- 
2.13.0.rc1.437.g927e4246e
