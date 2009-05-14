From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Thu, 14 May 2009 07:57:24 -0700
Message-ID: <20090514145724.GE30527@spearce.org>
References: <200905122329.15379.jnareb@gmail.com> <20090512233450.GY30527@spearce.org> <200905141024.17525.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 16:57:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4cNJ-0006cL-93
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 16:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbZENO5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 10:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbZENO5Y
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 10:57:24 -0400
Received: from george.spearce.org ([209.20.77.23]:51377 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbZENO5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 10:57:24 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C9794381D5; Thu, 14 May 2009 14:57:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200905141024.17525.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119201>

Jakub Narebski <jnareb@gmail.com> wrote:
> On Wed, 13 May 2009 Shawn O. Pearce wrote:
> > Jakub Narebski <jnareb@gmail.com> wrote:
> > > We have now proliferation of different (re)implementations of git:
> > > JGit in Java, Dulwich in Python, Grit in Ruby; and there are other
> > > planned: git# / managed git in C# (GSoC Mono project), ObjectiveGit
> > > in Objective-C (for iPhone IIRC).  At some time they would reach
> > > the point (or reached it already) of implementing git-daemon...
> > > but currently the documentation of git protocol is lacking.
> > 
> > Well, lets see...
> 
> So you are saying that even if detailed pack protocol specification
> isn't written down (Documentation/technical/pack-protocol.txt is more
> of a sketch than reference documentation), the knowledge is there,
> and it is not that hard to get (just ask on git mailing list), isn't it?

Yup.  We've tried to keep JGit right here on this list just to keep
the knowledge concentrated here, so git@vger is the place anyone
can ask questions, and get good answers.

> > No existing developers knew that the fetch-pack/upload-pack protocol
> > has this required implicit buffering consideration until JGit
> > deadlocked over it.  But even then I'm still not 100% sure this
> > is true, or if it is just an artifact of the JGit upload-pack side
> > implementation being partially wrong.
> 
> Well... I guess that section on Best Current Practices to avoid 
> deadlocking would not be there to avoid this issue in JGit, but
> would be added for the future later.

So I'm actually right (and Junio confirmed it off list), the
fetch-pack/upload-pack protocol with multi_ack enabled requires
a buffer on the client side of at least 2952 bytes which can be
drained to the server after the client enters its receive phase.

In practical implementations like git:// TCP and SSH, there is
enough inherit buffering in the TX side of the client that this
isn't an issue.

In loopback mode for local file URIs, it may become an issue.  C Git
is just getting lucky by the pipe size I think.  Though I thought I
read somewhere yesterday pipe FIFOs in Linux were being allocated
at 512 bytes, not one system page.  Of course other systems could
allocate whatever size they want too, and may allocate something
below the 2952 minimum, and we'd most likely see a deadlock on them.

> > > The current documentation of git protocol is very sparse; the docs
> > > in Documentation/technical/pack-protocol.txt offer only a sketch of
> > > exchange.  You can find more, including pkt-line format, a way sideband
> > > is multiplexed, and how capabilities are negotiated between server and
> > > client in design document for "smart" HTTP server, for example in
> > >   Subject: Re: More on git over HTTP POST
> > >   Message-ID: <20080803025602.GB27465@spearce.org>
> > >   URL: http://thread.gmane.org/gmane.comp.version-control.git/91104/focus=91196
> > 
> > Seriously?  Don't link to that.  Its a horrible version of the smart
> > HTTP RFC, and worse, it doesn't describe what you say it describes.
> 
> Ooops, I am sorry. This was my bookmark into this thread (which is very
> interesting, and contain host of otherwise unknown to me information
> about pack protocol), but the post in this thread was quite arbitrary
> (a random post where I decided that this thread is interesting enough
> to bookmark, and long enough to not want to save all interesting posts).

GMane is dead right now, otherwise I'd try to find the link you
were more likely talking about.  I think you were right, there may
have been a much better post in that particular thread.
 
> > And lets not even start to mention Dulwich not completing a thin
> > pack before storing it on disk.  Those sorts of on disk things
> > matter to other more popular Git implementations (c git, jgit).
> 
> Ugh! Errr... aren't thin packs send only if other side has the
> capability for it?

Yes.

> What is then Dulwich doing announcing such 
> capability when not supporting it correctly...

Because the implementation is just busted.

-- 
Shawn.
