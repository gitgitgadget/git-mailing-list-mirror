From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] remembering hand resolve...
Date: Wed, 25 Jan 2006 15:56:15 -0800
Message-ID: <7v1wyvn9pc.fsf@assigned-by-dhcp.cox.net>
References: <7v4q3ssbr6.fsf@assigned-by-dhcp.cox.net>
	<43D7810D.9010508@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 00:57:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1uUv-0006ue-Tc
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 00:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWAYX4T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 18:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWAYX4T
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 18:56:19 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:47613 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751243AbWAYX4S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 18:56:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060125235330.ZOOS17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 Jan 2006 18:53:30 -0500
To: Andreas Ericsson <ae@op5.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15143>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
>> The thing is, I find myself resolving the same conflicts over
>> and over.  This is because the master branch tends to advance
>> faster than topic branches that touch an overlapping area.
>
> How can that be possible? If the area of code in master is modified
> beyond simple merging from the topic-branches, the resulting diff
> (which has to be against master's HEAD) should apply cleanly so long
> as there aren't *new* changes to master, in which case the pu commit
> needs adaptation again, so it wouldn't really be the same conflict (or
> even necessarily a similar one), would it?

In general, you are right.  When the change that advances
"master" touches the same area as those held-back topic branches
touch, the earlier resolution between topic branches may not help.

However, the change to the "master" that leap-frogs these
held-back topic branches is often independent from the changes
in these held-back topic branches.

For example, as of this morning, my "master" and "pu" were like
this:

        $ git show-branch master pu
        * [master] Merge branches 'jc/clone', 'md/env' and 'mo/path'
         ! [pu] Merge jc/revparse,jc/abbrev
        --
         - [pu] Merge jc/revparse,jc/abbrev
         - [pu^] Merge lt/revlist,jc/diff,jc/bind
         + [pu^^3] combine-diff: fix appending at the tail of a list.
         + [pu^2] rev-parse --flags/--no-flags usability fix.
         + [pu^3] diff-tree: abbreviate merge parent object names wit...
         + [pu^^2] rev-list: stop when the file disappears
         + [pu^^3^] diff-tree --cc: denser combined diff output for a...
         + [pu^^3~2] diff-tree -c: show a merge commit a bit more sen...
         + [pu^^4] fsck-objects, convert-objects: understand bound co...
         + [pu^^4^] rev-list: understand bound commits.
         + [pu^^4~2] rev-list: simplify --object list generation.
         + [pu^^4~3] commit-tree: --bind <sha1> <path>/ option.
         + [pu^^4~4] write-tree: --prefix=<path>/ and --exclude=<pref...
         + [pu^^4~5] read-tree: --prefix=<path>/ option.
         + [pu^3^] rev-parse: --abbrev option.
         + [pu^3~2] abbrev cleanup: use symbolic constants
        -- [master] Merge branches 'jc/clone', 'md/env' and 'mo/path'

The two merges at the tip of "pu" shows that I merged lt/revlist
(Linus' "stop at disappearance"), jc/diff ("combined diff") and
jc/bind ("bound commit') first because I felt they are more or
less ready, and then jc/revparse and jc/abbrev on top of it.

Two topic branches, jc/abbrev and jc/bind, touch the same area
in commit.c.  The former changes the formatting of "Merge:" line
from prettyprinted commit (we did not honor --abbrev option to
diff-tree when we used that function).  The latter changes the
same function to include a call to add the new "Bind: " lines.
When I made the last merge for the tip of "pu", I had to hand
resolve conflicts in the file.

Now suppose I feel topic branches lt/revlist, jc/diff and
jc/revparse are ready, and want to have them graduate to the
"master" branch.  Also I may get a patch from you fixing
Documentation/Makefile, which none of my topic branches touch,
so I would advance "master" this way:

	$ git checkout master
        $ git pull . lt/revlist
        $ git pull . jc/diff
        $ git pull . jc/revparse
	$ git am -3 -s ./+ae-doc-make.email

What I would do after this step to rebuild "pu" would be to
merge jc/bind and jc/abbrev branches, in some order.  But in
whatever order I merge, I would get the conflict in commit.c
as before:

	$ git checkout pu
        $ git reset --hard master
        $ git pull . jc/bind
        $ git pull . jc/abbrev

If I swap the order I pull in jc/bind and jc/abbrev, the
sections marked with conflict markers <<< === >>> would be
swapped, so the conflict would not be exactly the same, but
the result of the resolution is the same.  I end up making the
result logically the same by hand resolving.

Although I happen to do Octopus when building "pu" but the issue
does not change if the merges were made one branch at a time.

>> If I linearize topic-branches that conflict with each other in
>> some way, say base topic B on top of topic A, I would not have
>> problem merging them into "pu" as long as I do not change my
>> mind later and try to merge only topic B without topic A.  But
>> that defeats the whole point of having independent topic
>> branches.
>
> Wouldn't cherry-pick be useful here? If it isn't, I fail to understand
> how a merge can solve it for you....

Suppose instead of having

              A---B---C jc/bind
             /    
  master ---O
             \    
              D---E---F jc/abbrev

I made this:

              A'--B'--C'--D---E---F
             /        ^jc/bind    ^jc/abbrev
  master ---O

When converting the two topic branches into this sequence,
obviously I have to hand merge the changes A-B-C makes and the
changes D-E-F makes to commit.c file.

I can later attempt to cherry-pick D-E-F on top of updated
"master".  I think that is what you mean by "cherry-picking",
but that would have the same "I've resolved this before" issue.
Because the change D-E-F brings in now depends on the change
A'-B'-C' brings in. But on the tip of the master branch, that
change is not there yet. The cherry-picked changes on top of O
would not cleanly apply.  Even with the 3-way merge fallback,
this is a merge of F and O using C' as the merge base, and we
will see conflicts.

However, as long as I do not have to merge the contents of
jc/abbrev branch in without the contents of jc/bind branch, a
merge to an updated master would not have any conflict between
A'-B'-C' chain and D-E-F chain, and often even after jc/bind and
jc/abbrev advances:

                        G---H jc/bind
                       /
              A'--B'--C'--D---E---F
             /                    ^jc/abbrev
  master ---O---I---J

Pulling jc/bind to master and then jc/abbrev on top it may have
conflicts between the changes O-I-J and C'-G-H bring in, but at
least I would not have to re-resolve the conflicts between
A'-B'-C' and D-E-F chains.  That is what I meant to say.  The
merge is helped by making jc/abbrev topic branch dependent on
the earlier part of jc/bind topic branch.

> Couldn't you do something like this:
>
> for t in $topic_branches; do
> 	checkout $t
> 	git rebase master
> done
> git checkout master
> git branch -D pu
> git checkout -b pu
> git pull . $topic_branches
>
> That's what I thought you were doing right now, but I can't imagine
> that flow leading to the same conflicts over and over, so I must be
> mistaken somehow.

That is exactly what I am doing [*1*]


[Footnote]

*1* In my primary development working tree, I have a checked-out
tree of "todo" branch at Meta/ directory.  The "pu" is built by
running Meta/PU (that is "PU" file in the "todo" branch) from
the toplevel and picking topic branches to merge on top of the
master branch, which essentially does what you just described.

To take a peek at how my primary development working tree looks
like, you could do this:

	$ git clone git://git.kernel.org/pub/scm/git/git GIT
        $ cd GIT
        $ git clone -l -s -n .git Meta
        $ cd Meta
        $ git checkout todo
        $ cd ..
	$ rm Meta/.git/refs/heads/[a-p]* ;# leave only "todo"
        $ rm -f .git/refs/heads/{html,man,todo}

This would give a rough approximation of where I work.

The above clone would not have any of the topic branches; but
their heads appear on merge commits between master and pu.  For
example, in the earlier show-branch output, the tip of "pu" says
"Merge jc/revparse,jc/abbrev", which means pu^1 was the tip of
pu when this merge was made, pu^2 is the tip of jc/revparse
topic, and pu^3 is jc/abbrev.  You can take them apart like so:

	$ git branch jc/revparse pu^2
	$ git branch jc/abbrev pu^3
