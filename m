From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gc --auto: warn garbage collection happens soon
Date: Wed, 28 Dec 2011 16:30:18 -0500
Message-ID: <20111228213018.GA22811@sigill.intra.peff.net>
References: <1324993534-16307-1-git-send-email-pclouds@gmail.com>
 <7vpqf94r8c.fsf@alter.siamese.dyndns.org>
 <20111228184000.GA18780@sigill.intra.peff.net>
 <7vfwg41n3p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 28 22:30:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rg159-00079U-3S
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 22:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437Ab1L1VaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Dec 2011 16:30:22 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53774
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753261Ab1L1VaV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2011 16:30:21 -0500
Received: (qmail 5521 invoked by uid 107); 28 Dec 2011 21:37:08 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Dec 2011 16:37:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Dec 2011 16:30:18 -0500
Content-Disposition: inline
In-Reply-To: <7vfwg41n3p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187759>

On Wed, Dec 28, 2011 at 12:02:18PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > [1] Actually, it's not just having objects. You may have just exploded
> >     unreachable objects from a pack, but they are still younger than the
> >     2 week expiration period. Therefore trying to prune them is
> >     pointless, because even if they are unreachable, you won't delete
> >     them. So you really want to say "how many actual candidate objects
> >     do we have for pruning?"
> 
> An obvious knee-jerk reaction is "Ugh, if we have very recently repacked,
> don't we know what are reachable and what are not already, and use that
> knowledge while pruning to avoid traversing everything again?"

Especially now that prune has learned about progress reporting, it's
easy to see in "git gc" that the "Counting objects" phase of the repack
and the connectivity search in prune are counting the same objects.  It
would obviously be easy to just dump the set of sha1s in packed binary
format, and let git-prune reference that.

But it doesn't work in the general case. Running "git gc" will repack
everything, and so it looks at all reachable objects. But "git gc
--auto" will typically do an incremental pack (unless you have too many
packs), which means its counting objects phase only looks at part of
the graph.  So that result can't be used for object reachability, since
many objects won't be marked[1].

So yes, it's an optimization we can do, but it only works some of the
time. And worse, it works in the time we care less (when we are doing a
full repack anyway, so we are already spending more time counting
objects, and more I/O rewriting existing packed objects), but not when
we want it most (doing a few seconds of incremental repack during "git
gc --auto", which balloons to a minute because of the prune time).

-Peff

[1] It's tempting to say "well, we just repacked incrementally, so if
    something was referenced and not packed, we would have just packed
    it, right?" But look at how incremental packing works. We do a
    traversal with "--unpacked", which means we don't dig down past
    commit objects that are already packed. And that's why its fast.

    But packs don't necessarily respect reachability. It's possible for
    you to have object X in a pack, but X^{tree} is not (or X^, or
    whatever)[2]. I believe using "git repack" would fail to actually
    pack that. But that's OK, because it almost never happens, and the
    worst case is that the object doesn't get packed until you do a full
    repack.

    But I'm not sure you would want the same level of shortcut for
    git-prune, which would actually be _deleting_ the object. We want to
    be very sure in that case.

[2] The obvious way to get into this situation is to give weird rev-list
    parameters to pack-objects. But I think you could also do it
    accidentally by having commit X loose, then fetching history
    containing commit Y that builds on X. If the fetch is big enough,
    we'll keep the pack that we got from the other side. So X remains
    loose, but its ancestors are packed. Running an incremental repack
    will stop the traversal at Y and never consider X for packing.

    I didn't actually test this, but that's my reading of the code (see
    the revs->unpacked check in revision.c:get_commit_action).
