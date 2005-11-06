From: Junio C Hamano <junkio@cox.net>
Subject: Re: git binary directory?
Date: Sat, 05 Nov 2005 18:49:24 -0800
Message-ID: <7voe4y5w3v.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511051247330.3316@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 06 03:51:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYacT-0002oh-Kf
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 03:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVKFCt1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Nov 2005 21:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVKFCt1
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Nov 2005 21:49:27 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:36522 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932211AbVKFCt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2005 21:49:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051106024905.UJKJ1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 5 Nov 2005 21:49:05 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511051247330.3316@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 5 Nov 2005 13:02:23 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11188>

Linus Torvalds <torvalds@osdl.org> writes:

> Now, I happen to think that 2500+ files in /usr/bin is a bit much (ever 
> try to use the horrid gnome executable finder on it when you want to 
> convince firefox to use xpdf instead of that broken crap called "evince"? 
> Takes absolutely ages and is horrible).
>
> And git made it about 4% worse all on its own.

My pragmatic half agrees with what you said.  /usr/bin should
not contain things that are never used by the end user -- things
like git-sh-setup, git-fmt-merge-msg, and git-merge-recursive
should not be there.  Not having things like git-show-branch and
git-update-index in /usr/bin is a regression because it needs an
extra fork to call them through 'git' wrapper, but I could live
with that.

My purist half, however, says that it is a wrong solution to the
problem.  If having many files in /usr/bin hurts performance,
you should be using a filesystem that handles large directory
better.  Modern shells already know how to hash command names
found in $PATH.  It is just your gnome executable finder that is
lacking the knowledge of which binaries are appropriate for what
mimetype; perhaps your distribution could help by having a way
for each package to register programs that handle particular
mimetypes well with the system-wide database.

And my lazy remainder (yes, I add up to more then one ;-))
cheers on my purist side.

But common sense prevails at the end of the day.  I would not
fight a battle I know I would not be able to win.  So what
should we do about this problem?  And when?

Since we do not have enough clout to have /usr/bin/git/ and ask
the users to put that in their PATH like X11 does, we need to
teach some of our commands that use other git commands to
prepend /usr/lib/git/ (or /usr/libexec/git) on their PATH while
they run.  Although many of the Porcelainish commands include
git-sh-setup, git-sh-setup itself is a prime candidate to be
kicked out of /usr/bin, which means essentially everything needs
to have that PATH trick.

This also is a bit inconvenient for our in-source-tree tests.
We need to be testing what we just built and are about to
install, not what is already installed, so every script needs to
start with something like this:

	#!/bin/sh
	: ${GIT_BIN_DIR=@@GIT_BIN_DIR@@}
        PATH="$GIT_BIN_DIR:$PATH"
        git-sh-setup || die "not a git repository"
	...

and our test will run with GIT_BIN_DIR set to `pwd`/../../ (they
run in t/trash and what we just built are found at the toplevel
of the source).  Also we need to do the same for binaries if they
fork/exec other git commands.

Commands like upload-pack and receive-pack are directly executed
from the ssh connection, and we need to arrange for them to be
found on the PATH of users' non-login shells.  This does not
necessarily mean these commands need to stay in /usr/bin, but if
we move them outside standard PATH, we would need to teach
.bash_profile vs .bashrc workaround to all users, which I think
is the yuckiest part of all of the above.
