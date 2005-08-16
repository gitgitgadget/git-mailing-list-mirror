From: Junio C Hamano <junkio@cox.net>
Subject: Re: Making note, in the repository, of push/pull relationships
Date: Mon, 15 Aug 2005 17:18:43 -0700
Message-ID: <7vzmrispi4.fsf@assigned-by-dhcp.cox.net>
References: <20050815162519.GB9719@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 02:19:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4pAJ-0005TH-4L
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 02:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbVHPASp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 20:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbVHPASp
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 20:18:45 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:12943 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S965045AbVHPASp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 20:18:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050816001843.JZXW7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 Aug 2005 20:18:43 -0400
To: Carl Baldwin <cnb@fc.hp.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Carl Baldwin <cnb@fc.hp.com> writes:

> Somewhere in the thread something was mentioned about maintaining
> <local branch>:<remote branch> pairs in the git repository when pushes
> and pulls are performed.  I think the argument was actually against
> keeping this information and ultimately against allowing pushes to a
> branch of a different name.

If you are referring to what I said about the user having some
control over both ends hence it should be possible to arrange to
use the same name on both ends to reduce mental burden, Pasky
and others convinced me otherwise during later discussions, and
the current core knows how to do renaming pushes.

One proposal which has not been pursued yet, due to lack of time
on my end if anything else, is to have a set of files that is an
extension of current $GIT_DIR/branches/* file (which can record
the URL and optionally one filename under refs/heads/ over there
to mean "which branch to pull from by default").  Instead, the
proposal introduces $GIT_DIR/remotes/* files, whose contents
would look like this:

    $ cat .git/remotes/ko
    URL: master.kernel.org:/pub/scm/git/git.git/
    Push: master pu rc
    Pull: master:ko-master pu:ko-pu rc:ko-rc

The expected workflow with the above example "remotes" file is
for me to be able to do this:

 (1) fetch from master.kernel.org (that is the source of the
     mirroring for everybody to see on {www,rsync}.kernel.org)
     before starting my day.  The current "git fetch" does not
     do this, but make it:

     $ git fetch ko

     to mean "fetch from those three branches on the 'Pull:'
     line, fast-forward local ko-master, ko-pu and ko-rc with
     these heads".

     Then I can see where my private heads and publicly visibile
     ones stand to make sure things are in good order.  E.g. I
     can do "git show-branches ko ko-master rc rc-master".

 (2) after doing work in my private repository, push to
     master.kernel.org with:

     $ git push ko

     This does not happen to involve renaming push, because both
     ends are owned and controlled by me, but you could put
     renaming refspec on "Push:" line in the .git/remotes line
     to make it rename.

Note that I am _not_ expecting for "git push/pull/fetch"
commands to dynamically update .git/remotes/ file whenever it
gets a new set of heads and renaming refspecs on the command
line.  Explicit refspecs on the command line will just override
what is recorded in .git/remotes/* files instead.  So:

     $ git push ko pu:refs/heads/testing

would not push usual "master pu rc" but create a new "testing"
branch there, starting at the commit which is the head commit of
the local "pu" branch.  This is a one-shot override, so next
time around, "git push ko" will do the usual three heads that is
recorded in the .git/remotes/ko file.
