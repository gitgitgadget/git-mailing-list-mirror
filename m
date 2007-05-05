From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/5] Add --remote option to send-pack
Date: Sat, 05 May 2007 00:54:14 -0700
Message-ID: <7vr6pvln89.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704281304360.28708@iabervon.org>
	<7vtzuzg26l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704290152410.28708@iabervon.org>
	<7vejm3g0dg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705022330460.28708@iabervon.org>
	<7virba31wd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705030137520.28708@iabervon.org>
	<7vejly305u.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705050115270.28708@iabervon.org>
	<7vr6pvn5k0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705050235210.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat May 05 09:54:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkF62-0006df-0x
	for gcvg-git@gmane.org; Sat, 05 May 2007 09:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646AbXEEHyQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 03:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030811AbXEEHyQ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 03:54:16 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:45681 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646AbXEEHyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 03:54:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070505075416.HNCC6556.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 5 May 2007 03:54:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vKuE1W00Q1kojtg0000000; Sat, 05 May 2007 03:54:15 -0400
In-Reply-To: <Pine.LNX.4.64.0705050235210.28708@iabervon.org> (Daniel
	Barkalow's message of "Sat, 5 May 2007 02:52:55 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46248>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Wouldn't it be better to to this as:
>
> [remote "origin"]
> 	url = git.kernel.org:/pub/scm/git/git.git/
> [branch "master"]
> 	remote = origin
> 	merge = refs/heads/master

As I am likely to pull from other people, and I happen to expect
the old fashioned "git pull gfi" without explicit refspec on the
command line to get the first Pull: line from remotes file to
tell which one to merge from, I am in favor of _not_ having that
[branch "master"] stuff in my repository.

remote.*.fetch is about what remote branches are fetched;
tracking may or may not happen as a side effect.  What I do with
the resulting .git/FETCH_HEAD is my business and branch.*.merge
should _not_ be the only way to access it.

> Merging without tracking is fine, in general; the "without tracking" was 
> intentionally parenthetical. 

Actually, fetching with or without tracking are both valid
options, and it does not make much sense to say which one is
norm and which one is exception.

> I just don't think always merging a 
> particular remote head into the current branch, regardless of what branch 
> is current, is a good idea.

Exactly.  That's why I do not think [branch "master"] for
toplevel maintainer usage is not very useful.

There are a few improvements we probably would want.

One is the interaction between the config "fetch =..." refspecs
and the command line ones.  Currently the rule is:

 - If you do not say refspecs on the command line, fetch config
   (or Pull: lines from remotes/* file) are used.

 - If you do have refspecs on the command line, fetch config are
   not used (they are ignored).

Which is fine when we talk about "git fetch", but if you _are_
using remote tracking, and if you are running "git fetch" as an
implementation detail of running "git pull" (IOW, you said "git
pull origin next"), it is less than optimum.  Instead of "only
fetch 'next' without tracking and then merge it", we would
certainly want "fetch to track everything as usual, and then
merge 'next' instead of what is usually merged".

Another thing is that which branch is merged into the current
branch should not be a function of the current branch, as the
current configuration mechanism suggests.  The current way maps
the current branch to "which repository's which branch".  In
addition to that, I think it should be a function of ("current
branch", "remote repository") pair.  IOW, allow you to say "If I
pull from this remote without saying which one to merge, merge
that branch.  If I pull from this other remote, merge that other
branch".  Something like:

        [branch "master"]
                ; Use this when "git pull" did not say which remote
                remote = origin

                ; Use this when "git pull origin" did not say which
                ; branch(es) to merge
                merge = refs/heads/master
                ; the above should be a synonym for
		; merge = refs/heads/master for origin

                ; "git pull fast-import" while on my "master"
                ; would merge 'for-junio' branch there.
                merge = refs/heads/for-junio for fast-import

                ; similarly, but use subtree strategy.
                merge = refs/heads/for-junio with subtree for git-gui

        [remote "origin"]
                url = git://git.kernel.org/pub/scm/git/git.git/
                fetch = refs/heads/*:remotes/origin/*
        [remote "fast-import"]
                url = git://repo.or.cz/git/fastimport.git/
                fetch = refs/heads/*:remotes/gfi/*
        [remote "git-gui"]
                url = git://repo.or.cz/git-gui.git/
                fetch = refs/heads/*:refs/remotes/git-gui/*
