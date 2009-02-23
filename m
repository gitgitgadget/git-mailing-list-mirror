From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: GSoC 2009 Prospective student
Date: Mon, 23 Feb 2009 07:58:36 -0800
Message-ID: <20090223155836.GI22848@spearce.org>
References: <a149495b0902221158h16d499f7w8bd18abaf1321e46@mail.gmail.com> <20090222204334.GY4371@genesis.frugalware.org> <alpine.LFD.2.00.0902221709460.5511@xanadu.home> <m3y6vxupvf.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Rohan Dhruva <rohandhruva@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 17:00:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbdE7-0007tH-OR
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 17:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754350AbZBWP6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 10:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754286AbZBWP6l
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 10:58:41 -0500
Received: from george.spearce.org ([209.20.77.23]:40873 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070AbZBWP6k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 10:58:40 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 396FD38210; Mon, 23 Feb 2009 15:58:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <m3y6vxupvf.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111146>

Jakub Narebski <jnareb@gmail.com> wrote:
> Nicolas Pitre <nico@cam.org> writes:
> > On Sun, 22 Feb 2009, Miklos Vajna wrote: 
> > > 
> > > http://thread.gmane.org/gmane.comp.version-control.git/55254/focus=55298
> > > 
> > > Especially Shawn's message, which can be a base for your proposal, if
> > > you want to work in this.
> > 
> > I don't particularly agree with Shawn's proposal.  Reliance on a stable 
> > sorting on the server side is too fragile, restrictive and cumbersome.

We already rely on a stable sort in the tree format.  Asking that
a stable sort be applied when a clone is started so that we can
later resume it isn't unreasonable.  Hell, that tree format sort
is a B***H anyway, its not a simple sort by memcmp().  Almost every
Git re-implementation gets it wrong the first time out.
 
> > Restartable clone is _hard_.  Even I who has quite a bit of knowledge in 
> > the affected area didn't find a satisfactory solution yet.

Sure, its difficult, but nobody has put effort into it either.
I think it could be done by enforcing a stable sort during clone
(and perhaps only during clone).  That's the basis of that message
Miklos points to.  Though I don't think I ever said anything about
the stable sort only being used during clone.

> I think it is possible for dumb protocols (using commit walkers) and
> for (deprecated) rsync.

Yes, it is possible for the commit walkers to implement a restart,
as they are actually beginning at the current root and walking back
in history.  Resuming a large file like a pack is easy to do on HTTP
if the remote server supports byte range serving.  Its also easy
to validate on the client that the pack wasn't repacked during the
idle period (between initial fetch and restart), just validate the
SHA-1 footer.  If the pack was repacked and came up with the same
name you'll have a mismatch on the footer.  Discard and try again.

And if you want to save bandwidth, always grab the last 20 bytes
of the file before getting any other parts, save it somewhere,
and revalidate that last 20 before resuming.  If its changed,
you should discard what you have and start over from the beginning.

> > I think restartable clone is a really bad suggestion for SOC students.  
> > After all we want successful SOC projects, not ones that even core git 
> > developers did not yet find a good solution for.
> > 
> > IMHO of course.
> 
> But I agree that within current limits (as far as I know there are no
> way to ask for SHA-1; you can only ask for refs for security reasons)
> it would be difficult to very difficult to add restartable clone
> support to native (smart) protocols.
> 
> If not for this limitation it would be, I think, possible to do a kind
> of fsck, checking which commits in packfile are complete (i.e. have
> all objects), and based on that ask for subset of objects.  This would
> require support only from a client... alas, this is not possible.

I think the current "must want advertised ref" restriction is
too strict.  If you make the server check the reachability of the
wanted object, (assuming it can be resolved to a commit) then you
can pick up in the middle of history.  We already (to some extent)
support that with the deepen thing in a shallow clone.  Sure, it
may cause more server load when clients ask for this partial fetch.

But clients can already abuse a server far more by repeatedly doing
a clone, and then break the network connection as soon as the PACK
header comes down the wire.  The server just spent a lot of CPU
and IO time building the complete list of the objects to transmit.
Its really a non-trivial load on the server side.  And by having
the client break the pipe at the 'PACK' header, the client doesn't
have to absorb the large data transfer either.  Making it fairly
easy to DOS a Git daemon with a small botnet.

So, IMHO, the restriction that a commit must be advertised, and not
merely reachable, is overly strict and doesn't buy us a whole lot.
 
> I think that unless 'restartable clone' is limited to commit wakers
> (HTP protocol etc.) it should be moved up the diffuculty from "New to
> Git?" section. I guess that mirror-sync, formerly GitTorrent, could be
> easier to implement.

Maybe.  But a simple stable sort on the objects makes it easier,
perhaps within reach of "new to git".

That ideas page is a wiki for a reason.  If folks feel differently
from me, please edit it to improve things!  :-)

-- 
Shawn.
