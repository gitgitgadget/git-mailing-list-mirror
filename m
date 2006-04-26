From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links
Date: Wed, 26 Apr 2006 00:50:01 -0700
Message-ID: <7virowrd1y.fsf@assigned-by-dhcp.cox.net>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
	<7vwtde2q1z.fsf@assigned-by-dhcp.cox.net>
	<444EAE7C.5010402@vilain.net> <e2mv30$k08$1@sea.gmane.org>
	<e2n01t$m8j$1@sea.gmane.org>
	<7vzmi8sxt1.fsf_-_@assigned-by-dhcp.cox.net>
	<e2n4am$1vn$1@sea.gmane.org>
	<7vlktssudl.fsf_-_@assigned-by-dhcp.cox.net>
	<e2n72h$aqe$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 26 09:50:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYemy-0002nS-Ty
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 09:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWDZHuK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 03:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWDZHuK
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 03:50:10 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:25333 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751137AbWDZHuI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Apr 2006 03:50:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060426075007.HYSD21197.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Apr 2006 03:50:07 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e2n72h$aqe$1@sea.gmane.org> (Jakub Narebski's message of "Wed,
	26 Apr 2006 09:22:23 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19191>

Jakub Narebski <jnareb@gmail.com> writes:

> Do I understand correctly that toplevel (master project) commits have tree
> which points to combined tree, and "bind" links which points to the
> subprojects commits whose trees make up the overall tree, or does the
> master tree points to tree containing only toplevel files (overall Makefile
> for example, INSTALL or README for the whole project including
> subprojects,...)?

The plan for "bind commit" was to have the toplevel commit to
contain:

	tree -- this covers the whole tree including subprojects
        parent -- list of parents in the toplevel project
        bind -- commit object name of subproject, plus which
	        directory to graft its tree onto.

And a subproject commit, unless it contains subsubproject, would
look like just an ordinary commit.  Its tree would match the
entry in the tree the toplevel commit at the path in "bind" line
of the top-level commit.

Some reading material, from newer to older:

  * http://www.kernel.org/git/?p=git/git.git;a=blob;hb=todo;f=Subpro.txt

  This talks about the overall "vision" on how the user-level
  interaction might look like, with a sketch on how the core-level
  would help Porcelain to implement that interaction.  Most of the
  core-level support described there is in the "bind commit"
  changes, except "update-index --bind/-unbind" to record the
  information on bound subprojects in the index file.

  * http://thread.gmane.org/gmane.comp.version-control.git/15072

  This was the thread that led to the above proposal.

  * http://thread.gmane.org/gmane.comp.version-control.git/14486

  This is older.  It touches an alternative "gitlink" approach,
  which I meant to prototype but never got around to.

  Surprisingly, these two threads are mostly noise-free and
  literally every message is worth reading.

Some old but working core-side code is available at jc/bind
branch of public git.git repository.

> BTW. I have lately stumbled upon (somewhat Vault and Subversion biased)
>  http://software.ericsink.com/Beyond_CheckOut_and_CheckIn.html
> Read about Share and Pin -- it's about subprojects (when you edit out the
> flawed "branch as folder" approach of author).

Not really.  You can easily do that by checking out another
project in a separate subdirectory.

My private working area for git.git is structured like this:

	/home/junio/git.junio/.git
        		      Makefile
                              COPYING
                              Documentation/
                              ...
                              Meta/.git
                              Meta/TODO
                              Meta/Make
                              Meta/TO
                              Meta/WI
                              ...

Notice two .git directories?  That's right.  

The top-level .git repository has the familiar branches like
"maint", "master", "next", "pu", in addition to various topic
branches.

Meta/.git is a separate repository that is a clone of "todo"
branch of git.git repository.  The top-level .git repository
does not even have "todo" branch.  I just happen to push into
the same public repository git.git at kernel.org from these two
separate repositories.

The Meta/ repository is "pinned" to a specific version, without
having any funky "Pin feature", no thank you, because I have
full control of when I update what is checked out in the Meta/
directory.

What you _might_ want is a reverse of Pinning.  Sometimes, you
would want to make sure subproject part is at least this version
or later to build other parts of the whole.

But for my particular "Meta/" directory, I do not need such a
linkage.  The major reason I do not keep TODO in the main
project is because it is supposed to be a task list for me
across "maint", "master" and "next".  I do not want it to
fluctuate whenever I work on different branches.

-jc
