From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git gc does not discard objects found in alternate unless
	the?alternate storage is packed
Date: Mon, 11 Aug 2008 07:33:08 -0700
Message-ID: <20080811143308.GA26363@spearce.org>
References: <loom.20080810T210546-549@post.gmane.org> <20080811025438.GB27195@spearce.org> <loom.20080811T101110-879@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: sergio <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 16:34:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSYTM-0001SG-IO
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 16:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbYHKOdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 10:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbYHKOdJ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 10:33:09 -0400
Received: from george.spearce.org ([209.20.77.23]:45803 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbYHKOdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 10:33:09 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4002E38375; Mon, 11 Aug 2008 14:33:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <loom.20080811T101110-879@post.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91940>

sergio <sergio.callegari@gmail.com> wrote:
> Shawn O. Pearce <spearce <at> spearce.org> writes:
> > Sergio <sergio.callegari <at> gmail.com> wrote:
> > >
> > > Is it the intended behaviour?
> > 
> > This is the current (intended) behavior.  We have never pruned an
> > object from a repository unless the object is packed in the shared
> > alternate repository.  See git-prune-packed's man page.  The prune
> > logic for loose objects only deletes objects which are in packs,
> > and it doesn't care where that pack came from.
> 
> Many thanks for the explanation.
> Two more questions:
> 1) Is there a way to prune objects that are anyway available at the alternate
> without touching the alternate (to repack it)?

No, no such function exists today in Git.  Why?  Because nobody has
coded it.  We needed git-prune-packed for local repository usage
once git-repack has finished its main work of running pack-objects
to produce a new pack file.  This extended nicely into also pruning
loose objects which are also available from a shared database,
as the code was actually identical.

> 2) Would there be any contraindication in doing so? (namely, is the current
> behaviour of git gc a mere consequence of the prune-packed logic or a behaviour
> purposely introduced for safety?)

Well, yes and no.

The first part of the answer is that yes, one could delete the
object from the clone if it is available loose in the alternate.
The object can still be read through the alternate, so there is no
data loss, and thus it really is just a matter of someone writing
the necessary code to implement this prune function.

The second part of the answer is that no, doing this deletion may
make it less safe to use the alternate as an alternate.  The reason
is that objects which are contained in pack files are likely to
be reachable in the alternate, and thus won't disappear during a
later git-prune invocation, as they are needed by that alternate.

This assumption is based upon the fact that an object only goes
into a pack file if it is reachable in that repository, as the
packing code uses reachability to determine what to pack.

Relying upon a loose object may cause breakage later on if the
alternate doesn't actually need that object and prunes it away,
and the clone doesn't have it either.

However, this pack based assumption can fail anyway if the
alternate repository rewinds a branch and repacks.  The object you
were relying on in the alternate may now be ejected into a loose
object, or discarded altogether, and the clone will (eventually)
break anyway when the object(s) it needs goes missing.

So it is sort-of a safety measure, but its a crude one at best.
And it only works about some X% of the time, where X is well
under 100.  :-)

-- 
Shawn.
