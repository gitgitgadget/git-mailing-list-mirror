Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D9DC208ED
	for <e@80x24.org>; Wed,  8 Aug 2018 15:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeHHSLE (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 14:11:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:46748 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727069AbeHHSLE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 14:11:04 -0400
Received: (qmail 32032 invoked by uid 109); 8 Aug 2018 15:50:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Aug 2018 15:50:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26593 invoked by uid 111); 8 Aug 2018 15:50:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 08 Aug 2018 11:50:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2018 11:50:46 -0400
Date:   Wed, 8 Aug 2018 11:50:46 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 2/2] repack: repack promisor objects if -a or -A is set
Message-ID: <20180808155045.GB1607@sigill.intra.peff.net>
References: <xmqqzhxxki84.fsf@gitster-ct.c.googlers.com>
 <20180807232304.181764-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180807232304.181764-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 07, 2018 at 04:23:04PM -0700, Jonathan Tan wrote:

> > Do we already have an access to the in-core reverse index for the
> > pack at this point in the code?
> 
> As far as I can tell, no. These patches construct the list of promisor
> objects in repack.c (which does not use the revindex at all), to be
> processed by pack-objects in a different process (which does use the
> revindex in reuse-delta mode, which is the default). I guess that we
> could have access to the revindex if we were to libify pack-objects and
> run it in the same process as repack.c or if we were to add a special
> mode to pack-objects that reads for itself the list of all the promisor
> objects.

It's not the end of the world to access the revindex here. It requires
effort proportional to the size of the packfile, which makes it a bad
choice for operations that want to touch only a few objects. But here
you're iterating over the whole packfile anyway.

I think that the for_each_packed_object() interface should visit items
in pack order. Something like this (I'd probably change the name of the
inner "i" variable for clarity, but I didn't here to minimize the diff):

diff --git a/packfile.c b/packfile.c
index 04d387f312..334f47e4cd 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1887,10 +1887,13 @@ int has_pack_index(const unsigned char *sha1)
 
 int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn cb, void *data)
 {
-	uint32_t i;
+	uint32_t in_pack;
 	int r = 0;
 
-	for (i = 0; i < p->num_objects; i++) {
+	load_pack_revindex(p);
+
+	for (in_pack = 0; in_pack < p->num_objects; in_pack++) {
+		uint32_t i = p->revindex[in_pack].nr;
 		struct object_id oid;
 
 		if (!nth_packed_object_oid(&oid, p, i))

Possibly it should be an optional flag, in case the caller is going to
eventually sort by sha1 anyway. But the major caller that sorts by sha1
is cat-file's --batch-all-objects option.  And IMHO that is actually a
bad default. Try timing this in a fully-packed repository:

  time git cat-file --batch-all-objects --buffer --batch | wc -c

versus this:

  time git show-index <.git/objects/pack/*.idx |
  sort -n |
  awk '{print $2}' |
  git cat-file --buffer --batch | wc -c

On my git.git repo, it's literally 7x faster to do the latter, because
of locality in resolving deltas.

So I think we should consider at least making it an option for cat-file
to do the iteration in pack-ish order (it can't be perfect, of course,
because there may be multiple packs, loose objects, etc, but
approximating it is a good idea).

I guess it has to be an option, since we advertise in the manpage that
the output is sorted by hash.

> > If so, we can enumerate the objects
> > in the offset order without incurring a lot of cost (building the
> > in-core revindex is the more expensive part).  When writing a pack,
> > we try to make sure that related objects are written out close to
> > each other [*1*], so listing them in the offset order (with made-up
> > pathname information to _force_ that objects that live close
> > together in the original pack are grouped together by getting
> > similar names) might give us a better than horrible deltification.
> > I dunno.
> 
> Before I write the NEEDSWORK comment, just to clarify - do you mean
> better than horrible object locality? I think deltification still occurs
> because pack-objects sorts the input when doing the windowed
> deltification, for example:
> 
>   git rev-parse HEAD:fetch-pack.c HEAD HEAD^ HEAD^^ \
> 	HEAD^^^ v2.17.0:fetch-pack.c | git pack-objects --window=2 abc
> 
> produces a packfile with a delta, as checked by `verify-pack -v`.

You're going to get a lot of reused deltas from the old pack, but you'll
probably miss opportunities to delta objects between packs. And
pack-object's compute_write_order() will fix some of the issues:

 - it will group objects of each type together

 - it will group delta "families" together

So the resulting packfile may not actually be _too_ bad with respect to
delta locality. Where it will fail is:

 - there's no locality with respect to history, so a traversal will have
   bad I/O patterns as it skips all over the packfile

 - the delta heuristics do use the incoming order (which usually is from
   a traversal) as a hint. But IMHO that is way less important than
   lacking the names. Even if you have an actual traversal, two versions
   of the same file may be separated by hundreds of other blob changes
   in the middle. Traversal order doesn't help you; putting things with
   similar names next to each other does.

   For traversals using bitmaps, we have a "name hash cache" in the
   .bitmap file, which stores the 32-bit hash of the name. That lets us
   put similar names next to each other without actually knowing the
   names. If we absolutely can't traverse as part of the strategy for
   repacking a promisor pack, then it may be worth trying to figure out
   how to carry that hash around.

-Peff
