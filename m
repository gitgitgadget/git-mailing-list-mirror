From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: fact-import: failed to apply delta
Date: Tue, 10 Feb 2009 15:03:32 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0902101427300.19665@iabervon.org>
References: <alpine.LNX.1.00.0902092218050.19665@iabervon.org> <alpine.DEB.1.00.0902101126040.10279@pacific.mpi-cbg.de> <20090210155626.GM30949@spearce.org> <alpine.LNX.1.00.0902101118110.19665@iabervon.org> <20090210172212.GR30949@spearce.org>
 <alpine.LNX.1.00.0902101226580.19665@iabervon.org> <20090210191220.GT30949@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 21:06:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWyrD-0004Vn-TR
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 21:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841AbZBJUDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 15:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755706AbZBJUDe
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 15:03:34 -0500
Received: from iabervon.org ([66.92.72.58]:43518 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754966AbZBJUDe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 15:03:34 -0500
Received: (qmail 29855 invoked by uid 1000); 10 Feb 2009 20:03:32 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Feb 2009 20:03:32 -0000
In-Reply-To: <20090210191220.GT30949@spearce.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109298>

On Tue, 10 Feb 2009, Shawn O. Pearce wrote:

> Daniel Barkalow <barkalow@iabervon.org> wrote:
> > 
> > Actually, I went for the other end; I made close_pack_windows() not mind 
> > the open windows (hey, it's dying anyway in my case, nobody's going to 
> > write more), and the results passed verification and "git fsck --full" 
> > with just a few dangling blobs and a dangling commit. So it seems to me 
> > that it has to be wrong information in memory.
> 
> Like the wrong offset within the pack for the object start?
> 
> Can you compare the offsets you are getting during
> unpack_delta_entry() against what verify-pack -v
> shows for the same file?  They should agree, unless
> we're somehow wrong in memory within fast-import.

Is there some easy way to tell what object it was having problems with 
when it failed to unpack? I've got a whole lot of objects.

On the other hand, there's something interesting:

The expected size of the base is 1882, while the actual size is 151. The 
base offset it found was 12.

I'm using "checkpoint" a lot, so I've got 24 packs. Two of them have tree 
objects of size 1882 at offset 12; a different one has a tree object of 
size 151 at offset 12. The one with the object of size 151 was the one 
that was still open at the end. There's no tree of size 1882 in this pack, 
nor in any other pack that has a tree of size 151.

So maybe it's right about the offsets and all, but it's confused about 
which pack something was in? Maybe it cached something when the pack 
containing the object it wants was open, and it ended up thinking it was 
in the pack that's now open rather than the pack that was open and is now 
closed?

I don't suppose there would be an easy way to figure out the object it was 
trying to unpack by applying the delta?

> But then, the output pack-*.idx file created when
> fast-import closed the pack would be wrong too.

I think the wrong info it has is about the contents of a pack that had 
been closed previously. I think all of the info about objects in the open 
pack is correct.

	-Daniel
*This .sig left intentionally blank*
