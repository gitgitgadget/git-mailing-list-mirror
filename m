From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] Build a shared / renamed / "stable" version of the library?
Date: Fri, 16 Sep 2005 11:46:55 -0700
Message-ID: <7vmzmcj1eo.fsf@assigned-by-dhcp.cox.net>
References: <pan.2005.09.16.12.37.14.736570@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Roundy <droundy@abridgegame.org>
X-From: git-owner@vger.kernel.org Fri Sep 16 20:47:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGLEi-0000kG-AQ
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 20:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161262AbVIPSq5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 14:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161257AbVIPSq5
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 14:46:57 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:24553 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1161262AbVIPSq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 14:46:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050916184656.QWBV3414.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Sep 2005 14:46:56 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>
cc: git@vger.kernel.org
In-Reply-To: <pan.2005.09.16.12.37.14.736570@smurf.noris.de> (Matthias
	Urlichs's message of "Fri, 16 Sep 2005 14:37:17 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8705>

[David Roundy CC:ed because I was once asked about libgit.a ABI
 stability issues from darcs-git community, and I lost the e-mail
 address of the primary person there who is working on it; but I
 know David is nice enough to arrange the message to be forwarded
 to appropriate places.]

Matthias, I think you are solving a wrong problem.  More
precisely, solving problems in a wrong order.

As things stand, libgit.a should not be taken as "a library" but
merely as a convenient way to simplify our Makefile [*1*].
There are larger problems with what is in the current libgit.a
viewed as a library if you want to use it to do anything
remotely interesting:

 - Almost all the interesting bits of git-core are in individual
   programs (rev-list, merge-base, ...).  The functionality from
   them _could_ be moved into libgit.{a,so}, but many have the
   built-in assumption that they are run once and the mess they
   leave behind will be cleaned up by process termination.

 - Management of even the most basic data structures used in
   libgit.a shares the "run once" mentality.  I can offhand
   think of three but I am sure there are more:

   - active_cache: once you are done with the current cache, it
     is very hard to reinitialize and use it without losing
     memory [*2*];

   - alternate_odb: GIT_ALTERNATE_OBJECT_DIRECTORIES and
     info/objects/alternates are looked at only once, and
     objects are slurped from these directories afterwards; this
     means you cannot easily switch between repositories (think
     of doing gitweb in mod-perl, with the libifiled libgit.so).

   - 'struct object' and its descendants: they keep track of
     which object has been seen, and the marks used by various
     commands that do the most interesting part of what git does
     persist; this means that you cannot for example make
     merge-base libified and run two of them inside a program
     very easily [*3*] [*4*].

 - The naming clash with host programs and other libraries they
   might use, which you mentioned.

I am not saying the above problems are unsolvable, but I think
the naming conflict is the least of them.  You just slurp the
current git.git into darcs-git, run token replace patch there
and slurp the results back in, teach the git-core people to use
the new names and you are done.  However, without solving the
second one (and to a lesser extent the first one), I do not
think you can usefully use the guts of git as a library.  You
can read many blobs without spawning git-cat-file for each of
them, but that is about how far you could go.  If we were to do
the libification properly, those "run once" bits should be
updated to have "git_init" [*5*] to return the handle to a data
structure that represents their current state, and be made to
take that handle to do their work in their given 'state
sandbox', and deallocate that state when they are done.

Don't get me wrong.  I would really want to see the guts of git
libified and SWIG'ed.  That would help not just your Python
thing but also StGIT and Fredrik merge (both are Python), as
well as gitk (tcl/tk) and gitweb (Perl).  I would not even mind
seeing all the git barebone Porcelain redone in Python once we
go in that direction, ditching the shell scripts we currently
have.


[Footnote]

*1* We do not have to build and maintain list of object files
each resulting binary uses in the Makefile and we let the
linker find it out for us.

*2* Hopefully this will be fixed when Chuck is done but the work
and the discussion has just been started and I do not know how the
timeframe of this cache abstraction cleanup meshes with 1.0
timeframe.

*3* I once wanted to have 'git-rev-parse A...B' to mean
'git-rev-parse `git-merge-base A B`..B'.  In order to grok
'git-rev-parse A...B C...D', you should be able to run
merge-base twice inside of git-rev-parse.

*4* I think diffcore part is reasonably well libified -- not
because who wrote it was brilliant, but simply because it was
necessary for it to be able to get called repeatedly from
'diff-tree --stdin' form from day one.

*5* Maybe we would want separate git_init_cache,
git_init_objects, ... and be able to mix and match them.  Maybe
not.  
