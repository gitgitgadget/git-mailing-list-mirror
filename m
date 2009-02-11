From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: fact-import: failed to apply delta
Date: Wed, 11 Feb 2009 13:09:12 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0902111247300.19665@iabervon.org>
References: <20090210155626.GM30949@spearce.org> <alpine.LNX.1.00.0902101118110.19665@iabervon.org> <20090210172212.GR30949@spearce.org> <alpine.LNX.1.00.0902101226580.19665@iabervon.org> <20090210191220.GT30949@spearce.org> <alpine.LNX.1.00.0902101427300.19665@iabervon.org>
 <20090210201203.GU30949@spearce.org> <alpine.LNX.1.00.0902101520240.19665@iabervon.org> <20090210212539.GV30949@spearce.org> <alpine.LNX.1.00.0902101628140.19665@iabervon.org> <20090210213612.GW30949@spearce.org> <7vprhqkjrr.fsf@gitster.siamese.dyndns.org>
 <7vfxillxiu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:10:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXJXu-0001ZY-9Q
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756728AbZBKSJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756606AbZBKSJP
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:09:15 -0500
Received: from iabervon.org ([66.92.72.58]:43432 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756740AbZBKSJN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:09:13 -0500
Received: (qmail 27568 invoked by uid 1000); 11 Feb 2009 18:09:12 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Feb 2009 18:09:12 -0000
In-Reply-To: <7vfxillxiu.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109468>

On Tue, 10 Feb 2009, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > "Shawn O. Pearce" <spearce@spearce.org> writes:
> >
> >> Daniel Barkalow <barkalow@iabervon.org> wrote:
> >>> On Tue, 10 Feb 2009, Shawn O. Pearce wrote:
> >>> > 
> >>> > We should dump the cached_objects table in sha1_file.c during
> >>> > a checkpoint in fast-import.
> >>> 
> >>> No, that one's keyed by sha1, and doesn't get collisions; it's the 
> >>> delta_base_cache that's the issue; it's keyed by struct packed_git * and 
> >>> offset.
> >>
> >> Uh, yea, I realize that after I sent the message.  Does this patch
> >> fix it for you?
> >>
> >> --8<--
> >> Clear the delta base cache during fast-import checkpoint
> >>
> >> Otherwise we may reuse the same memory address for a totally
> >> different "struct packed_git", and a previously cached object from
> >> the prior occupant might be returned when trying to unpack an object
> >> from the new pack.
> >
> > Can this be made more automatic?
> >
> > For example if you do this every time a new pack is installed to
> > sha1_file(), like in add_packed_git() perhaps, wouldn't that be much less
> > error prone?
> 
> On second thought, I think fast-import is the only program that plays
> funny games of feeding a packed_git that is *not* part of the real list of
> packed_git installed in the system to unpack_entry(), so probably your
> patch is a better idea.

That's not the problem; the problem is calling free on a struct packed_git 
that has been given to unpack_entry(), because it raises the possibility 
of having the memory allocated to a different pack in the future and 
ending up with actively wrong entries in the delta cache, since it keys 
off of the pointer.

I think free_pack_by_name() also needs to drop the entries that are from 
the freed pack, to avoid having repack able to get the same problem, 
although I wouldn't be surprised if repack happened to never allocate a 
new pack after freeing an old pack with stale delta cache entries, or 
never used the delta cache after that, simply because it does one thing 
and then exits.

	-Daniel
*This .sig left intentionally blank*
