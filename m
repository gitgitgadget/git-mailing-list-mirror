Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA40C1F71B
	for <e@80x24.org>; Fri, 29 Jul 2016 07:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbcG2HrO (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 03:47:14 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:49944 "EHLO
	mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbcG2HrO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 03:47:14 -0400
Received: from teco.navytux.spb.ru (pppoe.95-55-164-187.dynamic.avangarddsl.ru [95.55.164.187])
	by mail2.tiolive.com (Postfix) with ESMTPSA id 58C40BF01A5;
	Fri, 29 Jul 2016 09:47:11 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
	(envelope-from <kirr@teco.navytux.spb.ru>)
	id 1bT2Vi-0006tT-HL; Fri, 29 Jul 2016 10:47:10 +0300
From:	Kirill Smelkov <kirr@nexedi.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	=?UTF-8?q?J=C3=A9rome=20Perrin?= <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org,
	Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH 1/2] pack-objects: Teach --use-bitmap-index codepath to respect --local, --honor-pack-keep and --incremental
Date:	Fri, 29 Jul 2016 10:46:56 +0300
Message-Id: <20160729074656.23813-1-kirr@nexedi.com>
X-Mailer: git-send-email 2.9.0.431.g3cb5c84
In-Reply-To: <20160729074051.GA5987@teco.navytux.spb.ru>
References: <20160729074051.GA5987@teco.navytux.spb.ru>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Since 6b8fda2d (pack-objects: use bitmaps when packing objects) there
are two codepaths in pack-objects: with & without using bitmap
reachability index.

However add_object_entry_from_bitmap(), despite its non-bitmapped
counterpart add_object_entry(), in no way does check for whether --local
or --honor-pack-keep or --incremental should be respected. In
non-bitmapped codepath this is handled in want_object_in_pack(), but
bitmapped codepath has simply no such checking at all.

The bitmapped codepath however was allowing to pass in all those options
and with bitmap indices still being used under such conditions -
potentially giving wrong output (e.g. including objects from non-local or
.keep'ed pack).

We can easily fix this by noting the following: when an object comes to
add_object_entry_from_bitmap() it can come for two reasons:

    1. entries coming from main pack covered by bitmap index, and
    2. object coming from, possibly alternate, loose or other packs.

For "2" we always have pack not yet found by bitmap traversal code, and
thus we can simply reuse non-bitmapped want_object_in_pack() to find in
which pack an object lives and also for taking omitting decision.

For "1" we always have pack already found by bitmap traversal code and we
only need to check that pack for same criteria used in
want_object_in_pack() for found_pack.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Discussed-with: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c  |  39 +++++++++++++++++++
 t/t5310-pack-bitmaps.sh | 100 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a2f8cfd..34b3019 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -987,6 +987,42 @@ static int want_object_in_pack(const unsigned char *sha1,
 	return 1;
 }
 
+/* Like want_object_in_pack() but for objects coming from-under bitmapped traversal */
+static int want_object_in_pack_bitmap(const unsigned char *sha1,
+				      struct packed_git **found_pack,
+				      off_t *found_offset)
+{
+	struct packed_git *p = *found_pack;
+
+	/*
+	 * There are two types of requests coming here:
+	 * 1. entries coming from main pack covered by bitmap index, and
+	 * 2. object coming from, possibly alternate, loose or other packs.
+	 *
+	 * For "1" we always have *found_pack != NULL passed here from
+	 * traverse_bitmap_commit_list(). (*found_pack is bitmap_git.pack
+	 * actually).
+	 *
+	 * For "2" we always have *found_pack == NULL passed here from
+	 * traverse_bitmap_commit_list() - since this is the way bitmap
+	 * traversal passes here "extended" bitmap entries.
+	 */
+
+	/* objects not covered by bitmap */
+	if (!p)
+		return want_object_in_pack(sha1, 0, found_pack, found_offset);
+
+	/* objects covered by bitmap - we only have to check p wrt local and .keep */
+	if (incremental)
+		return 0;
+	if (local && !p->pack_local)
+		return 0;
+	if (ignore_packed_keep && p->pack_local && p->pack_keep)
+		return 0;
+
+	return 1;
+}
+
 static void create_object_entry(const unsigned char *sha1,
 				enum object_type type,
 				uint32_t hash,
@@ -1055,6 +1091,9 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
 	if (have_duplicate_entry(sha1, 0, &index_pos))
 		return 0;
 
+	if (!want_object_in_pack_bitmap(sha1, &pack, &offset))
+		return 0;
+
 	create_object_entry(sha1, type, name_hash, 0, 0, index_pos, pack, offset);
 
 	display_progress(progress_state, nr_result);
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 3893afd..a76f6ca 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -118,6 +118,88 @@ test_expect_success 'incremental repack can disable bitmaps' '
 	git repack -d --no-write-bitmap-index
 '
 
+test_expect_success 'pack-objects respects --local (non-local loose)' '
+	mkdir -p alt_objects/pack &&
+	echo $(pwd)/alt_objects > .git/objects/info/alternates &&
+	echo content1 > file1 &&
+	objsha1=$(GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w file1) &&
+	git add file1 &&
+	test_tick &&
+	git commit -m commit_file1 &&
+	echo HEAD | \
+	git pack-objects --local --stdout --revs >1.pack &&
+	git index-pack 1.pack &&
+	git verify-pack -v 1.pack >1.objects &&
+	if egrep "^$objsha1" 1.objects; then
+		echo "Non-local object present in pack generated with --local: $objsha1"
+		return 1
+	fi
+'
+
+test_expect_success 'pack-objects respects --honor-pack-keep (local non-bitmapped pack)' '
+	echo content2 > file2 &&
+	objsha2=$(git hash-object -w file2) &&
+	git add file2 &&
+	test_tick &&
+	git commit -m commit_file2 &&
+	pack2=$(echo $objsha2 | \
+		git pack-objects pack2) &&
+	mv pack2-$pack2.* .git/objects/pack/ &&
+	touch .git/objects/pack/pack2-$pack2.keep &&
+	rm $(objpath $objsha2) &&
+	echo HEAD | \
+	git pack-objects --honor-pack-keep --stdout --revs >2a.pack &&
+	git index-pack 2a.pack &&
+	git verify-pack -v 2a.pack >2a.objects &&
+	if egrep "^$objsha2" 2a.objects; then
+		echo "Object from .keeped pack present in pack generated with --honor-pack-keep: $objsha2"
+		return 1
+	fi
+'
+
+test_expect_success 'pack-objects respects --local (non-local pack)' '
+	mv .git/objects/pack/pack2-$pack2.* alt_objects/pack/ &&
+	echo HEAD | \
+	git pack-objects --local --stdout --revs >2b.pack &&
+	git index-pack 2b.pack &&
+	git verify-pack -v 2b.pack >2b.objects &&
+	if egrep "^$objsha2" 2b.objects; then
+		echo "Non-local object present in pack generated with --local: $objsha2"
+		return 1
+	fi
+'
+
+test_expect_success 'pack-objects respects --honor-pack-keep (local bitmapped pack)' '
+	ls .git/objects/pack/ | grep bitmap >output &&
+	test_line_count = 1 output &&
+	packbitmap=$(basename $(cat output) .bitmap) &&
+	git verify-pack -v .git/objects/pack/$packbitmap.pack >packbitmap.verify &&
+	grep -o "^$_x40" packbitmap.verify |sort >packbitmap.objects &&
+	touch .git/objects/pack/$packbitmap.keep &&
+	echo HEAD | \
+	git pack-objects --honor-pack-keep --stdout --revs >3a.pack &&
+	git index-pack 3a.pack &&
+	git verify-pack -v 3a.pack >3a.objects &&
+	if grep -qFf packbitmap.objects 3a.objects; then
+		echo "Object from .keeped bitmapped pack present in pack generated with --honour-pack-keep"
+		return 1
+	fi &&
+	rm .git/objects/pack/$packbitmap.keep
+'
+
+test_expect_success 'pack-objects respects --local (non-local bitmapped pack)' '
+	mv .git/objects/pack/$packbitmap.* alt_objects/pack/ &&
+	echo HEAD | \
+	git pack-objects --local --stdout --revs >3b.pack &&
+	git index-pack 3b.pack &&
+	git verify-pack -v 3b.pack >3b.objects &&
+	if grep -qFf packbitmap.objects 3b.objects; then
+		echo "Non-local object from bitmapped pack present in pack generated with --local"
+		return 1
+	fi &&
+	mv alt_objects/pack/$packbitmap.* .git/objects/pack/
+'
+
 test_expect_success 'full repack, reusing previous bitmaps' '
 	git repack -ad &&
 	ls .git/objects/pack/ | grep bitmap >output &&
@@ -143,6 +225,24 @@ test_expect_success 'create objects for missing-HAVE tests' '
 	EOF
 '
 
+test_expect_success 'pack-objects respects --incremental' '
+	cat >revs2 <<-EOF &&
+	HEAD
+	$commit
+	EOF
+	git pack-objects --incremental --stdout --revs <revs2 >4.pack &&
+	git index-pack 4.pack &&
+	git verify-pack -v 4.pack >4.verify &&
+	grep -o "^$_x40" 4.verify |sort >4.objects &&
+	test_line_count = 4 4.objects &&
+	git rev-list --objects $commit >revlist &&
+	grep -o "^$_x40" revlist |sort >objects &&
+	if grep -qvFf objects 4.objects; then
+		echo "Expected objects not present in incremental pack"
+		return 1
+	fi
+'
+
 test_expect_success 'pack with missing blob' '
 	rm $(objpath $blob) &&
 	git pack-objects --stdout --revs <revs >/dev/null
-- 
2.9.0.431.g3cb5c84
