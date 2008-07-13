From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] Finding all commits that touch the same files as a
 specific commit
Date: Sat, 12 Jul 2008 18:24:11 -0700
Message-ID: <7viqvavao4.fsf@gitster.siamese.dyndns.org>
References: <bd6139dc0807120858vc058451lb10933b5225c8521@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailinglist" <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Sun Jul 13 03:25:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHqL6-0003gu-Ha
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 03:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbYGMBY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 21:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbYGMBY0
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 21:24:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61217 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbYGMBY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 21:24:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 788EB2C3A5;
	Sat, 12 Jul 2008 21:24:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5A3AC2C3A2; Sat, 12 Jul 2008 21:24:19 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6C564F94-507A-11DD-8822-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88281>

"Sverre Rabbelier" <alturin@gmail.com> writes:

> Currently I do the following:
> $git diff-tree --name-status --no-commit-id -r <hash>
> To get all the files touched by the commit, I do:
> $git rev-list HEAD -- all the returned paths here
> This works perfectly, except when the subtree merge strategy is used,
> since in that case I get (example from git.git):
> $ git diff-tree --name-status --no-commit-id -r
> 5821988f97b827f6ba81dfeebff932067c88ba6c
> M	git-gui.sh
> M	lib/diff.tcl
> $ git rev-list HEAD -- git-gui.sh lib/diff.tcl
> $
>
> Now it was noticed on #git that git log has a --follow argument which
> -does- catch the rename, but it only works on one file at a time. So,
> my question is this:
> How do I find all commits that touch the same files as a specific commit?
> I have described my current approach above, which does not work when
> the subtree merge strategy is used. I am not stuck to this approach
> though, if someone comes up with a better way to do this than with
> 'git diff-tree' / 'git rev-list' I'm fine by that. I provided with my
> current approach in the hope that someone comes up with a similar
> solution which means I'll have to edit less ;).

First of all, a bad news that everybody should have known since day 1 when
the --follow option was introduced.  It merely is a cute hack that works
most of the time in trivial histories.  The data structure it uses cannot
reliably follow renames if you have any nontrivial history.

Revision traversal machinery has a single list of pathspecs to filter the
results with, and in the usual traversal, the list never changes.  That is
why you would need to give a list of three pathspecs upfront, like this:

	git log -- arch/i386 arch/x86 arch/x86_64

to get the whole picture of how things are consolidated into a single
arch/x86 hierarchy over time from originally two hierarchies.  The
revision traversal works by simplifying away commits that do not touch
path that match any of the given pathspecs, so giving the "current" path
(i.e. arch/x86) is not sufficient.

The --follow changes the behaviour slightly.  When you have this history:

    ---o---o---o---x---x---x

where a file you are interested in (say, arch/i386/kernel/reboot.c)
existed in the past in 'o' commits, but was renamed to something else
(say, arch/x86/kernel/reboot.c) in newer 'x' commits, you would start
following from the tip of the history like this:

	git log --follow arch/x86/kernel/reboot.c

And the machinery traverses down the history, showing only the commits
that touch the given path.  An interesting thing happens, however, when it
hits the earliest 'x' commit and realizes that its parent 'o' does not
have that path.  It runs the rename detection there, realizes the path it
is interested in corresponds to a different path in the parent, and
_updates_ the pathspec to the old name.  I.e. it will from that point on
behaves as if you started digging from the tip of this history:

    ---o---o---o

with a different pathspec:

	git log --follow arch/i386/kernel/reboot.c

This works as long as your history is trivial, but in real life, the world
is not linear.

          x---x---x---x
         /       /
    ----o---o---o

If commits 'x' have git-gui/git-gui.sh and commits 'o' have git-gui.sh at
the root level, you would start digging from the tip with --follow:

	git log --follow git-gui/git-gui.sh

When it hits the rightmost merge 'x', it realizes the changes to the file
came from lower history and switches the pathspec to "git-gui.sh" at the
root level (the commits that have already been traversed are marked with
uppercase latters here).

          x---x---X---X
         /       /
    ----o---o---O

Switching the pathspec from "git-gui/git-gui.sh" to "git-gui.sh" is fine
for the purpose of traversing the 'o' history down, but there is a
problem.  Remember I said there is a _single_ list of pathspecs the
revision traversal machinery keeps track of?  If you switch that single
list to "git-gui.sh", it means you completely forget that you were
following "git-gui/git-gui.sh".  You cannot follow the upper history
anymore.

In order to follow renames reliably in a merge heavy history, you need to
keep track of the pathname the file you are interested in appears as _in
each commit_.  As you traverse down the history, you pass down the
pathname to the parent you visit, so while you are traversing from 'x' to
earlier 'x', you will keep following "git-gui/git-gui.sh", while you
traverse down to 'o', you will inspect "git-gui.sh".

The data structure the revision traversal machinery uses does not support
this "path-per-commit" natively.

This is the reason "git-blame" uses its own traversal engine.  It keeps
track of <commit, path> pairs so that it can mark which line came from
what path in what commit.  When copy/move detection are used, we can even
notice that the contents we are interested in came from more than one file
in the same commits, and the data structure supports it (i.e. it is not
just a pointer to a single string from "struct commit").

For the purpose of "git log" traversal and the "file renames" people
usually talk about, this is overkill; you should however be able to
backport the basic idea to revision machinery, if you really cared.

In a real history, "file rename" is a very ill defined concept and is not
always useful in practice.  I did a fairly detailed analysis on one
real-world history more than two years ago, which is found here:

    http://thread.gmane.org/gmane.comp.version-control.git/13746/focus=13769

In our own "git.git" history, the evolution of what finally landed in
revision.c is interesting.  The interesting part of content movement never
involved any file renames --- only bits and pieces migrated over across
many files.  That is not something "file rename tracking", even with an
extension to the revision traversal machinery to keep one path per commit
to record the file you are interested in, can ever give meaningful
explanation of the history.  You need a lot more fine grained "blame"
traversal machinery for that.
