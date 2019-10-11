Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25EB91F4C1
	for <e@80x24.org>; Fri, 11 Oct 2019 18:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfJKSB2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 14:01:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:45984 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728470AbfJKSB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 14:01:28 -0400
Received: (qmail 16046 invoked by uid 109); 11 Oct 2019 18:01:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Oct 2019 18:01:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3536 invoked by uid 111); 11 Oct 2019 18:04:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Oct 2019 14:04:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Oct 2019 14:01:25 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        chriscool@tuxfamily.org, ramsay@ramsayjones.plus.com
Subject: Re: [RFC PATCH 10/10] pack-objects: improve partial packfile reuse
Message-ID: <20191011180125.GA20601@sigill.intra.peff.net>
References: <20190913130226.7449-11-chriscool@tuxfamily.org>
 <20191010235952.174426-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010235952.174426-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 10, 2019 at 04:59:52PM -0700, Jonathan Tan wrote:

> > +/*
> > + * Record the offsets needed in our reused packfile chunks due to
> > + * "gaps" where we omitted some objects.
> > + */
> > +static struct reused_chunk {
> > +	off_t start;
> > +	off_t offset;
> > +} *reused_chunks;
> > +static int reused_chunks_nr;
> > +static int reused_chunks_alloc;
> 
> This makes sense - offsets may be different when we omit objects from
> the packfile. I think this can be computed by calculating the number of
> zero bits between the current object's index and the nth object prior
> (where n is the offset) in the bitmap resulting from
> reuse_partial_packfile_from_bitmap() above, thus eliminating the need
> for this array, but I haven't tested it.

You need to know not just the number of zero bits, but the accumulated
offset due to those missing objects. So you'd end up having to walk over
the revindex for that set of objects. This array is basically caching
those accumulated offsets (for the parts we _do_ include) so we don't
have to compute them repeatedly.

There's also a more subtle issue with entry sizes; see below.

> > +			if (0) {
> > +				off_t expected_size = cur - offset;
> > +
> > +				if (len + ofs_len < expected_size) {
> > +					unsigned max_pad = (len >= 4) ? 9 : 5;
> > +					header[len - 1] |= 0x80;
> > +					while (len < max_pad && len + ofs_len < expected_size)
> > +						header[len++] = 0x80;
> > +					header[len - 1] &= 0x7F;
> > +				}
> > +			}
> 
> This if(0) should be deleted.

Yeah, definitely. I had to scratch my head at what this code was doing.
IIRC, the issue is this:

  - imagine we have a sequence of objects in a pack, A B C D, but we
    want to generate an output pack that contains just A C D

  - imagine C is a delta against A. We adjust its delta base offset to
    account for the absence of B

  - because the offset is stored in a variable-length encoding, that may mean
    that the entry for C gets shorter!

  - now imagine D is a delta against A, as well. We have to account for
    the missing B, but also for the shrunken C.

The current code does so by creating a new entry in the reused_chunks
array. In the worst case that can grow to have the same number of
entries as we have objects. So this code was an attempt to pad the
header of a shrunken entry to keep it the same size. I don't remember
all the problems we ran into with that, but in the end we found that it
didn't actually help much, because in practice we don't end up with a
lot of chunks anyway.

For instance, packing torvalds/linux on our servers just now reused 6.5M
objects, but only needed ~50k chunks.

> > +	copy_pack_data(out, reuse_packfile, w_curs, offset, next - offset);
> > +}
> 
> I didn't look into detail, but this looks like it's writing a single
> object. In particular, it can convert OFS into REF, something that the
> existing code cannot do.

Right, that was an easy thing to do once we started actually walking
over the set of objects. The old code just tried to dump a whole segment
of the pack verbatim. That's faster than the traditional way of actually
adding objects to the packing list, but it didn't kick in very often.
This new code is really going for a middle ground: do _some_ per-object
work, but way less than we'd traditionally do.

By the way, that's another possible solution for the offset problem:
convert everything after the first gap to REF_DELTA. But the resulting
pack is larger and slightly less efficient for the client to use. And I
don't know that it's actually cheaper to generate than just adjusting
the offset (for each OFS_DELTA, you have to compute the offset of its
base and then do a revindex lookup to find the actual sha1 to write).

> > +static size_t write_reused_pack_verbatim(struct hashfile *out,
> > +					 struct pack_window **w_curs)
> > +{
> > +	size_t pos = 0;
> > +
> > +	while (pos < reuse_packfile_bitmap->word_alloc &&
> > +			reuse_packfile_bitmap->words[pos] == (eword_t)~0)
> > +		pos++;
> > +
> > +	if (pos) {
> > +		off_t to_write;
> > +
> > +		written = (pos * BITS_IN_EWORD);
> > +		to_write = reuse_packfile->revindex[written].offset
> > +			- sizeof(struct pack_header);
> > +
> > +		record_reused_object(sizeof(struct pack_header), 0);
> > +		hashflush(out);
> > +		copy_pack_data(out, reuse_packfile, w_curs,
> > +			sizeof(struct pack_header), to_write);
> >  
> >  		display_progress(progress_state, written);
> >  	}
> > +	return pos;
> > +}
> 
> I presume this optimization is needed for the case where we are using
> *all* objects of a packfile, as is typical during a clone.

It's not strictly needed, but yeah. If we know we're sending the first N
objects of the pack, then we don't even have to look at them. We can
just dump the bytes, and start our per-object traversal at N+1. That
should make it just as fast as the original pack-reuse code for this
case.

> > @@ -1002,6 +1132,10 @@ static int have_duplicate_entry(const struct object_id *oid,
> >  {
> >  	struct object_entry *entry;
> >  
> > +	if (reuse_packfile_bitmap &&
> > +	    bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid))
> > +		return 1;
> 
> Hmm...why did we previously not need to check the reuse information, but
> we do now? I gave the code a cursory glance but couldn't find the
> answer.

I think the original code may simply have been buggy and nobody noticed.
Here's what I wrote when this line was added in our fork:

      pack-objects: check reused pack bitmap for duplicate objects
  
      If a client both asks for a tag by sha1 and specifies
      "include-tag", we may end up including the tag in the reuse
      bitmap (due to the first thing), and then later adding it to
      the packlist (due to the second). This results in duplicate
      objects in the pack, which git chokes on. We should notice
      that we are already including it when doing the include-tag
      portion, and avoid adding it to the packlist.
  
      The simplest place to fix this is right in add_ref_tag,
      where we could avoid peeling the tag at all if we know that
      we are already including it. However, I've pushed the check
      instead into have_duplicate_entry. This fixes not only this
      case, but also means that we cannot have any similar
      problems lurking in other code.
  
      No tests, because git does not actually exhibit this "ask
      for it and also include-tag" behavior. We do one or the
      other on clone, depending on whether --single-branch is set.
      However, libgit2 does both.

I'm not sure why we didn't notice it with the older reuse code. It may
simply have been that it hardly ever triggered on our servers.

> >  static int obj_is_packed(const struct object_id *oid)
> >  {
> > -	return !!packlist_find(&to_pack, oid, NULL);
> > +	return packlist_find(&to_pack, oid, NULL) ||
> > +		(reuse_packfile_bitmap &&
> > +		 bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid));
> 
> Same question here - why do we need to check the reuse information?

This was added earlier than the call above. It's meant to handle
include-tag as well. Again, I'm not sure why the earlier reuse code
didn't need that, and I'd suspect it may simply be buggy.

> > @@ -3061,7 +3199,6 @@ static void loosen_unused_packed_objects(void)
> >  static int pack_options_allow_reuse(void)
> >  {
> >  	return pack_to_stdout &&
> > -	       allow_ofs_delta &&
> >  	       !ignore_packed_keep_on_disk &&
> >  	       !ignore_packed_keep_in_core &&
> >  	       (!local || !have_non_local_packs) &&
> 
> Relaxing of the allow_ofs_delta condition - makes sense given (as above)
> we can convert OFS to REF.

Yep, exactly.

> Overall I think that this makes sense, except for my unanswered
> questions (and the presence of reused_chunk).

Thanks for looking at it. I still have to take a careful pass over the
whole split, but I've tried to at least answer your questions in the
meantime.

-Peff
