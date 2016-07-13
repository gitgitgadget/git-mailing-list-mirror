Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 492DD1F744
	for <e@80x24.org>; Wed, 13 Jul 2016 10:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794AbcGMKx0 (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 06:53:26 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:39153 "EHLO
	mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbcGMKxX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 06:53:23 -0400
Received: from teco.navytux.spb.ru (pppoe.178-66-6-140.dynamic.avangarddsl.ru [178.66.6.140])
	by mail2.tiolive.com (Postfix) with ESMTPSA id D9565BF02E4;
	Wed, 13 Jul 2016 12:52:17 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
	(envelope-from <kirr@teco.navytux.spb.ru>)
	id 1bNHm5-0003P9-0w; Wed, 13 Jul 2016 13:52:17 +0300
Date:	Wed, 13 Jul 2016 13:52:17 +0300
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
Message-ID: <20160713105216.GB16000@teco.navytux.spb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160713083044.GB18144@sigill.intra.peff.net>
 <20160713082653.GA18144@sigill.intra.peff.net>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 13, 2016 at 04:26:53AM -0400, Jeff King wrote:
> On Fri, Jul 08, 2016 at 01:38:55PM +0300, Kirill Smelkov wrote:
> 
> > >   - we will not compute the same write order (which is based on
> > >     traversal order), leading to packs that have less efficient cache
> > >     characteristics
> > 
> > I agree the order can be not exactly the same. Still if original pack is
> > packed well (with good recency order), while using bitmap we will tend
> > to traverse it in close to original order.
> > 
> > Maybe I'm not completely right on this, but to me it looks to be the
> > case because if objects in original pack are put there linearly sorted
> > by recency order, and we use bitmap index to set of all reachable
> > objects from a root, and then just _linearly_ gather all those objects
> > from original pack by 1s in bitmap and put them in the same order into
> > destination pack, the recency order won't be broken.
> > 
> > Or am I maybe misunderstanding something?
> 
> Yeah, I think you can go some of the way by reusing the order from the
> old pack. But keep in mind that the bitmap result may also contain
> objects that are not yet packed. Those will just come in a big lump at
> the end of the bitmap (these are the "extended entries" in the bitmap
> code).
> 
> So I think if you were to repeatedly "git repack -adb" over time, you
> would get worse and worse ordering as objects are added to the
> repository.

Jeff, first of all thanks for clarifying.

So it is not-yet-packed-objects which make packing with bitmap less
efficient. I was originally keeping in mind fresh repacked repository
with just built bitmap index and for that case extracting pack with
bitmap index seems to be just ok, but the more not-yet-packed objects we
have the worse the result can be.

> As an aside, two other things that pack order matters for: it makes the
> bitmaps themselves compress better (because it increases locality of
> reachability, so you get nice runs of "1" or "0" bits).

Yes I agree and thanks for bringing this up - putting objects in recency
order in pack also makes bitmap index to have larger runs of same 1 or 0.

> It also makes
> the pack-reuse code more efficient (since in an ideal case, you can just
> dump a big block of data from the front of the pack). Note that the
> pack-reuse code that's in upstream git isn't that great; I have a better
> system on my big pile of patches to send upstream (that never seems to
> get smaller; <sigh>).

Yes, it also make sense. I saw write_reused_pack() in upstream git just
copy raw bytes from original to destination pack. You mentioned you have
something better for pack reuse - in your patch queue, in two words, is
it now reusing pack based on object, not raw bytes, or is it something
else?

In other words in which way it works better? (I'm just curious here as
it is interesting to know)


> > >   - we don't learn about the filename of trees and blobs, which is going
> > >     to make the delta step much less efficient. This might be mitigated
> > >     by turning on the bitmap name-hash cache; I don't recall how much
> > >     detail pack-objects needs on the name (i.e., the full name versus
> > >     just the hash).
> > 
> > If I understand it right, it uses only uint32_t name hash while searching. From
> > pack-objects.{h,c} :
> 
> Yeah, I think you are right. Not having the real names is a problem for
> doing rev-list output, but I think pack-objects doesn't care (though do
> note that the name-hash cache is not enabled by default).

Yes, for packing it is only hash which is used. And I assume name-hash
for bitmap is not enabled by default for compatibility with JGit code.

It would make sense to me to eventually enable name-hash bitmap
extension by default, as packing result is much better with it. And
those who care about compatibility with JGit can just turn it off in
their git config.

Just my thoughts.

> > > There may be other subtle things, too. The general idea of tying the
> > > bitmap use to pack_to_stdout is that you _do_ want to use it for
> > > serving fetches and pushes, but for a full on-disk repack via gc, it's
> > > more important to generate a good pack.
> > 
> > It is better we send good packs to clients too, right? And with
> > pack.writeBitmapHashCache=true and retaining recency order (please see
> > above, but again maybe I'm not completely right) to me we should be still
> > generating a good pack while using bitmap reachability index for object
> > graph traversal.
> 
> We do want to send the client a good pack, but it's always a tradeoff.
> We could spend much more time searching for the perfect delta, but at
> some point we have to decide on how much CPU to spend serving them.
> Likewise, even if the bitmapped packs we send are in slightly worse
> order, saving a minute of CPU time off of every clone of the kernel is a
> big deal.

Yes, this I understand and agree. Like I said above I was imagining
freshly repacked repo with recently rebuilt bitmap index and for that
case we send a good pack with bitmaps out-of-the-box.

> We also take robustness shortcuts when sending to clients. For example,
> when doing an on-disk repack we re-crc32 all of the delta data we are
> reusing, even if we don't actually inflate it (because we would want to
> stop immediately if we see even a single bit flipped on disk). But we
> don't check them when sending to a client, because we know they are
> going to actually `index-pack` it and get a stronger consistency check
> anyway, and don't want to waste server CPU.
> 
> The bitmaps are sort of the same. If there is a bug or corruption in the
> bitmap, the worst case is that we send a broken pack to the client, who
> will complain that we did not give them all of the objects. It's a
> momentary problem that can be fixed. If you use them for an on-disk
> repack, then the next step is usually to delete all of the old packs. So
> a corruption there carries forward, and is irreversible.

Thanks for clarifying here. I did not knew pack-to-file is assumed to be
robust and pack-to-stdout is assumed to be allowed to be less so. Or at
least I did not thought about it this way before.

> As I understand your use case, it is OK to do the less careful things.
> It's just that pack-objects until now has been split into two modes:
> packing to a file is careful, and packing to stdout is less so. And you
> want to pack to a file in the non-careful mode.

Yes, it should be ok, as after repository extraction git-backup
verifies rev-list for all refs

    https://lab.nexedi.com/kirr/git-backup/blob/7fcb8c67/git-backup.go#L855

And if an object is missing - e.g. a blob - rev-list complains:

    fatal: missing blob object '980a0d5f19a64b4b30a87d4206aade58726b60e3'

though it does not catch blob corruptions.

As with when using bitmap index (due to bug in bitmap code or bitmap
index corruprtion) the worst that can happen is not all objects are
extracted, this should be effective measure to catch it.

The original whole-backup repository is also not removed, so we can
re-extract objects anytime.

So yes, using bitmap reachability index for faster extraction from
freshly repacked and bitmap indexed backup repository should be ok and
make sense to me.


> > > but I wonder if you should be using "pack-objects --stdout" yourself.
> > 
> > I already tried --stdout. The problem is on repository extraction we
> > need to both extract the pack and index it. While `pack-object file`
> > does both, for --stdout case we need to additionally index extracted
> > pack with `git index-pack`, and standalone `git index-pack` is very slow
> > - in my experience much slower than generating the pack itself:
> 
> Ah, right, that makes sense. The packfile does not carry the sha1 of the
> objects. A receiving index-pack has to compute them itself, including
> inflating and applying all of the deltas! By contrast, a pack to stdout
> can be quite quick, because in most cases it can avoid even inflating
> most of the data; where possible it just sends the zlib data straight
> from disk to the client.
> 
> So I do agree "--stdout" is not ideal for you (or at the very least, you
> really want pack-objects to generate the index from its internal table
> rather than having to reconstruct it just from the pack stream).

Yes, and thanks for clarifying a bit why standalone index-pack can be
slow.

> > > But even if it is the right thing for your use case to be using bitmaps
> > > to generate an on-disk bitmap, I think we should be making sure it
> > > _doesn't_ trigger when doing a normal repack.
> > 
> > So seems the way forward here is to teach pack-objects not to silently
> > drop explicit --use-pack-bitmap for cases when it can handle it?
> > (currently even if this option was given, for !stdout cases pack-objects
> > simply drop use_bitmap_index to 0).
> > 
> > And to make sure default for use_bitmap_index is 0 for !stdout cases?
> 
> I think it would be reasonable to accept "--use-bitmap-index" on the
> command line as an override for "yes, really, this is what I want". So
> the logic would be something like:
> 
>   static int use_bitmap_index_default = 1;
>   static int use_bitmap_index = -1;
> 
>   ... parse config; if we see pack.usebitmaps, set
>       use_bitmap_index_default ...
> 
>   ... parse command line, setting use_bitmap_index ...
> 
>   /* "soft" reasons not to use bitmaps */
>   if (!pack_to_stdout)
> 	use_bitmap_index_default = 0;
> 
>   /* now install our default if the user didn't otherwise specify */
>   if (use_bitmap_index < 0)
> 	use_bitmap_index = use_bitmap_index_default;
> 
>   /* "hard" reasons not to use bitmaps; these just won't work at all */
>   if (!use_internal_rev_list || is_repository_shallow())
> 	use_bitmap_index = 0;


On Wed, Jul 13, 2016 at 04:30:44AM -0400, Jeff King wrote:
> On Tue, Jul 12, 2016 at 10:08:08PM +0300, Kirill Smelkov wrote:
> 
> > > Or are we fine with my arguments about recency order staying the same
> > > when using bitmap reachability index for object graph traversal, and this
> > > way the patch is fine to go in as it is?
> > 
> > Since there is no reply I assume the safe way to go is to let default
> > for pack-to-file case to be "not using bitmap index". Please find updated
> > patch and interdiff below. I would still be grateful for feedback on
> > my above use-bitmap-for-pack-to-file arguments.
> 
> Yeah, I think that is a reasonable approach. I see here you've added new
> config, though, and I don't think we want that.
> 
> For your purposes, where you're driving pack-objects individually, I
> think a command-line option makes more sense.

Yes, I was going to use --use-bitmap-index explicitly, but I thought
since we already have pack.useBitmaps for consistency it is better to
introduce controlling to-file config point.


> If we did want to have a flag for "use bitmaps when repacking via
> repack", I think it should be "repack.useBitmaps", and git-repack should
> pass the command-line option to pack-objects. pack-objects is porcelain
> and should not really be reading config at all. You'll note that
> pack.writeBitmaps was a mistake and got deprecated in favor of
> repack.writeBitmaps. I think pack.useBitmaps is a mistake, too, but
> nobody has really noticed or cared because there's no good reason to set
> it (the more interesting question is: are there bitmaps available? and
> if so, we try to use them).

Probably pack.useBitmaps is of no use in normal situation, but for
debugging problems related to bitmaps it can be handy. Though when
someone debugs he/she can just adjust pack-objects.c . So should we
deprecate and eventually remove pack.useBitmaps ?

Anyway, please find below updated patch according to your suggestion.
Hope it is ok now.

Thanks again,
Kirill


(interdiff)
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8027951..4b14806 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2229,19 +2229,14 @@ pack.packSizeLimit::
 	Common unit suffixes of 'k', 'm', or 'g' are
 	supported.
 
-pack.useBitmaps (deprecated)::
-	This is a deprecated synonym for `pack.useBitmaps.stdout`.
-
-pack.useBitmaps.stdout::
+pack.useBitmaps::
 	When true, git will use pack bitmaps (if available) when packing
 	to stdout (e.g., during the server side of a fetch). Defaults to
 	true. You should not generally need to turn this off unless
 	you are debugging pack bitmaps.
-
-pack.useBitmaps.file::
-	When true, git will use pack bitmaps (if available) when packing
-	to file (e.g., on repack). Defaults to false. You should not
-	generally need to turn this on unless you know what you are doing.
++
+*NOTE*: when packing to file (e.g., on repack) the default is always not to use
+	pack bitmaps.
 
 pack.writeBitmaps (deprecated)::
 	This is a deprecated synonym for `repack.writeBitmaps`.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7aaa1af..ffe8da6 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -66,8 +66,8 @@ static struct packed_git *reuse_packfile;
 static uint32_t reuse_packfile_objects;
 static off_t reuse_packfile_offset;
 
-static int use_bitmap_stdout = 1, use_bitmap_file = 0;
-static int use_bitmap_index;
+static int use_bitmap_index_default = 1;
+static int use_bitmap_index = -1;
 static int write_bitmap_index;
 static uint16_t write_bitmap_options;
 
@@ -2228,12 +2228,8 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		else
 			write_bitmap_options &= ~BITMAP_OPT_HASH_CACHE;
 	}
-	if (!strcmp(k, "pack.usebitmaps") || !strcmp(k, "pack.usebitmaps.stdout")) {
-		use_bitmap_stdout = git_config_bool(k, v);
-		return 0;
-	}
-	if (!strcmp(k, "pack.usebitmaps.file")) {
-		use_bitmap_file = git_config_bool(k, v);
+	if (!strcmp(k, "pack.usebitmaps")) {
+		use_bitmap_index_default = git_config_bool(k, v);
 		return 0;
 	}
 	if (!strcmp(k, "pack.threads")) {
@@ -2710,7 +2706,6 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	reset_pack_idx_option(&pack_idx_opts);
 	git_config(git_pack_config, NULL);
-	use_bitmap_index = pack_to_stdout ? use_bitmap_stdout : use_bitmap_file;
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level = core_compression_level;
 
@@ -2782,6 +2777,22 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
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
 	if (!use_internal_rev_list || (!pack_to_stdout && write_bitmap_index) || is_repository_shallow())
 		use_bitmap_index = 0;
 

---- 8< ----
From: Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH v3] pack-objects: Teach it to use reachability bitmap index when
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
use bitmap reachability index when repacking a repository. The reason
here is for on-disk repack by default we want

- to produce good pack (with bitmap index not-yet-packed objects are
  emitted to pack in suboptimal order).

- to use more robust pack-generation codepath (avoiding possible
  bugs in bitmap code and possible bitmap index corruption).

Jeff also suggests that pack.useBitmaps was probably a mistake to
introduce originally. This way we are not adding another config point,
but instead just always default to-file pack-objects not to use bitmap
index: Tools which need to generate on-disk packs with using bitmap, can
pass --use-bitmap-index explicitly.

More context:

    http://article.gmane.org/gmane.comp.version-control.git/299063
    http://article.gmane.org/gmane.comp.version-control.git/299107
    http://article.gmane.org/gmane.comp.version-control.git/299420

Cc: Vicent Marti <tanoku@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 Documentation/config.txt |  3 +++
 builtin/pack-objects.c   | 28 ++++++++++++++++++++++++----
 t/t5310-pack-bitmaps.sh  | 14 ++++++++++++++
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index db05dec..4b14806 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2234,6 +2234,9 @@ pack.useBitmaps::
 	to stdout (e.g., during the server side of a fetch). Defaults to
 	true. You should not generally need to turn this off unless
 	you are debugging pack bitmaps.
++
+*NOTE*: when packing to file (e.g., on repack) the default is always not to use
+	pack bitmaps.
 
 pack.writeBitmaps (deprecated)::
 	This is a deprecated synonym for `repack.writeBitmaps`.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a2f8cfd..ffe8da6 100644
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
 
@@ -1052,6 +1053,9 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
 {
 	uint32_t index_pos;
 
+	if (local && has_loose_object_nonlocal(sha1))
+		return 0;
+
 	if (have_duplicate_entry(sha1, 0, &index_pos))
 		return 0;
 
@@ -2225,7 +2229,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 			write_bitmap_options &= ~BITMAP_OPT_HASH_CACHE;
 	}
 	if (!strcmp(k, "pack.usebitmaps")) {
-		use_bitmap_index = git_config_bool(k, v);
+		use_bitmap_index_default = git_config_bool(k, v);
 		return 0;
 	}
 	if (!strcmp(k, "pack.threads")) {
@@ -2488,7 +2492,7 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 	if (prepare_bitmap_walk(revs) < 0)
 		return -1;
 
-	if (pack_options_allow_reuse() &&
+	if (pack_options_allow_reuse() && pack_to_stdout &&
 	    !reuse_partial_packfile_from_bitmap(
 			&reuse_packfile,
 			&reuse_packfile_objects,
@@ -2773,7 +2777,23 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
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
