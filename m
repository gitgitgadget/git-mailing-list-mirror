From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: Subprojects
Date: Mon, 16 Jan 2006 12:49:48 -0800
Message-ID: <7vek37rj83.fsf@assigned-by-dhcp.cox.net>
References: <43C52B1F.8020706@hogyros.de>
	<Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
	<7vek3ah8f9.fsf@assigned-by-dhcp.cox.net>
	<200601161144.48245.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 21:49:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EybIY-0005ZK-TB
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 21:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWAPUtv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 15:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWAPUtv
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 15:49:51 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:8102 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750722AbWAPUtu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 15:49:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060116204838.TJZW6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 Jan 2006 15:48:38 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14760>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> The suggested "bind" info in commit objects has the same problem
> as the original overlay: if the superproject already has a
> subdirectory kernel/, and there is an additional "bind" specification
> in commits also for kernel/, what should be done?
>
> So the gitlink object seems to be the only solution if we want to
> bind git versions of subprojects into a superproject.

In "pu", I have some of the necessary basic pieces for "bind"
approach, barely enough so that anybody interested could start
prototyping using them as building blocks.  It still has very
rough edges; the missing includes rev-list and fsck-objects, so
you cannot do a send-pack or fetch-pack yet.

Yesterday I was working on "gitlink" approach to have similar
core-side support for prototyping.  I haven't finished it into a
buildable state yet (it is not in "pu"), and I am pessimistic if
I ever will X-<.

I think the updated "bind" thing makes the two approaches
semantically equivalent (i.e. it does not allow an arbitrary
overlayed setup anymore).  We simply do not allow the
conflicting "bind".  So neither is the _only_ solution.  We
probably could make both to work, but the details differ.

 * With "gitlink", the index of containing project never has
   subprojects parts of the tree, which I see it as an advantage
   compared to what "bind" does.  It only has one "gitlink"
   entry per each subproject.  update-index, read-tree,
   ls-files, diff-*, etc. needs to be aware of "gitlink" object.
   Especially tricky is read-tree.  It needs to treat a
   "gitlink" object as a directory for D/F conflict detection
   purposes, but treat it similar to blobs in most other aspects
   (e.g.  results in one entry in the index).  The stat
   information update-index and diff-files uses for quick
   up-to-date check needs to be taught not to worry about the
   stat information of the subdirectory a "gitlink" object
   points at (e.g. if you do a whole-tree build, the timestamp
   of the directory would change, but that does not mean the
   subtree is dirty).  tree/directory traversal code needs to be
   aware of "gitlink" and stop there.  This approach involves
   quite a lot of code changes, mostly because what is in the
   current index never correspond to a directory on the
   filesystem but "gitlink" quacks like a directory.

 * With "bind", the index of containing project keeps the entire
   tree structure, including subproject part.  In fact, there is
   no other separate index for the subproject part.

   An updated write-tree in "pu" can write a tree for only the
   subproject part with "write-tree --prefix=<path>/" from such
   an index file, and read-tree can read with "read-tree
   --prefix=<path>/" to graft a subproject tree on top of the
   current index contents.  Without the --prefix, write-tree
   writes out the whole thing for a commit for the containing
   project, so if somebody cloned that superproject, getting the
   whole tree out in order to "make" is just the matter of doing
   a regular "read-tree && checkout-index".

   We could introduce "bind the rest" to make write-tree write
   out a tree that contains only the containing project part and
   not any of the subproject part (e.g. Makefile, README and
   src/ but not linux-2.6/ nor gcc-4.0/ in the earlier example).
   Essentially the contents of such a tree object would be the
   same as what "gitlink" approach would have had for the
   containing project in the index file, minus "gitlink" entries
   themselves).  This is not so surprising, because the missing
   information "gitlink" approach recorded in the tree object
   itself is expressed on "bind" lines in the commit object with
   this approach.

An advantage with the "bind" approach, from the implementation
point of view, is that none of the "index vs working tree" part
of the core needs to be modified (you would notice that many
issues I had with trying "gitlink" I listed above are "index vs
working tree" issues).  "tree object vs index" part needed to be
enhanced somewhat (e.g. the re-rooting read-tree/write-tree with
the --prefix option) but it was not too painful.
