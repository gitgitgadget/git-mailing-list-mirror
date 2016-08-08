Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 443B82018E
	for <e@80x24.org>; Mon,  8 Aug 2016 15:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbcHHPlA (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 11:41:00 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:41266 "EHLO
	mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbcHHPk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 11:40:58 -0400
Received: from teco.navytux.spb.ru (pppoe.178-66-29-27.dynamic.avangarddsl.ru [178.66.29.27])
	by mail2.tiolive.com (Postfix) with ESMTPSA id 68918BF0097;
	Mon,  8 Aug 2016 17:40:55 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
	(envelope-from <kirr@teco.navytux.spb.ru>)
	id 1bWmfe-0007Fq-IG; Mon, 08 Aug 2016 18:40:54 +0300
Date:	Mon, 8 Aug 2016 18:40:54 +0300
From:	Kirill Smelkov <kirr@nexedi.com>
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Vicent Marti <tanoku@gmail.com>,
	=?iso-8859-1?Q?J=E9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 2/2] pack-objects: Teach it to use reachability bitmap
 index when generating non-stdout pack too
Message-ID: <20160808154054.GB3995@teco.navytux.spb.ru>
References: <20160729074051.GA5987@teco.navytux.spb.ru>
 <20160729074746.31862-1-kirr@nexedi.com>
 <20160808135600.c6hdlqwwtqe7thd5@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160808135600.c6hdlqwwtqe7thd5@sigill.intra.peff.net>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 08, 2016 at 09:56:00AM -0400, Jeff King wrote:
> On Fri, Jul 29, 2016 at 10:47:46AM +0300, Kirill Smelkov wrote:
> 
> > @@ -2527,7 +2528,7 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
> >  	if (prepare_bitmap_walk(revs) < 0)
> >  		return -1;
> >  
> > -	if (pack_options_allow_reuse() &&
> > +	if (pack_options_allow_reuse() && pack_to_stdout &&
> >  	    !reuse_partial_packfile_from_bitmap(
> 
> Should pack_to_stdout just be part of pack_options_allow_reuse()?

Yes, makes sense; thanks for catching this.


> > @@ -2812,7 +2813,23 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
> >  	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
> >  		unpack_unreachable_expiration = 0;
> >  
> > -	if (!use_internal_rev_list || !pack_to_stdout || is_repository_shallow())
> > +	/*
> > +	 * "soft" reasons not to use bitmaps - for on-disk repack by default we want
> > +	 *
> > +	 * - to produce good pack (with bitmap index not-yet-packed objects are
> > +	 *   packed in suboptimal order).
> > +	 *
> > +	 * - to use more robust pack-generation codepath (avoiding possible
> > +	 *   bugs in bitmap code and possible bitmap index corruption).
> > +	 */
> > +	if (!pack_to_stdout)
> > +		use_bitmap_index_default = 0;
> > +
> > +	if (use_bitmap_index < 0)
> > +		use_bitmap_index = use_bitmap_index_default;
> > +
> > +	/* "hard" reasons not to use bitmaps; these just won't work at all */
> > +	if (!use_internal_rev_list || (!pack_to_stdout && write_bitmap_index) || is_repository_shallow())
> >  		use_bitmap_index = 0;
> 
> This all makes sense and looks good.

Thanks.


> > +test_expect_success 'pack-objects to file can use bitmap' '
> > +	# make sure we still have 1 bitmap index from previous tests
> > +	ls .git/objects/pack/ | grep bitmap >output &&
> > +	test_line_count = 1 output &&
> > +	# verify equivalent packs are generated with/without using bitmap index
> > +	packasha1=$(git pack-objects --no-use-bitmap-index --all packa </dev/null) &&
> > +	packbsha1=$(git pack-objects --use-bitmap-index --all packb </dev/null) &&
> > +	git verify-pack -v packa-$packasha1.pack >packa.verify &&
> > +	git verify-pack -v packb-$packbsha1.pack >packb.verify &&
> > +	grep -o "^$_x40" packa.verify |sort >packa.objects &&
> > +	grep -o "^$_x40" packb.verify |sort >packb.objects &&
> > +	test_cmp packa.objects packb.objects
> > +'
> 
> I don't think "grep -o" is portable. However, an easier way to do this
> is probably:
> 
>   # these are already in sorted order
>   git show-index <packa-$packasha1.pack | cut -d' ' -f2 >packa.objects &&
>   git show-index <packb-$packbsha1.pack | cut -d' ' -f2 >packb.objects &&
>   test_cmp packa.objects packb.objects

Thanks for the info. I did not knew about show-index when I was starting
to work on this and later it just came out of sight. Please find
corrected patch below.

---- 8< ----
From: Kirill Smelkov <kirr@nexedi.com>
Date: Fri, 29 Jul 2016 10:47:46 +0300
Subject: [PATCH v5] pack-objects: Teach it to use reachability bitmap index when
 generating non-stdout pack too

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

More context:

    http://marc.info/?t=146792101400001&r=1&w=2

Cc: Vicent Marti <tanoku@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 Documentation/config.txt |  3 +++
 builtin/pack-objects.c   | 31 ++++++++++++++++++++++++-------
 t/t5310-pack-bitmaps.sh  | 12 ++++++++++++
 3 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bc1c433..4ba0c4a 100644
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
index 92e2e5f..0a89e8d 100644
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
 
@@ -2226,7 +2227,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 			write_bitmap_options &= ~BITMAP_OPT_HASH_CACHE;
 	}
 	if (!strcmp(k, "pack.usebitmaps")) {
-		use_bitmap_index = git_config_bool(k, v);
+		use_bitmap_index_default = git_config_bool(k, v);
 		return 0;
 	}
 	if (!strcmp(k, "pack.threads")) {
@@ -2475,13 +2476,13 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
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
@@ -2774,7 +2775,23 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
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
index 3893afd..ffecc6a 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -118,6 +118,18 @@ test_expect_success 'incremental repack can disable bitmaps' '
 	git repack -d --no-write-bitmap-index
 '
 
+test_expect_success 'pack-objects to file can use bitmap' '
+	# make sure we still have 1 bitmap index from previous tests
+	ls .git/objects/pack/ | grep bitmap >output &&
+	test_line_count = 1 output &&
+	# verify equivalent packs are generated with/without using bitmap index
+	packasha1=$(git pack-objects --no-use-bitmap-index --all packa </dev/null) &&
+	packbsha1=$(git pack-objects --use-bitmap-index --all packb </dev/null) &&
+	git show-index <packa-$packasha1.idx | cut -d" " -f2 >packa.objects &&
+	git show-index <packb-$packbsha1.idx | cut -d" " -f2 >packb.objects &&
+	test_cmp packa.objects packb.objects
+'
+
 test_expect_success 'full repack, reusing previous bitmaps' '
 	git repack -ad &&
 	ls .git/objects/pack/ | grep bitmap >output &&
-- 
2.9.2.701.gf965a18.dirty
