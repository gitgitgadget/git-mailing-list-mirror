From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 0.99.9g
Date: Thu, 10 Nov 2005 00:14:29 -0800
Message-ID: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 09:16:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea7Zs-0005m1-1k
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 09:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVKJIOc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 03:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVKJIOc
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 03:14:32 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:35572 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751180AbVKJIOb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 03:14:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051110081405.KHWQ4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Nov 2005 03:14:05 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11468>

GIT 0.99.9g is found at usual places.  There are a couple of
important changes, as the slow march towards 1.0 continues.

 - The RPM package has been split into a few packages by Jim
   Radford.  Unfortunately I am not equipped sufficiently to
   test the resulting RPMs, so please feed me updates and
   corrections as needed.  I think archimport part needs to be
   split out just like its svn/cvs cousins, and perhaps
   documentation into another separate package.

 - Fredrik Kuivinen's merge-recursive strategy is now the
   default merge strategy for two-head merge that happens after
   git-pull.  I do not expect this to cause major disruptions,
   but if this breaks things there is a workaround to override
   this [*1*].

Although I did not hear anybody jumping up-and-down to merge
svnimport updates from Yaacov Akiba Slama, I did not hear it
broke things either, so it graduated to the master branch and
included in this release.  It obviously improved things for
Yaacov, and I am hoping this would not cause disruptions for
people's existing setup.

Also included are unexciting bits of fixes here and there.

On the "proposed updates" front, things finally seem to be
calming down.

 - One important newcomer is git-pack-redundant.  It is still in
   "pu" not because I doubt what it does is useful, but simply
   because I have not had a chance to study how it does its
   thing.  I expect to fully merge it into "master" before 1.0
   happens.

 - Among my own toys in the "pu" branch:

   - Determination of merge base for Octopus merge was quite
     pessimistic, and a proposed fix is in there; since I will
     be regularly and frequently doing Octopus merges, I'll soon
     know if this change breaks things; otherwise it will
     graduate to "master" shortly.

   - merge-base computation done by show-branch was a bit loose
     compared to the real merge-base, as pointed out by Linus on
     the list, although it does not seem to matter too much in
     practice.  Also I plan to look into merge-base to see if I
     can fix the horizon effect cheaply but that work has not
     started yet (it is triggered by fairly pathological case).

   - I got tired of not being able to get the committer date
     (except the raw format which is unreadable) out of git-log,
     and added --pretty=fuller format.  This should not break
     people's existing setup, so I expect it to move to "master"
     soon, maybe with a name change if somebody can suggest a
     better name for it.

   - Change merge-one-file to handle the case where two sides
     add the same path differently.  Instead of punting, try to
     do two-file merge from both sides.  This _might_ turn out
     to be useful, but I do not know yet, so it won't graduate
     to "master" unless somebody convinces me (and the
     community) that it is useful in some use-case scenario.

   - Add git-lost+found.  Currently the implementation stores
     found refs under .git/lost+found/{commit,other}
     directories, but writing out their object names to the
     standard output and let the users decide what to do with
     them was suggested on the list by Daniel, which makes sense
     as well.  There are pros and cons so until we know if it is
     useful and if so in what form, it will not come out of "pu"
     branch.

   - I do not consider either git-shallow-pack and git-changes
     "master" material.  The former is a hack to create
     deliberately broken repository.  The latter is supporting a
     wrong workflow, as Linus described the other day.  You can
     temporarily fetch what you want to compare into local
     repository and run git-log or git-whatchanged normally.

Oh, and we will not be moving things out of /usr/bin/ during 1.0
timeframe.


[Footnote]

*1* If for whatever reason you would prefer to keep using the
'resolve' strategy as before when you run 'git-pull', you can
either do 'git-pull -s resolve <remote> <refspec>...' on the
command line, or add the following in your .git/config file:

        [pull]
                twohead = resolve

On the other hand, if you like to try resolve and then
recursive, you can have this instead (the order does matter, the
first one is tried first):

        [pull]
                twohead = resolve
                twohead = recursive
