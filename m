From: Tommy Wang <subscription@august8.net>
Subject: Git & Project Workflow
Date: Thu, 5 Nov 2009 18:19:31 -0600
Message-ID: <ae09c2a40911051619s36c9a781pdb403fb9140affdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 06 01:19:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6CYM-00057G-MW
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 01:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759118AbZKFAT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 19:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759106AbZKFAT2
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 19:19:28 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:63120 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758716AbZKFAT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 19:19:27 -0500
Received: by bwz27 with SMTP id 27so629419bwz.21
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 16:19:31 -0800 (PST)
Received: by 10.239.168.144 with SMTP id k16mr372721hbe.103.1257466771370; 
	Thu, 05 Nov 2009 16:19:31 -0800 (PST)
X-Google-Sender-Auth: 4c3f9f8ba791103d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132258>

Hi,

I'm trying to set up a project using git, and I'm having a hard time
figuring out the best way to implement one of my workflows.

Lets say I have a repository "main".  Some of my developers will have
full access to this repository, while others should have access only
to certain parts of it (and, no, unfortunately the files are scattered
all over the place, and reorganizing isn't an option, so I can't use
subtrees).

I've attempted to solve this project by cloning the project into
another repository "limited".  Now, half of my developers can work off
from "main", while the other half can work from "limited".
Incidentally, its okay that the original source is visible in limited,
I just don't want the work we put into "main" to show up in "limited".

So, lets say my "main" developer makes some changes to the project.
Some of his changes are to kept in "main" only, while other changes
need to be pushed into "limited".  I can maybe force developers to
keep changes in common files in separate commits, and just cherry pick
them into "limited".  "Limited" developers can then pull those changes
into his local repository, resolve conflicts, (rebase), and push them
back into "limited".  At some point later in time, lets suppose we
need to push changes made in limited back to main.  So, our main
developers will cherry pick again the newest changes into limited (to
keep the conflicts down).  Limited developers will then
commit/resolve/rebase their work into limited, and let the main
developers know that they're ready.  The main developers will now pull
from limited -- and since we (likely) haven't changed main, the pull
should be pretty conflict free (git does keep track of cherry-commits
in merges, right?).

My question is, is cherry-picking really the best way to do this?
What I'd really like to do is to create the limited repository by
doing a filter-branch and removing secure files out of the repository
entirely.  After doing this, though, it makes it difficult/impossible
to move changes between the two repositories.  I tried a number of
approaches, including trying to graft the two repositories together
after the filter-branch to make push/pull work as simple
merges/fast-forwards.  I would have to figure out way to filter
commits to make sure that main doesn't push a secure file into
limited, and that limited doesn't try to do something silly like
creating a secure file.  Perhaps I could use filter-branch to rewrite
these commits as well.  But, being that filter-branch totally changes
the commit ids, I figure that this approach really doesn't have any
merit.

I also considered doing something like this:

# create main & limited from upstream source
git clone upstream main
git clone main limited

# remove secure files from limited
cd limited
git rm -r secure files
git commit

# fake a merge to keep histories correct
cd main
git pull -s ours limited

# pulling from limited worked well, and would only get changes made after the rm
cd main
git pull limited master

# pull from main didn't work so well --> but I probably should be
cherry-picking here anyway?
cd limited
git pull main master

I'm not sure why I'm trying so hard to avoid cherry-picking.  Probably
due to the fact that developers need to be more intimate with git, and
that it takes considerably more time to look through a list of
commits, and pick out the ones that can be moved from main -> limited.

Is there a way to generate a list of commits based on a list of files
(paths aren't good enough, since my files are scattered all over the
place) that can be found in main but not limited?  Perhaps I can write
a script that can be used to automate the cherry-picking from main ->
limited.  If we run this script right after we resolve all the
conflicts from a limited -> main merge, we should be able to avoid all
conflicts.

Anyway, I'm hoping for some thoughts/direction on how I may be able to
solve my problem.  Perhaps there is a magical solution that is plainly
obvious to someone with more git experience?

Thanks,
Tommy
