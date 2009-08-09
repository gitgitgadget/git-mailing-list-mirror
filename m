From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to
 significantly speed up packing/walking
Date: Sat, 08 Aug 2009 22:37:05 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908082147480.32635@xanadu.home>
References: <op.ux8i6hrbtdk399@sirnot.private>
 <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de>
 <4A7AEFA8.5010001@drmicha.warpmail.net>
 <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com>
 <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
 <4A7B95A8.2010000@vilain.net>
 <alpine.LFD.2.00.0908070031160.16073@xanadu.home>
 <alpine.DEB.1.00.0908070806350.8306@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0908071010580.16073@xanadu.home>
 <alpine.DEB.1.00.0908081709380.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sam Vilain <sam@vilain.net>, Nick Edelen <sirnot@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 09 04:37:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZyHw-0001gp-Bd
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 04:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbZHIChO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 22:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbZHIChO
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 22:37:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:59970 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbZHIChM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 22:37:12 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KO300MJO8LU5L60@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 08 Aug 2009 22:37:07 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.0908081709380.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125317>

On Sat, 8 Aug 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Fri, 7 Aug 2009, Nicolas Pitre wrote:
> 
> > On Fri, 7 Aug 2009, Johannes Schindelin wrote:
> > 
> > > Hi,
> > > 
> > > On Fri, 7 Aug 2009, Nicolas Pitre wrote:
> > > 
> > > > On Fri, 7 Aug 2009, Sam Vilain wrote:
> > > > 
> > > > > Johannes Schindelin wrote:
> > > > > >> the short answer is that cache slices are totally independant of 
> > > > > >> pack files.
> > > > > >>     
> > > > > >
> > > > > > My idea with that was that you already have a SHA-1 map in the pack 
> > > > > > index, and if all you want to be able to accelerate the revision 
> > > > > > walker, you'd probably need something that adds yet another mapping, 
> > > > > > from commit to parents and tree, and from tree to sub-tree and blob 
> > > > > > (so you can avoid unpacking commit and tree objects).
> > > > > >   
> > > > > 
> > > > > Tying indexes together like that is not a good idea in the database 
> > > > > world. Especially as in this case as Nick mentions, the domain is 
> > > > > subtly different (ie pack vs dag). Unfortunately you just can't try to 
> > > > > pretend that they will always be the same; you can't force a full 
> > > > > repack on every ref change!
> > > > 
> > > > Right.  And the rev cache must work even if the repository is not 
> > > > packed.
> > > 
> > > Umm, why?  AFAICT the principal purpose of the rev cache is to help work 
> > > loads on, say, www.kernel.org.
> > 
> > So what?
> > 
> > Speeding up rev-list with a rev cache is completely orthogonal to 
> > whether the repository is packed or not.
> 
> No, it is not.
> 
> For both technical and practical reasons, caching revision walker data is
> very closely related to packing.

No it is not.

> You are _very_ unlikely helped by speeding up revision walking in the 
> general case, _especially_ when you do stuff like blame or -S that needs 
> to unpack tons of objects _anyway_.

I completely agree.  And this is why I wish for the rev cache to be 
enabled with a config variable.  Why?  Because "client" repositories are 
unlikely to benefit as much as "server" repositories from this cache.

> The one big kicker argument for speeding up revision walking _is_ to 
> relieve the loads on big ass servers, and they _should_ be as packed as 
> possible (as I will patiently explain over and over again).

Please do a shortlog on builtin-pack-objects.c and realize who spent a 
lot of energy making git repository packing what it is now.

Then re-read what I said on this list for more than a year now about the 
remaining latency on large git clone operations.  After explaining it a 
couple times already I will need some of your patience to make people 
understand that fully packing your repo is _not_ going to help it as 
we're always talking about fully packed repos to start with.

> > It is like having a "git diff" result cache: no one would think of 
> > stuffing that in the pack index.
> 
> Do you want to try to kid me?  You'll have to try harder.  Caching "git 
> diff" results... no, really!

Why not?  You worked on git diff yourself, so you certainly are well 
positionned to appreciate my suggestion, no?

> > If we want to improve on the repository packing format, that must be 
> > doable without bothering with an independent concept such as a rev 
> > cache.
> 
> I would love to tell you that you're right, but the single fact that 
> pack v4 is startig to compete with Duke Nukem Forever just prevents me 
> from doing that.

Because of the current economy, I was waiting to be laid off so to have 
the time to make pack v4 a reality.  Unfortunately for git they didn't 
fire me yet.  Oh well...

> > > I am unlikely to notice the improvements in my regular "git log" calls 
> > > that only show a couple of pages before I quit the pager.
> > 
> > Indeed.  But what is your point again?
> 
> Oh?  My point?  Being that the rev cache has a certain target audience, 
> and that the regular user is not part of that audience, and that it just 
> so happens that the _technical_ similarities with the pack index can be 
> exploited in those scenarios?

I don't see a similarity with the pack index at all, certainly not a 
technical one.

> IOW we can be pretty certain that a heavy-load server has a fully (or 
> next-to-fully) packed object database.  The pack indices already contain a 
> SHA-1 table that we can simply reuse.  And it should not be hard (or 
> fragile) at all to put the "cached" information about parents, 
> referenced tree and blob objects into that file, into a different section.

And then someone does a few pushes.  So most of the time your repository 
contains a few packs and not only a single one.  So in which pack index 
files should you put the rev cache?  What do yo do with that cache if it 
happens to be split across multiple pack index files when a repack is 
performed?  Can't you see all the disadvantages to tie rev cache data 
which happens to share no issue with repacking into the same file?

So what do you do to keep the code simple and maintainable?  Yes, you 
abstract things and use separate files, thank you very much.  After all, 
the packed refs are not stored in the pack index file either even if the 
packed-refs file contains a list of SHA1's.


Nicolas
