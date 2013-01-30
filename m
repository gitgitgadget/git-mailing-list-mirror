From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Wed, 30 Jan 2013 02:07:34 -0500
Message-ID: <20130130070734.GC11147@sigill.intra.peff.net>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <20130129091610.GD9999@sigill.intra.peff.net>
 <7vy5fbq48t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 08:08:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Rm4-0002dn-Bg
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 08:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588Ab3A3HHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 02:07:39 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53818 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753292Ab3A3HHh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 02:07:37 -0500
Received: (qmail 27433 invoked by uid 107); 30 Jan 2013 07:09:00 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Jan 2013 02:09:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Jan 2013 02:07:34 -0500
Content-Disposition: inline
In-Reply-To: <7vy5fbq48t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214998>

On Tue, Jan 29, 2013 at 09:38:10AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +int commit_metapack(unsigned char *sha1,
> > +		    uint32_t *timestamp,
> > +		    unsigned char **tree,
> > +		    unsigned char **parent1,
> > +		    unsigned char **parent2)
> > +{
> > +	struct commit_metapack *p;
> > +
> > +	prepare_commit_metapacks();
> > +	for (p = commit_metapacks; p; p = p->next) {
> > +		unsigned char *data;
> > +		int pos = sha1_entry_pos(p->index, 20, 0, 0, p->nr, p->nr, sha1);
> 
> This is a tangent, but isn't it about time to rip out the check for
> GIT_USE_LOOKUP in find_pack_entry_one(), I wonder.

Rip it out and always use sha1_entry_pos, or rip it out and never use
it? I have never been able to measure any speedup from it; I just use it
here to avoid rewriting the binary search myself. I do not think there
is any disadvantage to using it, so I'd be in favor of just
standardizing on it for any sha1 binary searches.

> These cached properties of a single commit will not change no matter
> which pack it appears in, and it feels logically wrong, especially
> when you record these object names in the full SHA-1 form, to tie a
> "commit metapack" to a pack.  Logically there needs only one commit
> metapack that describes all the commits known to the repository when
> the metapack was created.

True. I had originally envisioned it as tied to the packfile to help
manage the lifecycle. You know you need to generate a metapack for some
objects when they get packed, and you know you can throw it away when
the associated pack goes away. And it means you can verify the integrity
of the metapack by matching it to a particular packfile.

However, if you just have a commit cache, you can always blow the whole
thing away and regenerate it for all objects in the repo. It does not
have tied to a pack (you do end up doing some extra work at regeneration
when you are not doing a full repack, but it is really not enough to
worry about).

> In order to reduce the disk footprint and I/O cost, the future
> direction for this mechanism may want to point into an existing
> store of SHA-1 hashes with a shorter file offset, and the .idx file
> could be such a store, and in order to move in that direction, you
> cannot avoid tying a metapack to a pack.

Yes. That was not one of my original goals for the commit cache, but I
do think it's a useful direction to go in. And reachability bitmaps
(which would eventually be their own metapacks) would generally want to
be per-pack, too, for the same reason.

> > +	*tail = &commit_list_insert(c, *tail)->next;
> > +}
> 
> It feels somewhat wasteful to:
> 
>  - use commit_list for this, rather than an array of commit
>    objects.  If you have a rough estimate of the number of commits
>    in the pack, you could just preallocate a single array and use
>    ALLOC_GROW() on it, no?

We don't have a rough estimate, but yes, we could just use an array and
trust ALLOC_GROW to be reasonable. The use of commit_list did not have a
particular reason other than that it was simple (an array means stuffing
the array pointer and the nr and alloc counts into a struct to get to
the callback). The performance of writing the cache is dominated by
accessing the objects themselves, anyway. I don't mind changing it,
though, if you think it's clearer as an array.

>  - iterate over the .idx file and run sha1_object_info() and
>    parse_commit() on many objects in the SHA-1 order.  Iterating in
>    the way builtin/pack-objects.c::get_object_details() does avoids
>    jumping around in existing packfiles, which may be more
>    efficient, no?

Probably, though generating the complete commit cache for linux-2.6.git
takes only about 7 seconds on my machine. I wasn't too concerned with
optimizing generation, since it will typically be dwarfed by repacking
costs. It might make more of a difference for doing a metapack on all
objects (e.g., reachability bitmaps).

The reason I do it in .idx order is that it feeds the callback in sorted
order, so a writer could in theory just use that output as-is (and my
initial version did that, as it wrote separate metapacks for each
element). This version now puts all data elements together (for cache
locality), and builds the in-memory list so we do not have to re-do
sha1_object_info repeatedly. So it could very easily just generate the
list in pack order and sort it at the end.

I'll look into that for the next version.

-Peff
