From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
Date: Sat, 29 Apr 2006 13:44:58 -0700
Message-ID: <7viros1585.fsf@assigned-by-dhcp.cox.net>
References: <20060429165151.2570.qmail@science.horizon.com>
	<e30b48$ovk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 29 22:45:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZwJZ-0002Rn-2b
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 22:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWD2UpE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 29 Apr 2006 16:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWD2UpE
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 16:45:04 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:28388 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750770AbWD2UpB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Apr 2006 16:45:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060429204500.MMNM9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 29 Apr 2006 16:45:00 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19316>

Jakub Narebski <jnareb@gmail.com> writes:

>  * "prior" - heads=A0that=A0represent=A0topic=A0branch=A0merges

This is not any different from usual "parent" at all (but you
have to think about it a bit to realize it).

Before talking about making a new commit object that links to
other related commits, let's first talk about what it means to
update the branch head ($GIT_DIR/refs/heads/<branch>) from
commit A to commit B.  Understanding what it means is more
fundamental.

A git "branch" points at the tip of one possible history of a
development.  As the often-used word "topic branch" tells you, a
"branch", i.e. that history, has a specific purpose.  The
purpose of my "master" branch is to give reasonably stable new
feature set and bugfixes, "next" to give testable ones, and "pu"
to collect remaining bits that are worthy of discussion.

When your branch head points at commit A and you update the head
to point at a different commit B, you are making this statement:

	The commit B suits the purpose of the branch better
	than the commit A.

Notice there may or may not be ancestry relation between these
two commits at this point of the discussion.  B may be a direct
child of commit A, a merge that has A as its first parent, a
merge that has A as its one of its parent (but not necessarily
the first), or a Nth-generation descendant if the update was a
fast forward merge from another branch.  It might even be an
ancestor if the update rewinds the history.

Among the above cases (and there may be others), in only two
cases you actually create a new commit to record that
statement [*1*].

The simplest case is when commit B is a direct, single-parent
child of commit A, and that statement is in your commit log
message.  "I started out from the commit A, and the result is
this tree.  The result suits what I am doing better than the
previous commit and I made the world a better place." -- the "I
started out from the commit A" part is on the parent header and
the rest is in the free-text.

When you are creating a merge of N parents, the principle is the
same.  Although in pure core-git terms all parents are equal, in
practice, the first parent has somewhat special meaning to you.
When the parents of commit B are A and X, you started out from
the commit A.  Then what are other parents?  You can read such a
commit this way:

	I started out from commit A and came up with this tree,
	which suits my purpose better.  While doing so, I have
	also considered what X has; and this result, commit B,
	suits my purpose better than X, too.

This is why a later merge with another branch that further
builds on top of X works so well.

    ----A----B
            /
       ----X----Y

If somebody built Y on X independently from us, when we merge
with Y, we say the merge base is X because B says "I've already
considered what X has" to do a 3-way merge.  While that is what
happens at the mechanical level, what is happening at the
philosophical level is we are taking "I consider that B is
better than X", part of the message seriously, which means "I
want to keep changes I made between X B".  Also the other person
who made Y made a similar statement that she considers Y is
better than X, and we try to preserve the changes between X and
Y in the automated part of the merge while preparing the tree to
commit the merge between B and Y.

Once you start reading the commit parent to mean " considering
what all of these commits have, what this new commit has suits
my purpose better", it becomes clear that the "previous" pointer
for a branch like my "pu" is just another "parent".

I rebuild "pu" from the tip of then-current "next", and merge
other topics in, and discard the previous "pu".  So it results
in this kind of graph:

                         o---o---o---o---o (updated "pu")
                        /   /   /   / =20
        ---o---o---o---o
            \               \   \   \   \
             o---------------o---o---o---o (previous "pu")

But theoretically, I could include the previous "pu" tip as one
of the parents of the updated "pu" branch.

At the mechanical level, I start from then-current "next" and
merge each topic branch one-by-one on top of it.  But at the
philosophical level, what I am doing is to publish material that
shows a set of proposed changes that are more appropriate for
review by the curious than the previous round of "pu" head used
to have.  So the previous "pu" _is_ in the consideration while I
publish the updated "pu", although it is _not_ recorded anywhere.

After I come up with a fully merged tree, I could make a fake
Octopus that has the previous "pu" as its first parent and each
of the topic branch heads merged as second and subsequent
parents, with the resulting tree.  That would be more "honest"
at the philosophical level.

I am not going to actually suggest anybody doing this as a good
practice, but we can make such a commit with the current tool
like this:

        git checkout pu
	git tag -f prev-pu		;# remember where we were
	git reset --hard next		;# start at next
        git pull . topic-1		;# merge all remaining topics
        git pull . topic-2		;# ...
        git pull . topic-3
        ...
        git tag -f next-pu		;# this tree is what we want
        git reset --hard prev-pu	;# start from previous
        git pull --no-commit -s ours . next topic-1 topic-2 ...
	git read-tree -m -u next-pu	;# record a merge whose first
	git commit			;# parent is previous pu and
					;# has all the topics merged.
       =20

[Footnote]

*1* IOW, we _are_ losing some information by not recording the
fact that fast-forward was done while doing so. =20

That record should _not_ be in the commit chain.  At the
mechanical level, recording that in the commit chain means two
criss-crossing branches never converge at the commit chain
level, which is already bad.  At the philosophical level, the
commit chain is a mesh of many possible "global" histories, and
the record that somebody (a particular branch in a particular
repository) was at what point in the mesh at given time does not
belong there.

But from the repository-owner's point of view, that _might_ be a
useful information to keep.  I am just saying this preemptively
so that if somebody wants to record it, that should not be
recorded in the commit object.
