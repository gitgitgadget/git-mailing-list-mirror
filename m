Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D3111FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 19:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbcGLTIT (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 15:08:19 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:47858 "EHLO
	mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbcGLTIR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 15:08:17 -0400
Received: from teco.navytux.spb.ru (pppoe.178-66-16-76.dynamic.avangarddsl.ru [178.66.16.76])
	by mail2.tiolive.com (Postfix) with ESMTPSA id 6F8A8BF02E4;
	Tue, 12 Jul 2016 21:08:09 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
	(envelope-from <kirr@teco.navytux.spb.ru>)
	id 1bN32O-0004Mn-4d; Tue, 12 Jul 2016 22:08:08 +0300
Date:	Tue, 12 Jul 2016 22:08:08 +0300
From:	Kirill Smelkov <kirr@nexedi.com>
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?J=E9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org,
	Vicent Marti <tanoku@gmail.com>
Subject: Re: [PATCH] pack-objects: Use reachability bitmap index when
 generating non-stdout pack too
Message-ID: <20160712190807.GB4809@teco.navytux.spb.ru>
References: <20160707190917.20011-1-kirr@nexedi.com>
 <20160707205223.GA11753@sigill.intra.peff.net>
 <20160708103855.GD5462@teco.navytux.spb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160708103855.GD5462@teco.navytux.spb.ru>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 08, 2016 at 01:38:55PM +0300, Kirill Smelkov wrote:
> Peff first of all thanks for feedback,
> 
> On Thu, Jul 07, 2016 at 04:52:23PM -0400, Jeff King wrote:
> > On Thu, Jul 07, 2016 at 10:09:17PM +0300, Kirill Smelkov wrote:
> > 
> > > Starting from 6b8fda2d (pack-objects: use bitmaps when packing objects)
> > > if a repository has bitmap index, pack-objects can nicely speedup
> > > "Counting objects" graph traversal phase. That however was done only for
> > > case when resultant pack is sent to stdout, not written into a file.
> > > 
> > > We can teach pack-objects to use bitmap index for initial object
> > > counting phase when generating resultant pack file too:
> > 
> > I'm not sure this is a good idea in general. When bitmaps are in use, we
> > cannot fill out the details in the object-packing list as thoroughly. In
> > particular:
> > 
> >   - we will not compute the same write order (which is based on
> >     traversal order), leading to packs that have less efficient cache
> >     characteristics
> 
> I agree the order can be not exactly the same. Still if original pack is
> packed well (with good recency order), while using bitmap we will tend
> to traverse it in close to original order.
> 
> Maybe I'm not completely right on this, but to me it looks to be the
> case because if objects in original pack are put there linearly sorted
> by recency order, and we use bitmap index to set of all reachable
> objects from a root, and then just _linearly_ gather all those objects
> from original pack by 1s in bitmap and put them in the same order into
> destination pack, the recency order won't be broken.
> 
> Or am I maybe misunderstanding something?
> 
> Please also see below:
> 
> >   - we don't learn about the filename of trees and blobs, which is going
> >     to make the delta step much less efficient. This might be mitigated
> >     by turning on the bitmap name-hash cache; I don't recall how much
> >     detail pack-objects needs on the name (i.e., the full name versus
> >     just the hash).
> 
> If I understand it right, it uses only uint32_t name hash while searching. From
> pack-objects.{h,c} :
> 
> ---- 8< ----
> struct object_entry {
> 	...
> 	uint32_t hash;                  /* name hint hash */
> 
> 
> /*
>  * We search for deltas in a list sorted by type, by filename hash, and then
>  * by size, so that we see progressively smaller and smaller files.
>  * That's because we prefer deltas to be from the bigger file
>  * to the smaller -- deletes are potentially cheaper, but perhaps
>  * more importantly, the bigger file is likely the more recent
>  * one.  The deepest deltas are therefore the oldest objects which are
>  * less susceptible to be accessed often.
>  */
> static int type_size_sort(const void *_a, const void *_b)
> {
>         const struct object_entry *a = *(struct object_entry **)_a;
>         const struct object_entry *b = *(struct object_entry **)_b;
> 
>         if (a->type > b->type)
>                 return -1;
>         if (a->type < b->type) 
>                 return 1;
>         if (a->hash > b->hash)
>                 return -1;
>         if (a->hash < b->hash)
>                 return 1;
> 	...
> ---- 8< ----
> 
> Documentation/technical/pack-heuristics.txt also confirms this:
> 
> ---- 8< ----
>     ...
>     <gitster> The quote from the above linus should be rewritten a
>         bit (wait for it):
>         - first sort by type.  Different objects never delta with
>           each other.
>         - then sort by filename/dirname.  hash of the basename
>           occupies the top BITS_PER_INT-DIR_BITS bits, and bottom
>           DIR_BITS are for the hash of leading path elements.
> 
>     ...
> 
>     If I might add, the trick is to make files that _might_ be similar be
>     located close to each other in the hash buckets based on their file
>     names.  It used to be that "foo/Makefile", "bar/baz/quux/Makefile" and
>     "Makefile" all landed in the same bucket due to their common basename,
>     "Makefile". However, now they land in "close" buckets.
>     
>     The algorithm allows not just for the _same_ bucket, but for _close_
>     buckets to be considered delta candidates.  The rationale is
>     essentially that files, like Makefiles, often have very similar
>     content no matter what directory they live in.
> ---- 8< ----
> 
> 
> So yes, exactly as you say with pack.writeBitmapHashCache=true (ae4f07fb) the
> delta-search heuristics is almost as efficient as with just raw filenames.
> 
> I can confirm this also via e.g. (with my patch applied) :
> 
> ---- 8< ----
> $ time echo 0186ac99 | git pack-objects --no-use-bitmap-index --revs erp5pack-plain
> Counting objects: 627171, done.
> Compressing objects: 100% (176949/176949), done.
> 50570987560d481742af4a8083028c2322a0534a
> Writing objects: 100% (627171/627171), done.
> Total 627171 (delta 439404), reused 594820 (delta 410210)
> 
> real    0m37.272s
> user    0m33.648s
> sys     0m1.580s
> 
> $ time echo 0186ac99 | git pack-objects --revs erp5pack-bitmap
> Counting objects: 627171, done.
> Compressing objects: 100% (176914/176914), done.
> 7c15a9b1eca1326e679297b217c5a48954625ca2
> Writing objects: 100% (627171/627171), done.
> Total 627171 (delta 439484), reused 594855 (delta 410245)
> 
> real    0m27.020s
> user    0m23.364s
> sys     0m0.992s
> 
> $ ll erp5pack-{plain,bitmap}*
> 	  17561860  erp5pack-bitmap-7c15a9b1eca1326e679297b217c5a48954625ca2.idx
> 	 238760161  erp5pack-bitmap-7c15a9b1eca1326e679297b217c5a48954625ca2.pack
> 	  17561860  erp5pack-plain-50570987560d481742af4a8083028c2322a0534a.idx
> 	 238634201  erp5pack-plain-50570987560d481742af4a8083028c2322a0534a.pack
> ---- 8< ----
> 
> ( By the way about pack generated with bitmap retaining close recency
>   order:
> 
>   ---- 8< ----
>   $ git verify-pack -v erp5pack-plain-50570987560d481742af4a8083028c2322a0534a.pack >1
>   $ git verify-pack -v erp5pack-bitmap-7c15a9b1eca1326e679297b217c5a48954625ca2.pack >2
>   $ grep commit 1 |awk '{print $1}' >1.commit
>   $ grep commit 2 |awk '{print $1}' >2.commit
>   $ wc -l 1.commit
>   46136 1.commit
>   $ wc -l 2.commit
>   46136 2.commit
>   $ diff -u0 1.commit 2.commit |wc -l
>   55
>   ---- 8< ----
>   
>   so 55/46136 shows it is very almost the same. )
> 
> 
> > There may be other subtle things, too. The general idea of tying the
> > bitmap use to pack_to_stdout is that you _do_ want to use it for
> > serving fetches and pushes, but for a full on-disk repack via gc, it's
> > more important to generate a good pack.
> 
> It is better we send good packs to clients too, right? And with
> pack.writeBitmapHashCache=true and retaining recency order (please see
> above, but again maybe I'm not completely right) to me we should be still
> generating a good pack while using bitmap reachability index for object
> graph traversal.
> 
> > Your use case:
> > 
> > > git-backup extracts many packs on repositories restoration. That was my
> > > initial motivation for the patch.
> > 
> > Seems to be somewhere in between. I'm not sure I understand how you're
> > invoking pack-objects here,
> 
> It is just
> 
>     pack-objects --revs --reuse-object --reuse-delta --delta-base-offset extractedrepo/objects/pack/pack  < SHA1-HEADS
> 
>     https://lab.nexedi.com/kirr/git-backup/blob/7fcb8c67/git-backup.go#L829
> 
> > but I wonder if you should be using "pack-objects --stdout" yourself.
> 
> I already tried --stdout. The problem is on repository extraction we
> need to both extract the pack and index it. While `pack-object file`
> does both, for --stdout case we need to additionally index extracted
> pack with `git index-pack`, and standalone `git index-pack` is very slow
> - in my experience much slower than generating the pack itself:
> 
> ---- 8< ----
> $ time echo 0186ac99 | git pack-objects --stdout --revs >erp5pack-stdout.pack
> Counting objects: 627171, done.
> Compressing objects: 100% (176914/176914), done.
> Total 627171 (delta 439484), reused 594855 (delta 410245)
> 
> real    0m22.309s
> user    0m21.148s
> sys     0m0.932s
> 
> $ ll erp5pack-stdout*
>         238760161   erp5pack-stdout.pack
> 
> $ time git index-pack erp5pack-stdout.pack
> 7c15a9b1eca1326e679297b217c5a48954625ca2
> 
> real    0m50.873s   <-- more than 2 times slower than time to generate pack itself!
> user    0m49.300s
> sys     0m1.360s
> 
> $ ll erp5pack-stdout*
>          17561860   erp5pack-stdout.idx
>         238760161   erp5pack-stdout.pack
> ---- 8< ----
> 
> So the time for
> 
>     `pack-object --stdout >file.pack` + `index-pack file.pack`  is  72s,
>     
> while
> 
>     `pack-objects file.pack` which does both pack and index     is  27s.
>     
> And even
> 
>     `pack-objects --no-use-bitmap-index file.pack`              is  37s.
> 
> 
> I've tried to briefly see why index-pack is so slow and offhand I can
> see that it needs to load all objects, decompresses them etc (maybe I'm
> not so right here - I looked only briefly), while pack-objects while
> generating the pack has all needed information directly at hand and thus
> can emit index much more easily.
> 
> For sever - clients scenario, index-pack load is put onto clients thus
> offloading server, but for my use case where extracted repository is on
> the same machine the load does not go away.
> 
> That's why for me it makes more sense to emit both pack and its index in
> one go.
> 
> Still it would be interesting to eventually see why index-pack is so
> anomaly slow.
> 
> > But even if it is the right thing for your use case to be using bitmaps
> > to generate an on-disk bitmap, I think we should be making sure it
> > _doesn't_ trigger when doing a normal repack.
> 
> So seems the way forward here is to teach pack-objects not to silently
> drop explicit --use-pack-bitmap for cases when it can handle it?
> (currently even if this option was given, for !stdout cases pack-objects
> simply drop use_bitmap_index to 0).
> 
> And to make sure default for use_bitmap_index is 0 for !stdout cases?
> 
> Or are we fine with my arguments about recency order staying the same
> when using bitmap reachability index for object graph traversal, and this
> way the patch is fine to go in as it is?

Since there is no reply I assume the safe way to go is to let default
for pack-to-file case to be "not using bitmap index". Please find updated
patch and interdiff below. I would still be grateful for feedback on
my above use-bitmap-for-pack-to-file arguments.

Thanks,
Kirill

(interdiff)
diff --git a/Documentation/config.txt b/Documentation/config.txt
index e455fae..1888f42 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2241,12 +2241,20 @@ pack.packSizeLimit::
 	Common unit suffixes of 'k', 'm', or 'g' are
 	supported.
 
-pack.useBitmaps::
+pack.useBitmaps (deprecated)::
+	This is a deprecated synonym for `pack.useBitmaps.stdout`.
+
+pack.useBitmaps.stdout::
 	When true, git will use pack bitmaps (if available) when packing
 	to stdout (e.g., during the server side of a fetch). Defaults to
 	true. You should not generally need to turn this off unless
 	you are debugging pack bitmaps.
 
+pack.useBitmaps.file::
+	When true, git will use pack bitmaps (if available) when packing
+	to file (e.g., on repack). Defaults to false. You should not
+	generally need to turn this on unless you know what you are doing.
+
 pack.writeBitmaps (deprecated)::
 	This is a deprecated synonym for `repack.writeBitmaps`.
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index be0ebe8..7aaa1af 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -66,7 +66,8 @@ static struct packed_git *reuse_packfile;
 static uint32_t reuse_packfile_objects;
 static off_t reuse_packfile_offset;
 
-static int use_bitmap_index = 1;
+static int use_bitmap_stdout = 1, use_bitmap_file = 0;
+static int use_bitmap_index;
 static int write_bitmap_index;
 static uint16_t write_bitmap_options;
 
@@ -2227,8 +2228,12 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		else
 			write_bitmap_options &= ~BITMAP_OPT_HASH_CACHE;
 	}
-	if (!strcmp(k, "pack.usebitmaps")) {
-		use_bitmap_index = git_config_bool(k, v);
+	if (!strcmp(k, "pack.usebitmaps") || !strcmp(k, "pack.usebitmaps.stdout")) {
+		use_bitmap_stdout = git_config_bool(k, v);
+		return 0;
+	}
+	if (!strcmp(k, "pack.usebitmaps.file")) {
+		use_bitmap_file = git_config_bool(k, v);
 		return 0;
 	}
 	if (!strcmp(k, "pack.threads")) {
@@ -2705,6 +2710,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	reset_pack_idx_option(&pack_idx_opts);
 	git_config(git_pack_config, NULL);
+	use_bitmap_index = pack_to_stdout ? use_bitmap_stdout : use_bitmap_file;
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level = core_compression_level;
 
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 533fc31..9fab2bb 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -122,9 +122,14 @@ test_expect_success 'pack-objects to file can use bitmap' '
 	# make sure we still have 1 bitmap index from previous tests
 	ls .git/objects/pack/ | grep bitmap >output &&
 	test_line_count = 1 output &&
-	# pack-objects uses bitmap index by default, when it is available
-	packsha1=$(git pack-objects --all mypack </dev/null) &&
-	git verify-pack mypack-$packsha1.pack
+	# verify equivalent packs are generated with/without using bitmap index
+	packasha1=$(git pack-objects --no-use-bitmap-index --all packa </dev/null) &&
+	packbsha1=$(git pack-objects --use-bitmap-index --all packb </dev/null) &&
+	git verify-pack -v packa-$packasha1.pack >packa.verify &&
+	git verify-pack -v packb-$packbsha1.pack >packb.verify &&
+	grep -o "^$_x40" packa.verify |sort >packa.objects &&
+	grep -o "^$_x40" packb.verify |sort >packb.objects &&
+	test_cmp packa.objects packb.objects
 '
 
 test_expect_success 'full repack, reusing previous bitmaps' '


---- 8< ----
From: Kirill Smelkov <kirr@nexedi.com>
Date: Thu, 7 Jul 2016 20:12:00 +0300
Subject: [PATCH v2] pack-objects: Teach it to use reachability bitmap index when
 generating non-stdout pack too

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

NOTE

Jeff King suggested that it might be not generally a good idea to
use bitmap reachability index when repacking a repository. For this
reason when packing to a file the default is not to use bitmap, while
for packing-to-stdout case the default stays to be "bitmap is used".

The defaults can be configured with

    pack.useBitmaps.stdout      (renamed from pack.useBitmaps), and
    pack.useBitmaps.file

More context:

    http://article.gmane.org/gmane.comp.version-control.git/299063
    http://article.gmane.org/gmane.comp.version-control.git/299107

Cc: Vicent Marti <tanoku@gmail.com>
Cc: Jeff King <peff@peff.net>
Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 Documentation/config.txt | 10 +++++++++-
 builtin/pack-objects.c   | 19 ++++++++++++++-----
 t/t5310-pack-bitmaps.sh  | 14 ++++++++++++++
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e455fae..1888f42 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2241,12 +2241,20 @@ pack.packSizeLimit::
 	Common unit suffixes of 'k', 'm', or 'g' are
 	supported.
 
-pack.useBitmaps::
+pack.useBitmaps (deprecated)::
+	This is a deprecated synonym for `pack.useBitmaps.stdout`.
+
+pack.useBitmaps.stdout::
 	When true, git will use pack bitmaps (if available) when packing
 	to stdout (e.g., during the server side of a fetch). Defaults to
 	true. You should not generally need to turn this off unless
 	you are debugging pack bitmaps.
 
+pack.useBitmaps.file::
+	When true, git will use pack bitmaps (if available) when packing
+	to file (e.g., on repack). Defaults to false. You should not
+	generally need to turn this on unless you know what you are doing.
+
 pack.writeBitmaps (deprecated)::
 	This is a deprecated synonym for `repack.writeBitmaps`.
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a2f8cfd..7aaa1af 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -66,7 +66,8 @@ static struct packed_git *reuse_packfile;
 static uint32_t reuse_packfile_objects;
 static off_t reuse_packfile_offset;
 
-static int use_bitmap_index = 1;
+static int use_bitmap_stdout = 1, use_bitmap_file = 0;
+static int use_bitmap_index;
 static int write_bitmap_index;
 static uint16_t write_bitmap_options;
 
@@ -1052,6 +1053,9 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
 {
 	uint32_t index_pos;
 
+	if (local && has_loose_object_nonlocal(sha1))
+		return 0;
+
 	if (have_duplicate_entry(sha1, 0, &index_pos))
 		return 0;
 
@@ -2224,8 +2228,12 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		else
 			write_bitmap_options &= ~BITMAP_OPT_HASH_CACHE;
 	}
-	if (!strcmp(k, "pack.usebitmaps")) {
-		use_bitmap_index = git_config_bool(k, v);
+	if (!strcmp(k, "pack.usebitmaps") || !strcmp(k, "pack.usebitmaps.stdout")) {
+		use_bitmap_stdout = git_config_bool(k, v);
+		return 0;
+	}
+	if (!strcmp(k, "pack.usebitmaps.file")) {
+		use_bitmap_file = git_config_bool(k, v);
 		return 0;
 	}
 	if (!strcmp(k, "pack.threads")) {
@@ -2488,7 +2496,7 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 	if (prepare_bitmap_walk(revs) < 0)
 		return -1;
 
-	if (pack_options_allow_reuse() &&
+	if (pack_options_allow_reuse() && pack_to_stdout &&
 	    !reuse_partial_packfile_from_bitmap(
 			&reuse_packfile,
 			&reuse_packfile_objects,
@@ -2702,6 +2710,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	reset_pack_idx_option(&pack_idx_opts);
 	git_config(git_pack_config, NULL);
+	use_bitmap_index = pack_to_stdout ? use_bitmap_stdout : use_bitmap_file;
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level = core_compression_level;
 
@@ -2773,7 +2782,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
-	if (!use_internal_rev_list || !pack_to_stdout || is_repository_shallow())
+	if (!use_internal_rev_list || (!pack_to_stdout && write_bitmap_index) || is_repository_shallow())
 		use_bitmap_index = 0;
 
 	if (pack_to_stdout || !rev_list_all)
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 3893afd..9fab2bb 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -118,6 +118,20 @@ test_expect_success 'incremental repack can disable bitmaps' '
 	git repack -d --no-write-bitmap-index
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
