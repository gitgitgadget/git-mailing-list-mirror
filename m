From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to
 significantly speed up packing/walking
Date: Sun, 09 Aug 2009 11:54:18 +1200
Message-ID: <1249775658.7114.66.camel@maia.lan>
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
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Nick Edelen <sirnot@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 09 01:52:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZvi0-0006Ei-NX
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 01:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbZHHXwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 19:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753304AbZHHXwN
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 19:52:13 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:38259 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753303AbZHHXwM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 19:52:12 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 4CFA1FD50B; Sun,  9 Aug 2009 11:52:11 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 27CCB21C3C5;
	Sun,  9 Aug 2009 11:52:06 +1200 (NZST)
In-Reply-To: <alpine.DEB.1.00.0908081709380.8306@pacific.mpi-cbg.de>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125313>

On Sat, 2009-08-08 at 17:18 +0200, Johannes Schindelin wrote:
> > Speeding up rev-list with a rev cache is completely orthogonal to 
> > whether the repository is packed or not.
> 
> No, it is not.
> 
> For both technical and practical reasons, caching revision walker data is
> very closely related to packing.
> [...]
> ... the rev cache has a certain target audience, 
> and that the regular user is not part of that audience, and that it just 
> so happens that the _technical_ similarities with the pack index can be 
> exploited in those scenarios?
> 
> IOW we can be pretty certain that a heavy-load server has a fully (or 
> next-to-fully) packed object database.  The pack indices already contain a 
> SHA-1 table that we can simply reuse.  And it should not be hard (or 
> fragile) at all to put the "cached" information about parents, 
> referenced tree and blob objects into that file, into a different section.

I think your argument would work better if packs and bundles were the
same thing, and we always stored bundles in the objects/packs directory,
but they're not and we don't.  You can't assume that a pack has any
particular properties, such as representing the objects returned from a
single rev-cache walk.  And I will say that *especially* on a busy git
server, serving active projects you can't expect people to repack their
repository for every single update.  Repacking daily or so by a batch
job, sure.  Expecting the repository to always be fully packed?  No.
Too much churn, or inefficient packing.  You can't just pretend that the
mixed packed/loose case doesn't exist.

The 10% size seems a very good bang for your buck to me and a good
start.

Sam
