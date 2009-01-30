From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] EasyGit (eg) 0.97
Date: Fri, 30 Jan 2009 14:47:27 -0500
Message-ID: <20090130194727.GA31927@coredump.intra.peff.net>
References: <51419b2c0901300842rb993454u7e8b6d1032c12ac8@mail.gmail.com> <e2b179460901300859r438a4230hc990305688b4f29e@mail.gmail.com> <51419b2c0901301035g6867b9d8l2d4de9590035bd4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 20:49:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSzMY-0004n8-Az
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 20:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbZA3Trb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 14:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752640AbZA3Trb
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 14:47:31 -0500
Received: from peff.net ([208.65.91.99]:42018 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752514AbZA3Tra (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 14:47:30 -0500
Received: (qmail 4102 invoked by uid 107); 30 Jan 2009 19:47:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Jan 2009 14:47:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2009 14:47:27 -0500
Content-Disposition: inline
In-Reply-To: <51419b2c0901301035g6867b9d8l2d4de9590035bd4e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107866>

On Fri, Jan 30, 2009 at 11:35:50AM -0700, Elijah Newren wrote:

> > 2009/1/30 Elijah Newren <newren@gmail.com>:
> >> [5] The bug I can only occasionally trigger and which I don't know the
> >> cause of yet: when exiting from eg log the terminal settings sometimes
> >> are messed up (with echo off and such), requiring a "reset" to get the
> >> terminal back to normal.
> >
> > Are you sure that isn't this bug in git.git ?
> >
> > pager: do wait_for_pager on signal death
> > http://article.gmane.org/gmane.comp.version-control.git/106728
> 
> Interesting.  I just went and tried out next (git version
> 1.6.1.2.418.gd79e6), which I believe has this patch...and after a
> while I was still able to duplicate the eg bug on one of my
> machines[1].  So it doesn't seem to be that particular issue, at
> least.

There is also a related set of fixes for spawning externals via fork,
which fixes a bug with the pager not getting cleaned up. But it looks
like it is also in the version you tested.

Can you give a more complete recipe for reproducing? Since I was just
touching this area in git, I want to make sure it isn't a git bug you
are triggering. :)

As an aside, I found some related weirdness. In my git repo, if I do
this:

  $ git checkout next
  $ eg log -p

I get log output, but the diff is not colorized (and I have color.diff
set to "auto" in my ~/.gitconfig). But if I detach my HEAD and show the
log:

  $ git checkout next^0
  $ eg log -p

then I _do_ get color in the patch. I also get this error:

  Use of uninitialized value $branch in concatenation (.) or string at
  /home/peff/eg line 2854.
  eg: command (git rev-parse refs/heads/) failed
  eg: received signal 13

The error is easy to explain. The offending code is:

    my $branch = RepoUtil::current_branch();
    my ($ret, $revision) =
      ExecUtil::execute_captured("git rev-parse refs/heads/$branch");

So it is clear that you just need to handle the case of there being no
current branch. But the color thing is certainly exotic. :)

-Peff
