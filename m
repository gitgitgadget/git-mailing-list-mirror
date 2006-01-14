From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git
Date: Fri, 13 Jan 2006 19:45:05 -0800
Message-ID: <7vvewnwjzy.fsf@assigned-by-dhcp.cox.net>
References: <7vhd8al3ae.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jan 14 04:45:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExcM0-0005kW-Cx
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 04:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945987AbWANDpJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 22:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945992AbWANDpJ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 22:45:09 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:50420 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1945987AbWANDpH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 22:45:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060114034312.TWVT17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 Jan 2006 22:43:12 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14660>

Junio C Hamano <junkio@cox.net> writes:

>  - Exec git programs without using PATH (Michal Ostrowski).
>
>    This has been discussed for the last couple of days on the
>    list.  I think C side is ready to go in, but I'd like to
>    decide what to do on the scripting side before merging it
>    into the master branch.

I've done a minor fix in the Makefile (things were installed in
the wrong way around --- $bindir should hold git and gitk and
$gitexecdir should hold the rest), and ran a brief test after
installing things with gitexecdir set to /usr/lib/git-core/x.
gitk needs to be taught to use git --exec-path upfront to set
its own PATH, but other than that, everything looks peachy.

About prepending to/appending to/not touching PATH, my current
thinking is that prepending is the way to go.  The best
rationale so far I have heard against mucking with PATH was
"/home/mo/bin/diff vs /usr/bin/diff" issue, but I do not find
this to be so convincing in practice.  This "use my diff not
system diff" is done most often when system diff is not GNU
enough, but on such a machine git will not be installed under
/usr/bin anyway (after all git prefers GNU diff).

And this becomes truly a non-issue when you point $gitexecdir at
a separate location that holds *only* git stuff.  Everybody will
find the matching version of git that way, and when looking for
"diff", it will be found from one of the directories in the rest
of the PATH, not from $gitexecdir.

So unless there is an objection, this will graduate into the
"master" branch over the weekend.

What happens if gitexecdir != bindir?

As long as the user invokes "git foo" from the command line, not
"git-foo", everything should work fine, and once gitk is
updated, binary distributions could ship git with only git and
gitk in /usr/bin and others in /usr/lib/git-core/tools, or
something like that.

I will _not_ change the default gitexecdir in my Makefile nor
change the spec file, so RPM binary from kernel.org will still
have everything in /usr/bin for now.

Somebody needs to audit how ready popular Porcelains are, for at
least Cogito, stgit, gitweb and qgit and feed patches to
respective authors as necessary.  I haven't looked into any of
them about this issue.  The rules are:

    (1) you can assume "git" is available on PATH;

    (2) you should be safe if you do not use "git-foo" form;

    (3) you can run

        PATH="$(git --exec-path):$PATH"; export PATH

        once at the beginning of your program and use "git-foo"
        form.

Volunteers?
