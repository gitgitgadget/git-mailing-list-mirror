From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 11/19] pack-objects: use bitmaps when packing objects
Date: Wed, 30 Oct 2013 04:21:43 -0400
Message-ID: <20131030082143.GM11317@sigill.intra.peff.net>
References: <20131024175915.GA23398@sigill.intra.peff.net>
 <20131024180419.GK24180@sigill.intra.peff.net>
 <CAJo=hJuDx=3AOoz2oEORVOzeBYBwvOWO_ye8D5d8PcDc3Zm+Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>, Vicent Marti <vicent@github.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 30 09:22:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbR2L-0003Yj-PA
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 09:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335Ab3J3IVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 04:21:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:58315 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751426Ab3J3IVq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 04:21:46 -0400
Received: (qmail 18209 invoked by uid 102); 30 Oct 2013 08:21:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Oct 2013 03:21:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Oct 2013 04:21:43 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJuDx=3AOoz2oEORVOzeBYBwvOWO_ye8D5d8PcDc3Zm+Ew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237001>

On Fri, Oct 25, 2013 at 02:14:11PM +0000, Shawn O. Pearce wrote:

> On Thu, Oct 24, 2013 at 6:04 PM, Jeff King <peff@peff.net> wrote:
> > For bitmaps to be used, the following must be true:
> >
> >   1. We must be packing to stdout (as a normal `pack-objects` from
> >      `upload-pack` would do).
> >
> >   2. There must be a .bitmap index containing at least one of the
> >      "have" objects that the client is asking for.
> 
> The client must explicitly "have" a commit that has a bitmap? In JGit
> we allow the client to have anything, and walk backwards using
> traditional graph traversal until a bitmap is found.

If the bitmaps contain the full set of reachable objects and the client
does not have any "haves" that are bitmapped , then we know that either:

  1. Their "haves" are not reachable from the "wants"

     or

  2. Their "wants" are not bitmapped, and so the slice of "haves..wants"
     has no bitmaps

Since (1) is relatively rare, I think we are using this as a proxy for
(2), so that we can do a regular walk rather than looking around for
bitmaps that don't exist. But I may be misremembering the reasoning.
Vicent?

> > @@ -704,6 +759,18 @@ static void write_pack_file(void)
> >                 offset = write_pack_header(f, nr_remaining);
> >                 if (!offset)
> >                         die_errno("unable to write pack header");
> > +
> > +               if (reuse_packfile) {
> > +                       off_t packfile_size;
> > +                       assert(pack_to_stdout);
> > +
> > +                       packfile_size = write_reused_pack(f);
> > +                       if (!packfile_size)
> > +                               die_errno("failed to re-use existing pack");
> > +
> > +                       offset += packfile_size;
> > +               }
> > +
> >                 nr_written = 0;
> >                 for (; i < to_pack.nr_objects; i++) {
> >                         struct object_entry *e = write_order[i];
> 
> Can reuse_packfile be true at the same time as to_pack.nr_objects > 0?

Yes, if there are new, non-bitmapped objects to send on top of the
reused packfile.

> In JGit we write the to_pack list first, then the reuse pack. Our
> rationale was the to_pack list is recent objects that are newer and
> would appear first in a traditional traversal, so they should go at
> the front of the stream. This does mean if they delta compress against
> an object in that reuse_packfile slice they have to use REF_DELTA
> instead of OFS_DELTA.

That's a good point. In our case I think we do not delta against the
reused packfile objects at all, as we simply send out the whole slice of
packfile without making an entry for each object.

> Is this series running on github.com/torvalds/linux? Last Saturday I
> ran a live demo clone comparing github.com/torvalds/linux to a JGit
> bitmap clone and some guy heckled me because GitHub was only a few
> seconds slower. :-)

It is. Use kernel.org if you want to make fun of someone. :)

-Peff
