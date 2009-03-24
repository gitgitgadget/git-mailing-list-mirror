From: Nicolas Pitre <nico@cam.org>
Subject: Re: large(25G) repository in git
Date: Tue, 24 Mar 2009 14:31:31 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903241404080.26337@xanadu.home>
References: <49C7FAB3.7080301@brainfood.com>
 <alpine.LFD.2.00.0903232056520.26337@xanadu.home>
 <49C91F87.3050105@brainfood.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Adam Heath <doogie@brainfood.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 19:34:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmBRn-0007ND-ND
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 19:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744AbZCXSbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 14:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754228AbZCXSbl
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 14:31:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30353 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbZCXSbj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 14:31:39 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KH000KFPWSJ7G20@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 24 Mar 2009 14:31:31 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <49C91F87.3050105@brainfood.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114476>

On Tue, 24 Mar 2009, Adam Heath wrote:

> Nicolas Pitre wrote:
> 
> > Strange.  You could instruct ssh to keep the connection up with the 
> > ServerAliveInterval option (see the ssh_config man page).
> 
> Sure, could do that.  Already have a separate ssh config entry for
> this host.  But why should a connection be kept open for that long?
> Why not close and re-open?

Because it is way more complex for git to do that than for ssh to keep 
the connection alive.  And normally there is no need as git is supposed 
to be faster than that.

> Consider the case of other protocol access.  http/git/ssh.  Should
> they *all* be changed to allow for this?  Wouldn't it be simpler to
> just make git smarter?

Making git faster is the solution, not working around the issue.

> >> So, to work around that, I ran git gc.  When done, I discovered that
> >> git repacked the *entire* repository.  While not something I care for,
> >> I can understand that, and live with it.  It just took *hours* to do so.
> >>
> >> Then, what really annoys me, is that when I finally did the push, it
> >> tried sending the single 27G pack file, when the remote already had
> >> 25G of the repository in several different packs(the site was an
> >> hg->git conversion).  This part is just unacceptable.
> > 
> > This shouldn't happen either.  When pushing, git reconstruct a pack with 
> > only the necessary objects to transmit.  Are you sure it was really 
> > trying to send a 27G pack?
> 
> Of course I'm sure.  I wouldn't have sent the email if it didn't
> happen.  And, I have the bandwidthd graph and lost time to prove it.

As much as I would like to believe you, this doesn't help fixing the 
problem if you don't provide more information about this.  For example, 
the output from git during the whole operation might give us the 
beginning of a clue.  Otherwise, all I can tell you is that such thing 
is not supposed to happen.

> After I ran git push, ssh timed out, the temp pack that was created
> was then removed, as git complained about the connection being gone.

On a push, there is no creation of a temp pack.  It is always produced 
on the fly and pushed straight via the ssh connection.

> I then decided to do a 'git gc', which collapsed all the separate
> packs into one.  This allowed git push to proceed quickly, but at that
> point, it started sending the entire pack.

If this was really the case, then this is definitely a bug.  Please take 
a snapshot of your screen with git messages if this ever happens again.

> It's entirely possible that the temp pack created by git push was
> incremental; it just took too long to create it, so it got aborted.

The push operation has multiple phases.  You should see "counting 
objects", "compressing objects" and "writing objects".  Could you give 
us an approximation of how long each of those phases took?

> But, doing git gc shouldn't cause things to be resent.

Indeed.

> The machines in question have done push before.  Even small amounts;
> just the set of objects that are newer.  It's just this time, when the
> 1.6G of new data was added, git ended up creating a new pack file,
> that contained the entire repo, and then tried sending that.

And this is wrong.

> I forgot to mention previously, that the source machine was running
> git 1.5.6.5, and was pushing to 1.5.6.3.
> 
> I've tried duplicating this problem on a machine with 1.6.1.3, but
> either I don't fully understand the issue enough to replicate it, or
> the newer git doesn't have the problem.

That's possible.  Maybe others on the list might recall possible issues 
related to this that might have been fixed during that time.

> >> 2: Is there an option to tell git to *not* be so thorough when trying
> >> to find similiar files.  videos/doc/pdf/etc aren't always very
> >> deltafiable, so I'd be happy to just do full content compares.
> > 
> > Look at the gitattribute documentation.  One thing that the doc appears 
> > to be missing is information about the "delta" attribute.  You can 
> > disable delta compression on a file pattern that way.
> 
> Um, if it's missing documentation, then how am I supposed to know
> about it?

Asking on the list, like you did.  However this attribute should be 
documented as well of course.  I even think that someone posted a patch 
for it a while ago which might have been dropped.


Nicolas
