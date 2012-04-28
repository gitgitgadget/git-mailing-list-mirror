From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: gc --aggressive
Date: Sat, 28 Apr 2012 13:11:48 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1204281258050.21030@xanadu.home>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
 <CAG+J_DyqvCxwd6+gzixQEk6SxMZF0qsXKcJPaU6imsJdFQ-64g@mail.gmail.com>
 <vpqbomqqdxo.fsf@bauges.imag.fr> <20120428122533.GA12098@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 28 19:11:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOBBa-0007sS-QT
	for gcvg-git-2@plane.gmane.org; Sat, 28 Apr 2012 19:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849Ab2D1RLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Apr 2012 13:11:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49740 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537Ab2D1RLt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2012 13:11:49 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M3700IGB93OZI90@VL-VM-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 28 Apr 2012 13:11:49 -0400 (EDT)
In-reply-to: <20120428122533.GA12098@sigill.intra.peff.net>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196498>

On Sat, 28 Apr 2012, Jeff King wrote:

> On Tue, Apr 17, 2012 at 10:52:03PM +0200, Matthieu Moy wrote:
> 
> > Jay Soffian <jaysoffian@gmail.com> writes:
> > 
> > > + 3. `git gc --aggressive`; this is often much slower than (2) because git
> > > +    throws out all of the existing deltas and recomputes them from
> > > +    scratch. It uses a higher window parameter meaning it will spend
> > > +    more time computing, and it may end up with a smaller pack. However,
> > > +    unless the repository is known to have initially been poorly packed,
> > > +    this option is not needed and will just cause git to perform
> > > +    extra work.
> > 
> > I like your patch.
> > 
> > Maybe you should elaborate on "unless the repository is known to have
> > initially been poorly packed". My understanding is that --aggressive was
> > implemented to be called after an import from another VCS that would
> > have computed very poor deltas, but I'm not sure about the details.

This is somewhat subjective of course.  But to be effective, you need 
sufficient resources to repack with --aggressive, otherwise you may 
potentially end up with a worse pack.

> Coincidentally, I came across a case last week that shows --aggressive
> providing a large improvement. And it's a public repo, so I was able to
> grab a snapshot of the pre-packed state to experiment on and share.
> 
> The current packfile is ~246M. It was produced over time by pushes into
> the repository, which were then eventually grouped into a single pack by
> "git gc" (I'm not sure of the exact history, but this may even have been
> a set of "gc --auto" calls over time).
> 
> Here's a list of commands and the pack sizes they yield on the repo:
> 
>   1. `git repack -ad`: 246M
>   2. `git repack -ad -f`: 376M
>   3. `git repack -ad --window=250`: 246M
>   4. `git repack -ad -f --window=250`: 145M
> 
> The most interesting thing is (4): repacking with a larger window size
> yields a 100M (40%) space improvement. The other commands show that it
> is not that the current pack is simply bad; command (2) repacks from
> scratch and actually ends up with a worse pack. So the increased window
> size really is important.

Absolutely.  This doesn't surprises me.

> I haven't been able to figure out what it is about this dataset that
> makes the bigger window so much better. Certainly doing the same
> commands on git.git does not yield as impressive a speedup.

The default window size of 10 objects is really really small (yet if 
your objects are 150MB in size then it is probably too big, but I 
digress).  When doing an incremental repack, the window is also limited 
by the fact that we don't redelta those already packed objects.

Many things could explain the improvements with a larger window.  If a 
lot of files were renamed for example, the larger window would allow 
similar objects to still delta against each other, despite the fact that 
we pull them in the search window according to their corresponding file 
names.  With a smaller window this opportunity would be missed.


Nicolas
