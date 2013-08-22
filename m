From: Jeff King <peff@peff.net>
Subject: Re: [DO NOT APPLY PATCH 4/4] index-pack: optionally skip duplicate
 packfile entries
Date: Wed, 21 Aug 2013 20:47:10 -0400
Message-ID: <20130822004710.GA563@sigill.intra.peff.net>
References: <20130821204955.GA28025@sigill.intra.peff.net>
 <20130821205555.GD28165@sigill.intra.peff.net>
 <xmqqob8qskbc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 02:47:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCJ3V-0000gg-Sg
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 02:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353Ab3HVArO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 20:47:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:51284 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753331Ab3HVArN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 20:47:13 -0400
Received: (qmail 23176 invoked by uid 102); 22 Aug 2013 00:47:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 Aug 2013 19:47:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Aug 2013 20:47:10 -0400
Content-Disposition: inline
In-Reply-To: <xmqqob8qskbc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232756>

On Wed, Aug 21, 2013 at 04:20:07PM -0700, Junio C Hamano wrote:

> I do not understand the last bit.  If two copies of an object exist
> but you have only one slot for the object in the index, and another
> object names it as its base with ref-delta, then reconstituting it
> should work just fine---whichever representation of the base object
> is recorded in the .idx, that first needs to be reconstituted before
> the delta is applied to it, and both copies should yield identical
> contents for the delta base object, no?
> 
> In any case, ejecting one from the pack .idx would not help in the
> presense of either broken or malicious packer that reuses delta too
> aggressively.  Suppose you have objects A and B and somehow manage
> to create a cycle of deltas, A names B as its delta base and B names
> A as its delta base.  The packer may notice its mistake and then add
> another copy of A as a base object.  The pack contains two copies of
> A (one is delta based on B, the other is full) and B (delta against
> A).

Yes, that is the potentially problematic scenario...

> If B refers to the copy of A that is delta against B using ofs-delta,
> fixing the .idx file will have no effect.  read_packed_sha1(B) will
> read the delta data of B, finds the offset to start reading the data
> for A which was excised from the .idx and unless that codepath is
> updated to consult revindex (i.e. you mark one copy of A in the .pack
> as bad, and when B refers to that bad copy of A via ofs-delta, you
> check the offset against revindex to get the object name of A and go
> to the good copy of A), you will never finish reading B because
> reading the bad copy of A will lead you to first reconstitute B.

Yes. There are two levels of brokenness here.

One is that the pack has a delta base offset for B that leads to the
"wrong" A, creating a cycle. This is an utterly broken pack and cannot
be fixed automatically (you do not even know the name of the cycled A
because you cannot constitute it to find its name and realize that it
has a duplicate!). But we should notice this during index-pack, because
we cannot reconstruct the object.

Another situation is that your delta base points to the "right" A. You
can reconstruct either A or B, because although there is a duplicate,
there are no cycles in the delta chain (i.e., the chain does not care
about object name, only offset, and offsets point only one way).

So we do not have a problem at all with reconstructing the object data.
We do have two ways we might access A from the same pack. For regular
object lookup, that is probably not a big deal. For operations like
repacking that look more closely at the on-disk representation, I do not
know. We may mark A as "has a delta" or "does not have a delta" at one
point in the code, but then later find the other copy of A which does
not match. I did not trace through all of pack-objects to find whether
that is possible, or what bugs it might cause. But indexing only one
copy as the "master" means that we will always get a consistent view of
the object (from that particular pack, at least).

Now consider REF_DELTA. We lookup the base object by name, so we may get
a different answer depending on how it is indexed. E.g., index-pack
keeps an internal hash table, whereas later callers will use the .idx
file. When looking at the .idx file, we may use a regular binary search,
or sha1_entry_pos. The exact order of the search may even change from
git version to git version.

So you may have a situation where index-pack finds the "right" A and
properly reconstructs the file while creating the .idx, and thinks all
is well. But later lookups may find the "wrong" A, and fail. In other
words, we cannot trust that data that makes it through index-pack is not
corrupted (and it is index-pack's output that lets receive-pack commit
to the client that we have their objects, so we want to be reasonably
sure we have uncorrupted copies at that point).

Choosing a single "master" A to go in the .idx means we will get a
consistent view of A once the .idx is generated. But it may not be the
right one, and it may not be the one we used to check that we can
resolve A and B in the first place.

The right fix for that situation is to keep both entries in the .idx,
detect delta cycles, then look up extra copies of A, but being aware
that you already found one copy in the .idx and that sha1_entry_pos (or
the vanilla binary search) should return any other copies, if they
exist. I do not think we detect delta cycles at all (though I didn't
check), but certainly we do not have a way to tell sha1_entry_pos any
different information so that it will find the "other" A.

So I think it is a recoverable state, but it is a non-trivial bit of
code for something that should never happen. Rejecting on push/fetch via
index-pack is simple and easy, and we can deal with the fallout if and
when it ever actually happens.

> > I think this line of "fixing" should probably be scrapped.
> 
> I tend to agree.

OK. Let's drop the "skip" patch, then. I'll re-roll with a patch to flip
the default to "reject".

-Peff
