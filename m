From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-merge: New options `--no-fast-forward' and `--direct'.
Date: Sat, 18 Mar 2006 13:59:21 -0800
Message-ID: <7vmzfns9c6.fsf@assigned-by-dhcp.cox.net>
References: <slrne1nnhm.fr9.mdw@metalzone.distorted.org.uk>
	<20060318101941.8941.52615.stgit@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 18 22:59:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKjSN-0004vj-EP
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 22:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWCRV72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Mar 2006 16:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWCRV72
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Mar 2006 16:59:28 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:51711 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751052AbWCRV72 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Mar 2006 16:59:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060318215627.GZXV17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Mar 2006 16:56:27 -0500
To: Mark Wooding <mdw@distorted.org.uk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17703>

Mark Wooding <mdw@distorted.org.uk> writes:

> These options disable some of git-merge's optimizations.  

While there is no question about the part of the proposed change
to bypass "trivial merge", I do not necessarily agree with
"skipping fast forward" part.

It is a problem that "ours" strategy cannot be used as a way to
recover from the "accidentally rewound head" situation, because
it is prevented from running under certain conditions as you
described.  But that does not necessarily mean we should make
"ours" to work in these situations.

You accidentally discarded B while somebody picked it up:

                 o---o
                /     \
    ---o---o---A---o---o---B
               ^your head

Now you would want to recover.  With your patch, it would create
this:

                 o---o
                /     \
    ---o---o---A---o---o---B
                \           \
                 ------------M
                             ^your updated head,
                              having the same tree as A

But recording A as a parent of M is not necessary.  I think what
we want to have as the result is this instead:

                 o---o
                /     \
    ---o---o---A---o---o---B---M
                               ^your updated head,
                                having the same tree as A

This is something you cannot do within the current git-merge
framework; it is set up to either just fast forward or make a
multi-parent commit.  You would want have a "revert to this
state" [*1*], something like this (assuming you have rewound to
A and currently your index matches A):

        $ git reset --soft B
        $ git commit -m 'Discard A..B and revert to A'

I did "ours" primarily as a demonstration of a funky thing
people could do with the consolidated driver "git-merge".  I did
not have a useful use-case in mind back then, but it turned out
to be the ideal way to recover from "accidentally rewound head"
situation, except that making a merge commit between A and B is
not always the way to recover from it.  If we wanted to, we
could have a special purpose command that does "git merge -s
ours" if there will be a new commit, otherwise the above two
commands sequence if it will be a fast forward, but the
"recovering from accidentally rewound head" _is_ really a
special purpose, so I do not know if it is worth it.

In your cover letter, you talked about using --no-fast-forward
to collapse your sole topic branch into your master branch.  I
do not think smudging the development history with extra merge
commits for that is justfied either.  There is no reason for you
to discard your topic branch heads after you merged them into
master.  If they get in the way of your normal workflow, you can
stash them away as tags that you do not usually see in "git
branch" output [*2*].

Also I am already unhappy that git-merge knows about the
specifics of strategies [*3*], e.g. it knows octopus is
currently the only strategy that can do more than two heads.
Your patch gives more strategy specific knowledge to it, but I
do not know how to avoid it.


[Footnotes]

*1* As opposed to "git revert X" which means "revert the effect
of commit X", you would want "revert to the state X".

*2* I keep some of my old topic branch heads under
.git/tags/attic/.

*3* Another thing I am unhappy about is the list of available
strategies.  I initially wanted to allow users to write their
own merge strategies and have them on their PATH (not even
necessarily in GIT_EXEC_PATH directory), so that you can do a
git-merge-mdw secretly, keep it in ~mdw/bin and cook it for a
while using yourself as a guinea pig, and then share that with
the community later, _without_ touching git-merge.
