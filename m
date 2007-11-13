From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Strange "beagle" interaction..
Date: Tue, 13 Nov 2007 16:50:47 -0500
Message-ID: <20071113215047.GG22590@fieldses.org>
References: <alpine.LFD.0.9999.0711131241050.2786@woody.linux-foundation.org> <20071113210354.GD22590@fieldses.org> <alpine.LFD.0.9999.0711131326310.2786@woody.linux-foundation.org> <9e4733910711131344t381b939dg47b5e078c52be3b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 22:51:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is3fI-0007gv-Ac
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762393AbXKMVux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761328AbXKMVux
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:50:53 -0500
Received: from mail.fieldses.org ([66.93.2.214]:42591 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762379AbXKMVuv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:50:51 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Is3eh-00013k-BD; Tue, 13 Nov 2007 16:50:47 -0500
Content-Disposition: inline
In-Reply-To: <9e4733910711131344t381b939dg47b5e078c52be3b2@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64886>

On Tue, Nov 13, 2007 at 04:44:33PM -0500, Jon Smirl wrote:
> On 11/13/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> >
> > On Tue, 13 Nov 2007, J. Bruce Fields wrote:
> > >
> > > Last I ran across this, I believe I found it was adding extended
> > > attributes to the file.
> >
> > Yeah, I just straced it and found the same thing. It's saving fingerprints
> > and mtimes to files in the extended attributes.
> 
> Things like Beagle need a guaranteed log of global inotify events.
> That would let them efficiently find changes made since the last time
> they updated their index.

Wouldn't a simple change-attribute get you most of the way there?  All
you need is a number that's guaranteed to increase any time a file is
updated.

Lacking that, git's current approach (snapshot all the stat data, then
look closer at any files that appear to have been touched within a
second of the stat) seems pretty sensible.

--b.

> Right now every time Beagle starts it hasn't got a clue what has
> changed in the file system since it was last run. This forces Beagle
> to rescan the entire filesystem every time it is started. The xattrs
> are used as cache to reduce this load somewhat.
> 
> A better solution would be for the kernel to log inotify events to
> disk in a manner that survives reboots. When Beagle starts it would
> locate its last checkpoint and then process the logged inotify events
> from that time forward. This inotify logging needs to be bullet proof
> or it will mess up your Beagle index.
> 
> Logged files systems already contain the logged inotify data (in their
> own internal form). There's just no universal API for retrieving it in
> a file system independent manner.
