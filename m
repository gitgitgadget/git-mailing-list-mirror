From: Nicolas Pitre <nico@cam.org>
Subject: Re: GSoC 2009 Prospective student
Date: Mon, 23 Feb 2009 11:31:38 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902231108110.5511@xanadu.home>
References: <a149495b0902221158h16d499f7w8bd18abaf1321e46@mail.gmail.com>
 <20090222204334.GY4371@genesis.frugalware.org>
 <alpine.LFD.2.00.0902221709460.5511@xanadu.home>
 <m3y6vxupvf.fsf@localhost.localdomain> <20090223155836.GI22848@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Rohan Dhruva <rohandhruva@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 23 17:33:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbdk4-0003lt-3G
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 17:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000AbZBWQbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 11:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753930AbZBWQbq
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 11:31:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58521 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840AbZBWQbq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 11:31:46 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KFJ00ADI1WQX260@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 23 Feb 2009 11:31:39 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090223155836.GI22848@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111152>

On Mon, 23 Feb 2009, Shawn O. Pearce wrote:

> Jakub Narebski <jnareb@gmail.com> wrote:
> > Nicolas Pitre <nico@cam.org> writes:
> > > On Sun, 22 Feb 2009, Miklos Vajna wrote: 
> > > > 
> > > > http://thread.gmane.org/gmane.comp.version-control.git/55254/focus=55298
> > > > 
> > > > Especially Shawn's message, which can be a base for your proposal, if
> > > > you want to work in this.
> > > 
> > > I don't particularly agree with Shawn's proposal.  Reliance on a stable 
> > > sorting on the server side is too fragile, restrictive and cumbersome.
> 
> We already rely on a stable sort in the tree format.  Asking that
> a stable sort be applied when a clone is started so that we can
> later resume it isn't unreasonable.  Hell, that tree format sort
> is a B***H anyway, its not a simple sort by memcmp().  Almost every
> Git re-implementation gets it wrong the first time out.

That's not the issue at all.  The sorting within a single tree object is 
indeed well defined (even if it is arguably a bit odd).  The object 
order is not, and now with threaded delta the list of actually deltified 
objects may and do vary from successive packing of the same repo.  
Committing ourselves to determinism here just for the sake of a 
restartable clone is not something I subscribe to.

> > > Restartable clone is _hard_.  Even I who has quite a bit of knowledge in 
> > > the affected area didn't find a satisfactory solution yet.
> 
> Sure, its difficult, but nobody has put effort into it either.
> I think it could be done by enforcing a stable sort during clone
> (and perhaps only during clone).

We should aim for a real solution, not something that is "special" for a 
clone.  After all, a clone is just a fetch, and large fetches may be 
interrupted too.

> > I think it is possible for dumb protocols (using commit walkers) and
> > for (deprecated) rsync.
> 
> Yes, it is possible for the commit walkers to implement a restart,
> as they are actually beginning at the current root and walking back
> in history.  Resuming a large file like a pack is easy to do on HTTP
> if the remote server supports byte range serving.  Its also easy
> to validate on the client that the pack wasn't repacked during the
> idle period (between initial fetch and restart), just validate the
> SHA-1 footer.  If the pack was repacked and came up with the same
> name you'll have a mismatch on the footer.  Discard and try again.

Sure, dumb protocols are easy.  It's one of the few advantages they have 
over the native protocol.

> But clients can already abuse a server far more by repeatedly doing
> a clone, and then break the network connection as soon as the PACK
> header comes down the wire.  The server just spent a lot of CPU
> and IO time building the complete list of the objects to transmit.
> Its really a non-trivial load on the server side.  And by having
> the client break the pipe at the 'PACK' header, the client doesn't
> have to absorb the large data transfer either.  Making it fairly
> easy to DOS a Git daemon with a small botnet.

This is easy to fix, and something I've posted design notes about a 
while ago.  A cache of generated packs can be made, indexed by a hash of 
the wanted/excluded refs used for pack generation.  This way popular 
fetches (say after Linus pushes stuff to his tree and everyone else 
fetches it at night) would require computation only once.  That is I 
think something more suitable for a SOC student project.

Of course willfully abusing a git server can be done despite of this, 
but that is true for any other service as well.

> That ideas page is a wiki for a reason.  If folks feel differently
> from me, please edit it to improve things!  :-)

/me hates editing wiki pages...  :-/



Nicolas
