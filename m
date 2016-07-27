Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D8C61F621
	for <e@80x24.org>; Wed, 27 Jul 2016 20:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758257AbcG0UPY (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 16:15:24 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:56193 "EHLO
	mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757321AbcG0UPR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 16:15:17 -0400
Received: from teco.navytux.spb.ru (pppoe.178-66-26-123.dynamic.avangarddsl.ru [178.66.26.123])
	by mail2.tiolive.com (Postfix) with ESMTPSA id 06ABEBF0327;
	Wed, 27 Jul 2016 22:15:12 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
	(envelope-from <kirr@teco.navytux.spb.ru>)
	id 1bSVEQ-0004E4-D6; Wed, 27 Jul 2016 23:15:06 +0300
Date:	Wed, 27 Jul 2016 23:15:06 +0300
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
Message-ID: <20160727201506.GA15204@teco.navytux.spb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160725185313.GA13007@sigill.intra.peff.net>
 <20160725184025.GA12297@sigill.intra.peff.net>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 25, 2016 at 02:40:25PM -0400, Jeff King wrote:
> On Wed, Jul 13, 2016 at 01:52:17PM +0300, Kirill Smelkov wrote:
> 
> > > So I think if you were to repeatedly "git repack -adb" over time, you
> > > would get worse and worse ordering as objects are added to the
> > > repository.
> > 
> > Jeff, first of all thanks for clarifying.
> > 
> > So it is not-yet-packed-objects which make packing with bitmap less
> > efficient. I was originally keeping in mind fresh repacked repository
> > with just built bitmap index and for that case extracting pack with
> > bitmap index seems to be just ok, but the more not-yet-packed objects we
> > have the worse the result can be.
> 
> Right. So I think your scheme is fine as long as you are doing your
> regular "pack all into one" repacks with a real walk, and then
> "branching" off of that with one-off bitmap-computed packs into files
> (even if you later take a bunch of those files and pull them into a
> single bitmapped, as long as that final "all into one" does the walk).
> 
> Or I guess another way to think about it would be that if you're
> computing bitmaps, you'd want to do the actual traversal.

Yes, exactly, and thanks for stating it clearly. We are doing repacks
and recomputing bitmaps doing the real walk. As you say this should be
fine.


> > Yes, it also make sense. I saw write_reused_pack() in upstream git just
> > copy raw bytes from original to destination pack. You mentioned you have
> > something better for pack reuse - in your patch queue, in two words, is
> > it now reusing pack based on object, not raw bytes, or is it something
> > else?
> > 
> > In other words in which way it works better? (I'm just curious here as
> > it is interesting to know)
> 
> The problem with the existing pack-reuse code is that it doesn't kick in
> often enough. I think it looks to see that the client wants some
> percentage of the pack (e.g., 90%), and then just sends the whole
> beginning. This works especially badly if you have a bunch of related
> repositories packed together (e.g., all of the forks of torvalds/linux
> on GitHub), because you'll never hit 90% of that big pack; it has too
> much unrelated cruft, even if most of the stuff you want _is_ at the
> beginning. And "percent of pack" is not really a useful metric anyway.
> 
> So the better scheme is more like:
> 
>   1. Generate the bitmap of objects to send using reachability bitmaps.
> 
>   2. Do a quick scan of their content in the packfile to see which can
>      be reused verbatim. If they're base objects, we can send them
>      as-is. If they're deltas, we can send them if their base is going
>      to be sent. This fills in another bitmap of "reusable" objects.
> 
>      After a long string of unusable objects, you can give up and set
>      the rest of the bitmap to zeroes.
> 
>   3. Walk the "reuse" bitmap and send out the objects more-or-less
>      verbatim. You do have make adjustments to delta-base-offsets for
>      any "holes" (so if an object's entry says "my base is 500 bytes
>      back", but you omitted some objects in between, you have to adjust
>      that offset).
> 
> The upside is that you can send out those objects without even making a
> "struct object_entry" for them, which drastically reduces the memory
> requirements for serving a clone. Any objects which didn't get marked
> for reuse just get handled in the usual way (so stuff that was not close
> by in the pack, or stuff that was pushed since your last big repack).

Thanks for clarifying. Yes, you are right, current upstream code checks
to see whether >= 90% of pack is what destination wants and only reuse
in such case. (I forgot about it, initially putting reuse at side in my
head as "not applicable to git-backup" because of that >= 90% reason).

So with the scheme you are drawing above it can be indeed more
efficient, and applicable to both torvalds/linux+forks and git-backup
case (extracting packs from big pack of all repos).

I'm looking forward to your patches on this topic. Please cc me on those
if you find it convenient.

> The downside is that because those objects aren't in our normal packing
> list, they're not available as delta bases for the new objects we _do_
> send. So it can make the resulting pack a little bit bigger.

So once again, the badness effect is the more, the more we have such
"new" objects not in original main pack - i.e. as loose objects or
objects living in other smaller packs. The badness comes to zero in
ideal case of freshly repacked repo with only one big pack.

Also: after sending reused object, with more code effort, in principle
we can hook reused object for being considered as delta-bases for new
objects. I mean this should not be impossible in principle, or am I
missing something?


> > Yes, for packing it is only hash which is used. And I assume name-hash
> > for bitmap is not enabled by default for compatibility with JGit code.
> >
> > It would make sense to me to eventually enable name-hash bitmap
> > extension by default, as packing result is much better with it. And
> > those who care about compatibility with JGit can just turn it off in
> > their git config.
> 
> Correct, the defaults are for JGit compatibility. If you are not using
> JGit, you should have it on all the time.  We went with the conservative
> default, but as more people using regular Git bitmaps, it would probably
> be good to make them less arcane and confusing to use.

I've just checked - JGit 3.7.1.201504261725-r (the version from Debian -
quite old) does _not_ barf on seeing bitmaps with "name hash" section.
I mean at least it does not error-exit on `jgit gc`, like
t5310-pack-bitmaps.sh says it can:

    # jgit gc will barf if it does not like our bitmaps
    jgit gc


I will be sending another mail with relevant JGit people cc'ed to turn
pack.writeBitmapHashCache=true by default.


> > ---- 8< ----
> > From: Kirill Smelkov <kirr@nexedi.com>
> > Subject: [PATCH v3] pack-objects: Teach it to use reachability bitmap index when
> >  generating non-stdout pack too
> > 
> > Starting from 6b8fda2d (pack-objects: use bitmaps when packing objects)
> > if a repository has bitmap index, pack-objects can nicely speedup
> > "Counting objects" graph traversal phase. That however was done only for
> > case when resultant pack is sent to stdout, not written into a file.
> 
> I think we can give more motivation and context here with some of the
> bits that have come out in our discussion. Like:
> 
>   The reason for this split is that pack-objects tries to determine how
>   "careful" it should be based on whether we are packing to disk or to
>   stdout. Packing to disk implies "git repack", and that we will likely
>   delete the old packs after finishing. We want to be more careful (so
>   as not to carry forward a corruption, and to generate a more optimal
>   pack), and we presumably run less frequently and can afford extra CPU.
>   Whereas packing to stdout implies serving a remote via "git fetch" or
>   "git push". This happens more frequently (e.g., a server handling many
>   fetching clients), and we assume the receiving end takes more
>   responsibility for verifying the data.
> 
>   But this isn't always the case. One might want to generate on-disk
>   packfiles for a specialized object transfer. Just using "--stdout" and
>   writing to a file is not optimal, as it will not generate the matching
>   pack index.
> 
>   So it would be useful to have some way of overriding this heuristic:
>   to tell pack-objects that even though it should generate on-disk
>   files, it is still OK to use the reachability bitmaps to do the
>   traversal.

Thanks, I'm adding this to the patch message in appropriate place.


> > We can teach pack-objects to use bitmap index for initial object
> > counting phase when generating resultant pack file too:
> > 
> > - if we know bitmap index generation is not enabled for resultant pack:
> > 
> >   Current code has singleton bitmap_git so cannot work simultaneously
> >   with two bitmap indices.
> 
> So one reason is that it is not currently possible with the
> implementation. But I think it also gets to the above bit about
> "optimal" packs. We do not want to generate bitmaps off of bitmaps,
> because we lose information about the write order. That's probably worth
> mentioning here.

Ok. I'm adding relevant note.


> > - if we keep pack reuse enabled still only for "send-to-stdout" case:
> > 
> >   Because on pack reuse raw entries are directly written out to destination
> >   pack by write_reused_pack() bypassing needed for pack index generation
> >   bookkeeping done by regular codepath in write_one() and friends.
> > 
> >   (at least that's my understanding after briefly looking at the code)
> 
> Yes, that's right. We definitely want pack-reuse off for this case.

Ok, thanks for clarifying.

> > NOTE
> > 
> > Jeff King suggested that it might be not generally a good idea to
> > use bitmap reachability index when repacking a repository. The reason
> > here is for on-disk repack by default we want
> > 
> > - to produce good pack (with bitmap index not-yet-packed objects are
> >   emitted to pack in suboptimal order).
> > 
> > - to use more robust pack-generation codepath (avoiding possible
> >   bugs in bitmap code and possible bitmap index corruption).
> 
> Ah, this kind of covers the bits I talked about above. I think it makes
> more sense to introduce them as part of the motivation, though, rather
> than as a note here.

Thanks, good idea (after we discussed the robustness issues and start to
take them into account). I'm moving this close to head of the
description.


> > Jeff also suggests that pack.useBitmaps was probably a mistake to
> > introduce originally. This way we are not adding another config point,
> > but instead just always default to-file pack-objects not to use bitmap
> > index: Tools which need to generate on-disk packs with using bitmap, can
> > pass --use-bitmap-index explicitly.
> 
> This part is important, though. Basically the reason we respect the
> command-line option is that we know that git-repack would never set it
> explicitly, so it is the hint that pack-objects can use to know which
> case we are serving: a careful repack of our data, or just extraction of
> some objects.

Yes. To make this very clear I'm also adding explicit note git-repack
never passes --use-bitmap-index to pack-objects, so this way we can be
sure regular on-disk repacking remains robust.


> > @@ -1052,6 +1053,9 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
> >  {
> >  	uint32_t index_pos;
> >  
> > +	if (local && has_loose_object_nonlocal(sha1))
> > +		return 0;
> > +
> >  	if (have_duplicate_entry(sha1, 0, &index_pos))
> >  		return 0;
> 
> Hrm. Adding entries from the bitmap should ideally be very fast, but
> here we're introducing extra lookups in the object database. I guess it
> only kicks in when --local is given, though, which most bitmap-using
> paths would not do.
> 
> But is this check enough? The non-bitmap code path calls
> want_object_in_pack, which checks not only loose objects, but also
> non-local packs, and .keep.
> 
> Those don't kick in for your use case. I wonder if we should simply have
> something like:
> 
>   if (local || ignore_packed_keep)
> 	use_bitmap_index = 0;
> 
> and just skip bitmaps for those cases. That's easy to reason about, and
> I don't think anybody would care (your use case does not, and the repack
> use case is already not going to use bitmaps).

You are right - this is not enough. Initially I did not delved into this
--local case and only cared to make tests pass (which were failing without this
check when initial patch was using --use-bitmap-index by default).

I agree it is simpler to just not handle this case for now.

Actually after thinking about it a bit more, I can see that even current
code, allows `git pack-objects --stdout --local or --honor-pack-keep`
and does not handle those options properly. Thus I suggest to apply the
following patch as the first one in this now series:

---- 8< ----
From: Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH 1/2] pack-objects: Make sure use_bitmap_index is not active under
 --local or --honor-pack-keep

Since 6b8fda2d (pack-objects: use bitmaps when packing objects) there
are two codepaths in pack-objects: with & without using bitmap
reachability index.

However add_object_entry_from_bitmap(), despite its non-bitmapped
counterpart add_object_entry(), in no way does check for whether --local
or --honor-pack-keep should be respected. In non-bitmapped codepath this
is handled in want_object_in_pack(), but bitmapped codepath has simply
no such checking at all.

The bitmapped codepath however was allowing to pass --local and
--honor-pack-keep and bitmap indices were still used under such
conditions - potentially giving wrong output (including objects from
non-local or .keep'ed pack).

Instead of fixing bitmapped codepath to respect those options, since
currently no one actually need or use them in combination with bitmaps,
let's just force use_bitmap_index=0 when any of --local or
--honor-pack-keep are used and add appropriate comment about
not-checking for those in add_object_entry_from_bitmap()

Suggested-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 15866d7..d7cf782 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1055,6 +1055,12 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
 	if (have_duplicate_entry(sha1, 0, &index_pos))
 		return 0;
 
+	/*
+	 * for simplicity we always want object to be in pack, as
+	 * use_bitmap_index codepath assumes neither --local nor --honor-pack-keep
+	 * is active.
+	 */
+
 	create_object_entry(sha1, type, name_hash, 0, 0, index_pos, pack, offset);
 
 	display_progress(progress_state, nr_result);
@@ -2776,6 +2782,15 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!use_internal_rev_list || !pack_to_stdout || is_repository_shallow())
 		use_bitmap_index = 0;
 
+	/*
+	 * "lazy" reasons not to use bitmaps; it is easier to reason about when
+	 * neither --local nor --honor-pack-keep is in action, and so far no one
+	 * needed nor implemented such support yet.
+	 */
+	if (local || ignore_packed_keep)
+		use_bitmap_index = 0;
+
+
 	if (pack_to_stdout || !rev_list_all)
 		write_bitmap_index = 0;
 
-- 
2.9.0.431.g3cb5c84
---- 8< ----


On Mon, Jul 25, 2016 at 02:53:13PM -0400, Jeff King wrote:
> On Mon, Jul 25, 2016 at 02:40:25PM -0400, Jeff King wrote:
> 
> > > @@ -1052,6 +1053,9 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
> > >  {
> > >  	uint32_t index_pos;
> > >  
> > > +	if (local && has_loose_object_nonlocal(sha1))
> > > +		return 0;
> > > +
> > >  	if (have_duplicate_entry(sha1, 0, &index_pos))
> > >  		return 0;
> > 
> > Hrm. Adding entries from the bitmap should ideally be very fast, but
> > here we're introducing extra lookups in the object database. I guess it
> > only kicks in when --local is given, though, which most bitmap-using
> > paths would not do.
> > 
> > But is this check enough? The non-bitmap code path calls
> > want_object_in_pack, which checks not only loose objects, but also
> > non-local packs, and .keep.
> > 
> > Those don't kick in for your use case. I wonder if we should simply have
> > something like:
> > 
> >   if (local || ignore_packed_keep)
> > 	use_bitmap_index = 0;
> > 
> > and just skip bitmaps for those cases. That's easy to reason about, and
> > I don't think anybody would care (your use case does not, and the repack
> > use case is already not going to use bitmaps).
> 
> BTW, I thought we had more optimizations in this area, but I realized
> that I had never sent them to the list. I just did, and you may want to
> take a peek at:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/300218
>
> I doubt it will speed up your case much (unless you really do have tons
> of packs in your extraction).

> And I think it is still worth doing disabling I showed above, even
> with the optimizations, just because it's easier to reason about.
> 
> So I _think_ those optimizations are orthogonal to what we're discussing
> here, but I wanted to point you at them just in case.

Thanks for the head-ups and for sending it. Yes, for git-backup we
usually do restore from freshly repacked repo, But the optimization is
useful in many other cases.  After reading the patches I wonder why
current state was for so a long time. I frequently have close to 50
packs in a repository, with only automatic gc triggering to do full
repack, and for that case looping always through whole 50 packs for
every object, even when we already found the pack an object lives in, is
just a waste of time. And yes, on client side I almost never use
alternate objects store and almost never do concurrent fetches etc (so if
I understand correctly, no .keep files). Thanks for sending it.

( Btw, if we are talking about optimizations, here is something related
  to pack extractions, I think it is worth mentioning just in case:

  https://lab.nexedi.com/kirr/git-backup/blob/ad6c6853/NOTES.restore

  It is a scheme how to compute "non-overlapping" set of packs when
  restoring repositories from big backup repo, so both disk size (same
  objects in many packs) and time (computing packs with many same objects
  many times) are not wasted. Then shared between repositories packs are
  just hardlinked to appropriate places.
  
  It is in line with e.g. 
  
  https://git.kernel.org/cgit/git/git.git/commit/tree-diff.c?id=72441af7
  
  because it is algorithmical optimization, only for now I do not have
  working code implementing it yet. )


anyway updated main patch goes below:

(whole-patch interdiff)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1ef85a6..f8b173d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1053,12 +1053,15 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
 {
        uint32_t index_pos;
 
-       if (local && has_loose_object_nonlocal(sha1))
-               return 0;
-
        if (have_duplicate_entry(sha1, 0, &index_pos))
                return 0;
 
+       /*
+        * for simplicity we always want object to be in pack, as
+        * use_bitmap_index path assumes neither --local nor --honor-pack-keep
+        * is active.
+        */
+
        create_object_entry(sha1, type, name_hash, 0, 0, index_pos, pack, offset);
 
        display_progress(progress_state, nr_result);
@@ -2796,6 +2799,15 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
        if (!use_internal_rev_list || (!pack_to_stdout && write_bitmap_index) || is_repository_shallow())
                use_bitmap_index = 0;
 
+       /*
+        * "lazy" reasons not to use bitmaps; it is easier to reason about when
+        * neither --local nor --honor-pack-keep is in action, and so far no one
+        * needed nor implemented such support yet.
+        */
+       if (local || ignore_packed_keep)
+               use_bitmap_index = 0;
+
+
        if (pack_to_stdout || !rev_list_all)
                write_bitmap_index = 0;
 

(log interdiff)
@@ -5,29 +5,69 @@ if a repository has bitmap index, pack-objects can nicely speedup
 "Counting objects" graph traversal phase. That however was done only for
 case when resultant pack is sent to stdout, not written into a file.
 
-We can teach pack-objects to use bitmap index for initial object
+The reason here is for on-disk repack by default we want:
+
+- to produce good pack (with bitmap index not-yet-packed objects are
+  emitted to pack in suboptimal order).
+
+- to use more robust pack-generation codepath (avoiding possible
+  bugs in bitmap code and possible bitmap index corruption).
+
+Jeff Kind further explains:
+
+    The reason for this split is that pack-objects tries to determine how
+    "careful" it should be based on whether we are packing to disk or to
+    stdout. Packing to disk implies "git repack", and that we will likely
+    delete the old packs after finishing. We want to be more careful (so
+    as not to carry forward a corruption, and to generate a more optimal
+    pack), and we presumably run less frequently and can afford extra CPU.
+    Whereas packing to stdout implies serving a remote via "git fetch" or
+    "git push". This happens more frequently (e.g., a server handling many
+    fetching clients), and we assume the receiving end takes more
+    responsibility for verifying the data.
+
+    But this isn't always the case. One might want to generate on-disk
+    packfiles for a specialized object transfer. Just using "--stdout" and
+    writing to a file is not optimal, as it will not generate the matching
+    pack index.
+
+    So it would be useful to have some way of overriding this heuristic:
+    to tell pack-objects that even though it should generate on-disk
+    files, it is still OK to use the reachability bitmaps to do the
+    traversal.
+
+So we can teach pack-objects to use bitmap index for initial object
 counting phase when generating resultant pack file too:
 
+- if we care it is not activated under git-repack:
+
+  See above about repack robustness and not forward-carrying corruption.
+
 - if we know bitmap index generation is not enabled for resultant pack:
 
   Current code has singleton bitmap_git so cannot work simultaneously
   with two bitmap indices.
 
+  We also want to avoid (at least with current implementation)
+  generating bitmaps off of bitmaps. The reason here is: when generating
+  a pack, not-yet-packed objects will be emitted into pack in
+  suboptimal order and added to tail of the bitmap as "extended entries".
+  When the resultant pack + some new objects in associated repository
+  are in turn used to generate another pack with bitmap, the situation
+  repeats: new objects are again not emitted optimally and just added to
+  bitmap tail - not in recency order.
+
+  So the pack badness can grow over time when at each step we have
+  bitmapped pack + some other objects. That's why we want to avoid
+  generating bitmaps off of bitmaps, not to let pack badness grow.
+
 - if we keep pack reuse enabled still only for "send-to-stdout" case:
 
   Because on pack reuse raw entries are directly written out to destination
   pack by write_reused_pack() bypassing needed for pack index generation
   bookkeeping done by regular codepath in write_one() and friends.
 
-  (at least that's my understanding after briefly looking at the code)
-
-We also need to care and teach add_object_entry_from_bitmap() to respect
---local via not adding nonlocal loose object to resultant pack (this
-is bitmap-codepath counterpart of daae0625 (pack-objects: extend --local
-to mean ignore non-local loose objects too) -- not to break 'loose
-objects in alternate ODB are not repacked' in t7700-repack.sh .
-
-Otherwise all git tests pass, and for pack-objects -> file we get nice
+This way all git tests pass, and for pack-objects -> file we get nice
 speedup:
 
     erp5.git[1] (~230MB) extracted from ~ 5GB lab.nexedi.com backup
@@ -55,27 +95,62 @@ initial motivation for the patch.
 
 NOTE
 
-Jeff King suggested that it might be not generally a good idea to
-use bitmap reachability index when repacking a repository. The reason
-here is for on-disk repack by default we want
-
-- to produce good pack (with bitmap index not-yet-packed objects are
-  emitted to pack in suboptimal order).
-
-- to use more robust pack-generation codepath (avoiding possible
-  bugs in bitmap code and possible bitmap index corruption).
-
 Jeff also suggests that pack.useBitmaps was probably a mistake to
 introduce originally. This way we are not adding another config point,
 but instead just always default to-file pack-objects not to use bitmap
 index: Tools which need to generate on-disk packs with using bitmap, can
-pass --use-bitmap-index explicitly.
+pass --use-bitmap-index explicitly. And git-repack does never pass
+--use-bitmap-index, so this way we can be sure regular on-disk repacking
+remains robust.
+
+NOTE2
+
+`git pack-objects --stdout >file.pack` + `git index-pack file.pack` is much slower
+than `git pack-objects file.pack`. Extracting erp5.git pack from
+lab.nexedi.com backup repository:
+
+---- 8< ----
+$ time echo 0186ac99 | git pack-objects --stdout --revs >erp5pack-stdout.pack
+
+real    0m22.309s
+user    0m21.148s
+sys     0m0.932s
+
+$ time git index-pack erp5pack-stdout.pack
+
+real    0m50.873s   <-- more than 2 times slower than time to generate pack itself!
+user    0m49.300s
+sys     0m1.360s
+---- 8< ----
+
+So the time for
+
+    `pack-object --stdout >file.pack` + `index-pack file.pack`  is  72s,
+
+while
+
+    `pack-objects file.pack` which does both pack and index     is  27s.
+
+And even
+
+    `pack-objects --no-use-bitmap-index file.pack`              is  37s.
+
+Jeff explains:
+
+    The packfile does not carry the sha1 of the objects. A receiving
+    index-pack has to compute them itself, including inflating and applying
+    all of the deltas.
+
+that's why for `git-backup restore` we want to teach `git pack-objects
+file.pack` to use bitmaps instead of using `git pack-objects --stdout
+>file.pack` + `git index-pack file.pack`.
 
 More context:
 
     http://article.gmane.org/gmane.comp.version-control.git/299063
     http://article.gmane.org/gmane.comp.version-control.git/299107
     http://article.gmane.org/gmane.comp.version-control.git/299420
+    http://article.gmane.org/gmane.comp.version-control.git/300217
 
 Cc: Vicent Marti <tanoku@gmail.com>
 Helped-by: Jeff King <peff@peff.net>


(patch itself)
---- 8< ----
From: Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH 2/2] pack-objects: Teach it to use reachability bitmap index when
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
index b0ed71f..39ab41d 100644
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
index d7cf782..f8b173d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -66,7 +66,8 @@ static struct packed_git *reuse_packfile;
 static uint32_t reuse_packfile_objects;
 static off_t reuse_packfile_offset;
 
-static int use_bitmap_index = 1;
+static int use_bitmap_index_default = 1;
+static int use_bitmap_index = -1;
 static int write_bitmap_index;
 static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE;
 
@@ -2231,7 +2232,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 			write_bitmap_options &= ~BITMAP_OPT_HASH_CACHE;
 	}
 	if (!strcmp(k, "pack.usebitmaps")) {
-		use_bitmap_index = git_config_bool(k, v);
+		use_bitmap_index_default = git_config_bool(k, v);
 		return 0;
 	}
 	if (!strcmp(k, "pack.threads")) {
@@ -2494,7 +2495,7 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 	if (prepare_bitmap_walk(revs) < 0)
 		return -1;
 
-	if (pack_options_allow_reuse() &&
+	if (pack_options_allow_reuse() && pack_to_stdout &&
 	    !reuse_partial_packfile_from_bitmap(
 			&reuse_packfile,
 			&reuse_packfile_objects,
@@ -2779,7 +2780,23 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
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
 
 	/*
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 0d03583..0802b7c 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -117,6 +117,20 @@ test_expect_success 'incremental repack can disable bitmaps' '
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
