From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/19] pack-bitmap: add support for bitmap indexes
Date: Wed, 30 Oct 2013 04:10:23 -0400
Message-ID: <20131030081023.GK11317@sigill.intra.peff.net>
References: <20131024175915.GA23398@sigill.intra.peff.net>
 <20131024180357.GJ24180@sigill.intra.peff.net>
 <CAJo=hJvw-UNWVDADcGzA1P3GGOKJGh8h4LrETPYnjBNYmfkxjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>, Vicent Marti <vicent@github.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 30 09:10:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbQrT-0000L7-4t
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 09:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948Ab3J3IKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 04:10:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:58292 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752836Ab3J3IK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 04:10:26 -0400
Received: (qmail 17703 invoked by uid 102); 30 Oct 2013 08:10:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Oct 2013 03:10:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Oct 2013 04:10:23 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJvw-UNWVDADcGzA1P3GGOKJGh8h4LrETPYnjBNYmfkxjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236999>

On Fri, Oct 25, 2013 at 01:55:13PM +0000, Shawn O. Pearce wrote:

> > As an extra optimization, when `prepare_bitmap_walk` succeeds, the
> > `reuse_partial_packfile_from_bitmap` call can be attempted: it will find
> > the amount of objects at the beginning of the on-disk packfile that can
> > be reused as-is, and return an offset into the packfile. The source
> > packfile can then be loaded and the bytes up to `offset` can be written
> > directly to the result without having to consider the entires inside the
> > packfile individually.
> 
> Yay! This is similar to the optimization we use in JGit to send the
> entire pack, but the part about sending a leading prefix is new. Do
> you have any data showing how well this works in practice for cases
> where offset is before than length-20?

Actually, I don't think it kicks in very much due to packfile ordering.
You have all of the commits at the front of the pack, then all of the
trees, then all of the blobs. So if you want the whole thing, it is easy
to reuse a big chunk. But if you want only the most recent slice, we can
reuse the early bit with the new commits, but we stop partway through
the commit list. You still have to handle all of the trees and blobs
separately.

So in practice, I think this really only kicks in for clones anyway.

In theory, you could find "islands" of ones in the bitmap and send whole
slices of packfile at once. But you need to be careful not to send a
delta without its base. Which I think means you end up having to
generate the whole sha1 list anyway, and check that the other side has
each base before reusing a delta (i.e., the normal code path).

In fact, I'm not quite sure that even a partial reuse up to an offset is
100% safe. In a newly packed git repo it is, because we always put bases
before deltas (and OFS_DELTA objects need this). But if you had a bitmap
generated from a fixed thin pack, we would have REF_DELTA objects early
on that depend on bases appended to the end of the pack. So I really
wonder if we should scrap this partial reuse and either just have full
reuse, or go through the regular object_entry construction.

Vicent, you've thought about the reuse code a lot more than I have. Any
thoughts?

-Peff
