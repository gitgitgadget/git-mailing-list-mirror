From: tom fogal <tfogal@alumni.unh.edu>
Subject: More on svn workflows
Date: Sat, 23 Jan 2010 15:57:17 -0700
Message-ID: <auto-000021753828@sci.utah.edu>
Reply-To: tfogal@sci.utah.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 24 00:24:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYpLW-0001kg-4N
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 00:24:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682Ab0AWXYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 18:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277Ab0AWXYp
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 18:24:45 -0500
Received: from mail.sci.utah.edu ([155.98.58.79]:49488 "EHLO sci.utah.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750883Ab0AWXYo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 18:24:44 -0500
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Jan 2010 18:24:44 EST
Received: from dummy.name; Sat, 23 Jan 2010 15:54:42 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137878>

I have recently (1, 1.5 months ago?) started using a workflow similar
to the one described here:

  http://www.spinics.net/lists/git/msg109896.html

(short summary: work in private branch, "merge --no-ff" into svn
upstream, "merge" from svn upstream.)

... with the minor modification that I use "--squash" instead of
"--no-ff".  If I use --no-ff, I end up with a lot of "merge from master
into <myprivatebranch>" commits on my master branch before I dcommit.
It also merges in a lot of history that I feel like I shouldn't see--
that is, both the svn commit and my private branch's commit, and I'm
worried about what might happen if I dcommit that.  That said, I might
be in that situation because I used --squash 3 or 4 times before I
realized I was misremembering that thread.

Anyway, my current issue is that whenever I do a `git commit' after a
"merge --squash", I end up with *everything* I've done since starting
the branch in the commit message.  To be more explicit, say I've got
this setup:

  o--o--o                 master
         \
          o--o--o         private branch started

then I'll update master and merge it into my private branch:

  o--o--o--------D          master
         \        \
          A--B--C--o        private

test, merge --squash private into master and dcommit:

  o--o--o--------D---A'--B'--C'--D''     master
         \        \ /
          A--B--C--D'                    private

something happens upstream:

  o--o--o--------D---A'--B'--C'--D''--E        master
         \        \ /
          A--B--C--D'                          private

which I merge to private:

  o--o--o--------D---A'--B'--C'--D''--E        master
         \        \ /                  \
          A--B--C--D'-------------------E'     private

I do some work, commit F, and decide I want to push it upstream, so
I'll do a merge --squash into master:

  o--o--o--------D---A'--B'--C'--D''--E-------F'   master
         \        \ /                  \     /
          A--B--C--D'-------------------E'--F      private

Now the issue is when I `git commit' the merge from private, git says
this is a "squashed commit of the following", and lists the commit
messages for A, B, C, D, D', D'' E, E' and F.  I really just want the
commit message for "F" in this case -- every other message is already
on the trunk, in a different commit.  This wasn't such a big issue
at first: git picked up a few extra commits, so I hacked out the log
messages before committing them on master.  After doing this for a
while though, there's something like 100 commits I have to wade through
while doing this, and it's only going to get worse and worse.

On the other hand, I'm sure there's some option I could use so "git
commit" would startup with an empty commit message in this case, but I
do *want* the partial history, as it helps me design the commit message
that I want the svn trunk's history to have.

What am I doing wrong?

-tom
