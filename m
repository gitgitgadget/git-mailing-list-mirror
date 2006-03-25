From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: Fix branch ancestry calculation
Date: Fri, 24 Mar 2006 20:45:32 -0500
Message-ID: <20060325014532.GB32522@pe.Belkin>
References: <Pine.LNX.4.64.0603221723230.9196@g5.osdl.org> <44240619.20103@dm.cobite.com> <Pine.LNX.4.64.0603240739360.26286@g5.osdl.org> <1143218338.6850.68.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	David Mansfield <centos@dm.cobite.com>,
	David Mansfield <cvsps@dm.cobite.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 25 02:46:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMxqp-00082s-Qm
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 02:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbWCYBph (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 20:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbWCYBph
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 20:45:37 -0500
Received: from eastrmmtao06.cox.net ([68.230.240.33]:5518 "EHLO
	eastrmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751462AbWCYBpg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 20:45:36 -0500
Received: from localhost ([24.250.31.7]) by eastrmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060325014523.NNWI9108.eastrmmtao06.cox.net@localhost>;
          Fri, 24 Mar 2006 20:45:23 -0500
Received: from chris by localhost with local (Exim 4.43)
	id 1FMxqP-0008TH-0H; Fri, 24 Mar 2006 20:45:33 -0500
To: Keith Packard <keithp@keithp.com>
Content-Disposition: inline
In-Reply-To: <1143218338.6850.68.camel@neko.keithp.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17947>

On Fri, Mar 24, 2006 at 08:38:58AM -0800, Keith Packard wrote:
> On Fri, 2006-03-24 at 07:46 -0800, Linus Torvalds wrote:
> > 
> > On Fri, 24 Mar 2006, David Mansfield wrote:
> > > 
> > > Anyway, I'd like to nail down some of the other nagging ancestry/branch point
> > > problems if possible.
> > 
> > What I considered doing was to just ignore the branch ancestry that cvsps 
> > gives us, and instead use whatever branch that is closest (ie generates 
> > the minimal diff). That's really wrong too (the data just _has_ to be in 
> > CVS somehow), but I just don't know how CVS handles branches, and it's how 
> > we'd have to do merges if we were to ever support them (since afaik, the 
> > merge-back information simply doesn't exists in CVS).
> 
> cvsps is more of a problem than cvs itself. Per-file branch information
> is readily available in the ,v files; each version has a list of
> branches from that version, and there are even tags marking the names of
> them. One issue that I've discovered is when files have differing branch
> structure in the same repository. That happens when a branch is created
> while files are checked out on different branches.  I'm not quite sure
> what to do in this case; I've been trying several approaches and none
> seem optimal. One remaining plan is to just attach such branches by
> date, but that assumes that the first commit along a branch occurs
> shortly after the branch is created (which isn't required).
> 
> Of course, this branch information is only created when a change is made
> to the file along said branch, so most of the repository will lack
> precise branch information for each branch. When you create a child
> branch, the files with no commits in the parent branch will never get
> branch information, so the child branch will be numbered as if it were a
> branch off of the grandparent. Globally, it is possible to reconstruct
> the entire branch structure.

If that last sentence was a typo then you already know this, but
otherwise you may be disappointed to learn that it's not _always_
possible to discern the correct ancestry tree.

The simplest counter-example is two branches where each adds one file
and no files in common are modified.  If A and B both branched off of
HEAD and each adds one file, then they should each only have one file.
But if B branched from A which branched from HEAD, then B should also
have the file that was added to A. (*)  However, the information to
distinguish these two cases isn't recorded in CVS.  

I seem to have described this example more fully in the notes I took
while writing the patch to cvsps that does the global inferrence
you're describing.  You _usually_ can make a very good guess, and the
more files that are modified, the better you can do.

BTW, those notes are still available here:
http://www.codesifter.com/cvsps-notes.txt 

If you end up comparing the ancestry tree discovered by your tool and
the tree output by a patched cvsps, I would be very interested in the
results.

-chris

(*) You can distinguish between A->B->head and B->A->head simply by
date.
