From: Sebastian Andres Mancilla Matta <smancill@alumnos.inf.utfsm.cl>
Subject: Integration-Manager Workflow and merges
Date: Fri, 30 Apr 2010 20:02:41 -0400
Message-ID: <4BDB6FA1.4070802@alumnos.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 01 02:30:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O80ba-0000GV-2I
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 02:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758089Ab0EAAam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 20:30:42 -0400
Received: from alegre.inf.utfsm.cl ([204.87.169.3]:51914 "EHLO
	alegre.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866Ab0EAAal (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 20:30:41 -0400
X-Greylist: delayed 1674 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Apr 2010 20:30:40 EDT
Received: from [10.9.14.251] ([10.9.14.251])
	(authenticated bits=0)
	by alegre.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id o4102jER021144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 30 Apr 2010 20:02:45 -0400
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
X-Spam-Status: No, score=-100.8 required=5.0 tests=ALL_TRUSTED,AWL,
	USER_IN_WHITELIST autolearn=ham version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on alegre.inf.utfsm.cl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146070>

Hello.

I am working with the Physics Department of my university, and I
convinced them to use Git for our project of particle analysis (all the
physicists work whit CVS or things like that, so I am very glad they
liked Git and accepted it).

So, I am in charge of defining the workflow we are going to use (we are
a team of 6 to 10 developers). We will use two branches, the 'master'
branch has stable code, and all the work is done in the 'devel' branch.

I want to use the Integration-Manager workflow, but I have some issues
about it. Suppose we have a blessed repository with the following state
for the 'devel' branch

         BLESSED (public)

         1--2--3     devel

and some developer (Dev1) has a clone of it, and his 'devel' branch and
the 'blessed/devel' branch point to the same commit

         DEVELOPER (private)

         1--2--3     devel

This developer does some work and obtains

         DEVELOPER (private)

         1---2---3             blesed/devel
                  \
                   4---5---6   devel

but in the meantime, other developer works on his own, and pushes their
changes to his public repository, and the maintainer accepts them and
pushes them to the blessed repository:

         BLESSED (public)

         1---2---3---7---8      devel

Now Dev1 pushes his changes to his public repository and sends a pull
request to the maintainer. To this point, everything is fine.

Later, Dev1 wants to continue his works, but he needs the changes made
by the other developer. So, he fetches the blessed repository

         DEVELOPER (private)

         1---2---3---7---8      blessed/devel
                  \
                   4---5---6    devel

but the maintainer has not accepted his changes yet, so blessed/devel's
tip does not include public devel's tip of Dev1. The developer decides
to merge 'blessed/devel', and work from that commit, and obtains

         DEVELOPER (private)

         1---2---3-------7---8                blessed/devel
                  \           \
                   \           9---10---11    devel
                    \         /
                     4---5---6                origin/devel

with the commit 9 being the merge commit. In the meantime, the
maintainer sees the pull request of Dev1, and pulls his changes and
accepts them, and updates the blessed repository

         BLESSED (public)

         1---2---3---7---8---12    devel
                  \         /
                   4---5---6

with the commit 12 being the maintainer merge commit.

And this is my problem. We have two differents commits (9 and 12) doing
the same thing. If Dev1 pushes his changes again, and sends a new pull
request, what will be the state of the repository? I think it
will look like this at the end

         1---2---3-----7----8--12-----------13   devel
                  \          \/            /
                   \         /\           /
                    4---5---6--9---10---11

but the history is a mess with those two merges doing the same. And this
is only with one developer doing a merge. If all the others do the same,
it will become a pain.


Can you help me with some guidelines to solve this? We do not want to
keep a linear history doing rebase every time. We just want to avoid
those duplicated merges. I have been looking for similar workflows but
there is no useful information, or at least I have not found it.


I think the solution is to forbid developers doing merges in the 'devel'
branch. Only the maintainer merges remotes branches. So the merge is
done in a temporal branch, and the work is done in a topic branch

         DEVELOPER (private)

         1---2---3-----7-----8                blessed/devel
                  \           \
                   4---5---6   \              devel
                            \   \
                             ----9            tmpMerge
                                  \
                                   10---11    topic

then, after the maintainer accepted the first pull request, Dev1 fetches
the blessed repository, obtaining the merge commit 12. Then he merges 
the branch 'blessed/devel' into his 'devel' branch (this is just a
fast-forward merge)

         DEVELOPER (private)

         1---2---3-----7----8--12             devel -  blessed/devel
                  \          \/
                   \         /\
                    4---5---6--9              tmpMerge
                                \
                                 10---11      topic

and finally he rebases the 'topic' branch onto 'devel'

         DEVELOPER (private)

         1---2---3---7---8---12               blessed/devel
                  \         /  \
                   4---5---6    20---21       devel

and pushes his work and sends a pull request to the maintainer. For
both, the maintainer and the developer, the repository looks like this
at the end (after the maintainer accepts Dev1's changes)

         1---2---3---7---8---12---20---21   devel
                  \         /
                   4---5---6

This way, there is no duplicated merges. Is this a good workflow? Can
anyone using a similar approach give me some comments?

Thanks.


-- 
Sebastian Mancilla Matta
Est. Ingenieria Civil Informatica UTFSM
Valparaiso - Chile
