Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A0071F71B
	for <e@80x24.org>; Fri, 29 Jul 2016 07:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbcG2Hrz (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 03:47:55 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:49955 "EHLO
	mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbcG2Hry (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 03:47:54 -0400
Received: from teco.navytux.spb.ru (pppoe.95-55-164-187.dynamic.avangarddsl.ru [95.55.164.187])
	by mail2.tiolive.com (Postfix) with ESMTPSA id ECCB3BF0332;
	Fri, 29 Jul 2016 09:47:51 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
	(envelope-from <kirr@teco.navytux.spb.ru>)
	id 1bT2WN-0008J8-BD; Fri, 29 Jul 2016 10:47:51 +0300
From:	Kirill Smelkov <kirr@nexedi.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	=?UTF-8?q?J=C3=A9rome=20Perrin?= <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org,
	Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH v4 2/2] pack-objects: Teach it to use reachability bitmap index when generating non-stdout pack too
Date:	Fri, 29 Jul 2016 10:47:46 +0300
Message-Id: <20160729074746.31862-1-kirr@nexedi.com>
X-Mailer: git-send-email 2.9.0.431.g3cb5c84
In-Reply-To: <20160729074051.GA5987@teco.navytux.spb.ru>
References: <20160729074051.GA5987@teco.navytux.spb.ru>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Starting from 6b8fda2d (pack-objects: use bitmaps when packing objects)
if a repository has bitmap index, pack-objects can nicely speedup
"Counting objects" graph traversal phase. That however was done only for
case when resultant pack is sent to stdout, not written into a file.

The reason here is for on-disk repack by default we want:

- to produce good pack (with bitmap index not-yet-packed objects are
  emitted to pack in suboptimal order).

- to use more robust pack-generation codepath (avoiding possible
  bugs in bitmap code and possible bitmap index corruption).

Jeff Kind further explains:

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

- if we care it is not activated under git-repack:

  See above about repack robustness and not forward-carrying corruption.

- if we know bitmap index generation is not enabled for resultant pack:

  Current code has singleton bitmap_git so cannot work simultaneously
  with two bitmap indices.

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

  Because on pack reuse raw entries are directly written out to destination
  pack by write_reused_pack() bypassing needed for pack index generation
  bookkeeping done by regular codepath in write_one() and friends.

This way all git tests pass, and for pack-objects -> file we get nice
speedup:

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

More context:

    http://article.gmane.org/gmane.comp.version-control.git/299063
    http://article.gmane.org/gmane.comp.version-control.git/299107
    http://article.gmane.org/gmane.comp.version-control.git/299420
    http://article.gmane.org/gmane.comp.version-control.git/300217

Cc: Vicent Marti <tanoku@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 Documentation/config.txt |  3 +++
 builtin/pack-objects.c   | 25 +++++++++++++++++++++----
 t/t5310-pack-bitmaps.sh  | 14 ++++++++++++++
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8b1aee4..6a903c0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2244,6 +2244,9 @@ pack.useBitmaps::
 	to stdout (e.g., during the server side of a fetch). Defaults to
 	true. You should not generally need to turn this off unless
 	you are debugging pack bitmaps.
++
+*NOTE*: when packing to file (e.g., on repack) the default is always not to use
+	pack bitmaps.
 
 pack.writeBitmaps (deprecated)::
 	This is a deprecated synonym for `repack.writeBitmaps`.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 34b3019..2b2e74a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -66,7 +66,8 @@ static struct packed_git *reuse_packfile;
 static uint32_t reuse_packfile_objects;
 static off_t reuse_packfile_offset;
 
-static int use_bitmap_index = 1;
+static int use_bitmap_index_default = 1;
+static int use_bitmap_index = -1;
 static int write_bitmap_index;
 static uint16_t write_bitmap_options;
 
@@ -2264,7 +2265,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 			write_bitmap_options &= ~BITMAP_OPT_HASH_CACHE;
 	}
 	if (!strcmp(k, "pack.usebitmaps")) {
-		use_bitmap_index = git_config_bool(k, v);
+		use_bitmap_index_default = git_config_bool(k, v);
 		return 0;
 	}
 	if (!strcmp(k, "pack.threads")) {
@@ -2527,7 +2528,7 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 	if (prepare_bitmap_walk(revs) < 0)
 		return -1;
 
-	if (pack_options_allow_reuse() &&
+	if (pack_options_allow_reuse() && pack_to_stdout &&
 	    !reuse_partial_packfile_from_bitmap(
 			&reuse_packfile,
 			&reuse_packfile_objects,
@@ -2812,7 +2813,23 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
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
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index a76f6ca..58c3b29 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -200,6 +200,20 @@ test_expect_success 'pack-objects respects --local (non-local bitmapped pack)' '
 	mv alt_objects/pack/$packbitmap.* .git/objects/pack/
 '
 
+test_expect_success 'pack-objects to file can use bitmap' '
+	# make sure we still have 1 bitmap index from previous tests
+	ls .git/objects/pack/ | grep bitmap >output &&
+	test_line_count = 1 output &&
+	# verify equivalent packs are generated with/without using bitmap index
+	packasha1=$(git pack-objects --no-use-bitmap-index --all packa </dev/null) &&
+	packbsha1=$(git pack-objects --use-bitmap-index --all packb </dev/null) &&
+	git verify-pack -v packa-$packasha1.pack >packa.verify &&
+	git verify-pack -v packb-$packbsha1.pack >packb.verify &&
+	grep -o "^$_x40" packa.verify |sort >packa.objects &&
+	grep -o "^$_x40" packb.verify |sort >packb.objects &&
+	test_cmp packa.objects packb.objects
+'
+
 test_expect_success 'full repack, reusing previous bitmaps' '
 	git repack -ad &&
 	ls .git/objects/pack/ | grep bitmap >output &&
-- 
2.9.0.431.g3cb5c84
