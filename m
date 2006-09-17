From: Junio C Hamano <junkio@cox.net>
Subject: Re: Notes on supporting Git operations in/on partial Working Directories
Date: Sun, 17 Sep 2006 03:43:40 -0700
Message-ID: <7vvenm3h9f.fsf@assigned-by-dhcp.cox.net>
References: <4509A7EC.9090805@gmail.com>
	<7vu03a2po8.fsf@assigned-by-dhcp.cox.net> <4509B954.60101@gmail.com>
	<7v8xkl26kb.fsf@assigned-by-dhcp.cox.net> <450AEDBF.9050307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 12:43:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOu7r-0001YR-Ta
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 12:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbWIQKnm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 06:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWIQKnl
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 06:43:41 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:1745 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964920AbWIQKnl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 06:43:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060917104340.KXLF21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Sep 2006 06:43:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PNjU1V00H1kojtg0000000
	Sun, 17 Sep 2006 06:43:29 -0400
To: gitzilla@gmail.com
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27183>

A Large Angry SCM <gitzilla@gmail.com> writes:

> Junio C Hamano wrote:
> ...
>>
>> Having said that, I do not necessarily agree that highly modular
>> projects would want to put everything in one git repository and
>> track everything as a whole unit.
>
> And yet that's exactly how a lot of developers use CVS. You can argue
> that some other way is better but when they move from CVS they're
> looking for continuity of productivity which often means not radically
> changing how they work. At least in the short term.

(Note. In the next paragraph, I used (for the want of better
       wording) the word "unrelated" to mean "indeed related,
       but without need to be in sync at whole-tree commit
       level, and probably insisting to be in sync at that level
       has more disadvantages than advantages".  Think of it to
       refer to the relationship among more-or-less independent
       project subcomponents in my earlier example).

Well, the fact is, it does not make any difference to CVS if you
put unrelated projects in a single "repository", because CVS
does not even have the concept of managing a project as a whole.
Except perhaps that you can give the same tag to individual
files and treat the set of the revs of the files that have that
particular tag forms a revision of a project.  And even that is
just a kludge -- if you throw a totally unrelated project into
such a "repository" and give files a tag that happens to be the
same name as the one used in another project, the tool happily
lets you do so and checking out a revision by the tag will pull
files from totally unrelated projects together.  We happen to
use the words "repository" and "revision" in git but what they
mean is quite different because we are more whole-tree oriented.
It misses the point to compare CVS and git and say CVS allows
placing unrelated things in the same "repository".  CVS does not
even track the whole tree state, so it does not hurt the user
nor the tool even if you did so.  With a tool that tracks the
whole tree, you need a bit of thinking and planning.

I do not think, by the way, we are aiming at much different
things.  We both know that our current tools do not support
either mode of operation; the direction you are coming from
where everything is under one roof and only parts are accessed
while others are left untouched, or an organization where
loosely-related projects from different repositories are checked
out into a working tree hierarchy.  You alluded to "split index"
in another message, and the project organization I suggested to
keep component projects in their own separate repositories would
also have separate indices in component repositories.

I am certainly not opposed to the idea of making operations in
such a tree (built either way) go seamlessly for the users.  A
Porcelain that supports such mode of operation needs to be built
or enhanced, because we do not have one.

What I am saying is that I suspect everything-under-one-roof
approach would incur higher damage to the core than multiple
repositories approach.  It is my understanding that Cogito has
such a light-weight subproject support that lets you have
separate repositories laid out in a single working tree.

For example, users of such a Porcelain most likely would not
worry about what is stored in .git/index and .git/remotes/
directories of individual repositories that appear in such a
single working tree.  The Porcelain would keep track of which
files are locally modified, what components are checked out in
which subdirectory, where their upstream repositories are, and
things like that.  It will use .git/index and .git/remotes/ of
component repositories to implement the unified tree, but the
use of the individual .git/ directories is its implementation
detail.  It is likely to do its own bookkeeping that is beyond
what the current core offers, but I do not think it needs much
additional core support.  If such bookkeeping turns out to be
useful and necessary to have it in the core for whatever reason
(either performance or interoperability across Porcelains), we
could certainly talk about putting that into the core.

I suspect that everything-under-one-roof approach is coming from
an observation that:

 - with CVS, projects that share the same cvsroot can be updated
   with single 'cvs update' command in a directory close to the
   root.

 - with git, if you use multiple repositories checked out at
   right places in the working tree hierarchy, you need to run
   around and say "git checkout" or "git commit" everywhere.

and the latter looks very inconvenient.

But of course the latter is very inconvenient.  The current "git
checkout" nor "git commit" are not such subprojects-aware
Porcelain commands.  But that does not mean you have to house
everything in the same repository and make partial check-in to
work.  You will be enhancing or replacing the same "git checkout"
and "git commit" commands to do so anyway.
