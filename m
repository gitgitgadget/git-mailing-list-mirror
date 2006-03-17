From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-cvsimport "you may need to merge manually"
Date: Thu, 16 Mar 2006 19:23:37 -0800
Message-ID: <7vk6at7o06.fsf@assigned-by-dhcp.cox.net>
References: <86veud23v0.fsf@blue.stonehenge.com>
	<7vu09x7puo.fsf@assigned-by-dhcp.cox.net>
	<86r75122yj.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Fri Mar 17 04:23:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FK5Z1-0001z5-Qj
	for gcvg-git@gmane.org; Fri, 17 Mar 2006 04:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbWCQDXk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 22:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbWCQDXk
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 22:23:40 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:59821 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964922AbWCQDXj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 22:23:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060317032138.CZTA20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 16 Mar 2006 22:21:38 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86r75122yj.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "16 Mar 2006 18:57:08 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17655>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> Junio> I do not use cvsimport but I wonder what Commit ID 985ca7
> Junio> contains.  Can you try "git show 985ca7" and see if that is the
> Junio> commit you want?
>
> To bring the tree clean, I issued "git commit -a -m 'cvs sync'", and
> "git-whatchanged -p" shows the most recent commit with the diff actually
> *backed out* the most recent change in CVS, and the next change down was
> actually the good one.  Weird.  Do I need to start all over again?

So the commit ID reported before the command says Done. was
actually what you wanted, but that latest tree was not checked
out cvsimport, so "git status" reported "you have these changes"
(it should have said "you have these backed-out", but there is
no way for it to know), and obviously your commit on top of that
is to back it out.

I just tried it on a copy of my day-job CVS repository.  Indeed
what it does seem quite strange.

    ...
    skip patchset 1019: 1142562992 before 1142562992
    skip patchset 1020: 1142563093 before 1142563093
    Fetching Makefile   v 1.10
    Update Makefile: 871 bytes
    Tree ID 4c51717e01fb08b6d15bc6e35d48142d2d5b94e7
    Parent ID 98d49aa57b93552cea82ce20c880bad4bcc5ebfc
    Committed patch 1021 (master 2006-03-17 03:04:31)
    Commit ID ad6c4fb908df7057d5564bf22cf9e0f9f3e743f2
    DONE


It updated the 'master' branch head, it reported the tip commit
ID before saying DONE, and that commit ID is stored in
refs/heads/master.  However, it does not seem to touch index nor
working tree files (I did not get "you may need to do merge"
message, by the way).

Since I know I was just trying things out, I do not care what is
in my index nor in the working tree files, so I could at this
point say:

	$ git reset --hard

to sync the master tree, but in general you may be running
cvsimport into a dirty tree, in which case you are screwed.

I think reverting this commit would help, but I do not remember
offhand what the breakage this patch was trying to fix.

    commit a541211ef4136eb7464c4466d20b60b8580efc44
    Author: Matthias Urlichs <smurf@smurf.noris.de>
    Date:   Tue Mar 7 10:08:34 2006 +0100

        cvsimport: Remove master-updating code

        The code which tried to update the master branch was somewhat broken.
        => People should do that manually, with "git merge".

        Signed-off-by: Matthias Urlichs <smurf@smurf.noris.de>
        Signed-off-by: Junio C Hamano <junkio@cox.net>

... Ugh, and after I wrote all of the above, the version of git
I have at work predates that commit X-<.  So maybe this was
fixed with that commit, and you are expected to say:

	$ git pull . origin

assuming that you are on "master" branch and cvsimoprt tracks
CVS head with "origin" branch, that is.

Smurf, help?
