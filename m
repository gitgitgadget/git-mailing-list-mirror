From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Wed, 15 Mar 2006 15:35:36 -0800
Message-ID: <7vlkvbffhz.fsf@assigned-by-dhcp.cox.net>
References: <20060314211022.GA12498@localhost.localdomain>
	<Pine.LNX.4.64.0603141351470.3618@g5.osdl.org>
	<20060314224027.GB14733@localhost.localdomain>
	<Pine.LNX.4.64.0603141506130.3618@g5.osdl.org>
	<7vek13ieap.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603151450070.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 16 00:35:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJfWo-0001UE-QW
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 00:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbWCOXfk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Mar 2006 18:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752170AbWCOXfk
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Mar 2006 18:35:40 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:22741 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1752166AbWCOXfj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Mar 2006 18:35:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060315233237.NGO17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 15 Mar 2006 18:32:37 -0500
To: Qingning Huo <qhuo@mayhq.co.uk>
In-Reply-To: <Pine.LNX.4.64.0603151450070.3618@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 15 Mar 2006 14:51:30 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17623>

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 15 Mar 2006, Junio C Hamano wrote:
>> 
>> If we do the dash-form for consistency's sake, we should do
>> PATH="`git --exec-path`:$PATH" in git-setup-sh when/before we do
>> so.
>
> Yes. That would make sense too. Then git-setup-sh would look more like 
> what the builtin git.c does.

I think some historical background is in order.

We started without bindir vs execdir distinction but we wanted a
way to someday migrate out of putting everything in bindir.  As
one part of the solution, "git" wrapper was invented, and as the
result of that effort, some parts of the scripts, and lot of
documentation pages and sample scripts, lost dashes.

Historically, git tools have always wanted everything git-* to
be found on user's PATH, and we were alarmed to see 100+ git-*
commands in /usr/bin.  That's why "git" wrapper and
GIT_EXEC_PATH environment were invented.  People can have
/usr/bin/git and no other git-* on their PATH, because that
"git" knows where to find the rest of git-* commands.  For that
to work, the scripts should know where to find the rest -- and
cleanest way is to run others via "git foo" form.

Consistency via s/git-foo/git foo/g _is_ the goal, but that kind
of change interferes with the other patches that do the real
work, and it is kind of boring, so nobody has done wholesale
clean-up of all the scripts.

Invoking with the full path is not an option -- it makes
building and testing-before-installing process too cumbersome.
You are welcome to try and send in a patch to do that if (and
only if) you volunteer to go the whole nine yards, but I have to
warn you that that approach is something we have already
considered and discarded, one reason why is because it makes the
testsuite unworkable (testing needs to be done before
installing).

If you want to use the other "git" (GNU interactive tools, which
I once heard is changing its name to gitfm or something like
that -- how nice of them -- but has it ever happened?), and if
you want to have /usr/bin (which has that "git") and then
/other/bin (which has on-topic "git") on your PATH, in that
order, that would be a problem.  Saying just "git" would invoke
other "git" that does not know what to do.

If you can solve that without hardcoding the full path in our
scripts, that would be ideal.  But otherwise, especially with
changing things back to "git-foo" form without making sure going
backward in that way would not hinder the migration out of
/usr/bin, then that creates more problems than it solves.

So that is why I said I would prefer dashless form.

I _think_ the simplest fix is to change the order of directories
you list on your PATH so that "git" is found before GNU
interactive tool, which is my impression that most people seem
to do (many in fact do not have GNU interactive tool on their
PATH anywhere).
