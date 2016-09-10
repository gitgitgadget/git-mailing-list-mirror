Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93ABF1F859
	for <e@80x24.org>; Sat, 10 Sep 2016 15:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755218AbcIJPBw (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Sep 2016 11:01:52 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:57999 "EHLO
        mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754237AbcIJPBv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2016 11:01:51 -0400
Received: from teco.navytux.spb.ru (unknown [178.70.98.236])
        by mail2.tiolive.com (Postfix) with ESMTPSA id EF275BF0319;
        Sat, 10 Sep 2016 17:01:48 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
        (envelope-from <kirr@teco.navytux.spb.ru>)
        id 1bijmu-0004xx-9E; Sat, 10 Sep 2016 18:01:48 +0300
From:   Kirill Smelkov <kirr@nexedi.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
        =?UTF-8?q?J=C3=A9rome=20Perrin?= <jerome@nexedi.com>,
        Isabelle Vallet <isabelle.vallet@nexedi.com>,
        Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
        Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org,
        Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH 2/2 v8] pack-objects: use reachability bitmap index when generating non-stdout pack
Date:   Sat, 10 Sep 2016 18:01:44 +0300
Message-Id: <20160910150144.19018-1-kirr@nexedi.com>
X-Mailer: git-send-email 2.9.2.701.gf965a18.dirty
In-Reply-To: <20160910145925.xbbus7eck5ineika@teco.navytux.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Starting from 6b8fda2d (pack-objects: use bitmaps when packing objects)
if a repository has bitmap index, pack-objects can nicely speedup
"Counting objects" graph traversal phase. That however was done only for
case when resultant pack is sent to stdout, not written into a file.

The reason here is for on-disk repack by default we want:

- to produce good pack (with bitmap index not-yet-packed objects are
  emitted to pack in suboptimal order).

- to use more robust pack-generation codepath (avoiding possible
  bugs in bitmap code and possible bitmap index corruption).

Jeff King further explains:

    The reason for this split is that pack-objects tries to determine how
    "careful" it should be based on whether we are packing to disk or to
    stdout. Packing to disk implies "git repack", and that we will likely
    delete the old packs after finishing. We want to be more careful (so
    as not to carry forward a corruption, and to generate a more optimal
    pack), and we presumably run less frequently and can afford extra CPU.
    Whereas packing to stdout implies serving a remote via "git fetch" or
    "git push". This happens more frequently (e.g., a server handling many
    fetching clients), and we assume the receiving end takes more
    responsibility for verifying the data.

    But this isn't always the case. One might want to generate on-disk
    packfiles for a specialized object transfer. Just using "--stdout" and
    writing to a file is not optimal, as it will not generate the matching
    pack index.

    So it would be useful to have some way of overriding this heuristic:
    to tell pack-objects that even though it should generate on-disk
    files, it is still OK to use the reachability bitmaps to do the
    traversal.

So we can teach pack-objects to use bitmap index for initial object
counting phase when generating resultant pack file too:

- if we take care to not let it be activated under git-repack:

  See above about repack robustness and not forward-carrying corruption.

- if we know bitmap index generation is not enabled for resultant pack:

  The current code has singleton bitmap_git, so it cannot work
  simultaneously with two bitmap indices.

  We also want to avoid (at least with current implementation)
  generating bitmaps off of bitmaps. The reason here is: when generating
  a pack, not-yet-packed objects will be emitted into pack in
  suboptimal order and added to tail of the bitmap as "extended entries".
  When the resultant pack + some new objects in associated repository
  are in turn used to generate another pack with bitmap, the situation
  repeats: new objects are again not emitted optimally and just added to
  bitmap tail - not in recency order.

  So the pack badness can grow over time when at each step we have
  bitmapped pack + some other objects. That's why we want to avoid
  generating bitmaps off of bitmaps, not to let pack badness grow.

- if we keep pack reuse enabled still only for "send-to-stdout" case:

  Because pack-to-file needs to generate index for destination pack, and
  currently on pack reuse raw entries are directly written out to the
  destination pack by write_reused_pack(), bypassing needed for pack index
  generation bookkeeping done by regular codepath in write_one() and
  friends.

  ( In the future we might teach pack-reuse code about cases when index
    also needs to be generated for resultant pack and remove
    pack-reuse-only-for-stdout limitation )

This way for pack-objects -> file we get nice speedup:

    erp5.git[1] (~230MB) extracted from ~ 5GB lab.nexedi.com backup
    repository managed by git-backup[2] via

    time echo 0186ac99 | git pack-objects --revs erp5pack

before:  37.2s
after:   26.2s

And for `git repack -adb` packed git.git

    time echo 5c589a73 | git pack-objects --revs gitpack

before:   7.1s
after:    3.6s

i.e. it can be 30% - 50% speedup for pack extraction.

git-backup extracts many packs on repositories restoration. That was my
initial motivation for the patch.

[1] https://lab.nexedi.com/nexedi/erp5
[2] https://lab.nexedi.com/kirr/git-backup

NOTE

Jeff also suggests that pack.useBitmaps was probably a mistake to
introduce originally. This way we are not adding another config point,
but instead just always default to-file pack-objects not to use bitmap
index: Tools which need to generate on-disk packs with using bitmap, can
pass --use-bitmap-index explicitly. And git-repack does never pass
--use-bitmap-index, so this way we can be sure regular on-disk repacking
remains robust.

NOTE2

`git pack-objects --stdout >file.pack` + `git index-pack file.pack` is much slower
than `git pack-objects file.pack`. Extracting erp5.git pack from
lab.nexedi.com backup repository:

    $ time echo 0186ac99 | git pack-objects --stdout --revs >erp5pack-stdout.pack

    real    0m22.309s
    user    0m21.148s
    sys     0m0.932s

    $ time git index-pack erp5pack-stdout.pack

    real    0m50.873s   <-- more than 2 times slower than time to generate pack itself!
    user    0m49.300s
    sys     0m1.360s

So the time for

    `pack-object --stdout >file.pack` + `index-pack file.pack`  is  72s,

while

    `pack-objects file.pack` which does both pack and index     is  27s.

And even

    `pack-objects --no-use-bitmap-index file.pack`              is  37s.

Jeff explains:

    The packfile does not carry the sha1 of the objects. A receiving
    index-pack has to compute them itself, including inflating and applying
    all of the deltas.

that's why for `git-backup restore` we want to teach `git pack-objects
file.pack` to use bitmaps instead of using `git pack-objects --stdout
>file.pack` + `git index-pack file.pack`.

NOTE3

The speedup is now tracked via t/perf/p5310-pack-bitmaps.sh

    Test                                    56dfeb62          this tree
    --------------------------------------------------------------------------------
    5310.2: repack to disk                  8.98(8.05+0.29)   9.05(8.08+0.33) +0.8%
    5310.3: simulated clone                 2.02(2.27+0.09)   2.01(2.25+0.08) -0.5%
    5310.4: simulated fetch                 0.81(1.07+0.02)   0.81(1.05+0.04) +0.0%
    5310.5: pack to file                    7.58(7.04+0.28)   7.60(7.04+0.30) +0.3%
    5310.6: pack to file (bitmap)           7.55(7.02+0.28)   3.25(2.82+0.18) -57.0%
    5310.8: clone (partial bitmap)          1.83(2.26+0.12)   1.82(2.22+0.14) -0.5%
    5310.9: pack to file (partial bitmap)   6.86(6.58+0.30)   2.87(2.74+0.20) -58.2%

More context:

    http://marc.info/?t=146792101400001&r=1&w=2
    http://public-inbox.org/git/20160707190917.20011-1-kirr@nexedi.com/T/#t

Cc: Vicent Marti <tanoku@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-objects.c       | 31 ++++++++++++++++++++++++-------
 t/perf/p5310-pack-bitmaps.sh | 14 +++++++++++++-
 t/t5310-pack-bitmaps.sh      | 12 ++++++++++++
 3 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 19668d3..d48c290 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -67,7 +67,8 @@ static struct packed_git *reuse_packfile;
 static uint32_t reuse_packfile_objects;
 static off_t reuse_packfile_offset;
 
-static int use_bitmap_index = 1;
+static int use_bitmap_index_default = 1;
+static int use_bitmap_index = -1;
 static int write_bitmap_index;
 static uint16_t write_bitmap_options;
 
@@ -2274,7 +2275,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 			write_bitmap_options &= ~BITMAP_OPT_HASH_CACHE;
 	}
 	if (!strcmp(k, "pack.usebitmaps")) {
-		use_bitmap_index = git_config_bool(k, v);
+		use_bitmap_index_default = git_config_bool(k, v);
 		return 0;
 	}
 	if (!strcmp(k, "pack.threads")) {
@@ -2523,13 +2524,13 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
 }
 
 /*
- * This tracks any options which a reader of the pack might
- * not understand, and which would therefore prevent blind reuse
- * of what we have on disk.
+ * This tracks any options which pack-reuse code expects to be on, or which a
+ * reader of the pack might not understand, and which would therefore prevent
+ * blind reuse of what we have on disk.
  */
 static int pack_options_allow_reuse(void)
 {
-	return allow_ofs_delta;
+	return pack_to_stdout && allow_ofs_delta;
 }
 
 static int get_object_list_from_bitmap(struct rev_info *revs)
@@ -2822,7 +2823,23 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
-	if (!use_internal_rev_list || !pack_to_stdout || is_repository_shallow())
+	/*
+	 * "soft" reasons not to use bitmaps - for on-disk repack by default we want
+	 *
+	 * - to produce good pack (with bitmap index not-yet-packed objects are
+	 *   packed in suboptimal order).
+	 *
+	 * - to use more robust pack-generation codepath (avoiding possible
+	 *   bugs in bitmap code and possible bitmap index corruption).
+	 */
+	if (!pack_to_stdout)
+		use_bitmap_index_default = 0;
+
+	if (use_bitmap_index < 0)
+		use_bitmap_index = use_bitmap_index_default;
+
+	/* "hard" reasons not to use bitmaps; these just won't work at all */
+	if (!use_internal_rev_list || (!pack_to_stdout && write_bitmap_index) || is_repository_shallow())
 		use_bitmap_index = 0;
 
 	if (pack_to_stdout || !rev_list_all)
diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index de2a224..bb91dbb 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -32,6 +32,14 @@ test_perf 'simulated fetch' '
 	} | git pack-objects --revs --stdout >/dev/null
 '
 
+test_perf 'pack to file' '
+	git pack-objects --all pack1 </dev/null >/dev/null
+'
+
+test_perf 'pack to file (bitmap)' '
+	git pack-objects --use-bitmap-index --all pack1b </dev/null >/dev/null
+'
+
 test_expect_success 'create partial bitmap state' '
 	# pick a commit to represent the repo tip in the past
 	cutoff=$(git rev-list HEAD~100 -1) &&
@@ -53,8 +61,12 @@ test_expect_success 'create partial bitmap state' '
 	git update-ref HEAD $orig_tip
 '
 
-test_perf 'partial bitmap' '
+test_perf 'clone (partial bitmap)' '
 	git pack-objects --stdout --all </dev/null >/dev/null
 '
 
+test_perf 'pack to file (partial bitmap)' '
+	git pack-objects --use-bitmap-index --all pack2b </dev/null >/dev/null
+'
+
 test_done
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index a278d30..9602e9a 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -196,6 +196,18 @@ test_expect_success 'pack-objects respects --local (non-local bitmapped pack)' '
 	! has_any packbitmap.objects 3b.objects
 '
 
+test_expect_success 'pack-objects to file can use bitmap' '
+	# make sure we still have 1 bitmap index from previous tests
+	ls .git/objects/pack/ | grep bitmap >output &&
+	test_line_count = 1 output &&
+	# verify equivalent packs are generated with/without using bitmap index
+	packasha1=$(git pack-objects --no-use-bitmap-index --all packa </dev/null) &&
+	packbsha1=$(git pack-objects --use-bitmap-index --all packb </dev/null) &&
+	list_packed_objects <packa-$packasha1.idx >packa.objects &&
+	list_packed_objects <packb-$packbsha1.idx >packb.objects &&
+	test_cmp packa.objects packb.objects
+'
+
 test_expect_success 'full repack, reusing previous bitmaps' '
 	git repack -ad &&
 	ls .git/objects/pack/ | grep bitmap >output &&
-- 
2.9.2.701.gf965a18.dirty
