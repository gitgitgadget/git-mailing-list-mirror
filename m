From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: fact-import: failed to apply delta
Date: Tue, 10 Feb 2009 16:19:27 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0902101520240.19665@iabervon.org>
References: <alpine.LNX.1.00.0902092218050.19665@iabervon.org> <alpine.DEB.1.00.0902101126040.10279@pacific.mpi-cbg.de> <20090210155626.GM30949@spearce.org> <alpine.LNX.1.00.0902101118110.19665@iabervon.org> <20090210172212.GR30949@spearce.org>
 <alpine.LNX.1.00.0902101226580.19665@iabervon.org> <20090210191220.GT30949@spearce.org> <alpine.LNX.1.00.0902101427300.19665@iabervon.org> <20090210201203.GU30949@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 22:21:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX02h-0001Sv-HO
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 22:21:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756302AbZBJVTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 16:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755936AbZBJVTf
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 16:19:35 -0500
Received: from iabervon.org ([66.92.72.58]:40769 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756302AbZBJVTe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 16:19:34 -0500
Received: (qmail 716 invoked by uid 1000); 10 Feb 2009 21:19:27 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Feb 2009 21:19:27 -0000
In-Reply-To: <20090210201203.GU30949@spearce.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109312>

On Tue, 10 Feb 2009, Shawn O. Pearce wrote:

> Daniel Barkalow <barkalow@iabervon.org> wrote:
> > 
> > Is there some easy way to tell what object it was having problems with 
> > when it failed to unpack? I've got a whole lot of objects.
> 
> Can you use gdb to find it?  If so, walk up the stack into
> fast-import.c's load_tree() function and look at sha1 here,
> and also, *myoe.

Okay, sha1 is 961a2199..., which is correct as a delta against the tree of 
size 151 at offset 12 of its own pack; the bogus thing seems to be the 
base_size (and presumably base).

> > The expected size of the base is 1882, while the actual size is 151. The 
> > base offset it found was 12.
> > 
> > I'm using "checkpoint" a lot, so I've got 24 packs. Two of them have tree 
> > objects of size 1882 at offset 12; a different one has a tree object of 
> > size 151 at offset 12. The one with the object of size 151 was the one 
> > that was still open at the end. There's no tree of size 1882 in this pack, 
> > nor in any other pack that has a tree of size 151.
> > 
> > So maybe it's right about the offsets and all, but it's confused about 
> > which pack something was in? Maybe it cached something when the pack 
> > containing the object it wants was open, and it ended up thinking it was 
> > in the pack that's now open rather than the pack that was open and is now 
> > closed?
> 
> fast-import keeps all of its object data in a single table of
> "struct object_entry", the table is keyed by SHA-1.  Each entry
> has a pack_id, which tells it which pack this object is in, and
> the offset of the object within that pack.
> 
> Sounds like maybe its confusing the pack pointer in the all_packs
> array (see gfi_unpack_entry).

I think maybe there's aliasing in the delta base cache? If it recycled a 
struct packed_git, the cache would come up with a cached tree at offset 12 
of the packed_git at that address, but the pack used by that struct has 
changed.

I don't see any reason that the situation couldn't arise where you start a
pack, look up an object in it while it's still open but the object isn't 
in the window, cache the delta base, end that packfile, eventually start a 
packfile that gets allocated in the space that was freed, produce a new 
delta against the object at exactly the same offset of the new pack (with 
the same address as the old pack), and go on happily until you try looking 
up this last delta and pull the wrong base out of the cache.

I don't see any code to flush the delta cache ever, but it's hard to get a 
new packed_git allocated at the address of a freed one, except by doing a 
lot of checkpoints in fast-import...

	-Daniel
*This .sig left intentionally blank*
