From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Thu, 16 Mar 2006 02:14:52 -0800
Message-ID: <7vmzfq8zmr.fsf@assigned-by-dhcp.cox.net>
References: <20060314211022.GA12498@localhost.localdomain>
	<Pine.LNX.4.64.0603141351470.3618@g5.osdl.org>
	<20060314224027.GB14733@localhost.localdomain>
	<Pine.LNX.4.64.0603141506130.3618@g5.osdl.org>
	<7vek13ieap.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603151450070.3618@g5.osdl.org>
	<7vlkvbffhz.fsf@assigned-by-dhcp.cox.net>
	<20060316075324.GA19650@pfit.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 16 11:15:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJpWA-0004gs-Ks
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 11:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbWCPKOz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 05:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbWCPKOz
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 05:14:55 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:44758 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1752321AbWCPKOy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 05:14:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060316101137.TJRI26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 16 Mar 2006 05:11:37 -0500
To: Qingning Huo <qhuo@mayhq.org>
In-Reply-To: <20060316075324.GA19650@pfit.vm.bytemark.co.uk> (Qingning Huo's
	message of "Thu, 16 Mar 2006 07:53:24 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17631>

Qingning Huo <qhuo@mayhq.org> writes:

> On Wed, Mar 15, 2006 at 03:35:36PM -0800, Junio C Hamano wrote:
>> I think some historical background is in order.
>> ...
> Thanks for the historical background.

Sorry, it just occurred to me that I was totally confused, and I
apologize for giving only half of the historical background,
without giving the "end of the story -- conclusion", which I did
not remember until now.

What we ended up deciding after that "My /usr/bin/git is sane
but /usr/bin/diff is wrong so I have /home/$u/bin/diff and
/home/$u/bin is listed earlier in my $PATH" discussion, as I
remember, was this:

 * We expect users to invoke things on the command line via the
   "git" wrapper.  Either having the directory that has our
   "git" in earlier on the PATH, or giving the full path to it
   as the command (your use of alias qualifies as the latter).

 * One of the important things the "git" wrapper does is to
   prefix GIT_EXEC_PATH to the $PATH environment before invoking
   the "git-foo" commands [*1*].  

 * "git-foo" command, if it is written in a scripting language,
   can safely assume "git-bar" is found on the PATH while it is
   executing.  If it is C-level and uses exec[vl]_git_cmd() to
   run the subcommand, it would also work fine (it will use the
   right GIT_EXEC_PATH).

This has a few implications:

 * By doing the above setup, we are effectively punting on the
   original issue.  First of all, it is very inconceivable that
   /usr/bin/git is sane, and /usr/bin/diff is not (git wants a
   working diff after all).  If the user is overriding
   /usr/bin/diff by having a better diff under /home/$u/bin/, he
   could have his own copy of git under /home/$u/bin/ as well
   (more likely, the person with correct privilege to installed
   /usr/bin/git would have replaced faulty /usr/bin/diff).  More
   importantly, when bindir and gitexecdir are split, gitexecdir
   will not be /usr/bin (bindir will be).  It will more likely
   to be /usr/lib/git/exec, and it would contain only git-*
   things; prefixing that directory to PATH would not mask the
   /home/$u/bin/diff or anything else non-git the user wanted to
   mask stuff from /usr/bin with, so the original issue becomes
   moot at that point.

 * Typing "git-foo" on the command line would work most of the
   time, if git is built with gitexecdir set to standard bin
   directory (the way our Makefile is shipped).  git-foo will be
   found on your PATH, and it will find "git-bar" on your PATH.
   However, when we split bindir and gitexecdir, typing
   "git-foo" on the command line without having GIT_EXEC_PATH on
   your PATH would stop working, so users have been encouraged
   to train their fingers to use dashless form ever since
   GIT_EXEC_PATH was introduced [*2*].

 * If "git-foo" invoked from the command line (without necessary
   GIT_EXEC_PATH prefixing done by the "git" wrapper) tries to
   run "git", the right git needs to be found on your PATH,
   otherwise things may not necessarily work (your setup
   violates this).  But people have been encouraged to say "git
   foo" to begin with, so this is probably not a big
   deal. Retraining people to say "git foo" instead of "git-foo"
   is a bigger issue compared to this.

 * If "git foo" is typed on the command line, underlying
   "git-foo" is run with GIT_EXEC_PATH prefixed, so it will find
   "git-bar".  If the script uses "git bar", "git" needs to be
   found either in GIT_EXEC_PATH or on your PATH, since our
   Makefile does not install "git" in gitexecdir.  Right now, we
   have bindir == gitexecdir, so "git bar" in "git-foo" script
   will work fine and this is a non-issue, but when we split
   them, it will break your setup, so we need to address this
   before that happens.

So in short, there are two real issues with your original
"git-push misbehaves".  One is that it broke because it was
spelled with dash.  I think "git push" shouldn't misbehave even
with your setup, because the "git" wrapper, before it calls
"git-push", should set up the PATH so that its exec-path is in
front of anything you have in your original PATH (either
/usr/bin or ~/opt/bin), and should find the right "git".

And the second issue is the last point in the "implications"
list above.  You are right, and I stand corrected.  Our scripts
should consistently use dash form.

One thing that bothers me is that we need to keep encouraging
users to use dashless form from the command line, while we
update our scripts to use dash form.  What a contradicting and
confusing situation X-<.


[Footnote]

*1* The "remove prefixing from git.c" patch I sent out earlier
tonight is wrong.  That's the crucial piece to make this whole
setup work.

*2* I think I've been careful enough to use dashless form in the
examples I give in my list postings, but I am not sure how
successful I have been.
