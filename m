From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: Subprojects
Date: Mon, 16 Jan 2006 22:18:47 -0800
Message-ID: <7vfynnfkc8.fsf@assigned-by-dhcp.cox.net>
References: <43C52B1F.8020706@hogyros.de>
	<Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
	<7vek3ah8f9.fsf@assigned-by-dhcp.cox.net>
	<200601161144.48245.Josef.Weidendorfer@gmx.de>
	<7vek37rj83.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601170001130.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 07:18:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EykBB-0001R4-VV
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 07:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWAQGSt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 01:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWAQGSt
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 01:18:49 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:12537 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751210AbWAQGSs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2006 01:18:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060117061605.YWQD20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 17 Jan 2006 01:16:05 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0601170001130.25300@iabervon.org> (Daniel
	Barkalow's message of "Tue, 17 Jan 2006 00:46:40 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14781>

Daniel Barkalow <barkalow@iabervon.org> writes:

> So why not use the "bind" approach for the "index vs working tree" part, 
> but write out "gitlink"-style tree objects?

I said "index vs working tree" as a mere example, and never said
"gitlink" is easier (or at least as easy as "bind") for "tree
object vs index" or "tree object vs working tree through index".
In fact I suspect those parts also need to be changed fairly
heavily, and to be honest, I am not very much looking forward to
investigating the details.

> In any case, I think it would be good to track where the subprojects are 
> in some core state, and probably the right solution is to have special 
> index entries for them, in addition to having their contents in the index. 

Actually, the "special entry" was what I found out to be quite a
pain, if you mean to have "linux-2.6/" in the index and have it
used in some meaningful way.  Further hacking and prototyping
_might_ convince me otherwise, but I am not so optimistic at
this moment.

> I'm not seeing a clear way to get from commit objects with "bind" lines to 
> an index with the appropriate things read and back otherwise.

Here again I am thinking aloud, remembering the earlier example
of an embedded linux project that ships with linux-2.6 and
gcc-4.0, along with its own README and Makefile at the toplevel
and src/ for its own sources.  The tools at the tip of "pu"
should be able to let you do the following:

	$ git cat-file commit $such_toplevel_commit
	tree $tree
        parent $parent
        bind $primarysub /
        bind $linuxsub linux-2.6/
        bind $gccsub gcc-4.0/
	author A U Thor <author@example.com> 1137392543 -0800
	commmitter A U Thor <author@example.com> 1137392543 -0800

        An example.

where $tree is the object name of the whole tree (no "gitlink"
object), $primarysub and $linuxsub are the object names of
commit objects for the primary subproject (which sits at the
rootlevel) and another subproject (which sits at linux-2.6/
subdirectory).

To make sure there is no misunderstanding:

	* "git-ls-tree $tree" would show the object name of
          $linuxsub^{tree} at path "linux-2.6/" because
          "tree" line of a commit describes the whole tree,
          including subprojects.

	* "git-ls-tree $primarysub" would show README,
          Makefile and src/ directories but not linux-2.6/ nor
          gcc-4.0/.

	* "git-ls-tree $linuxsub" would show COPYING, Makefile
          etc., not linux-2.6/COPYING.

Reading such a commit is easy:

	$ git-read-tree $tree ;# ;-)

But that is cheating.  Constructing such an index can be done by:

	$ git-read-tree $primarysub
        $ git-read-tree --prefix=linux-2.6/ $linuxsub
        $ git-read-tree --prefix=gcc-4.0/ $gccsub

When you have such an index, writing out various trees are:

	$ git-write-tree ;# $tree
	$ git-write-tree --prefix=linux-2.6/ ;# $linuxsub^{tree}
	$ git-write-tree --prefix=gcc-4.0/ ;# $gccsub^{tree}
	$ git-write-tree \
          --bound=linux-2.6/ --bound=gcc-4.0/ ;# $primarysub^{tree}

The decision to use what --prefix and --bound and what tree(s)
to write out must come from somewhere, and as you say it would
be nice if we _could_ stick them in the index as "special
entries", but for the purpose of prototyping I am assuming I
keep that somewhere in $GIT_DIR/ (the "mtab" in the previous
message.  Maybe "$GIT_DIR/bind" is a good name?).
