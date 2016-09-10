Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A35C11F859
	for <e@80x24.org>; Sat, 10 Sep 2016 15:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755256AbcIJPBV (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Sep 2016 11:01:21 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:47625 "EHLO
        mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755182AbcIJPBS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2016 11:01:18 -0400
Received: from teco.navytux.spb.ru (unknown [178.70.98.236])
        by mail2.tiolive.com (Postfix) with ESMTPSA id 3C2F9BF0319;
        Sat, 10 Sep 2016 17:01:16 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
        (envelope-from <kirr@teco.navytux.spb.ru>)
        id 1bijmN-0004v9-IT; Sat, 10 Sep 2016 18:01:15 +0300
From:   Kirill Smelkov <kirr@nexedi.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
        =?UTF-8?q?J=C3=A9rome=20Perrin?= <jerome@nexedi.com>,
        Isabelle Vallet <isabelle.vallet@nexedi.com>,
        Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
        Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org,
        Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH 1/2 v8] pack-objects: respect --local/--honor-pack-keep/--incremental when bitmap is in use
Date:   Sat, 10 Sep 2016 18:01:10 +0300
Message-Id: <20160910150110.18844-1-kirr@nexedi.com>
X-Mailer: git-send-email 2.9.2.701.gf965a18.dirty
In-Reply-To: <20160910145738.x6ihp2gqzpk7dbi3@teco.navytux.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

"2" can be already handled by want_object_in_pack() and to cover
"1" we can teach want_object_in_pack() to expect that *found_pack can be
non-NULL, meaning calling client already found object's pack entry.

In want_object_in_pack() we care to start the checks from already found
pack, if we have one, this way determining the answer right away
in case neither --local nor --honour-pack-keep are active. In
particular, as p5310-pack-bitmaps.sh shows (3 consecutive runs), we do
not do harm to served-with-bitmap clones performance-wise:

    Test                      56dfeb62          this tree
    -----------------------------------------------------------------
    5310.2: repack to disk    9.08(8.20+0.25)   9.09(8.14+0.32) +0.1%
    5310.3: simulated clone   1.92(2.12+0.08)   1.93(2.12+0.09) +0.5%
    5310.4: simulated fetch   0.82(1.07+0.04)   0.82(1.06+0.04) +0.0%
    5310.6: partial bitmap    1.96(2.42+0.13)   1.95(2.40+0.15) -0.5%

    Test                      56dfeb62          this tree
    -----------------------------------------------------------------
    5310.2: repack to disk    9.11(8.16+0.32)   9.11(8.19+0.28) +0.0%
    5310.3: simulated clone   1.93(2.14+0.07)   1.92(2.11+0.10) -0.5%
    5310.4: simulated fetch   0.82(1.06+0.04)   0.82(1.04+0.05) +0.0%
    5310.6: partial bitmap    1.95(2.38+0.16)   1.94(2.39+0.14) -0.5%

    Test                      56dfeb62          this tree
    -----------------------------------------------------------------
    5310.2: repack to disk    9.13(8.17+0.31)   9.07(8.13+0.28) -0.7%
    5310.3: simulated clone   1.92(2.13+0.07)   1.91(2.12+0.06) -0.5%
    5310.4: simulated fetch   0.82(1.08+0.03)   0.82(1.08+0.03) +0.0%
    5310.6: partial bitmap    1.96(2.43+0.14)   1.96(2.42+0.14) +0.0%

with delta timings showing they are all within noise from run to run.

In the general case we do not want to call find_pack_entry_one() more than
once, because it is expensive. This patch splits the loop in
want_object_in_pack() into two parts: finding the object and seeing if it
impacts our choice to include it in the pack. We may call the inexpensive
want_found_object() twice, but we will never call find_pack_entry_one() if we
do not need to.

I appreciate help and discussing this change with Junio C Hamano and
Jeff King.

Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-objects.c  | 97 ++++++++++++++++++++++++++++++++-----------------
 t/t5310-pack-bitmaps.sh | 92 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 156 insertions(+), 33 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c4c2a3c..19668d3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -944,13 +944,48 @@ static int have_duplicate_entry(const unsigned char *sha1,
 	return 1;
 }
 
+static int want_found_object(int exclude, struct packed_git *p)
+{
+	if (exclude)
+		return 1;
+	if (incremental)
+		return 0;
+
+	/*
+	 * When asked to do --local (do not include an object that appears in a
+	 * pack we borrow from elsewhere) or --honor-pack-keep (do not include
+	 * an object that appears in a pack marked with .keep), finding a pack
+	 * that matches the criteria is sufficient for us to decide to omit it.
+	 * However, even if this pack does not satisfy the criteria, we need to
+	 * make sure no copy of this object appears in _any_ pack that makes us
+	 * to omit the object, so we need to check all the packs.
+	 *
+	 * We can however first check whether these options can possible matter;
+	 * if they do not matter we know we want the object in generated pack.
+	 * Otherwise, we signal "-1" at the end to tell the caller that we do
+	 * not know either way, and it needs to check more packs.
+	 */
+	if (!ignore_packed_keep &&
+	    (!local || !have_non_local_packs))
+		return 1;
+
+	if (local && !p->pack_local)
+		return 0;
+	if (ignore_packed_keep && p->pack_local && p->pack_keep)
+		return 0;
+
+	/* we don't know yet; keep looking for more packs */
+	return -1;
+}
+
 /*
  * Check whether we want the object in the pack (e.g., we do not want
  * objects found in non-local stores if the "--local" option was used).
  *
- * As a side effect of this check, we will find the packed version of this
- * object, if any. We therefore pass out the pack information to avoid having
- * to look it up again later.
+ * If the caller already knows an existing pack it wants to take the object
+ * from, that is passed in *found_pack and *found_offset; otherwise this
+ * function finds if there is any pack that has the object and returns the pack
+ * and its offset in these variables.
  */
 static int want_object_in_pack(const unsigned char *sha1,
 			       int exclude,
@@ -958,15 +993,30 @@ static int want_object_in_pack(const unsigned char *sha1,
 			       off_t *found_offset)
 {
 	struct packed_git *p;
+	int want;
 
 	if (!exclude && local && has_loose_object_nonlocal(sha1))
 		return 0;
 
-	*found_pack = NULL;
-	*found_offset = 0;
+	/*
+	 * If we already know the pack object lives in, start checks from that
+	 * pack - in the usual case when neither --local was given nor .keep files
+	 * are present we will determine the answer right now.
+	 */
+	if (*found_pack) {
+		want = want_found_object(exclude, *found_pack);
+		if (want != -1)
+			return want;
+	}
 
 	for (p = packed_git; p; p = p->next) {
-		off_t offset = find_pack_entry_one(sha1, p);
+		off_t offset;
+
+		if (p == *found_pack)
+			offset = *found_offset;
+		else
+			offset = find_pack_entry_one(sha1, p);
+
 		if (offset) {
 			if (!*found_pack) {
 				if (!is_pack_valid(p))
@@ -974,31 +1024,9 @@ static int want_object_in_pack(const unsigned char *sha1,
 				*found_offset = offset;
 				*found_pack = p;
 			}
-			if (exclude)
-				return 1;
-			if (incremental)
-				return 0;
-
-			/*
-			 * When asked to do --local (do not include an
-			 * object that appears in a pack we borrow
-			 * from elsewhere) or --honor-pack-keep (do not
-			 * include an object that appears in a pack marked
-			 * with .keep), we need to make sure no copy of this
-			 * object come from in _any_ pack that causes us to
-			 * omit it, and need to complete this loop.  When
-			 * neither option is in effect, we know the object
-			 * we just found is going to be packed, so break
-			 * out of the loop to return 1 now.
-			 */
-			if (!ignore_packed_keep &&
-			    (!local || !have_non_local_packs))
-				break;
-
-			if (local && !p->pack_local)
-				return 0;
-			if (ignore_packed_keep && p->pack_local && p->pack_keep)
-				return 0;
+			want = want_found_object(exclude, p);
+			if (want != -1)
+				return want;
 		}
 	}
 
@@ -1039,8 +1067,8 @@ static const char no_closure_warning[] = N_(
 static int add_object_entry(const unsigned char *sha1, enum object_type type,
 			    const char *name, int exclude)
 {
-	struct packed_git *found_pack;
-	off_t found_offset;
+	struct packed_git *found_pack = NULL;
+	off_t found_offset = 0;
 	uint32_t index_pos;
 
 	if (have_duplicate_entry(sha1, exclude, &index_pos))
@@ -1073,6 +1101,9 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
 	if (have_duplicate_entry(sha1, 0, &index_pos))
 		return 0;
 
+	if (!want_object_in_pack(sha1, 0, &pack, &offset))
+		return 0;
+
 	create_object_entry(sha1, type, name_hash, 0, 0, index_pos, pack, offset);
 
 	display_progress(progress_state, nr_result);
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 3893afd..a278d30 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -7,6 +7,18 @@ objpath () {
 	echo ".git/objects/$(echo "$1" | sed -e 's|\(..\)|\1/|')"
 }
 
+# show objects present in pack ($1 should be associated *.idx)
+list_packed_objects () {
+	git show-index <"$1" | cut -d' ' -f2
+}
+
+# has_any pattern-file content-file
+# tests whether content-file has any entry from pattern-file with entries being
+# whole lines.
+has_any () {
+	grep -Ff "$1" "$2"
+}
+
 test_expect_success 'setup repo with moderate-sized history' '
 	for i in $(test_seq 1 10); do
 		test_commit $i
@@ -16,6 +28,7 @@ test_expect_success 'setup repo with moderate-sized history' '
 		test_commit side-$i
 	done &&
 	git checkout master &&
+	bitmaptip=$(git rev-parse master) &&
 	blob=$(echo tagged-blob | git hash-object -w --stdin) &&
 	git tag tagged-blob $blob &&
 	git config repack.writebitmaps true &&
@@ -118,6 +131,71 @@ test_expect_success 'incremental repack can disable bitmaps' '
 	git repack -d --no-write-bitmap-index
 '
 
+test_expect_success 'pack-objects respects --local (non-local loose)' '
+	git init --bare alt.git &&
+	echo $(pwd)/alt.git/objects >.git/objects/info/alternates &&
+	echo content1 >file1 &&
+	# non-local loose object which is not present in bitmapped pack
+	altblob=$(GIT_DIR=alt.git git hash-object -w file1) &&
+	# non-local loose object which is also present in bitmapped pack
+	git cat-file blob $blob | GIT_DIR=alt.git git hash-object -w --stdin &&
+	git add file1 &&
+	test_tick &&
+	git commit -m commit_file1 &&
+	echo HEAD | git pack-objects --local --stdout --revs >1.pack &&
+	git index-pack 1.pack &&
+	list_packed_objects 1.idx >1.objects &&
+	printf "%s\n" "$altblob" "$blob" >nonlocal-loose &&
+	! has_any nonlocal-loose 1.objects
+'
+
+test_expect_success 'pack-objects respects --honor-pack-keep (local non-bitmapped pack)' '
+	echo content2 >file2 &&
+	blob2=$(git hash-object -w file2) &&
+	git add file2 &&
+	test_tick &&
+	git commit -m commit_file2 &&
+	printf "%s\n" "$blob2" "$bitmaptip" >keepobjects &&
+	pack2=$(git pack-objects pack2 <keepobjects) &&
+	mv pack2-$pack2.* .git/objects/pack/ &&
+	>.git/objects/pack/pack2-$pack2.keep &&
+	rm $(objpath $blob2) &&
+	echo HEAD | git pack-objects --honor-pack-keep --stdout --revs >2a.pack &&
+	git index-pack 2a.pack &&
+	list_packed_objects 2a.idx >2a.objects &&
+	! has_any keepobjects 2a.objects
+'
+
+test_expect_success 'pack-objects respects --local (non-local pack)' '
+	mv .git/objects/pack/pack2-$pack2.* alt.git/objects/pack/ &&
+	echo HEAD | git pack-objects --local --stdout --revs >2b.pack &&
+	git index-pack 2b.pack &&
+	list_packed_objects 2b.idx >2b.objects &&
+	! has_any keepobjects 2b.objects
+'
+
+test_expect_success 'pack-objects respects --honor-pack-keep (local bitmapped pack)' '
+	ls .git/objects/pack/ | grep bitmap >output &&
+	test_line_count = 1 output &&
+	packbitmap=$(basename $(cat output) .bitmap) &&
+	list_packed_objects .git/objects/pack/$packbitmap.idx >packbitmap.objects &&
+	test_when_finished "rm -f .git/objects/pack/$packbitmap.keep" &&
+	>.git/objects/pack/$packbitmap.keep &&
+	echo HEAD | git pack-objects --honor-pack-keep --stdout --revs >3a.pack &&
+	git index-pack 3a.pack &&
+	list_packed_objects 3a.idx >3a.objects &&
+	! has_any packbitmap.objects 3a.objects
+'
+
+test_expect_success 'pack-objects respects --local (non-local bitmapped pack)' '
+	mv .git/objects/pack/$packbitmap.* alt.git/objects/pack/ &&
+	test_when_finished "mv alt.git/objects/pack/$packbitmap.* .git/objects/pack/" &&
+	echo HEAD | git pack-objects --local --stdout --revs >3b.pack &&
+	git index-pack 3b.pack &&
+	list_packed_objects 3b.idx >3b.objects &&
+	! has_any packbitmap.objects 3b.objects
+'
+
 test_expect_success 'full repack, reusing previous bitmaps' '
 	git repack -ad &&
 	ls .git/objects/pack/ | grep bitmap >output &&
@@ -143,6 +221,20 @@ test_expect_success 'create objects for missing-HAVE tests' '
 	EOF
 '
 
+test_expect_success 'pack-objects respects --incremental' '
+	cat >revs2 <<-EOF &&
+	HEAD
+	$commit
+	EOF
+	git pack-objects --incremental --stdout --revs <revs2 >4.pack &&
+	git index-pack 4.pack &&
+	list_packed_objects 4.idx >4.objects &&
+	test_line_count = 4 4.objects &&
+	git rev-list --objects $commit >revlist &&
+	cut -d" " -f1 revlist |sort >objects &&
+	test_cmp 4.objects objects
+'
+
 test_expect_success 'pack with missing blob' '
 	rm $(objpath $blob) &&
 	git pack-objects --stdout --revs <revs >/dev/null
-- 
2.9.2.701.gf965a18.dirty
