From: Junio C Hamano <junkio@cox.net>
Subject: Re: sending changesets from the middle of a git tree
Date: Sun, 14 Aug 2005 00:57:13 -0700
Message-ID: <7vhddtdk86.fsf@assigned-by-dhcp.cox.net>
References: <42FEBC16.9050309@austin.rr.com>
	<Pine.LNX.4.58.0508132155100.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Aug 14 09:57:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4DN6-0003kr-Q5
	for gcvg-git@gmane.org; Sun, 14 Aug 2005 09:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVHNH5P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 03:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVHNH5P
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 03:57:15 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:55237 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932201AbVHNH5O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2005 03:57:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050814075713.LGEL8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 Aug 2005 03:57:13 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0508132155100.3553@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 13 Aug 2005 22:03:48 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

>> If I export those two changesets as patches, and send them on.
>> presumably I lose the changset comments etc.
>
> Well, you can export them with "git send-email" and you won't be losing 
> any comments.

Yes, except the command is "git format-patch".  Not just
comments, but "format-patch --author --date" generates messages
that would help preserving the authorship and original author
date information as well.

> Alternatively, use "git cherry", which helps re-order the commits in your
> tree. They'll be _new_ commits, but they'll have the contents moved over. 

> Junio, maybe you want to talk about how you move patches from your "pu" 
> branch to the real branches.

As I have mentioned elsewhere, I have been trying not to use
JIT, my own Porcelain, to make sure that the core-git barebone
Porcelain is usable.

Unfortunately, this is one area in my workflow that I still
heavily rely on JIT, because it is so handy.  I've kept saying I
do not do Porcelain, but I'll make an exception this time, by
invitation ;-).

Let's say I have three commits in "pu" which are not yet in
"master".  I first use "jit-cherry-snap" to give myself a ready
access to these them:

prompt$ jit-cherry-snap master pu
* 3: Alternate object pool mechanism updates.
* 4: Audit rev-parse users.
* 5: Add cheap local clone '-s' flag to git-clone-script

This command is a thin wrapper around "git cherry".  Instead of
giving you long SHA1 commit object names, JIT gave a short name
to them, #3, #4, and #5 (I can say "git-rev-parse 3", or even
"git-diff-tree 3", for example).  I have to mention that
x"alternate object pool" commit is the oldest (i.e. the one that
immediately follows the "master" head), #4 is its child, and #5
is #4's child.

Suppose I have tested the "pu" branch to my satisfaction, but
I would want to hold the commit #3 back (because I promised
Pasky to hold it for a couple of days).  But I know #4 and #5
are good and would like to push them out.  Here is what I do:

prompt$ git checkout master
prompt$ jit-replay 4 5
*** 4 ***
patching file git-rebase-script
patching file git-reset-script
patching file git-tag-script
*** 5 ***
patching file git-clone-script
prompt$

"jit-replay" is essentially this shell scriptlet:

    #!/bin/sh
    . git-sh-setup-script || die "not a git repository"
    for snap
    do
        snap=$(git-rev-parse --verify "$snap") &&
        git-diff-tree -p "$snap" | git-apply --index &&
        git commit -C "$snap"
    done

That is, to apply the change in an existing commit, and record
it with the commit log message, authorship information and
author timestamp from that commit.  What I just did is to port
commits #4 and #5 on top of the "master" branch.

What happened so far is this:

 * I used to have this commit graph.  O is the original "master"
   head, P is the original "pu" head.

    O --> #3 --> #4 --> #5 == P

 * I advanced the "master" branch, but not along the original
   path that lead to "pu" head.  Instead, I made a fork:


                 * New "master" head
      --> #4'--> #5'
     /
    O --> #3 --> #4 --> #5 == P

As Linus and Ryan already said, the old history is "immutable".
I did not (actually, could not) touch #3...#5 commits; they are
still there.  I created two new commit objects #4' and #5'.  And
#5' is now the new "master" head.

What's left to do is to make sure that I do not lose the change
in #3.  So I rebase the "pu" branch to the new "master" head.
The following sequence does it:

prompt$ git-rev-parse master >.git/refs/heads/pu
prompt$ git checkout pu
prompt$ jit-replay 3
*** 3 ***
patching file cache.h
patching file fsck-cache.c
patching file sha1_file.c

Now, the commit ancestry graph looks like this.  "pu" head is at
P', and the original "pu" head P is still recorded as the
snapshot #5.

                  new "master"
                 *head        *new "pu" head
      --> #4'--> #5'--> #3 == P'
     /
    O --> #3 --> #4 --> #5 == P

As the last sanity check, I make sure that the resulting "pu"
head has exactly the same tree as the original "pu" head;
because all I did in this example was to shuffle the order of 
commits, they should exactly match:

prompt$ git diff HEAD..5
prompt$

And they do match.  I discard the numbered snapshots, because I
do not need them anymore.

prompt$ jit-clean

It is worth pointing out that this workflow means that "pu"
branch is just a staging area and if people start pulling from
and merging with it, things will get messy on the receiving end
(not my end), so the owner of a frequently rebased branch like
this should be very clear about the nature of the branch
upfront.  Saying "this branch will be frequently rebased" is
equivalent of saying "comments and replacement patches are
welcome, but do not merge with it, or you may have hard time
yourself cleaning _your_ history up later".

As I said, I do not do Porcelain, and I would _not_ encourage
people to try JIT out at this point.  Because I have not had
enough time to keep it up-to-date and make it take advantage of
the recent git-core improvements, some of the parts I did not
demonstrate above have still (or have acquired) rough edges that
I myself know not to touch, but others would by accident and
burn themselves.  What I would eventually do is to take good
pieces and ideas out of JIT and repackage them as part of the
core-git barebone Porcelain.
