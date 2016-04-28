From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: warn on split packs disabling bitmaps
Date: Wed, 27 Apr 2016 22:15:09 -0400
Message-ID: <20160428021509.GB9707@sigill.intra.peff.net>
References: <20160427215324.GA22165@dcvr.yhbt.net>
 <xmqqfuu67j9t.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 04:15:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avbUA-0004dF-V5
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 04:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542AbcD1CPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 22:15:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:58013 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752363AbcD1CPN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 22:15:13 -0400
Received: (qmail 22583 invoked by uid 102); 28 Apr 2016 02:15:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Apr 2016 22:15:12 -0400
Received: (qmail 4495 invoked by uid 107); 28 Apr 2016 02:15:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Apr 2016 22:15:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Apr 2016 22:15:09 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfuu67j9t.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292842>

On Wed, Apr 27, 2016 at 03:56:46PM -0700, Junio C Hamano wrote:

> Eric Wong <normalperson@yhbt.net> writes:
> 
> > It can be tempting for a server admin to want a stable set of
> > long-lived packs for dumb clients; but also want to enable
> > bitmaps to serve smart clients more quickly.
> >
> > Unfortunately, such a configuration is impossible;
> > so at least warn users of this incompatibility since
> > commit 21134714787a02a37da15424d72c0119b2b8ed71
> > ("pack-objects: turn off bitmaps when we split packs").
> >
> > Tested the warning by inspecting the output of:
> >
> > 	make -C t t5310-pack-bitmaps.sh GIT_TEST_OPTS=-v
> 
> While I do not think the update in this patch is wrong, this makes
> me wonder what happens to a server admin who wants a stable set of
> long-lived objects in a pack, and other objects in another pack that
> is frequently recreated, by first packing objects needed for the
> latest released version into a single pack and marking it with .keep
> and then running "git repack" to create the second pack for the
> remainder.
> 
> There is no automatic split involved, so we would get a bitmap file
> for each of these two packs.  Would that pose a problem?  The pack
> with the newer part of the history would not satisfy "all of the
> reachable objects are in the same pack" condition.

You will not get two bitmaps in such a case. In add_object_entry(), if
we exclude an object via want_object_in_pack(), we will issue a warning
and turn off bitmaps.  That includes finding that one of the reachable
objects we would need is in a .keep pack.

You could in theory construct a broken non-closed bitmap by feeding an
arbitrary set of objects to pack-objects, but we turn off bitmap writing
entirely unless --all is used. So the test in add_object_entry() should
be sufficient for all cases there (it's actually too conservative; it's
possible that the object is not reachable from the other objects that
are going into the pack, but this is so impractical that it's not even
worth trying to catch).

The split-pack check from 211347147 had to come separately, because we
only find out about the split much later during the write phase (and
again, it is too conservative; it's _possible_ that the objects being
split aren't reachable from anything in the previous pack, but it's
exceedingly unlikely and not worth caring about).

Adding a warning as Eric's patch does is a definite improvement, and
something I should have done in the original (we _could_ just use the
same no_closure_warning, as that is technically what is going on, but I
think it is nice to mention pack-splitting, which is more likely to lead
the user in the right direction to fixing it).

> [discussion of doc fixes]

I do not mind overly if pack-splitting mentions disabling bitmaps. But I
think it may be simpler to keep the documentation in the bitmap section,
rather than trying to cross-reference in both directions.  It is the
bitmap code which is not prepared to work with pack-splits (and other
things, like .keep), not the other way around.

-Peff
