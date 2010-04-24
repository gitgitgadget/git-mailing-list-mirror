From: tytso@mit.edu
Subject: Re: bug in name-rev on linux-2.6 repo?
Date: Sat, 24 Apr 2010 19:04:15 -0400
Message-ID: <20100424230415.GA667@thunk.org>
References: <r2sbe6fef0d1004220354g6443218ezbd0452428ad9e4b5@mail.gmail.com>
 <20100422121408.GI3211@stro.at>
 <20100422124042.GA1433@progeny.tock>
 <m2hbn37e7q.fsf@igel.home>
 <20100422144433.GB28923@coredump.intra.peff.net>
 <20100422145455.GC28923@coredump.intra.peff.net>
 <20100422150325.GB4801@progeny.tock>
 <20100422151708.GA15039@coredump.intra.peff.net>
 <20100422162504.GA4913@progeny.tock>
 <alpine.LFD.2.00.1004221119290.26046@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	maximilian attems <max@stro.at>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 25 01:04:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5oP1-0005T3-KL
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 01:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107Ab0DXXEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 19:04:43 -0400
Received: from THUNK.ORG ([69.25.196.29]:39490 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753634Ab0DXXEm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 19:04:42 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1O5oOa-0006cJ-6p; Sat, 24 Apr 2010 19:04:20 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1O5oOW-0000Bx-3t; Sat, 24 Apr 2010 19:04:16 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1004221119290.26046@i5.linux-foundation.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145710>

On Thu, Apr 22, 2010 at 11:20:34AM -0700, Linus Torvalds wrote:
> On Thu, 22 Apr 2010, Jonathan Nieder wrote:
> >
> > Hi Ted, [ nip ]
> > 
> > It seems that the committer date is set to coincide with the author
> > date for ext4 patches, which breaks some assumptions by git that each
> > commit has a later or equal committer date than all parents (modulo
> > some skew).
> 
> Argh. Yeah, that's just _evil_. Admittedly, git should never care, but in 
> practice it does, because doing the whole graph walk can be _very_ 
> expensive. So git wants to think that the committer dates at least have 
> _some_ real-life significance.
>
> > How is the ext4 tree generated from your patch queue?

Argh, sorry, I didn't realize git cared.  I didn't realize it was
doing optimizations based on the committer dates.

I'm using guilt to generate the ext4 tree.  The realize why I like
guilt is that keep the patch queue stored in git, both for revision
history purposes and because it allows other people to see and
potentially collaborate on the patch queue maintenance.

A long time ago (as in years), I put in a feature request to the guilt
maintainer that the author and committer dates should be set from the
file modtimes.  This has the property that when I go back and forth
between commits, it doesn't generate excess garbage for git to deal
with, since with the author and committer dates the same, if I do a
"guilt pop" followed by a "guilt push", the commit id of HEAD stays
the same.

So far, so good, until it happens that I decide I need to rewind the
patch queue and update a patch description (maybe to add a kernel
bugzilla entry, or an tested-by, etc.)  Since that touches the
modtime, you can end up with crazy date sequences such as this:

Sun Jan 24 14:34:07 2010 -0500 19f5fb7
Mon Dec 7 10:36:20 2009 -0500 d2eecb0
Fri Jan 1 01:00:21 2010 -0500 f8ec9d6
Wed Dec 23 07:45:44 2009 -0500 71f2be2
Fri Jan 22 17:40:42 2010 -0500 1f2acb6
Mon Feb 15 20:17:55 2010 -0500 15121c1
Thu Feb 4 23:58:38 2010 -0500 a1de02d

In any case, I didn't realize this causes problems, so I can add some
manual processing to make sure this doesn't happen in the future, and
I can look into hacking guilt so that enforces the invariant that the
commiter time/date must always be increasing.

Sorry about causing problems,

					- Ted
