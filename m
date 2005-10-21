From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to create a new branch based on a tag?
Date: Fri, 21 Oct 2005 01:20:58 -0700
Message-ID: <7v4q7bz3f9.fsf@assigned-by-dhcp.cox.net>
References: <435901F7.9020509@ust.hk>
	<7vsluv5y0p.fsf@assigned-by-dhcp.cox.net> <4359161B.5000808@ust.hk>
	<7vzmp3319v.fsf@assigned-by-dhcp.cox.net> <43593E08.1060208@ust.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 10:22:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESs9E-0005jf-Bh
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 10:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbVJUIVA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 04:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbVJUIVA
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 04:21:00 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:57042 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750988AbVJUIU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2005 04:20:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051021082029.HKYC776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 21 Oct 2005 04:20:29 -0400
To: Ben Lau <benlau@ust.hk>
In-Reply-To: <43593E08.1060208@ust.hk> (Ben Lau's message of "Sat, 22 Oct 2005
	03:14:16 +0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10426>

Ben Lau <benlau@ust.hk> writes:

>>Linus or somebody authoritative could do:
>>
>>    $ commit=$(echo v2.6.11 | \
>>      git-commit-tree c39ae07f393806ccf406ef966e9a15afc43cc36a)
>>    $ git-tag -s -m 'v2.6.11 canonical "fake" commit' v2.6.11fake $commit
>>
>>and tell everybody interested to have:
>>
>>1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 xxxxxxxxxx
>>
>>(where xxxxx... is the value of $commit above) in their
>>info/grafts file.  Then we *could* pretend that v2.6.12-rc2's
>>parent is v2.6.11.  You could branch off from v2.6.11fake commit
>>and base your development, and later you could merge that into
>>later development history (say, v2.6.14-rc5) if you wanted to.
>>
> Thanks for detail explanation.
>
> It is a little bit difficult for me. The result of `git log`
> shows that the eldest commit is 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
> which is linux-2.6.12-rc2. Is that means the git repository do not
> store the history before this tag?

Linux development on git, at least the history available
officially, starts from 2.6.12-rc2.

Let's try to find things together.  In the typescript below,
": siamese;" is my shell prompt $PS1.

First, look at v2.6.12-rc2 object.  What type is it?

    : siamese; git-cat-file -t v2.6.12-rc2
    tag

It is a tag.  Let's see what's inside.

    : siamese; git-cat-file tag v2.6.12-rc2
    object 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
    type commit
    tag v2.6.12-rc2

    Linux v2.6.12-rc2 release
    -----BEGIN PGP SIGNATURE-----
    Version: GnuPG v1.2.4 (GNU/Linux)

    iD8DBQBCbW8ZF3YsRnbiHLsRAgFRAKCq/TkuDaEombFABkPqYgGCgWN2lQCcC0qc
    wznDbFU45A54dZC8RZ5JxyE=
    =ESRP
    -----END PGP SIGNATURE-----

OK, that points at a commit and object name is 1da177e4c...
Let's look at that object.  You can abbreviate object name here.

    : siamese; git-cat-file commit 1da177e4c
    tree 0bba044c4ce775e45a88a51686b5d9f90697ea9d
    author Linus Torvalds <torvalds@ppc970.osdl.org> 1113690036 -0700
    committer Linus Torvalds <torvalds@ppc970.osdl.org> 1113690036 -0700

    Linux-2.6.12-rc2

    Initial git repository build. I'm not bothering with the full history,
    even though we have it. We can create a separate "historical" git
    archive of that later if we want to, and in the meantime it's about
    3.2GB when imported into git - space that would just make the early
    git days unnecessarily complicated, when we don't have a lot of good
    infrastructure for it.

    Let it rip!

Notice the top three lines?  There is no "parent " line, like
recent commits, for example:

    : siamese; git-cat-file commit v2.6.13
    tree 9b182c47688d261775f8c49e06cb795dfc8931dc
    parent 20b1730af3ae05450b0e03f5aed40c4313f65db6
    author Linus Torvalds <torvalds@g5.osdl.org> 1125272461 -0700
    committer Linus Torvalds <torvalds@g5.osdl.org> 1125272461 -0700

    Linux v2.6.13

What this means is that 2.6.12-rc2 was the big-bang, the
beginning of time, as far as the history recorded in git is
concerned.  There was nothing before that time.  On the other
hand, v2.6.13 has a "parent " line -- this names another commit,
and Linus has some change between that parent commit and
v2.6.13.

    : siamese; git diff v2.6.13^ v2.6.13
    diff --git a/Makefile b/Makefile
    index 300f61f..5acd1fc 100644
    --- a/Makefile
    +++ b/Makefile
    @@ -1,7 +1,7 @@
     VERSION = 2
     PATCHLEVEL = 6
     SUBLEVEL = 13
    -EXTRAVERSION =-rc7
    +EXTRAVERSION =
     NAME=Woozy Numbat

     # *DOCUMENTATION*

Of course, the version number has changed.  v2.6.13^ is a
short-hand to say "first parent of v2.6.13" (see git-rev-parse
documentation).

> Then how can `git-read-tree v2.6.11` fetchs the content of
> v2.6.11?

Trees do not have their position in timeline.  Only commits do.
This is explained by King Penguin himself.  If you are reading
the documentation on the web,

	http://www.kernel.org/pub/software/scm/git/docs/

find the link "The [Discussion] section below contains much
useful information...", and follow it.  README in the git source
tree at the top level has the same.  The description there
covers the object database and blob/tree/commit/tag objects, and
how these things fit together.

Think of a tree as if you created a tar archive (but without
even timestamps) of an extracted kernel source tree.  It is a
snapshot of directory structure and file contents.  You can have
many such snapshots, but they themselves do not describe how
each of them is related with other snapshots.  Commit objects
tie them together and give them their position in time.  The
"parent " line above refers to another commit (note that you can
have more than one "parent " lines to denote a merge).

> By the way, How could you find the 
> c39ae07f393806ccf406ef966e9a15afc43cc36a out?

    : siamese; git-cat-file tag v2.6.11-tree
    object c39ae07f393806ccf406ef966e9a15afc43cc36a
    type tree
    tag v2.6.11-tree

    This is the 2.6.11 tree object.

    NOTE! There's no commit for this, since it happened before I started with git.
    Eventually we'll import some sort of history, and that should tie this tree
    object up to a real commit. In the meantime, this acts as an anchor point for
    doing diffs etc under git.
    -----BEGIN PGP SIGNATURE-----
    Version: GnuPG v1.2.4 (GNU/Linux)

    iD8DBQBCeV/eF3YsRnbiHLsRAl+SAKCVp8lVXwpUhMEvy8N5jVBd16UCmACeOtP6
    KLMHist5yj0sw1E4hDTyQa0=
    =/bIK
    -----END PGP SIGNATURE-----

When v2.6.11 was released, there was no git.  Linus can create a
tree out of that release, and that is what he did.

He could have created a commit that claimed it was the beginning
of time.  He did not do that because what he could not do was to
retroactively make that commit a parent of the v2.6.12-rc2
commit he already made.

This is because any git object (any type) has a name based on a
cryptographically secure hash of its contents, and "the
contents" in the case of a commit object includes those header
lines (which tree object that commit records, what commits its
parents are, who wrote it and who committed it when).

Retroactively adding/modifying parent to an existing commit
would mean you would change its contents -- hence its name.  An
existing child of that commit now needs to get its "parent "
line changed to point at the updated parent.  Which means
rewriting the whole history since v2.6.12-rc2 commit.

The "graft" facility I mentioned in my previous message was
invented much later.  It lets you pretend that a given commit
object has an arbitrary set of commit objects as its parents,
which is typically different from its real parents.  By using
it, you *could* pretend that v2.6.12-rc2 is a child of
v2.6.11fake commit (which you create by wrapping the v2.6.11
tree into it).

There is a mention on "graft" facility in the repository layout
documentation:

http://www.kernel.org/pub/software/scm/git/docs/repository-layout.html

we might want to also refer to this from git-log documentation, 
and perhaps git-merge-base documentation.
