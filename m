Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF77C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 08:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02DD205ED
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 08:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfLIILb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 03:11:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:41822 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727044AbfLIILa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 03:11:30 -0500
Received: (qmail 19197 invoked by uid 109); 9 Dec 2019 08:11:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Dec 2019 08:11:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18621 invoked by uid 111); 9 Dec 2019 08:15:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Dec 2019 03:15:47 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Dec 2019 03:11:29 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 9/9] pack-objects: improve partial packfile reuse
Message-ID: <20191209081129.GA1546451@coredump.intra.peff.net>
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
 <20191115141541.11149-10-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191115141541.11149-10-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 15, 2019 at 03:15:41PM +0100, Christian Couder wrote:

> The old code to reuse deltas from an existing packfile
> just tried to dump a whole segment of the pack verbatim.
> That's faster than the traditional way of actually adding
> objects to the packing list, but it didn't kick in very
> often. This new code is really going for a middle ground:
> do _some_ per-object work, but way less than we'd
> traditionally do.

This is a good intro to the general problem, but...

> For instance, packing torvalds/linux on GitHub servers
> just now reused 6.5M objects, but only needed ~50k
> chunks.

What the heck is a chunk? :)

I know, because I wrote the patches, but I think we need to sketch out
the solution a bit for the reader.

I think the flow here is:

  - we want to do some per-object work (i.e., your intro above)

  - the general strategy is to make a bitmap of objects from the
    packfile we'll include, and then iterate over it, writing out each
    object exactly as it is in our on-disk pack, but _not_ adding it to
    our packlist (which costs memory, and increases the search space for
    deltas)

  - one complication is that if we're omitting some objects, we can't
    set a delta against a base that we're not sending. So we have to
    check each object in try_partial_reuse() to make sure we have its
    delta (actually, that third big comment in that function is
    incomplete, I think; it talks about sending the object later, not as
    part of the reused pack, but we might not send it at all!).

  - another complication is that when we omit parts of the packfile,
    that screws up delta base offsets. So to handle that, we have to
    keep track of which chunks we send (which is the bits you included
    below about chunks)

  - and then we can talk about performance; worst case we might have
    interleaved objects that we are sending or not sending, and we'd
    have as many chunks as objects. But in practice we send big chunks,
    so that's where the 6.5M objects vs 50k chunks comes in.

> Additional checks are added in have_duplicate_entry()
> and obj_is_packed() to avoid duplicate objects in the
> reuse bitmap. It was probably buggy to not have such a
> check before.
> 
> If a client both asks for a tag by sha1 and specifies
> "include-tag", we may end up including the tag in the reuse
> bitmap (due to the first thing), and then later adding it to
> the packlist (due to the second). This results in duplicate
> objects in the pack, which git chokes on. We should notice
> that we are already including it when doing the include-tag
> portion, and avoid adding it to the packlist.
> 
> The simplest place to fix this is right in add_ref_tag,
> where we could avoid peeling the tag at all if we know that
> we are already including it. However, I've pushed the check
> instead into have_duplicate_entry(). This fixes not only
> this case, but also means that we cannot have any similar
> problems lurking in other code.

I think this part could go in its own commit. If we introduce
reuse_packfile_bitmap early, even if it's always an all-or-nothing chunk
at the beginning of the file with the existing code, then we can
introduce the extra checks in have_duplicate_entry() on top of that.

And then it would be safe to do the cleanup in show_objects_from_type()
that triggers the test failure in patch 4.

>  builtin/pack-objects.c | 222 ++++++++++++++++++++++++++++++++---------
>  pack-bitmap.c          | 150 ++++++++++++++++++++--------
>  pack-bitmap.h          |   3 +-
>  3 files changed, 288 insertions(+), 87 deletions(-)

It might be worth having a perf test here. The case this is helping the
most, I think, is when somebody cloning wants all of the objects from
the beginning of the pack, but then there's a bunch of _other_ stuff.

That could be unreachable objects kept by "repack -k", or maybe objects
reachable outside of heads and tags. Or objects that are part of other
delta islands. This last is the most plausible, really, because we'll
put all of the root-island objects at the beginning of the pack. So
maybe a good perf test would be to take an existing repository add a
bunch of new commits in refs/foo/, and then repack with delta islands
such that refs/heads and refs/tags are in one (root) island, but
refs/foo is in another.

The old code should fail to do the pack-reuse thing, but we should get
pretty good reuse with the new code (and less CPU and peak RAM,
hopefully, though the perf suite doesn't measure RAM directly).


Answering some questions from Jonathan's response in the last round
(some of the quotes are his, some are yours):

> I still don't understand this part. Going off what's written in the
> commit message here, it seems to me that the issue is that (1) an object
> can be added to the reuse bitmap without going through to_pack, and (2)
> this is done when the client asks for a tag by SHA-1. But all objects
> when specified by SHA-1 go through to_pack, don't they?

No, if it's part of the reused chunk, we'd avoid adding it to to_pack at
all (and I think the commit message should make that more clear, as I
described above).

> >> No tests, because git does not actually exhibit this "ask
> >> for it and also include-tag" behavior. We do one or the
> >> other on clone, depending on whether --single-branch is set.
> >> However, libgit2 does both.
>
> So my wild guess sould be that maybe the reason is that some of this
> code was shared (or intended to be shared) with libgit2?

No, the question is how the client behaves, and how we on the server
react to it. Git as a client would never ask for both include-tag and
for the tag itself by sha1. But libgit2 will, so a libgit2 client
cloning from a Git server would trigger the bug.

> > +     if (pos >= bitmap_git->pack->num_objects)
> > +             return; /* not actually in the pack */
>
> Is this case possible? try_partial_reuse() is only called when there is
> a 1 at the bit location.

Yes, it's possible. The result of a bitmap walk is larger than a given
pack, because we have to extend it to match whatever objects the caller
asked for. E.g., imagine we have commit A, repack into into a bitmapped
pack, and then somebody pushes up commit B. Now I want to clone, getting
both A and B.

Our bitmap result represents the whole answer, and so must include both
objects. But since "B" isn't in the pack, it doesn't have an assigned
bit. We add it to the in-memory bitmap_git->ext_index, which gives it a
bit (valid only for that walk result!). But of course for pack reuse, we
only care about the objects that were actually in the bitmapped pack.

> > +     /* Don't mark objects not in the packfile */
> > +     if (i > bitmap_git->pack->num_objects / BITS_IN_EWORD)
> > +             i = bitmap_git->pack->num_objects / BITS_IN_EWORD;
>
> Why is this necessary? Let's say we have 42 fully-1 words, and therefore
> i is 42. Shouldn't we allocate 42 words in our reuse bitmap?

This is the same issue as above. Imagine instead of two objects, imagine
we have 42 words worth. But if only 20 words worth are in the packfile,
then we have to stop there.

Now we _could_ figure this out for each individual object through the
similar logic in try_partial_reuse(). But we try to take an even faster
path for the initial chunk of objects. We don't even walk over them
looking to see if they're deltas or not. We just send that chunk of the
pack verbatim.

I don't have numbers for how often we hit this path versus the
individual try_partial_reuse() path. Possibly the stats could
differentiate that.

Thinking on it more, though, I wonder if there's a bug hiding here. We
know that we can send the whole initial chunk verbatim for OFS_DELTA
objects, because the relative offsets will remain unchanged (i.e., there
are no "holes" that trigger our chunk code). But if there were a
REF_DELTA in that initial chunk, we have no certainty that the base is
being sent.

In practice, this doesn't happen because the objects in question have to
be in a pack with bitmaps, which means it was written ourselves by
git-repack. And we'd never write REF_DELTA objects there.

But I wonder if it's worth being a bit more careful (and what the
performance impact is; it would mean checking the type of every object
in that initial chunk).

-Peff
