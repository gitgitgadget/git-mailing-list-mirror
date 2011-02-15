From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] git-gui: give more advice when detaching HEAD
Date: Tue, 15 Feb 2011 20:16:21 +0100
Message-ID: <20110215191620.GA56397@book.hvoigt.net>
References: <20110212070538.GA2459@sigill.intra.peff.net> <20110213123151.GA31375@book.hvoigt.net> <20110215063903.GA28634@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Pat Thoyts <patthoyts@googlemail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 15 20:16:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpQNx-0001wZ-Qc
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 20:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382Ab1BOTQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 14:16:25 -0500
Received: from darksea.de ([83.133.111.250]:33671 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755313Ab1BOTQX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 14:16:23 -0500
Received: (qmail 21404 invoked from network); 15 Feb 2011 20:16:21 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 15 Feb 2011 20:16:21 +0100
Content-Disposition: inline
In-Reply-To: <20110215063903.GA28634@sigill.intra.peff.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166868>

Hi,

On Tue, Feb 15, 2011 at 01:39:03AM -0500, Jeff King wrote:
> On Sun, Feb 13, 2011 at 01:31:52PM +0100, Heiko Voigt wrote:
> 
> > On Sat, Feb 12, 2011 at 02:05:38AM -0500, Jeff King wrote:
> > >   1. Give some indication or warning during commit that you're in a
> > >      detached state. The CLI template says "You are not on any branch"
> > >      when editing the commit message, and mentions "detached HEAD" as
> > >      the branch in the post-commit summary. As far as I can tell,
> > >      git-gui says nothing at all.
> > 
> > How about something like this:
> > [...]
> > Subject: [PATCH] git-gui: warn when trying to commit on a detached head
> > 
> > The commandline is already warning when checking out a detached head.
> > Since the only thing thats potentially dangerous is to create commits
> > on a detached head lets warn in case the user is about to do that.
> 
> It seems a little heavy-handed to have a dialog pop up for each commit.
> It's not actually dangerous to create a commit on a detached HEAD; it's
> just dangerous to _leave_ without referencing your new commits.

Hmm, how about adding a checkbox:

  [ ] Do not ask again

In my experience anything other than a popup will be overseen so I would
suggest doing it at least once to prepare the user for the possible
consequences.

IMO such a message is a good thing for the GUI regardless whether we
implement the leaving detached HEAD state warning. First I think a
typical GUI user does not commit on a detached head that often since
there is currently no way to use these commits from the GUI (e.g.
format-patch, rebase, ...). Second because a detached head is very
practical for testing work on a remote branch the message box would
remind most users to switch to their development branch first. If they
only get that message after a series of commits it might become a hassle
for them to get these commits onto another branch (remember no
format-patch or rebase currently).

> So I think for making commits, something informational that doesn't
> require a click-through would be the more appropriate level (similar to
> what the CLI does; it just mentions it in the commit template). I guess
> there isn't a commit template in the same way for git gui; instead, it
> is always showing you the current state. And indeed, it does switch from
> "Current Branch: master" to "Current Branch: HEAD" when you are on a
> detached head. Maybe we should beef that up a bit to "You are not on any
> branch." or something that is more self-explanatory. I dunno. I am just
> guessing here about what users would want.
> 
> I do think a pop-up is appropriate when you try to check something else
> out, and commits you have made on the detached HEAD are about to become
> unreferenced. But this is something even the CLI doesn't do, so it would
> make sense to see how the check is implemented there first before doing
> anything in git-gui.

>From what I read in this thread it currently seems to be not so easy to
precisely find out whether some commit is referenced. (If we care about
stuff outside of remotes, heads and tags). But maybe we do not need
that for the GUI.

If a commit is referenced from non typical refs the worst we do is issue
a false warning. Meaning we warn the user even though the commit is
referenced. For a GUI I think being a little more restrictive is the
right thing to do since it should guide the user much more into a safe
workflow. If he wants to do special things than there still is the CLI
to fall back on. And its just a warning so we are not preventing
anything.

Now it depends on what we would want for the CLI if we are going to
implement a thorough check over everything in refs/ than there is no
reason for not applying the same thing to git-gui. In case the current
behavior is deemed sufficient we should go with the check mention

Just to give you a practical example:

At $dayjob we are currently even more restrictive and completely forbid
commits on a detached head by a pre-commit hook. This was mainly done
due to the lack of warnings but I do not recall a single incident where a
user actually complained about this restriction (~90% GUI users).

Cheers Heiko
