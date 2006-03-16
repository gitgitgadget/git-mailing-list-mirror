From: Qingning Huo <qhuo@mayhq.org>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Thu, 16 Mar 2006 07:53:24 +0000
Message-ID: <20060316075324.GA19650@pfit.vm.bytemark.co.uk>
References: <20060314211022.GA12498@localhost.localdomain> <Pine.LNX.4.64.0603141351470.3618@g5.osdl.org> <20060314224027.GB14733@localhost.localdomain> <Pine.LNX.4.64.0603141506130.3618@g5.osdl.org> <7vek13ieap.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603151450070.3618@g5.osdl.org> <7vlkvbffhz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Qingning Huo <qhuo@mayhq.co.uk>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 16 08:45:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJnAh-0006S1-MW
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 08:45:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbWCPHpU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 02:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752234AbWCPHpU
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 02:45:20 -0500
Received: from pfit.vm.bytemark.co.uk ([80.68.90.202]:37128 "HELO
	pfit.vm.bytemark.co.uk") by vger.kernel.org with SMTP
	id S1752232AbWCPHpU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 02:45:20 -0500
Received: (qmail 19794 invoked by uid 1001); 16 Mar 2006 07:53:24 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkvbffhz.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17628>

On Wed, Mar 15, 2006 at 03:35:36PM -0800, Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Wed, 15 Mar 2006, Junio C Hamano wrote:
> >> 
> >> If we do the dash-form for consistency's sake, we should do
> >> PATH="`git --exec-path`:$PATH" in git-setup-sh when/before we do
> >> so.
> >
> > Yes. That would make sense too. Then git-setup-sh would look more like 
> > what the builtin git.c does.
> 
> I think some historical background is in order.
> 
> We started without bindir vs execdir distinction but we wanted a
> way to someday migrate out of putting everything in bindir.  As
> one part of the solution, "git" wrapper was invented, and as the
> result of that effort, some parts of the scripts, and lot of
> documentation pages and sample scripts, lost dashes.
> 
> Historically, git tools have always wanted everything git-* to
> be found on user's PATH, and we were alarmed to see 100+ git-*
> commands in /usr/bin.  That's why "git" wrapper and
> GIT_EXEC_PATH environment were invented.  People can have
> /usr/bin/git and no other git-* on their PATH, because that
> "git" knows where to find the rest of git-* commands.  For that
> to work, the scripts should know where to find the rest -- and
> cleanest way is to run others via "git foo" form.
> 
> Consistency via s/git-foo/git foo/g _is_ the goal, but that kind
> of change interferes with the other patches that do the real
> work, and it is kind of boring, so nobody has done wholesale
> clean-up of all the scripts.

Thanks for the historical background.

> Invoking with the full path is not an option -- it makes
> building and testing-before-installing process too cumbersome.
> You are welcome to try and send in a patch to do that if (and
> only if) you volunteer to go the whole nine yards, but I have to
> warn you that that approach is something we have already
> considered and discarded, one reason why is because it makes the
> testsuite unworkable (testing needs to be done before
> installing).

So we recognize the full path approach is desired, but because of
technique reasons (building and testing), it is not applied.  I would
like to have a look of the said patch.  Can you give me some pointers?

> If you want to use the other "git" (GNU interactive tools, which
> I once heard is changing its name to gitfm or something like
> that -- how nice of them -- but has it ever happened?), and if
> you want to have /usr/bin (which has that "git") and then
> /other/bin (which has on-topic "git") on your PATH, in that
> order, that would be a problem.  Saying just "git" would invoke
> other "git" that does not know what to do.

This is exactly the problem I want to solve.  In this case, I alias git
to use our git program.

> If you can solve that without hardcoding the full path in our
> scripts, that would be ideal.  But otherwise, especially with
> changing things back to "git-foo" form without making sure going
> backward in that way would not hinder the migration out of
> /usr/bin, then that creates more problems than it solves.

We do not hard code the full path in the script.  We can use a function
gitexec() (in git-sh-setup) similiar to execv_git_cmd().  gitexec
searches git-command in GIT_EXEC_PATH, and then libexedir.  libexedir is
hardcoded in git-sh-setup.  But can be override by the environment
GIT_EXEC_PATH.  The make test target should set GIT_EXEC_PATH to the
build directory.

The remaining job is search and replace.  If we call gitexec() git(), we
can even keep the "git command" form unchanged.  But I prefer explicit
gitexec().

> I _think_ the simplest fix is to change the order of directories
> you list on your PATH so that "git" is found before GNU
> interactive tool, which is my impression that most people seem
> to do (many in fact do not have GNU interactive tool on their
> PATH anywhere).

I cannot uninstall /usr/bin/git.  It is not under my control.  I am
wondering whether I should move my home dir to the front of the PATH.
But a good tool should not force users to change their settings.

Qingning
