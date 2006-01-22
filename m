From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Reverting "git push logic change"?
Date: Sun, 22 Jan 2006 12:31:28 -0800
Message-ID: <7vr770c8db.fsf@assigned-by-dhcp.cox.net>
References: <20060120225336.GA29206@kroah.com>
	<7vlkxa30rd.fsf@assigned-by-dhcp.cox.net>
	<20060121001547.GA30712@kroah.com>
	<7vfynivx9s.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601221311530.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Sun Jan 22 21:31:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0ls5-0001tN-OW
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 21:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWAVUbb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 15:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWAVUbb
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 15:31:31 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:63134 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751319AbWAVUba (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2006 15:31:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060122203031.FTXP15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 22 Jan 2006 15:30:31 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15060>

Daniel Barkalow <barkalow@iabervon.org> writes:

>  - Make the case of a pure rewind (i.e., pushing something that would be a 
>    fast-forward in the other direction) have no effect and give a more 
>    positive message like 'Remote "origin" is already ahead of your 
>    version.'

If the remote is not behind you, you would not be able to tell
if it is ahead of you or totally unrelated, unless you fetch
from them.  So I am afraid this is unpractical.

>  - Have a command to write, report, and modify remotes files, so Greg can 
>    tell it exactly what he actually wants without mucking around with the 
>    files by hand. Also generally nice.

For the record, it was somebody else.  Greg has the repositories
on both ends set up correctly, and does not suffer from this
"left behind origin" error message.  He has every right to
expect the "all the matching refs" semantics to keep working.

I think in this case, it was not the lack of tool to "tell it
exactly what he actually wants", but "what he actually wants"
was not quite well understood by the developers who experienced
this problem (again, not Greg).  This is a user error but that
is not their fault.  It means that we need to document this
better:

	A typical "cloned" repository has an "origin" branch to
	record the head commit of the upstream repository when
	the repository was cloned, and the branch is used to
	keep track of further development at the upstream.  But
	in a shared repository, it usually is not used for
	further development by your developers who clone from it
	and then push their changes back to it (for that they
	would use the "master" branch).  Your developers may
	occasionally need to sync with the upstream, but that is
	done by pulling from the upstream directly, and the
	"origin" branch at the shared repository is not
	involved.  In other words, that branch is useless and
	tends to be left behind.  If you are preparing a
	repository by first cloning from somewhere else, remove
	branches that your developers and people who download
	from your shared repository do not use, including
	"origin".

	"git push", without telling the tool which branches to
        push explicitly, pushes the branches that exist on both
        ends.  Culling unused branches, especially "origin",
        from the shared repository helps your developers because
        they do not have to do anything special to prevent their
        "origin" from being pushed back to the shared repository.

or something like that.

>  - Require --all in push, but, if none are given, produce a summary of 
>    what you could specify instead...

This is essentially what the "fix" did, except giving a summary.
The effect to the end user was that we were robbing "matching
refs" option from them.

>  - Maybe "git clone" should add "Push: master:master" by default if the 
>    URL permits pushing?

This might be a good thing to have.  I suspect majority of users
would benefit from this.

> I think that having it default to matching branches isn't really ideal, 
> since that seems to me to work for practically everybody only by 
> coincidence: master:master is by far the most common case; then 
> there are some people who use multiple branches, but they must have done 
> something other than the default to create this situation, anyway;

Actually I started to think matching is a very good default for
everyday use.

 - In the recommended "topic branches" workflow, a developer
   repository has more branches than his public repository he
   pushes into.  A typical public repository on kernel.org has
   either "master" alone, or "test" and "release" pair.  In
   either case, I expect the set of branches on these public
   repositories have "matching" ones in the owners' development
   repositories.  "matching" push lets them updated without
   pushing topic branch heads _unless_ the developer also wants
   to push topic branches to public, which reduces the clutter
   on the public repository.

 - In a shared repository setup, a developer still can employ
   topic branches workflow for himself.  The same "matching
   semantics prevents unneeded exposure of private topic
   branches" applies here.

 - In a non-default developer repository that has more than one,
   they must have done something other than the default.  For
   example:

	$ git branch test
        $ git branch release
        $ git push public:myrepo test release

   We _could_ require (or strongly suggest) them to keep a
   remotes/ shorthand for push destination and have:

	URL: public:myrepo
        Push: test
        Push: release

   so that next push would be "git push public".  Another
   possibility is that "git push public test release"
   (i.e. using a "remotes/public" shorthand) _could_ offer to
   update the remotes/ file when it sees these branches do not
   appear on Push: lines.

   But the "matching ones" push has the same effect.  It
   remembers which ones have been pushed out before, without
   mucking with remotes/ file, as long as the branch names are
   the same on the both ends (which I suspect is the most common
   usage).

   Also we need to remember there are people who push into more
   than one repositories, and they would need to keep and
   maintain separate remotes/ file per destination if there is
   no "matching ones" option.

If we add "Push: master" upon clone from host:repo (or local),
then these new repositories would push master into master and
nothing else with "git push origin", and "git push URL" to the
same remote repository without using remotes/ shorthand would
result in the matching behaviour.  That may be a good default.
