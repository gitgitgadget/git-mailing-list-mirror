From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Wed, 21 Feb 2007 03:22:51 -0800
Message-ID: <7vmz37pxf8.fsf@assigned-by-dhcp.cox.net>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net>
	<7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
	<20070217232603.GB30839@coredump.intra.peff.net>
	<7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
	<20070217233203.GA6014@coredump.intra.peff.net>
	<Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>
	<7vodnp68p8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702191527320.20368@woody.linux-foundation.org>
	<7vwt2d4s6c.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702191601300.20368@woody.linux-foundation.org>
	<Pine.LNX.4.64.0702210014140.6485@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 12:23:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJpYt-0000Je-QV
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 12:23:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbXBULWx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 06:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbXBULWx
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 06:22:53 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:43646 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbXBULWw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 06:22:52 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070221112252.WHJ2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Wed, 21 Feb 2007 06:22:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SBNr1W0031kojtg0000000; Wed, 21 Feb 2007 06:22:52 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40294>

Daniel Barkalow <barkalow@iabervon.org> writes:

> "git apply" should be able to notice the many clues that this patch 
> doesn't go at the root: (1) it's not -r; (2) it's not a rename, but the 
> filenames aren't the same; (3) there isn't an extra path element to 
> remove.

I would sort-of agree with (1) and (3) but people can do

	cd drivers && diff -u Makefile~ Makefile

so (2) is not a good clue and (3) is not really either.

Especially files like 'Makefile' are everywhere that dwimming
and getting it wrong is worse than being stupid but consistent.

We do -p1 by default because the BCP on the kernel list (which
is where git came from -- but I suspect many projects follow the
convention) is to use "diff a/dir/file b/dir/file".  This is
also a convenient setup for people who apply git generated (or
BCP formatted) patches from the toplevel of the tree.

But when you are dealing with handcrafted patches in a
subdirectory, such as the one you would get by:

    $ cd some/dir && edit file.c && diff -u file.c~ file.c >G.patch

you do not have the "a/some/dir b/some/dir" prefix, so -p1 to
strip "a/" and "b/" is a wrong thing to begin with, but looking
at G.patch you would not even have "some/dir", so no "correct"
value exists if we refuse to DWIM (and I refuse to).  We support
path strip levels with -p<n> option ever since you added it with
e36f8b60, so that is Ok.

However, the current version (in v1.5.0.1) of git-apply has a
few inconsistencies.

 * When --index (or --cached) is given, and when the patch is a
   git generated (or BCP formatted) patch, it finds out where in
   the working tree you are, and strips the right prefix
   automatically.

 * When there is no --index nor --cached, however, it does not
   bother to find out where in the working tree your $cwd is,
   and assumes you are at the toplevel (you may not even be in a
   git managed tree but are using git-apply as a better "patch",
   in which case there is no way to find out where the toplevel
   is).  You need to give -p<n> to explicitly strip the leading
   path.  This is not a problem but happens to be a feature to
   help applying handcrafted patches, like G.patch above.  Also,
   it is consistent with how GNU patch would behave.  However,
   -p<n> is ignored when the patch is a git generated one, which
   is a minor additional problem.

I was initially in favor of correcting this inconsistency by
matching the behaviour of non --index/--cached case to that of
the behaviour of --index/--cached case (in other words, making
things more convenient for people who apply git generated and/or
BCP formatted patches).  But Linus talked me out of it --- and I
think he is right.

Inconsistency is fixed by making the behaviour more similar to
"GNU patch".  The behaviour of --index/--cached case is changed
so that it does not automatically strip "some/dir" part when you
are in a subdirectory, which is how git-apply without these
options operates.  Of course, ignoring -p<n> for git generated
patches no longer makes sense with this change, which is also
fixed, so you can use the same -p<n> as you would give to "GNU
patch".

What is cooking in 'next' should behave the way described above.
If not, patches to fix it is very much welcome ;-).

P.S.  I think the list hasn't heard from you for quite some
time.  Welcome back.
