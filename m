From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: svn user trying to recover from brain damage
Date: Fri, 11 May 2007 19:29:31 +0200
Organization: At home
Message-ID: <f228t6$qnq$1@sea.gmane.org>
References: <92fdc3450705090830t64c8f5b9r4af277807dfe834d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 19:25:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmYrx-0006Zp-Rn
	for gcvg-git@gmane.org; Fri, 11 May 2007 19:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759736AbXEKRZQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 13:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759596AbXEKRZQ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 13:25:16 -0400
Received: from main.gmane.org ([80.91.229.2]:35815 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760145AbXEKRZO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 13:25:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HmYrd-0007fH-19
	for git@vger.kernel.org; Fri, 11 May 2007 19:25:09 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 May 2007 19:25:09 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 May 2007 19:25:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46969>

[Cc: Joshua Ball <sciolizer@gmail.com>, git@vger.kernel.org]

Joshua Ball wrote:

> What the heck do these terms mean? The glossary on the Git wiki was
> unhelpful (I'll explain later).

Glossary at GitWiki, http://git.or.cz/gitwiki/GitGlossary is
wikification of "GIT Glossary" from Documentation/glossary.txt
distributed with git-core and installed usually under

  /usr/share/doc/git-core-<version>/glossary.html

but also available at

  http://www.kernel.org/pub/software/scm/git/doc/glossary.html

This wiki page was created for GitWiki to be self contained
(to be able to reference to anchor in GitGlossary when referring
to some term which needs explanation), and also to be able to add
some links to wiki pages in wikified GitGlossary. This wiki page
is probably a bit outdated.

> head
> head ref
> working tree
> object
> branch
> merge
> master
> commit (as in the phrase "bring the working tree to a given commit")
> 
> While the Git wiki does in fact define all of these, it doesn't answer
> any of my questions about those terms:
[cut]

I hope that the following mini-tutorial with some explanations would
help you understand those terms, and clean some SVN misconceptions.


In git history itself is separated from the references to it; when cloning
or fetching from other repository, you get and append missing parts of
history, but the refs on the remote and on local side does not need to
have the same names. In the ascii-art graphs of history objects which
are in "object database" (in history) are on the left, and references
to history are on the right.

 /------ object database -----------\  /------- refs --------\

Let's start with the following history (the following repository
structure)

   A <-- B <-- C <-- D <----------------- master <------- HEAD


$ git branch branchA
(does not change working directory)

   A <-- B <-- C <-- D <----------------- master <------- HEAD
                      \
                       \
                        \--------------- branchA

Branching does not create copy of revisions so far (even if it is
cheap copy like in the case of Subversion). You can always find
the place where branches diverge; it is recorded in repository.
"git merge-base master branchA" returns [id of] revision D.

Creating a branch is just creating a pointer (reference) to some
commit. Head ref, or just a head is this pointer, e.g. 'branchA'
(it resides in  $GIT_DIR/refs/heads/branchA). Commit D is often
called branch tip. Branch as a non-cyclical graph of revisions
is, in the case of 'branchA', branch history of commit D including
this commit, i.e. A<--B<--C<--D DAG.

HEAD (case sensitive, all uppercase) is current branch, usuually
pointer to some other branch.


$ git checkout branchA
(changes working directory, updates HEAD)

   A <-- B <-- C <-- D <----------------- master      /- HEAD
                      \                              /
                       \                            /
                        \--------------- branchA <-/

Those two above steps can be combined to single command
$ git checkout -b branchA


$ edit; edit; ... (changes working directory)
$ git commit -a
(this creates new commit object E, updates branchA ref, i.e.
 ref pointed by HEAD, aka. current branch [head])

   A <-- B <-- C <-- D <----------------- master       /- HEAD
                      \                               /
                       \                             /
                        \- E <----------- branchA <-/

Committing (commit as verb) creates commit object E (commit as noun),
and advances branch head to the newly created commit.


$ git checkout master
$ edit; edit; ...
$ git commit -a

   A <-- B <-- C <-- D <-- F <------------ master <----- HEAD
                      \
                       \
                        \- E <----------- branchA

Note that "git commit" advances current branch head / tip of current
branch, i.e. branch pointed to by HEAD reference.


$ git merge branchA
This does equivalent of doing "diff3 -E F D E", i.e. 3-way merge on
file level, or "diff3 -E HEAD $(git merge-base HEAD branchA) branchA"

   A <-- B <-- C <-- D <-- F <-- G <------ master <----- HEAD
                      \        /
                       \      /
                        \- E- <---------- branchA

Merging (merge as verb) creates merge commit [object] G (merge as noun).
Commit object G has commits G and E as parents (more than one parent).
The information that G is result of merge is recorded in commit
[object] G.


If you have noticed that you want to discard the merge, for example
you don't want to merge yet, i.e. you want to return to state before
merge you can do:

$ git reset --hard ORIG_HEAD
(updates current branch, *does not* update HEAD as a ref,
 contrary to git-checkout)

                           |------\
                           v       \
   A <-- B <-- C <-- D <-- F <-- G  \----- master <----- HEAD
                      \        /
                       \      /
                        \- E- <---------- branchA


Assume situation at the graph before

$ git checkout branchA
$ edit; edit; ...
$ git commit -a
(creates commit H)
$ git checkout master
$ git merge branchA
This time, because merge is recorded as such, the merge base between
'master' branch (branch we merge into) and 'branchA' (branch being
merged) is commit E. Git knows that it has to merge only changes
accumulated since last merge.

   A <-- B <-- C <-- D <-- F <-- G <- J <- master <----- HEAD
                      \        /     /
                       \      /     /
                        \- E-<-- H <------ branchA

 
> In the words of Dijkstra, "Since breaking out of bad habits, rather
> than acquiring new ones, is the toughest part of learning, we must
> expect from that system permanent mental damage for most ... exposed
> to it."
> 
> May you lead me to a quick recovery. Hail to decentralized version control.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
