Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E52F1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 20:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758094AbcG1UWp (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 16:22:45 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:40301 "EHLO
	mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876AbcG1UWm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 16:22:42 -0400
Received: from teco.navytux.spb.ru (95-55-95-138.dynamic.avangarddsl.ru [95.55.95.138])
	by mail2.tiolive.com (Postfix) with ESMTPSA id 22D08BF0337;
	Thu, 28 Jul 2016 22:22:38 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
	(envelope-from <kirr@teco.navytux.spb.ru>)
	id 1bSrpG-0007mL-0D; Thu, 28 Jul 2016 23:22:38 +0300
Date:	Thu, 28 Jul 2016 23:22:37 +0300
From:	Kirill Smelkov <kirr@nexedi.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?J=E9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org,
	Vicent Marti <tanoku@gmail.com>
Subject: Re: [PATCH] pack-objects: Use reachability bitmap index when
 generating non-stdout pack too
Message-ID: <20160728202237.GC4026@teco.navytux.spb.ru>
References: <20160725185313.GA13007@sigill.intra.peff.net>
 <20160727201506.GA15204@teco.navytux.spb.ru>
 <xmqqlh0mvmpn.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlh0mvmpn.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio, first of all thanks for feedback,

On Wed, Jul 27, 2016 at 01:40:36PM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@nexedi.com> writes:
> 
> > > From: Kirill Smelkov <kirr@nexedi.com>
> > Subject: [PATCH 1/2] pack-objects: Make sure use_bitmap_index is not active under
> >  --local or --honor-pack-keep
> >
> > Since 6b8fda2d (pack-objects: use bitmaps when packing objects) there
> > are two codepaths in pack-objects: with & without using bitmap
> > reachability index.
> >
> > However add_object_entry_from_bitmap(), despite its non-bitmapped
> > counterpart add_object_entry(), in no way does check for whether --local
> > or --honor-pack-keep should be respected. In non-bitmapped codepath this
> > is handled in want_object_in_pack(), but bitmapped codepath has simply
> > no such checking at all.
> >
> > The bitmapped codepath however was allowing to pass --local and
> > --honor-pack-keep and bitmap indices were still used under such
> > conditions - potentially giving wrong output (including objects from
> > non-local or .keep'ed pack).
> >
> > Instead of fixing bitmapped codepath to respect those options, since
> > currently no one actually need or use them in combination with bitmaps,
> > let's just force use_bitmap_index=0 when any of --local or
> > --honor-pack-keep are used and add appropriate comment about
> > not-checking for those in add_object_entry_from_bitmap()
> >
> > Suggested-by: Jeff King <peff@peff.net>
> > ---
> >  builtin/pack-objects.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index 15866d7..d7cf782 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -1055,6 +1055,12 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
> >  	if (have_duplicate_entry(sha1, 0, &index_pos))
> >  		return 0;
> >  
> > +	/*
> > +	 * for simplicity we always want object to be in pack, as
> > +	 * use_bitmap_index codepath assumes neither --local nor --honor-pack-keep
> > +	 * is active.
> > +	 */
> 
> I am not sure this comment is useful to readers.
> 
> Unless the readers are comparing add_object_entry() and this
> function and wondering why this side lacks a check here, iow, when
> they are merely following from a caller of this function through
> this function down to its callee to understand what goes on, this
> comment would not help them and only confuse them.
> 
> If we were to say something to help those who are comparing these
> two functions, I think we should be more explicit, i.e.
> 
>     The caller disables use-bitmap-index when --local or
>     --honor-pack-keep options are in effect because bitmap code is
>     not prepared to handle them.  Because the control does not reach
>     here if these options are in effect, the check with
>     want_object_in_pack() to skip objects is not done.
> 
> or something like that.

You are probably right.


> Or is the rest of the bitmap codepath prepared to handle these
> options and it is just the matter of adding the missing check with
> want_object_in_pack() here to make it work correctly?

I'm waiting so long for main patch to be at least queued to pu, that I'm
now a bit frustrated and ready to do something not related to main goal :)
(they say every joke contains part of a joke). Here is something from
sleepy me:

---- 8< ----
From: Kirill Smelkov <kirr@nexedi.com>
Date: Wed, 27 Jul 2016 22:18:04 +0300
Subject: [PATCH 1/2] pack-objects: Teach --use-bitmap-index codepath to
 respect --local, --honor-pack-keep and --incremental

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
only need to check that pack for same omission criteria used in
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
---- 8< ----


and main patch updated to avoid trivial conflicts

---- 8< ----
From: Kirill Smelkov <kirr@nexedi.com>
Date: Thu, 7 Jul 2016 20:12:00 +0300
Subject: [PATCH 2/2] pack-objects: Teach it to use reachability bitmap index
 when generating non-stdout pack too

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

---- 8< ----
$ time echo 0186ac99 | git pack-objects --stdout --revs >erp5pack-stdout.pack

real    0m22.309s
user    0m21.148s
sys     0m0.932s

$ time git index-pack erp5pack-stdout.pack

real    0m50.873s   <-- more than 2 times slower than time to generate pack itself!
user    0m49.300s
sys     0m1.360s
---- 8< ----

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
---- 8< ----

Thanks,
Kirill
