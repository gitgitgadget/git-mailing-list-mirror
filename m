From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to
 significantly speed up packing/walking
Date: Sat, 8 Aug 2009 17:18:42 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908081709380.8306@pacific.mpi-cbg.de>
References: <op.ux8i6hrbtdk399@sirnot.private> <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de> <4A7AEFA8.5010001@drmicha.warpmail.net> <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com> <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
 <4A7B95A8.2010000@vilain.net> <alpine.LFD.2.00.0908070031160.16073@xanadu.home> <alpine.DEB.1.00.0908070806350.8306@pacific.mpi-cbg.de> <alpine.LFD.2.00.0908071010580.16073@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>, Nick Edelen <sirnot@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Aug 08 17:18:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZngh-0001VL-LP
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 17:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbZHHPSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 11:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbZHHPSP
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 11:18:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:54466 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751610AbZHHPSO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 11:18:14 -0400
Received: (qmail invoked by alias); 08 Aug 2009 15:18:13 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 08 Aug 2009 17:18:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+7eZ84WPy74eoR/57RjB+I0tFW/QdLBFzc+OnbdL
	l2it3ENkID3rD8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0908071010580.16073@xanadu.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125280>

Hi,

On Fri, 7 Aug 2009, Nicolas Pitre wrote:

> On Fri, 7 Aug 2009, Johannes Schindelin wrote:
> 
> > Hi,
> > 
> > On Fri, 7 Aug 2009, Nicolas Pitre wrote:
> > 
> > > On Fri, 7 Aug 2009, Sam Vilain wrote:
> > > 
> > > > Johannes Schindelin wrote:
> > > > >> the short answer is that cache slices are totally independant of 
> > > > >> pack files.
> > > > >>     
> > > > >
> > > > > My idea with that was that you already have a SHA-1 map in the pack 
> > > > > index, and if all you want to be able to accelerate the revision 
> > > > > walker, you'd probably need something that adds yet another mapping, 
> > > > > from commit to parents and tree, and from tree to sub-tree and blob 
> > > > > (so you can avoid unpacking commit and tree objects).
> > > > >   
> > > > 
> > > > Tying indexes together like that is not a good idea in the database 
> > > > world. Especially as in this case as Nick mentions, the domain is 
> > > > subtly different (ie pack vs dag). Unfortunately you just can't try to 
> > > > pretend that they will always be the same; you can't force a full 
> > > > repack on every ref change!
> > > 
> > > Right.  And the rev cache must work even if the repository is not 
> > > packed.
> > 
> > Umm, why?  AFAICT the principal purpose of the rev cache is to help work 
> > loads on, say, www.kernel.org.
> 
> So what?
> 
> Speeding up rev-list with a rev cache is completely orthogonal to 
> whether the repository is packed or not.

No, it is not.

For both technical and practical reasons, caching revision walker data is
very closely related to packing.

You are _very_ unlikely helped by speeding up revision walking in the 
general case, _especially_ when you do stuff like blame or -S that needs 
to unpack tons of objects _anyway_.

The one big kicker argument for speeding up revision walking _is_ to 
relieve the loads on big ass servers, and they _should_ be as packed as 
possible (as I will patiently explain over and over again).

> It is like having a "git diff" result cache: no one would think of 
> stuffing that in the pack index.

Do you want to try to kid me?  You'll have to try harder.  Caching "git 
diff" results... no, really!

> If we want to improve on the repository packing format, that must be 
> doable without bothering with an independent concept such as a rev 
> cache.

I would love to tell you that you're right, but the single fact that 
pack v4 is startig to compete with Duke Nukem Forever just prevents me 
from doing that.

> > I am unlikely to notice the improvements in my regular "git log" calls 
> > that only show a couple of pages before I quit the pager.
> 
> Indeed.  But what is your point again?

Oh?  My point?  Being that the rev cache has a certain target audience, 
and that the regular user is not part of that audience, and that it just 
so happens that the _technical_ similarities with the pack index can be 
exploited in those scenarios?

IOW we can be pretty certain that a heavy-load server has a fully (or 
next-to-fully) packed object database.  The pack indices already contain a 
SHA-1 table that we can simply reuse.  And it should not be hard (or 
fragile) at all to put the "cached" information about parents, 
referenced tree and blob objects into that file, into a different section.

After all, the parents, referenced tree and blob objects to change as 
often as the objects in the pack: never.

Ciao,
Dscho
