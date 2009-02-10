From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: fact-import: failed to apply delta
Date: Tue, 10 Feb 2009 16:32:11 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0902101628140.19665@iabervon.org>
References: <alpine.LNX.1.00.0902092218050.19665@iabervon.org> <alpine.DEB.1.00.0902101126040.10279@pacific.mpi-cbg.de> <20090210155626.GM30949@spearce.org> <alpine.LNX.1.00.0902101118110.19665@iabervon.org> <20090210172212.GR30949@spearce.org>
 <alpine.LNX.1.00.0902101226580.19665@iabervon.org> <20090210191220.GT30949@spearce.org> <alpine.LNX.1.00.0902101427300.19665@iabervon.org> <20090210201203.GU30949@spearce.org> <alpine.LNX.1.00.0902101520240.19665@iabervon.org>
 <20090210212539.GV30949@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 22:33:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX0Eh-0005uH-8g
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 22:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755595AbZBJVcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 16:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755565AbZBJVcO
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 16:32:14 -0500
Received: from iabervon.org ([66.92.72.58]:45799 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754629AbZBJVcO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 16:32:14 -0500
Received: (qmail 1607 invoked by uid 1000); 10 Feb 2009 21:32:11 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Feb 2009 21:32:11 -0000
In-Reply-To: <20090210212539.GV30949@spearce.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109317>

On Tue, 10 Feb 2009, Shawn O. Pearce wrote:

> Daniel Barkalow <barkalow@iabervon.org> wrote:
> > 
> > I think maybe there's aliasing in the delta base cache? If it recycled a 
> > struct packed_git, the cache would come up with a cached tree at offset 12 
> > of the packed_git at that address, but the pack used by that struct has 
> > changed.
> 
> Yup, that must be it.
>  
> > I don't see any reason that the situation couldn't arise where you start a
> > pack, look up an object in it while it's still open but the object isn't 
> > in the window, cache the delta base, end that packfile, eventually start a 
> > packfile that gets allocated in the space that was freed, produce a new 
> > delta against the object at exactly the same offset of the new pack (with 
> > the same address as the old pack), and go on happily until you try looking 
> > up this last delta and pull the wrong base out of the cache.
> > 
> > I don't see any code to flush the delta cache ever, but it's hard to get a 
> > new packed_git allocated at the address of a freed one, except by doing a 
> > lot of checkpoints in fast-import...
> 
> *ouch*.  I think you found it.
> 
> We should dump the cached_objects table in sha1_file.c during
> a checkpoint in fast-import.

No, that one's keyed by sha1, and doesn't get collisions; it's the 
delta_base_cache that's the issue; it's keyed by struct packed_git * and 
offset.

	-Daniel
*This .sig left intentionally blank*
