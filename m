From: Junio C Hamano <junkio@cox.net>
Subject: [3/4] What's not in 1.5.2 (new topics)
Date: Wed, 16 May 2007 15:47:15 -0700
Message-ID: <11793556371774-git-send-email-junkio@cox.net>
References: <11793556363795-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 00:47:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoSHY-0005dw-4P
	for gcvg-git@gmane.org; Thu, 17 May 2007 00:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757277AbXEPWrY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 18:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757467AbXEPWrY
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 18:47:24 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:46870 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757277AbXEPWrT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 18:47:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070516224718.JCAK2758.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Wed, 16 May 2007 18:47:18 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id zynG1W00a1kojtg0000300; Wed, 16 May 2007 18:47:17 -0400
X-Mailer: git-send-email 1.5.2.rc3.50.gfdcb7
In-Reply-To: <11793556363795-git-send-email-junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47470>

Here are random things that I'd like to see happen during 1.5.3
cycle.

 * git-clone should become a very thin wrapper around
   init/remote/fetch/checkout.

   - it may be necessary to teach git-remote about --bare
     layout.

   - by getting rid of 'fetch' logic from git-clone as much as
     possible, it would hopefully become easier to freeze what
     git-fetch needs to do and help rewriting the latter in C.

   - update native protocol with an extension to carry which
     branch HEAD (or any symref) points at, instead of guessing.
     We already know this information when clone is done over
     HTTP, but we are discarding that information in git-clone
     for the sake of implementation simplicity and having it
     also guess.

 * more superproject support in Porcelain-ish.

   - superproject support in Porcelain-ish is mostly about
     checking things out.  One possible scenario:

	$ git clone --recursive $url_of_superproject

     may instruct "clone that, and also clone any projects that
     the superproject uses, and check everything out".  I would
     imagine that lThis would be carried out in the following
     steps.

     (1) The usual "git-clone" dance, determining the directory
         name to create, running mkdir and init-db, setting up
         tracking refspec specification in the config, and
         running the initial fetch.

     (2) Because the command was not given '-n' ("do not
         checkout"), HEAD is checked out.  git-checkout notices
         that there are commits bound to some directories in its
         tree.

     (3) git-checkout finds there is .gitmodules file in the
         tree (and the checked-out working file), which
         describes these subprojects.  It looks at the config
         and notices that it does not yet know about them
         (obviously this is true, as this is the first checkout
         after clone, but I am trying to outline how checkout
         after a merge should work in the general case).

	 It determines where to fetch that subproject from,
	 perhaps it uses the default URL described in
	 .gitmodules file to, while asking the user for
	 confirmation and giving the user a chance to override
	 it.  And it records something in the config -- now that
	 project is known to this repository.

     (4) git-checkout then calls git-clone recursively in that
         subdirectory for the subproject (which may further
         contain subprojects of its own, but that would
         naturally work).

   - Another scenario, after "git clone" of the superproject
     _without_ the above "--recursive" behaviour.  There needs
     to be a way to later clone and checkout a named subproject
     (and that subproject alone).  Perhaps

	$ git checkout --populate-subproject subdir

     would notice that subdir corresponds to a subproject that
     is "not known" to this repository.

	 I am assuming .gitmodules from the upstream describes it,
	 but the default is not to recurse into any subproject,
	 which would leave the subdir _without_ its own .git
	 directory.  A subproject becomes "known" to your repository
	 when you tell git that you care about it (e.g. "clone
	 --recursive" above), and that decision would be recorded
	 somewhere in .git/config of the superproject.  .gitmodules
	 would give the default URL and probably the branch to
	 follow.  The URL definitely needs to be overridable by
	 per-repository configuration as network reachability would
	 be different for everybody; I am not sure about the need to
	 make it overridable which branch the subproject should
	 follow, but my gut feeling is that we do not have to.

     Then it does the same as (3) and (4) in "clone --reference"
     above (in fact, I am envisioning that that scenario would
     call "git checkout --populate-subproject" in those steps).

   - We might want to have a way to tell it to stop tracking an
     already "known" subproject, which means that the section in
     .git/config that would track the status of the subproject
     (e.g. "is it known", "what's the URL", etc.) needs another
     variable that says "are we still interested in it?".

   - There may be obvious "frills" we would want to eventually
     have, such as defaulting the repository to find the
     subproject that corresponds to subdir/ to $URL/subdir (iow
     if http://repo.or.cz/cgit.git binds git.git at its src/
     directory, we would expect that the repository to house
     that subproject is found at http://repo.or/cz/cgit.git/src
     by default), but during the first round, I think it is
     better to leave things explicit.  So, for the above
     example, instead of defaulting the $URL/$subdir location,
     always require .gitmodules to say where to fetch the
     subproject from.

   - "git diff", "git status" and friends might want to learn
     recursive behaviour.  These should be much easier than any
     of the above.

   Note: I am not trying to dictate the overall superproject
   Porcelain design should follow the above literally, but just
   throwing out a strawman.  As I do not expect to be a heavy
   user of superproject support myself yet, other people who
   have thought about the problem longer (much longer) than I
   have will certainly have better ideas.


 * Perhaps add 'tree' entries in the index.  This may make the
   current cache-tree extension unnecessary, and I suspect it
   will simplify various paths that deal with D/F conflicts in
   the current codebase.

   I suspect this might need 1.6, as it is a one-way backward
   incompatible change for the 'index', but 'index' is local so
   it might not be such a big deal.  In the worst case, when the
   users find "git checkout" from 1.5.2 does not work in a
   repository checked out with such an updated index format, we
   could ask them to "rm -f .git/index && git checkout HEAD".

 * make merge-recursive and read-tree -u more robust when D/F
   conflict is involved.

   I think that the use of current_{file,directory}_set is
   misguided and it should just ask the index if there are
   conflicts.  unpack-trees.c::check_updates() logic probably is
   the right place to deal with what to do with the working tree
   when the merge result contains D/F conflicts (i.e.
   merge-recursive wants to create file~branchname instead of
   not touching the working tree).
