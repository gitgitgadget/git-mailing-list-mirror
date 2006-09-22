From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Remove branch by putting a null sha1 into the ref file.
Date: Fri, 22 Sep 2006 15:09:31 -0700
Message-ID: <7v3baj365g.fsf@assigned-by-dhcp.cox.net>
References: <20060918065429.6f4de06e.chriscool@tuxfamily.org>
	<Pine.LNX.4.64.0609180926590.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Sep 23 00:10:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQtDk-0007uM-BA
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 00:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbWIVWJf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 22 Sep 2006 18:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965226AbWIVWJe
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 18:09:34 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:45507 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965227AbWIVWJd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Sep 2006 18:09:33 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060922220932.YBNU21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Fri, 22 Sep 2006 18:09:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ra9a1V00A1kojtg0000000
	Fri, 22 Sep 2006 18:09:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609180926590.4388@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 18 Sep 2006 09:31:21 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27534>

Linus Torvalds <torvalds@osdl.org> writes:

> It's entirely possible that the proper way to do branch deletion with=
=20
> packed branches is to simply re-pack without the old branch, rather t=
han=20
> the negative branch model. I couldn't really decide.

After playing with branch deletion issues for some time, I
started to think it would be a lot simpler if we do not mark
a deleted branch with 0{40}.

I started rewriting git-branch in C, mostly reusing Kristian
H=F8gsberg's patch but taking care of the reflog issue still left
in the original thread:

    Subject: [PATCH] branch as a builtin (again)
    Date: Sun, 20 Aug 2006 17:22:18 -0400
    Message-ID: <59ad55d30608201422h4a6d40f7y7782212637380438@mail.gmai=
l.com>

We need to take care of two funny cases around packed-ref in
lock_ref_sha1_basic() where a creation of a new ref takes
place.  It needs to deal with two issues.

 * We should not allow frotz branch to be created when
   frotz/nitfol branch already exists (packed and pruned).
   Being able to create .git/refs/heads/frotz.lock file and
   being able to rename it to .git/refs/heads/frotz is not
   enough.  The other way around has the same problem.  So we
   would need to have a for_each_ref() to check if the ref being
   created is a prefix of an existing one or there is an
   existing one that is a prefix of the one being created.

 * When creating frotz branch, there may be a leftover
   .git/refs/heads/frotz/ directory on the filesystem.  If the
   directory is empty (or contains only empty subdirectories),
   we can rmdir recursively and make refs/heads/frotz file
   there.  Otherwise it means that a branch frotz/something
   still exists there, but the above prefix check should have
   taken care of it.  So in practice we should always be able to
   just do an equivalent of "rm -fr .git/refs/heads/frotz" when
   creating a frotz branch.

But the latter falls apart if we use 0{40} convention to mark a
deleted branch. Removing .git/refs/heads/frotz/nitfol file which
has 0{40} and creating .git/refs/heads/frotz file resurrects
frotz/nitfol branch that is still packed.  Not allowing frotz
branch to be created only because we had deleted frotz/nitfol
previously is not what we want either, so at that point we need
to repack without frotz/nitfol anyway.

Which makes me think that we would better repack when removing
any existing ref.

BTW, the second issue exists without packed ref; currently we
cannot do

    git branch foo/bar
    git branch -d foo/bar
    git branch foo
