From: Junio C Hamano <junkio@cox.net>
Subject: Re: git rebase chokes on directory -> symlink -> directory
Date: Sun, 13 May 2007 21:37:44 -0700
Message-ID: <7v1whkow9z.fsf@assigned-by-dhcp.cox.net>
References: <463FCD7C.4020009@zytor.com> <20070508215009.GA2670@steel.home>
	<46413565.3090503@zytor.com> <7vps569904.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alex Riesen <raa.lkml@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 14 06:37:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnSJm-0004bv-FH
	for gcvg-git@gmane.org; Mon, 14 May 2007 06:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757283AbXENEhq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 00:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757029AbXENEhq
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 00:37:46 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:59602 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754655AbXENEhq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 00:37:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070514043746.MXGG1318.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 14 May 2007 00:37:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ysdl1W0011kojtg0000000; Mon, 14 May 2007 00:37:45 -0400
In-Reply-To: <7vps569904.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 11 May 2007 17:32:43 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47219>

Junio C Hamano <junkio@cox.net> writes:

> However.
>
> I usually have "[apply] whitespace = strip" in my ~/.gitconfig,
> but during this verification run, I disabled it to keep rebase
> from falling back to 3-way merge using merge-recursive.  If I
> turn it on, rebase still fails and I strongly suspect "rebase
> -m" would fail the same way, although I haven't tried it (it
> takes too much time).
>
> I'll be somewhat busy this weekend, so I would welcome anybody
> else beating me to fixing the problem in merge-recursive.

Yuck.  merge-recursive does seem to have problem with D/F
conflict in general; I suspect this is not limited to cases that
involve symbolic links.

First, the setup.

$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-2.6-newsetup.git/
$ cd linux-2.6-newsetup.git
$ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
$ git branch other b2ad90f4969226fe8cf3edc5330711ed5fc20105
$ git branch ancestor other^1
$ git reset --hard ancestor
$ echo >>Makefile ; git add Makefile ; git commit -m 'change one'
$ git branch try

To see that the underlying read-tree is working as expected (and
do not have to be debugged), we can first try the usual three-way
read tree:

$ git read-tree -m -u ancestor HEAD other
$ git ls-files -u --abbrev arch/x86-64

This would show...

    120000 ad3f146 3       arch/x86_64/boot
    100644 495f20c 1       arch/x86_64/boot/.gitignore
    100644 495f20c 2       arch/x86_64/boot/.gitignore
    100644 ee6f650 1       arch/x86_64/boot/Makefile
    100644 ee6f650 2       arch/x86_64/boot/Makefile
    ...

The current HEAD (the one that we tagged as 'try') has the
directory arch/x86_64/boot/, but all of its files are unchanged
from the "common ancestor", so they all have identical stages 1
and 2, with stage 3 missing.  The other tree has boot/ as a
symlink.  These "One-side removes other side does not touch" and
"one-side adds" cases are left unmerged by "read-tree -m -u", as
that is how merge-recursive can find renames to begin with.

Now we've seen what the read-tree (which is the same machinery
used as git_merge_trees() in mege-recursive) does with these
three trees, let's see how merge-recursive finishes this off:

    $ git reset --hard try
    $ git merge-recursive ancestor -- HEAD other
    CONFLICT (directory/file): There is a directory with name arch/x86_64/boot in HEAD. Added arch/x86_64/boot as arch/x86_64/boot~other
    Removed arch/x86_64/boot/.gitignore
    Removed arch/x86_64/boot/Makefile
    Removed arch/x86_64/boot/bootsect.S
    Removed arch/x86_64/boot/compressed/Makefile
    Removed arch/x86_64/boot/compressed/head.S
    Removed arch/x86_64/boot/compressed/misc.c
    Removed arch/x86_64/boot/compressed/vmlinux.lds
    Removed arch/x86_64/boot/compressed/vmlinux.scr
    Removed arch/x86_64/boot/install.sh
    Removed arch/x86_64/boot/mtools.conf.in
    Removed arch/x86_64/boot/setup.S
    Removed arch/x86_64/boot/tools/.gitignore
    Removed arch/x86_64/boot/tools/build.c

There is no rename, so rename detection does not interfere, but
the D/F conflict detection code in merge-recursive thinks that
arch/x86_64/boot is a directory in one tree (yes, it is true in
the original tree, but it goes away as all files under it), and
a non-directory in another.  And instead of replacing the boot/
directory that becomes empty with a new symlink boot/, it
creates the boot~funny-name symlink and fails the operation.

When it actually is checking out arch/x86_64/boot out of the
resolved index, it should notice that (1) arch/x86_64/boot
directory is unnecessary to house anything in the resulting
index anymore, and that (2) there is no locally created
untracked file that is 'precious' [*1*].  Then it can rmdir()
and create the boot/ symlink in its place.  To fix this, it may
be necessary to update its checkout code to perform the "remove
first then create" two-pass process git-apply does.

It is unfortunate that for merge-recursive it is probably too
cumbersome to always do the right thing, but I think it should
at least notice that arch/x86_64/boot whose files all disappear
does not conflict with creation of the new symlink.
