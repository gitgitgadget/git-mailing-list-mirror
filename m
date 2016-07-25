Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68D62203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 18:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbcGYSkf (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 14:40:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:48721 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751962AbcGYSkd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 14:40:33 -0400
Received: (qmail 9419 invoked by uid 102); 25 Jul 2016 18:40:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jul 2016 14:40:33 -0400
Received: (qmail 27369 invoked by uid 107); 25 Jul 2016 18:40:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jul 2016 14:40:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jul 2016 14:40:25 -0400
Date:	Mon, 25 Jul 2016 14:40:25 -0400
From:	Jeff King <peff@peff.net>
To:	Kirill Smelkov <kirr@nexedi.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org,
	Vicent Marti <tanoku@gmail.com>
Subject: Re: [PATCH] pack-objects: Use reachability bitmap index when
 generating non-stdout pack too
Message-ID: <20160725184025.GA12297@sigill.intra.peff.net>
References: <20160713083044.GB18144@sigill.intra.peff.net>
 <20160713082653.GA18144@sigill.intra.peff.net>
 <20160713105216.GB16000@teco.navytux.spb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160713105216.GB16000@teco.navytux.spb.ru>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 13, 2016 at 01:52:17PM +0300, Kirill Smelkov wrote:

> > So I think if you were to repeatedly "git repack -adb" over time, you
> > would get worse and worse ordering as objects are added to the
> > repository.
> 
> Jeff, first of all thanks for clarifying.
> 
> So it is not-yet-packed-objects which make packing with bitmap less
> efficient. I was originally keeping in mind fresh repacked repository
> with just built bitmap index and for that case extracting pack with
> bitmap index seems to be just ok, but the more not-yet-packed objects we
> have the worse the result can be.

Right. So I think your scheme is fine as long as you are doing your
regular "pack all into one" repacks with a real walk, and then
"branching" off of that with one-off bitmap-computed packs into files
(even if you later take a bunch of those files and pull them into a
single bitmapped, as long as that final "all into one" does the walk).

Or I guess another way to think about it would be that if you're
computing bitmaps, you'd want to do the actual traversal.

> Yes, it also make sense. I saw write_reused_pack() in upstream git just
> copy raw bytes from original to destination pack. You mentioned you have
> something better for pack reuse - in your patch queue, in two words, is
> it now reusing pack based on object, not raw bytes, or is it something
> else?
> 
> In other words in which way it works better? (I'm just curious here as
> it is interesting to know)

The problem with the existing pack-reuse code is that it doesn't kick in
often enough. I think it looks to see that the client wants some
percentage of the pack (e.g., 90%), and then just sends the whole
beginning. This works especially badly if you have a bunch of related
repositories packed together (e.g., all of the forks of torvalds/linux
on GitHub), because you'll never hit 90% of that big pack; it has too
much unrelated cruft, even if most of the stuff you want _is_ at the
beginning. And "percent of pack" is not really a useful metric anyway.

So the better scheme is more like:

  1. Generate the bitmap of objects to send using reachability bitmaps.

  2. Do a quick scan of their content in the packfile to see which can
     be reused verbatim. If they're base objects, we can send them
     as-is. If they're deltas, we can send them if their base is going
     to be sent. This fills in another bitmap of "reusable" objects.

     After a long string of unusable objects, you can give up and set
     the rest of the bitmap to zeroes.

  3. Walk the "reuse" bitmap and send out the objects more-or-less
     verbatim. You do have make adjustments to delta-base-offsets for
     any "holes" (so if an object's entry says "my base is 500 bytes
     back", but you omitted some objects in between, you have to adjust
     that offset).

The upside is that you can send out those objects without even making a
"struct object_entry" for them, which drastically reduces the memory
requirements for serving a clone. Any objects which didn't get marked
for reuse just get handled in the usual way (so stuff that was not close
by in the pack, or stuff that was pushed since your last big repack).

The downside is that because those objects aren't in our normal packing
list, they're not available as delta bases for the new objects we _do_
send. So it can make the resulting pack a little bit bigger.

> Yes, for packing it is only hash which is used. And I assume name-hash
> for bitmap is not enabled by default for compatibility with JGit code.
>
> It would make sense to me to eventually enable name-hash bitmap
> extension by default, as packing result is much better with it. And
> those who care about compatibility with JGit can just turn it off in
> their git config.

Correct, the defaults are for JGit compatibility. If you are not using
JGit, you should have it on all the time.  We went with the conservative
default, but as more people using regular Git bitmaps, it would probably
be good to make them less arcane and confusing to use.

> > As I understand your use case, it is OK to do the less careful things.
> > It's just that pack-objects until now has been split into two modes:
> > packing to a file is careful, and packing to stdout is less so. And you
> > want to pack to a file in the non-careful mode.
> 
> Yes, it should be ok, as after repository extraction git-backup
> verifies rev-list for all refs
> 
>     https://lab.nexedi.com/kirr/git-backup/blob/7fcb8c67/git-backup.go#L855
> 
> And if an object is missing - e.g. a blob - rev-list complains:
> 
>     fatal: missing blob object '980a0d5f19a64b4b30a87d4206aade58726b60e3'
> 
> though it does not catch blob corruptions.

Right, that makes sense. Even the pack-to-disk code invoked by
git-repack is not foolproof for blob corruptions. It is only checking a
crc, not the full sha1. So it's better than nothing, but not as careful
as a full index-pack.

> Probably pack.useBitmaps is of no use in normal situation, but for
> debugging problems related to bitmaps it can be handy. Though when
> someone debugs he/she can just adjust pack-objects.c . So should we
> deprecate and eventually remove pack.useBitmaps ?

In my opinion, yes. If we had any debugging option, it should be
something like "core.usebitmaps", to tell _all_ of git to pretend that
bitmaps don't exist (right now only pack-objects respects it, but we
could be using them to optimize more traversals).

> ---- 8< ----
> From: Kirill Smelkov <kirr@nexedi.com>
> Subject: [PATCH v3] pack-objects: Teach it to use reachability bitmap index when
>  generating non-stdout pack too
> 
> Starting from 6b8fda2d (pack-objects: use bitmaps when packing objects)
> if a repository has bitmap index, pack-objects can nicely speedup
> "Counting objects" graph traversal phase. That however was done only for
> case when resultant pack is sent to stdout, not written into a file.

I think we can give more motivation and context here with some of the
bits that have come out in our discussion. Like:

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

> We can teach pack-objects to use bitmap index for initial object
> counting phase when generating resultant pack file too:
> 
> - if we know bitmap index generation is not enabled for resultant pack:
> 
>   Current code has singleton bitmap_git so cannot work simultaneously
>   with two bitmap indices.

So one reason is that it is not currently possible with the
implementation. But I think it also gets to the above bit about
"optimal" packs. We do not want to generate bitmaps off of bitmaps,
because we lose information about the write order. That's probably worth
mentioning here.

> - if we keep pack reuse enabled still only for "send-to-stdout" case:
> 
>   Because on pack reuse raw entries are directly written out to destination
>   pack by write_reused_pack() bypassing needed for pack index generation
>   bookkeeping done by regular codepath in write_one() and friends.
> 
>   (at least that's my understanding after briefly looking at the code)

Yes, that's right. We definitely want pack-reuse off for this case.

> NOTE
> 
> Jeff King suggested that it might be not generally a good idea to
> use bitmap reachability index when repacking a repository. The reason
> here is for on-disk repack by default we want
> 
> - to produce good pack (with bitmap index not-yet-packed objects are
>   emitted to pack in suboptimal order).
> 
> - to use more robust pack-generation codepath (avoiding possible
>   bugs in bitmap code and possible bitmap index corruption).

Ah, this kind of covers the bits I talked about above. I think it makes
more sense to introduce them as part of the motivation, though, rather
than as a note here.

> Jeff also suggests that pack.useBitmaps was probably a mistake to
> introduce originally. This way we are not adding another config point,
> but instead just always default to-file pack-objects not to use bitmap
> index: Tools which need to generate on-disk packs with using bitmap, can
> pass --use-bitmap-index explicitly.

This part is important, though. Basically the reason we respect the
command-line option is that we know that git-repack would never set it
explicitly, so it is the hint that pack-objects can use to know which
case we are serving: a careful repack of our data, or just extraction of
some objects.

> @@ -1052,6 +1053,9 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
>  {
>  	uint32_t index_pos;
>  
> +	if (local && has_loose_object_nonlocal(sha1))
> +		return 0;
> +
>  	if (have_duplicate_entry(sha1, 0, &index_pos))
>  		return 0;

Hrm. Adding entries from the bitmap should ideally be very fast, but
here we're introducing extra lookups in the object database. I guess it
only kicks in when --local is given, though, which most bitmap-using
paths would not do.

But is this check enough? The non-bitmap code path calls
want_object_in_pack, which checks not only loose objects, but also
non-local packs, and .keep.

Those don't kick in for your use case. I wonder if we should simply have
something like:

  if (local || ignore_packed_keep)
	use_bitmap_index = 0;

and just skip bitmaps for those cases. That's easy to reason about, and
I don't think anybody would care (your use case does not, and the repack
use case is already not going to use bitmaps).

> @@ -2773,7 +2777,23 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
>  		unpack_unreachable_expiration = 0;
>  
> -	if (!use_internal_rev_list || !pack_to_stdout || is_repository_shallow())
> +	/*
> +	 * "soft" reasons not to use bitmaps - for on-disk repack by default we want
> +	 *
> +	 * - to produce good pack (with bitmap index not-yet-packed objects are
> +	 *   packed in suboptimal order).
> +	 *
> +	 * - to use more robust pack-generation codepath (avoiding possible
> +	 *   bugs in bitmap code and possible bitmap index corruption).
> +	 */
> +	if (!pack_to_stdout)
> +		use_bitmap_index_default = 0;
> +
> +	if (use_bitmap_index < 0)
> +		use_bitmap_index = use_bitmap_index_default;
> +
> +	/* "hard" reasons not to use bitmaps; these just won't work at all */
> +	if (!use_internal_rev_list || (!pack_to_stdout && write_bitmap_index) || is_repository_shallow())
>  		use_bitmap_index = 0;

And that local/keep logic above would just become "hard" reasons
included here.

-Peff
