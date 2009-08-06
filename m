From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to 
 significantly speed up packing/walking
Date: Thu, 6 Aug 2009 21:06:59 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
References: <op.ux8i6hrbtdk399@sirnot.private>  <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de>  <4A7AEFA8.5010001@drmicha.warpmail.net> <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Sam Vilain <sam@vilain.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 21:06:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ8IU-0007D4-JW
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 21:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665AbZHFTGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 15:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755521AbZHFTGe
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 15:06:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:58973 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755397AbZHFTGd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 15:06:33 -0400
Received: (qmail invoked by alias); 06 Aug 2009 19:06:33 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 06 Aug 2009 21:06:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18RLtIzrIMRogwWd5PB2sVO0e7kLnDlk88IMwdWgL
	EQCCn0oKRHalLU
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125107>

Hi,

On Thu, 6 Aug 2009, Nick Edelen wrote:

> > Sorry, I forgot the details, could you quickly remind me why these 
> > caches are not in the pack index files?
> 
> Er, I'm not sure what you mean.  Are you asking why these revision 
> caches are required if we have a pack index, or why they aren't in the 
> pack index, or something different?  I'm thinking probably the second:

Yep.

> the short answer is that cache slices are totally independant of pack 
> files.

My idea with that was that you already have a SHA-1 map in the pack index, 
and if all you want to be able to accelerate the revision walker, you'd 
probably need something that adds yet another mapping, from commit to 
parents and tree, and from tree to sub-tree and blob (so you can avoid 
unpacking commit and tree objects).

I just thought that it could be more efficient to do it at the time the 
pack index is written _anyway_, as nothing will change in the pack after 
that anyway.

But I guess I can answer my question easily myself: the boundary commits 
will not be handled that way.

Still, there is some redundancy between the pack index and your cache, as 
you have to write out the whole list of SHA-1s all over again.  I guess it 
is time to look at the code instead of asking stupid questions.

> It might be possible to somehow merge revision cache slices with pack 
> indexes, but I don't think it'd be a very suitable modification.  The 
> rev-cache slices are meant to act almost like topo-relation pack files: 
> new slices are simply new files, seperate slice files can be fused 
> ("repacked") into a larger one, the index is a (recreatable) single file 
> associating file (positions) with objects.  The format was geared to 
> reducing potential cache/data loss and preventing overly large cache 
> slices.
> 
> >> Hmpf.
> >>
> >> We got rid of the last Python script in Git a long time ago, but now 
> >> two different patch series try to sneak that dependency (at least for 
> >> testing) back in.
> >>
> >> That's all the worse because we cannot use Python in msysGit, and 
> >> Windows should be a platform benefitting dramatically from your work.
> >
> > In fact, the test the script performs could be easily rephrased with 
> > "sort", "uniq" and "comm". OTOH: If the walker is supposed to return 
> > the exact same orderd list of commits you can just use test_cmp.
> 
> The language that script is written in isn't important.  I originally
> wrote it in python because I wanted something quick and wasn't much of
> a sh guru (sorry :-/ ).  As Micheal said I've no doubt it can easily
> be converted to shell script

That is not what I wanted to hear.

> -- in fact, I'll try to get a shell version working today.

That is.

Thanks,
Dscho
