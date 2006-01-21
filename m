From: Junio C Hamano <junkio@cox.net>
Subject: [RFC] Reverting "git push logic change"?
Date: Fri, 20 Jan 2006 23:46:23 -0800
Message-ID: <7vfynivx9s.fsf_-_@assigned-by-dhcp.cox.net>
References: <20060120225336.GA29206@kroah.com>
	<7vlkxa30rd.fsf@assigned-by-dhcp.cox.net>
	<20060121001547.GA30712@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Sat Jan 21 08:46:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0DSA-0002Pq-NR
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 08:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWAUHq0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 02:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWAUHq0
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 02:46:26 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:39918 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751106AbWAUHqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 02:46:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060121074424.TVVT17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 Jan 2006 02:44:24 -0500
To: git@vger.kernel.org
In-Reply-To: <20060121001547.GA30712@kroah.com> (Greg KH's message of "Fri, 20
	Jan 2006 16:15:47 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14985>

The change introduced by 9e9b267 commit broke "correct" usage of
git push to push matching refs, to work around a problem
observed in a usage pattern on a shared repository.

I think I made a bad judgement in evaluating the scenario, and
made a bad change to "fix" a problem that did not exist.  I
apologize for having caused this confusion.

My conclusion after thinking about the problem again is that we
would be better of if we reverted that commit.  This message is
to make my intention clear, and solicit objections or comments
from the list.

The use case that prompted this change was this:

 - A shared repository is created by cloning Linus repository.
   This repository gets "origin" (then-current Linus master) and
   "master" (the same).

	$ git clone --naked \
          git://git.kernel.org/.../linux-2.6.git/ project.git

 - Two developers use this as their shared repository.  They
   first start out by cloning from it, do their development in
   their "master" branch and pushing back to the "master" branch
   of the shared repository.  Their workflow is:

	0. Clone it (once per developer):
        $ git clone ssh://pub.example.com/project.git/ work

	1. To make sure the developers are in sync:
	$ git pull ssh://pub.example.com/project.git/ ;# (a) or
	$ git pull origin			      ;# (b)

        2. His own development:
	$ edit;compile;test;git commit

	3. Pull from upstream, to avoid conflicts with it (only when needed):
	$ git pull git://git.kernel.org/.../linux-2.6.git/

	4. Push back the result to shared repository:
        $ git push ssh://pub.example.com/project.git/

With this workflow, in the two developer repositories, "origin"
branch is not really well maintained.  If "git pull origin" was
used with the remotes/origin file "git clone" initially gave
him, it would have kept track of the latest push into the shared
"master" closely, but if the explicit URL was used, "origin" of
the developer repository would have been left behind.

This is not problem as far as the correctness of the "master"
branch is concerned.  The fast-forward check when pushing into
the shared repository "master" branch prevents the two
developers from losing commits.  In other words, either way to
pull from the shared repository is legal/valid.

However, the push done in step 4. triggers the default "push all
matching refs" behaviour.  All three repositories have "origin"
and "master", which means this results in "origin" being updated
in the shared repository.  But one developer repository has a
stale "origin" while the other developer has an up-to-date
"origin".  This triggers a "not a fast forward" error, which
does not cause the push of "master" to fail, but still looks
worrisome.

I think the correct thing to do in this workflow is to simply
remove "origin" branch from the shared repository.  

Using or not using "origin" as a reference branch to keep track
of what was fetched from the shared repository is a matter of
personal taste for each developer, and there is no reason to
enforce either (1-a) or (1-b).  This means that the branch is
not maintained the same way in developer repositories, and there
is no point pushing into it --- there is no point to have
"origin" in the shared repository.

Once "origin" branch is removed from that shared repository,
then, either "push all matching refs", or "push 'master'
explicitly" would work well for these developers.
