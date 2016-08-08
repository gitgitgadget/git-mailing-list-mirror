Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57DDC2018E
	for <e@80x24.org>; Mon,  8 Aug 2016 12:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbcHHMhm (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 08:37:42 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:54105 "EHLO
	mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbcHHMhm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 08:37:42 -0400
Received: from teco.navytux.spb.ru (pppoe.178-66-29-27.dynamic.avangarddsl.ru [178.66.29.27])
	by mail2.tiolive.com (Postfix) with ESMTPSA id BA164BF0363;
	Mon,  8 Aug 2016 14:37:38 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
	(envelope-from <kirr@teco.navytux.spb.ru>)
	id 1bWjoF-000827-8Y; Mon, 08 Aug 2016 15:37:35 +0300
Date:	Mon, 8 Aug 2016 15:37:35 +0300
From:	Kirill Smelkov <kirr@nexedi.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	=?iso-8859-1?Q?J=E9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] pack-objects: Teach --use-bitmap-index codepath to
 respect --local, --honor-pack-keep and --incremental
Message-ID: <20160808123734.GA3995@teco.navytux.spb.ru>
References: <20160729074051.GA5987@teco.navytux.spb.ru>
 <20160729074656.23813-1-kirr@nexedi.com>
 <xmqqy44gjqv9.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy44gjqv9.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 11:17:30AM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@nexedi.com> writes:
> 
> > Since 6b8fda2d (pack-objects: use bitmaps when packing objects) there
> > are two codepaths in pack-objects: with & without using bitmap
> > reachability index.
> >
> > However add_object_entry_from_bitmap(), despite its non-bitmapped
> > counterpart add_object_entry(), in no way does check for whether --local
> > or --honor-pack-keep or --incremental should be respected. In
> > non-bitmapped codepath this is handled in want_object_in_pack(), but
> > bitmapped codepath has simply no such checking at all.
> >
> > The bitmapped codepath however was allowing to pass in all those options
> > and with bitmap indices still being used under such conditions -
> > potentially giving wrong output (e.g. including objects from non-local or
> > .keep'ed pack).
> >
> > We can easily fix this by noting the following: when an object comes to
> > add_object_entry_from_bitmap() it can come for two reasons:
> >
> >     1. entries coming from main pack covered by bitmap index, and
> >     2. object coming from, possibly alternate, loose or other packs.
> >
> > For "2" we always have pack not yet found by bitmap traversal code, and
> > thus we can simply reuse non-bitmapped want_object_in_pack() to find in
> > which pack an object lives and also for taking omitting decision.
> >
> > For "1" we always have pack already found by bitmap traversal code and we
> > only need to check that pack for same criteria used in
> > want_object_in_pack() for found_pack.
> >
> > Suggested-by: Junio C Hamano <gitster@pobox.com>
> > Discussed-with: Jeff King <peff@peff.net>
> > ---
> 
> I do not think I suggested much of this to deserve credit like this,
> though, as I certainly haven't thought about the pros-and-cons
> between adding the same "some object in pack may not want to be in
> the output" logic to the bitmap side, or punting the bitmap codepath
> when local/keep are involved.

I understand. Still for me it was you who convinced me to add proper
support for e.g. --local vs bitmap instead of special-casing it.
I think we also can avoid punting the bitmap codepath - please see
below.


> > +/* Like want_object_in_pack() but for objects coming from-under bitmapped traversal */
> > +static int want_object_in_pack_bitmap(const unsigned char *sha1,
> > +				      struct packed_git **found_pack,
> > +				      off_t *found_offset)
> > +{
> > +	struct packed_git *p = *found_pack;
> > +
> > +	/*
> > +	 * There are two types of requests coming here:
> > +	 * 1. entries coming from main pack covered by bitmap index, and
> > +	 * 2. object coming from, possibly alternate, loose or other packs.
> > +	 *
> > +	 * For "1" we always have *found_pack != NULL passed here from
> > +	 * traverse_bitmap_commit_list(). (*found_pack is bitmap_git.pack
> > +	 * actually).
> > +	 *
> > +	 * For "2" we always have *found_pack == NULL passed here from
> > +	 * traverse_bitmap_commit_list() - since this is the way bitmap
> > +	 * traversal passes here "extended" bitmap entries.
> > +	 */
> > +
> > +	/* objects not covered by bitmap */
> > +	if (!p)
> > +		return want_object_in_pack(sha1, 0, found_pack, found_offset);
> > +	/* objects covered by bitmap - we only have to check p wrt local and .keep */
> 
> I am assuming that p != NULL only means "this object exists in THIS
> pack", without saying anything about "this object may also exist in
> other places", but "we only have to check" implies that "p != NULL"
> means "this object exists *ONLY* in this pack and nowhere else".
> 
> Puzzled.

You are right. Being new to --local and .keep I've missed this. I've
added tests to cover cases like "object lives in both bitmapped pack and
non-local loose or .keep'ed pack" and made the adjustments. The checks
are now live unified in want_object_in_pack() for both bitmapped and
non-bitmapped codepaths. Please apply the following corrected patch on
top of 56dfeb62 (jk/pack-objects-optim).

Thanks,
Kirill

---- 8< ----
From: Kirill Smelkov <kirr@nexedi.com>
Date: Fri, 29 Jul 2016 10:46:56 +0300
Subject: [PATCH v2] pack-objects: Teach --use-bitmap-index codepath to respect
 --local, --honor-pack-keep and --incremental

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
pack, if we have one, this way caring not to do more than 1 iteration
in case neither --local nor --honour-pack-keep are active. In
particular, as p5310-pack-bitmaps.sh shows, we do not do harm to
served-with-bitmap clones performance-wise:

    Test                      56dfeb62          this tree
    -----------------------------------------------------------------
    5310.2: repack to disk    9.14(8.18+0.31)   8.89(7.92+0.28) -2.7%
    5310.3: simulated clone   1.94(2.14+0.07)   1.91(2.08+0.08) -1.5%
    5310.4: simulated fetch   0.75(1.01+0.02)   0.75(0.94+0.07) +0.0%
    5310.6: partial bitmap    1.99(2.44+0.16)   1.95(2.40+0.14) -2.0%

with all differences strangely showing we are a bit faster now, but
probably all being within noise.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Discussed-with: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c  |  36 ++++++++++++-----
 t/t5310-pack-bitmaps.sh | 103 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+), 9 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c4c2a3c..2c274d3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -948,9 +948,9 @@ static int have_duplicate_entry(const unsigned char *sha1,
  * Check whether we want the object in the pack (e.g., we do not want
  * objects found in non-local stores if the "--local" option was used).
  *
- * As a side effect of this check, we will find the packed version of this
- * object, if any. We therefore pass out the pack information to avoid having
- * to look it up again later.
+ * As a side effect of this check, if object's pack entry was not already found,
+ * we will find the packed version of this object, if any. We therefore pass
+ * out the pack information to avoid having to look it up again later.
  */
 static int want_object_in_pack(const unsigned char *sha1,
 			       int exclude,
@@ -958,15 +958,30 @@ static int want_object_in_pack(const unsigned char *sha1,
 			       off_t *found_offset)
 {
 	struct packed_git *p;
+	struct packed_git *pack1 = *found_pack;
+	int pack1_seen = !pack1;
 
 	if (!exclude && local && has_loose_object_nonlocal(sha1))
 		return 0;
 
-	*found_pack = NULL;
-	*found_offset = 0;
+	/*
+	 * If we already know the pack object lives in, start checks from that
+	 * pack - in the usual case when neither --local was given nor .keep files
+	 * are present the loop will degenerate to have only 1 iteration.
+	 */
+	for (p = (pack1 ? pack1 : packed_git); p;
+	     p = (pack1_seen ? p->next : packed_git), pack1_seen = 1) {
+		off_t offset;
+
+		if (p == pack1) {
+			if (pack1_seen)
+				continue;
+			offset = *found_offset;
+		}
+		else {
+			offset = find_pack_entry_one(sha1, p);
+		}
 
-	for (p = packed_git; p; p = p->next) {
-		off_t offset = find_pack_entry_one(sha1, p);
 		if (offset) {
 			if (!*found_pack) {
 				if (!is_pack_valid(p))
@@ -1039,8 +1054,8 @@ static const char no_closure_warning[] = N_(
 static int add_object_entry(const unsigned char *sha1, enum object_type type,
 			    const char *name, int exclude)
 {
-	struct packed_git *found_pack;
-	off_t found_offset;
+	struct packed_git *found_pack = NULL;
+	off_t found_offset = 0;
 	uint32_t index_pos;
 
 	if (have_duplicate_entry(sha1, exclude, &index_pos))
@@ -1073,6 +1088,9 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
 	if (have_duplicate_entry(sha1, 0, &index_pos))
 		return 0;
 
+	if (!want_object_in_pack(sha1, 0, &pack, &offset))
+		return 0;
+
 	create_object_entry(sha1, type, name_hash, 0, 0, index_pos, pack, offset);
 
 	display_progress(progress_state, nr_result);
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 3893afd..1a61de4 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -16,6 +16,7 @@ test_expect_success 'setup repo with moderate-sized history' '
 		test_commit side-$i
 	done &&
 	git checkout master &&
+	bitmaptip=$(git show-ref -s master) &&
 	blob=$(echo tagged-blob | git hash-object -w --stdin) &&
 	git tag tagged-blob $blob &&
 	git config repack.writebitmaps true &&
@@ -118,6 +119,90 @@ test_expect_success 'incremental repack can disable bitmaps' '
 	git repack -d --no-write-bitmap-index
 '
 
+test_expect_success 'pack-objects respects --local (non-local loose)' '
+	mkdir -p alt_objects/pack &&
+	echo $(pwd)/alt_objects > .git/objects/info/alternates &&
+	echo content1 > file1 &&
+	objsha1=$(GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w file1) &&
+	git cat-file blob $blob | GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w --stdin &&
+	git add file1 &&
+	test_tick &&
+	git commit -m commit_file1 &&
+	echo HEAD | \
+	git pack-objects --local --stdout --revs >1.pack &&
+	git index-pack 1.pack &&
+	git verify-pack -v 1.pack >1.objects &&
+	echo -e "$objsha1\n$blob" >nonlocal-loose &&
+	if grep -qFf nonlocal-loose 1.objects; then
+		echo "Non-local object present in pack generated with --local"
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
+	echo -e "$objsha2\n$bitmaptip" >keepobjects &&
+	pack2=$(git pack-objects pack2 <keepobjects) &&
+	mv pack2-$pack2.* .git/objects/pack/ &&
+	touch .git/objects/pack/pack2-$pack2.keep &&
+	rm $(objpath $objsha2) &&
+	echo HEAD | \
+	git pack-objects --honor-pack-keep --stdout --revs >2a.pack &&
+	git index-pack 2a.pack &&
+	git verify-pack -v 2a.pack >2a.objects &&
+	if grep -qFf keepobjects 2a.objects; then
+		echo "Object from .keeped pack present in pack generated with --honor-pack-keep"
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
+	if grep -qFf keepobjects 2b.objects; then
+		echo "Non-local object present in pack generated with --local"
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
@@ -143,6 +228,24 @@ test_expect_success 'create objects for missing-HAVE tests' '
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
2.9.2.701.gf965a18.dirty
