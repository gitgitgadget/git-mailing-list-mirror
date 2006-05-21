From: Junio C Hamano <junkio@cox.net>
Subject: Re: synchronizing incremental git changes to cvs
Date: Sun, 21 May 2006 11:21:58 -0700
Message-ID: <7v3bf3jl15.fsf@assigned-by-dhcp.cox.net>
References: <87mzdcjqey.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 21 20:22:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhsZ9-0007r6-6X
	for gcvg-git@gmane.org; Sun, 21 May 2006 20:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWEUSWB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 14:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWEUSWB
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 14:22:01 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:11683 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932403AbWEUSWA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 14:22:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060521182159.HABA27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 21 May 2006 14:21:59 -0400
To: Jim Meyering <jim@meyering.net>
In-Reply-To: <87mzdcjqey.fsf@rho.meyering.net> (Jim Meyering's message of
	"Sun, 21 May 2006 00:13:25 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20456>

Jim Meyering <jim@meyering.net> writes:

> I'd like to develop using git, and have a commit hook mirror the
> day-to-day changes (tags/commits) made in the git repo to a
> cvs repository.  The idea is that the only way changes get into
> the cvs repo is via the git commit hook.

I do not use the automated tools myself, but I sync the day-job
work in my git repository to CVS at work.  I do not develop with
CVS but use it merely as a publishing medium.  Although other
people can make commits into CVS in which case I have to slurp
the change back into my git repository.

 (0) Bootstrap.  I did use git-cvsimport myself (this repository
     started before the tool was written).  Instead:

     . cvs checkout the tip of the CVS development history

     . "git init-db", edit .gitignore to ignore CVS, and "git
       add ."

     . "git commit -m epoch"; the git side of development
       history in this repository starts at that point for me. 

     . "git branch origin"; the tip of CVS repository is kept
       track of with this branch.  I work in "master".

     I think I could have done the above with git-cvsimport,

 (1) Beginning of the day.  In case other people did work on
     the CVS side, I do this:

     . "git checkout origin", "cvs -q update".  If there is no
       change, go to step (3).

     . add any new files with "git add", and update the "origin"
       branch with "git commit -a -m 'from CVS'".

 (2) Merge other's work into my git master branch.

     . "git checkout master" and "git pull . cvs"; conflict
       resolve as needed.

 (3) Do my work.

     . "git checkout master" if I haven't done so.     

     . hack away, grow "master" branch using full power of git
       including the use of topic branches etc.

 (4) Publish, when "master" changes are ready.

     . To avoid conflicts with other people working on CVS,
       perform (1) again to make sure "origin" matches the tip
       of CVS.

     . "git checkout origin", "git pull . master".

     . generate the consolidated log I am about to push back to
       CVS with "git log --no-merges ORIG_HEAD.. | git shortlog >L".

     . add any new files with "cvs add", and "cvs commit -F L"

     . go back to (3) and continue.

This can be extended to multiple CVS branches.  Per one CVS
branch, use one git branch to track its head (plays the role of
"origin" in the above), use another to do the real development
for that branch ("master" in the above).  Never use merges on
the CVS side, but perform merges on the git side and then
pushing the merge result back to CVS.  This frees you from the
nightmarish branch management.

The above obviously have advantages and disadvantages.

 . I do not use any git import tool, so in theory you can apply
   this to _any_ foreign SCM.

 . I treat the foreign SCM as a second class citizen; multiple
   commits made there are rolled into a single commit on the git
   side (the real project history as far as I am concerned),
   which may or may not be nice.  The people who see my work
   through CVS see multiple commits on git side as a single
   commit in CVS.

In my situation this is fine as is, but I think you could leave
the management of "origin" to git-cvsimport (then your working
tree would not have CVS metadirectories as the above outline
does) if you wanted to avoid the "rolled into one commit" issue.

Pushing the changes on the git side back to CVS may become
trickier (and that is why I still keep the above setup without
using git-cvsimport), as I do not offhand know how exportcommit
works.  The commits on the git side you would want to push back
are the ones on "master" but not on "origin", which you can get
from "git rev-list origin..master", so I presume if you feed
that to exportcommit things all magically work?

By the way, I met Paul a few days ago and he mentioned that you
have some quick audit results on our code from your evaluation.
Can we expect fixes or at least pointing-out-problems from you
sometime soon please?
