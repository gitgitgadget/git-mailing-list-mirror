Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C1DF2070D
	for <e@80x24.org>; Thu,  7 Jul 2016 19:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbcGGTrY (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 15:47:24 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:43466 "EHLO
	mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbcGGTrV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 15:47:21 -0400
X-Greylist: delayed 1795 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jul 2016 15:47:21 EDT
Received: from teco.navytux.spb.ru (unknown [178.70.97.18])
	by mail2.tiolive.com (Postfix) with ESMTPSA id 5906BBF0097;
	Thu,  7 Jul 2016 21:09:40 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
	(envelope-from <kirr@teco.navytux.spb.ru>)
	id 1bLEg4-0005Fh-3b; Thu, 07 Jul 2016 22:09:36 +0300
From:	Kirill Smelkov <kirr@nexedi.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	=?UTF-8?q?J=C3=A9rome=20Perrin?= <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org,
	Kirill Smelkov <kirr@nexedi.com>,
	Vicent Marti <tanoku@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH] pack-objects: Use reachability bitmap index when generating non-stdout pack too
Date:	Thu,  7 Jul 2016 22:09:17 +0300
Message-Id: <20160707190917.20011-1-kirr@nexedi.com>
X-Mailer: git-send-email 2.9.0.431.gb11dac7.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Starting from 6b8fda2d (pack-objects: use bitmaps when packing objects)
if a repository has bitmap index, pack-objects can nicely speedup
"Counting objects" graph traversal phase. That however was done only for
case when resultant pack is sent to stdout, not written into a file.

We can teach pack-objects to use bitmap index for initial object
counting phase when generating resultant pack file too:

- if we know bitmap index generation is not enabled for resultant pack:

  Current code has singleton bitmap_git so cannot work simultaneously
  with two bitmap indices.

- if we keep pack reuse enabled still only for "send-to-stdout" case:

  Because on pack reuse raw entries are directly written out to destination
  pack by write_reused_pack() bypassing needed for pack index generation
  bookkeeping done by regular codepath in write_one() and friends.

  (at least that's my understanding after briefly looking at the code)

We also need to care and teach add_object_entry_from_bitmap() to respect
--local via not adding nonlocal loose object to resultant pack (this
is bitmap-codepath counterpart of daae0625 (pack-objects: extend --local
to mean ignore non-local loose objects too) -- not to break 'loose
objects in alternate ODB are not repacked' in t7700-repack.sh .

Otherwise all git tests pass, and for pack-objects -> file we get nice
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

Cc: Vicent Marti <tanoku@gmail.com>
Cc: Jeff King <peff@peff.net>
Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 builtin/pack-objects.c  | 7 +++++--
 t/t5310-pack-bitmaps.sh | 9 +++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a2f8cfd..be0ebe8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1052,6 +1052,9 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
 {
 	uint32_t index_pos;
 
+	if (local && has_loose_object_nonlocal(sha1))
+		return 0;
+
 	if (have_duplicate_entry(sha1, 0, &index_pos))
 		return 0;
 
@@ -2488,7 +2491,7 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 	if (prepare_bitmap_walk(revs) < 0)
 		return -1;
 
-	if (pack_options_allow_reuse() &&
+	if (pack_options_allow_reuse() && pack_to_stdout &&
 	    !reuse_partial_packfile_from_bitmap(
 			&reuse_packfile,
 			&reuse_packfile_objects,
@@ -2773,7 +2776,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
-	if (!use_internal_rev_list || !pack_to_stdout || is_repository_shallow())
+	if (!use_internal_rev_list || (!pack_to_stdout && write_bitmap_index) || is_repository_shallow())
 		use_bitmap_index = 0;
 
 	if (pack_to_stdout || !rev_list_all)
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 3893afd..533fc31 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -118,6 +118,15 @@ test_expect_success 'incremental repack can disable bitmaps' '
 	git repack -d --no-write-bitmap-index
 '
 
+test_expect_success 'pack-objects to file can use bitmap' '
+	# make sure we still have 1 bitmap index from previous tests
+	ls .git/objects/pack/ | grep bitmap >output &&
+	test_line_count = 1 output &&
+	# pack-objects uses bitmap index by default, when it is available
+	packsha1=$(git pack-objects --all mypack </dev/null) &&
+	git verify-pack mypack-$packsha1.pack
+'
+
 test_expect_success 'full repack, reusing previous bitmaps' '
 	git repack -ad &&
 	ls .git/objects/pack/ | grep bitmap >output &&
-- 
2.9.0.431.gb11dac7.dirty
